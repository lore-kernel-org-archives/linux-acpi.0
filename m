From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 14/21] ACPI: ibm-acpi: store embedded controller firmware version for matching
Date: Sat, 25 Nov 2006 18:46:37 -0200
Message-ID: <20061125204637.6604.92373.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35027 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S967191AbWKYUqe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Nov 2006 15:46:34 -0500
In-Reply-To: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This patch changes the ThinkPad Embedded Controller DMI matching
code to store the firmware version of the EC for later usage, e.g.
for quirks.

It also prints the firmware version when starting up.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---

 drivers/acpi/ibm_acpi.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 7ea4a26..af83977 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -77,6 +77,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/string.h>
 #include <linux/proc_fs.h>
 #include <linux/backlight.h>
 #include <asm/uaccess.h>
@@ -361,7 +362,7 @@ enum {					/* Fan control constants */
 						 * control */
 };
 
-static int ibm_thinkpad_ec_found;
+static char* ibm_thinkpad_ec_found = NULL;
 
 struct ibm_struct {
 	char *name;
@@ -2539,11 +2540,15 @@ static void acpi_ibm_exit(void)
 		ibm_exit(&ibms[i]);
 
 	remove_proc_entry(IBM_DIR, acpi_root_dir);
+
+	if (ibm_thinkpad_ec_found)
+		kfree(ibm_thinkpad_ec_found);
 }
 
-static int __init check_dmi_for_ec(void)
+static char* __init check_dmi_for_ec(void)
 {
 	struct dmi_device *dev = NULL;
+	char ec_fw_string[18];
 
 	/*
 	 * ThinkPad T23 or newer, A31 or newer, R50e or newer,
@@ -2553,10 +2558,15 @@ static int __init check_dmi_for_ec(void)
 	 * See http://thinkwiki.org/wiki/List_of_DMI_IDs
 	 */
 	while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, NULL, dev))) {
-		if (strstr(dev->name, "IBM ThinkPad Embedded Controller"))
-			return 1;
+		if (sscanf(dev->name,
+			   "IBM ThinkPad Embedded Controller -[%17c",
+			   ec_fw_string) == 1) {
+			ec_fw_string[sizeof(ec_fw_string) - 1] = 0;
+			ec_fw_string[strcspn(ec_fw_string, " ]")] = 0;
+			return kstrdup(ec_fw_string, GFP_KERNEL);
+		}
 	}
-	return 0;
+	return NULL;
 }
 
 static int __init acpi_ibm_init(void)
@@ -2580,6 +2590,9 @@ static int __init acpi_ibm_init(void)
 
 	/* Models with newer firmware report the EC in DMI */
 	ibm_thinkpad_ec_found = check_dmi_for_ec();
+	if (ibm_thinkpad_ec_found)
+		printk(IBM_INFO "ThinkPad EC firmware %s\n",
+		       ibm_thinkpad_ec_found);
 
 	/* these handles are not required */
 	IBM_HANDLE_INIT(vid);
