From: akpm@osdl.org
Subject: [patch 19/19] asus_acpi: Add support for Asus Z81SP
Date: Tue, 19 Dec 2006 12:56:25 -0800
Message-ID: <200612192056.kBJKuP7b010068@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:34507 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932959AbWLSU5N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 15:57:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, calvinmc@gmail.com

From: Matthew C Campbell <calvinmc@gmail.com>

Adds support in asus_acpi for the Asus Z81SP laptop.  This preserves all
old functionality when improperly detected as well as enabling Bluetooth
support.

Signed-off-by: Matthew C Campbell <calvinmc@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/asus_acpi.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/asus_acpi.c~asus_acpi-add-support-for-asus-z81sp drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c~asus_acpi-add-support-for-asus-z81sp
+++ a/drivers/acpi/asus_acpi.c
@@ -145,6 +145,7 @@ struct asus_hotk {
 		W5F,            //W5F
 		V6V,            //V6V
 		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
+		A4S,            //Z81sp
 		//(Centrino)
 		END_MODEL
 	} model;		//Models currently supported
@@ -450,7 +451,16 @@ static struct model_data model_conf[END_
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
@@ -1188,6 +1198,8 @@ static int asus_model_match(char *model)
 		return W5F;
 	else if (strncmp(model, "V6V", 3) == 0)
 		return V6V;
+	else if (strncmp(model, "A4S", 3) == 0)
+		return A4S;
 	else
 		return END_MODEL;
 }
_
