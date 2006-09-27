From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [patch 2/3] dmi_scan: this teaches dmi_decode() how to decode and save OEM Strings
Date: Wed, 27 Sep 2006 20:53:37 -0300
Message-ID: <20060928001132.199075978@khazad-dum.debian.net>
References: <20060927235335.483578718@khazad-dum.debian.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:5549 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1031295AbWI1Ais (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Sep 2006 20:38:48 -0400
Content-Disposition: inline; filename=dmi-decode-and-save-oem-string-information.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: borislav@users.sf.net
Cc: linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org, jeremy@goop.org, multinymous@gmail.com, stefan@datenfreihafen.org

This teaches dmi_decode() how to decode and save OEM Strings (type 11) DMI
information, which is currently discarded silently.  Existing code using
DMI is not affected.  Follows the "System Management BIOS (SMBIOS)
Specification" (http://www.dmtf.org/standards/smbios), and also the
userspace dmidecode.c code.

OEM Strings are the only safe way to identify some hardware, e.g., the
ThinkPad embedded controller used by the soon-to-be-submitted tp_smapi
driver.  This will also let us eliminate the long whitelist in the mainline
hdaps driver (in a future patch).

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

This patch is in 2.6.18-mm1.

 drivers/firmware/dmi_scan.c |   23 +++++++++++++++++++++++
 include/linux/dmi.h         |    3 ++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff -puN drivers/firmware/dmi_scan.c~dmi-decode-and-save-oem-string-information drivers/firmware/dmi_scan.c
--- a/drivers/firmware/dmi_scan.c~dmi-decode-and-save-oem-string-information
+++ a/drivers/firmware/dmi_scan.c
@@ -123,6 +123,26 @@ static void __init dmi_save_devices(stru
 		dev->type = *d++ & 0x7f;
 		dev->name = dmi_string(dm, *d);
 		dev->device_data = NULL;
+		list_add(&dev->list, &dmi_devices);
+	}
+}
+
+static void __init dmi_save_oem_strings_devices(struct dmi_header *dm)
+{
+	int i, count = *(u8 *)(dm + 1);
+	struct dmi_device *dev;
+
+	for (i = 1; i <= count; i++) {
+		dev = dmi_alloc(sizeof(*dev));
+		if (!dev) {
+			printk(KERN_ERR
+			   "dmi_save_oem_strings_devices: out of memory.\n");
+			break;
+		}
+
+		dev->type = DMI_DEV_TYPE_OEM_STRING;
+		dev->name = dmi_string(dm, i);
+		dev->device_data = NULL;
 
 		list_add(&dev->list, &dmi_devices);
 	}
@@ -181,6 +201,9 @@ static void __init dmi_decode(struct dmi
 	case 10:	/* Onboard Devices Information */
 		dmi_save_devices(dm);
 		break;
+	case 11:	/* OEM Strings */
+		dmi_save_oem_strings_devices(dm);
+		break;
 	case 38:	/* IPMI Device Information */
 		dmi_save_ipmi_device(dm);
 	}
diff -puN include/linux/dmi.h~dmi-decode-and-save-oem-string-information include/linux/dmi.h
--- a/include/linux/dmi.h~dmi-decode-and-save-oem-string-information
+++ a/include/linux/dmi.h
@@ -27,7 +27,8 @@ enum dmi_device_type {
 	DMI_DEV_TYPE_ETHERNET,
 	DMI_DEV_TYPE_TOKENRING,
 	DMI_DEV_TYPE_SOUND,
-	DMI_DEV_TYPE_IPMI = -1
+	DMI_DEV_TYPE_IPMI = -1,
+	DMI_DEV_TYPE_OEM_STRING = -2
 };
 
 struct dmi_header {
_

--
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
