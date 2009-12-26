From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH] ACPI: WMI: Handle duplicate GUIDs
Date: Sat, 26 Dec 2009 19:14:59 +0000
Message-ID: <200912261914.59515.carlos@strangeworlds.co.uk>
References: <4B352513.90302@lwfinger.net> <200912261836.41882.carlos@strangeworlds.co.uk> <4B365E56.9030302@lwfinger.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:9897 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbZLZTPE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Dec 2009 14:15:04 -0500
In-Reply-To: <4B365E56.9030302@lwfinger.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Matthew Garrett <mjg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ACPI <linux-acpi@vger.kernel.org>, lenb@kernel.org

It would appear that in BIOS's with nVidia hooks, the GUID
05901221-D566-11D1-B2F0-00A0C9062910 is duplicated. For now, the simple=
st
solution is to just ignore any duplicate GUIDs. These particular hooks =
are not
currently supported/ used in the kernel, so whoever does that can figur=
e out
what the 'right' solution should be (if there's a better one).

=46ixes kernel bugzilla #14846

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Reported-by: Old=C5=99ich Jedli=C4=8Dka <oldium.pro@seznam.cz>
---
Len,

Can you get this out ASAP, as it fixes a regression with the WMI autolo=
ading code.

 drivers/platform/x86/wmi.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 9f93d6c..845aaf6 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -716,6 +716,22 @@ static int wmi_class_init(void)
 	return ret;
 }
=20
+static bool guid_already_parsed(const char *guid_string) {
+	struct guid_block *gblock;
+	struct wmi_block *wblock;
+	struct list_head *p;
+
+	list_for_each(p, &wmi_blocks.list) {
+		wblock =3D list_entry(p, struct wmi_block, list);
+		gblock =3D &wblock->gblock;
+
+		if (strncmp(gblock->guid, guid_string, 16) =3D=3D 0) {
+			return true;
+		}
+	}
+	return false;
+}
+
 /*
  * Parse the _WDG method for the GUID data blocks
  */
@@ -725,6 +741,7 @@ static __init acpi_status parse_wdg(acpi_handle han=
dle)
 	union acpi_object *obj;
 	struct guid_block *gblock;
 	struct wmi_block *wblock;
+	char guid_string[37];
 	acpi_status status;
 	u32 i, total;
=20
@@ -747,6 +764,19 @@ static __init acpi_status parse_wdg(acpi_handle ha=
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
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
