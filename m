From: akpm@linux-foundation.org
Subject: [patch 03/13] asus_acpi: Add support for Asus Z81SP
Date: Mon, 05 Feb 2007 16:09:09 -0800
Message-ID: <200702060010.l160ACsX003721@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:40701 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965158AbXBFALu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Feb 2007 19:11:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, calvinmc@gmail.com, acpi4asus-user@lists.sourceforge.net, corentincj@iksaif.net, sziwan@users.sourceforge.net

From: Matthew C Campbell <calvinmc@gmail.com>

Adds support in asus_acpi for the Asus Z81SP laptop.  This preserves all
old functionality when improperly detected as well as enabling Bluetooth
support.

Signed-off-by: Matthew C Campbell <calvinmc@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>
Cc: Karol Kozimor <sziwan@users.sourceforge.net>
Cc: <acpi4asus-user@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/asus_acpi.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/asus_acpi.c~asus_acpi-add-support-for-asus-z81sp drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c~asus_acpi-add-support-for-asus-z81sp
+++ a/drivers/acpi/asus_acpi.c
@@ -141,6 +141,7 @@ struct asus_hotk {
 		W5A,		//W5A
 		W3V,            //W3030V
 		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
+		A4S,            //Z81sp
 		//(Centrino)
 		END_MODEL
 	} model;		//Models currently supported
@@ -397,7 +398,16 @@ static struct model_data model_conf[END_
 	 .brightness_set = "SPLV",
 	 .brightness_get = "GPLV",
 	 .display_set = "SDSP",
-	 .display_get = "\\ADVG"}
+	.display_get = "\\ADVG"},
+
+	{
+		.name              = "A4S",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.mt_bt_switch      = "BLED",
+		.mt_wled           = "WLED"
+	}
+
 };
 
 /* procdir we use */
@@ -1117,6 +1127,8 @@ static int asus_model_match(char *model)
 		return W3V;
 	else if (strncmp(model, "W5A", 3) == 0)
 		return W5A;
+	else if (strncmp(model, "A4S", 3) == 0)
+		return A4S;
 	else
 		return END_MODEL;
 }
_
