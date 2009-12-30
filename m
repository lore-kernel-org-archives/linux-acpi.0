From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/14] ACPI: WMI: Survive BIOS with duplicate GUIDs
Date: Wed, 30 Dec 2009 02:36:35 -0500
Message-ID: <10ebbe5442bb9c61e315b5640ee9103c9d19193a.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:64677 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZL3X1J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 18:27:09 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVH007CENT0HQT5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 17:27:07 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>

=46rom: Carlos Corbacho <carlos@strangeworlds.co.uk>

It would appear that in BIOS's with nVidia hooks, the GUID
05901221-D566-11D1-B2F0-00A0C9062910 is duplicated. For now, the simple=
st
solution is to just ignore any duplicate GUIDs. These particular hooks =
are not
currently supported/ used in the kernel, so whoever does that can figur=
e out
what the 'right' solution should be (if there's a better one).

http://bugzilla.kernel.org/show_bug.cgi?id=3D14846

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Reported-by: Old=C5=99ich Jedli=C4=8Dka <oldium.pro@seznam.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/wmi.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index cc9ad74..b104302 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -714,6 +714,22 @@ static int wmi_class_init(void)
 	return ret;
 }
=20
+static bool guid_already_parsed(const char *guid_string)
+{
+	struct guid_block *gblock;
+	struct wmi_block *wblock;
+	struct list_head *p;
+
+	list_for_each(p, &wmi_blocks.list) {
+		wblock =3D list_entry(p, struct wmi_block, list);
+		gblock =3D &wblock->gblock;
+
+		if (strncmp(gblock->guid, guid_string, 16) =3D=3D 0)
+			return true;
+	}
+	return false;
+}
+
 /*
  * Parse the _WDG method for the GUID data blocks
  */
@@ -723,6 +739,7 @@ static __init acpi_status parse_wdg(acpi_handle han=
dle)
 	union acpi_object *obj;
 	struct guid_block *gblock;
 	struct wmi_block *wblock;
+	char guid_string[37];
 	acpi_status status;
 	u32 i, total;
=20
@@ -745,6 +762,19 @@ static __init acpi_status parse_wdg(acpi_handle ha=
ndle)
 	memcpy(gblock, obj->buffer.pointer, obj->buffer.length);
=20
 	for (i =3D 0; i < total; i++) {
+		/*
+		  Some WMI devices, like those for nVidia hooks, have a
+		  duplicate GUID. It's not clear what we should do in this
+		  case yet, so for now, we'll just ignore the duplicate.
+		  Anyone who wants to add support for that device can come
+		  up with a better workaround for the mess then.
+		*/
+		if (guid_already_parsed(gblock[i].guid) =3D=3D true) {
+			wmi_gtoa(gblock[i].guid, guid_string);
+			printk(KERN_INFO PREFIX "Skipping duplicate GUID %s\n",
+				guid_string);
+			continue;
+		}
 		wblock =3D kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
 		if (!wblock)
 			return AE_NO_MEMORY;
--=20
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
