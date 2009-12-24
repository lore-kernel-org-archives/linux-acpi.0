From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/34] sony-laptop: enumerate rfkill devices using SN06
Date: Thu, 24 Dec 2009 01:23:54 -0500
Message-ID: <528809c35faebd8c50a4722c85ab8610725875cc.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622AbZLXTbU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:20 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:31:02 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

=46rom: Mattia Dongili <malattia@linux.it>

SN06 makes sure we get back a longer buffer which seems to be necessary
going forward as the SNC devices describes more and more devices (or
features more precisely). Moreover SN06 should be called with only the
descriptor offset to make sure we hit the rfkill controlling function
(F124 or F135) with a 0 argument to get a full list of features.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Tested-by: Miguel Rodr=C3=ADguez P=C3=A9rez <miguelrp@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |   76 +++++++++++++++++++++++++++-=
--------
 1 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/=
sony-laptop.c
index 1144686..49f3fe0 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1156,35 +1156,73 @@ static void sony_nc_rfkill_update()
 	}
 }
=20
-static int sony_nc_rfkill_setup(struct acpi_device *device)
+static void sony_nc_rfkill_setup(struct acpi_device *device)
 {
-	int result, ret;
+	int offset;
+	u8 dev_code, i;
+	acpi_status status;
+	struct acpi_object_list params;
+	union acpi_object in_obj;
+	union acpi_object *device_enum;
+	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
=20
-	if (sony_find_snc_handle(0x124) =3D=3D -1) {
-		if (sony_find_snc_handle(0x135) =3D=3D -1)
-			return -1;
+	offset =3D sony_find_snc_handle(0x124);
+	if (offset =3D=3D -1) {
+		offset =3D sony_find_snc_handle(0x135);
+		if (offset =3D=3D -1)
+			return;
 		else
 			sony_rfkill_handle =3D 0x135;
 	} else
 		sony_rfkill_handle =3D 0x124;
+	dprintk("Found rkfill handle: 0x%.4x\n", sony_rfkill_handle);
=20
-	ret =3D sony_call_snc_handle(sony_rfkill_handle, 0xb00, &result);
-	if (ret) {
-		printk(KERN_INFO DRV_PFX
-		       "Unable to enumerate rfkill devices: %x\n", ret);
-		return ret;
+	/* need to read the whole buffer returned by the acpi call to SN06
+	 * here otherwise we may miss some features
+	 */
+	params.count =3D 1;
+	params.pointer =3D &in_obj;
+	in_obj.type =3D ACPI_TYPE_INTEGER;
+	in_obj.integer.value =3D offset;
+	status =3D acpi_evaluate_object(sony_nc_acpi_handle, "SN06", &params,
+			&buffer);
+	if (ACPI_FAILURE(status)) {
+		dprintk("Radio device enumeration failed\n");
+		return;
 	}
=20
-	if (result & 0x1)
-		sony_nc_setup_rfkill(device, SONY_WIFI);
-	if (result & 0x2)
-		sony_nc_setup_rfkill(device, SONY_BLUETOOTH);
-	if (result & 0x1c)
-		sony_nc_setup_rfkill(device, SONY_WWAN);
-	if (result & 0x20)
-		sony_nc_setup_rfkill(device, SONY_WIMAX);
+	device_enum =3D (union acpi_object *) buffer.pointer;
+	if (!device_enum || device_enum->type !=3D ACPI_TYPE_BUFFER) {
+		printk(KERN_ERR "Invalid SN06 return object 0x%.2x\n",
+				device_enum->type);
+		goto out_no_enum;
+	}
=20
-	return 0;
+	/* the buffer is filled with magic numbers describing the devices
+	 * available, 0xff terminates the enumeration
+	 */
+	while ((dev_code =3D *(device_enum->buffer.pointer + i)) !=3D 0xff &&
+			i < device_enum->buffer.length) {
+		i++;
+		dprintk("Radio devices, looking at 0x%.2x\n", dev_code);
+
+		if (dev_code =3D=3D 0 && !sony_rfkill_devices[SONY_WIFI])
+			sony_nc_setup_rfkill(device, SONY_WIFI);
+
+		if (dev_code =3D=3D 0x10 && !sony_rfkill_devices[SONY_BLUETOOTH])
+			sony_nc_setup_rfkill(device, SONY_BLUETOOTH);
+
+		if ((0xf0 & dev_code) =3D=3D 0x20 &&
+				!sony_rfkill_devices[SONY_WWAN])
+			sony_nc_setup_rfkill(device, SONY_WWAN);
+
+		if (dev_code =3D=3D 0x30 && !sony_rfkill_devices[SONY_WIMAX])
+			sony_nc_setup_rfkill(device, SONY_WIMAX);
+	}
+
+out_no_enum:
+	kfree(buffer.pointer);
+	return;
 }
=20
 static int sony_nc_add(struct acpi_device *device)
--=20
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
