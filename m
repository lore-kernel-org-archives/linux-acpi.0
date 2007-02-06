From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/2] ACPI: ibm-acpi: cleanup init and exit paths
Date: Tue,  6 Feb 2007 19:13:44 -0200
Message-ID: <11707964241860-git-send-email-hmh@hmh.eng.br>
References: <11707964241851-git-send-email-hmh@hmh.eng.br> <11707964243869-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:37833 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965496AbXBFVN5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Feb 2007 16:13:57 -0500
In-Reply-To: <11707964243869-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This patch fixes a small memory leak on module removal, and does other
assorted minor cleanups on the module init codepath.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/acpi/ibm_acpi.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 5c0f1b8..20cbde5 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -497,6 +497,10 @@ static int ibm_acpi_driver_init(void)
 	printk(IBM_INFO "%s v%s\n", IBM_DESC, IBM_VERSION);
 	printk(IBM_INFO "%s\n", IBM_URL);
 
+	if (ibm_thinkpad_ec_found)
+		printk(IBM_INFO "ThinkPad EC firmware %s\n",
+		       ibm_thinkpad_ec_found);
+
 	return 0;
 }
 
@@ -2618,7 +2622,7 @@ static void __init ibm_handle_init(char *name,
 	ibm_handle_init(#object, &object##_handle, *object##_parent,	\
 		object##_paths, ARRAY_SIZE(object##_paths), &object##_path)
 
-static int set_ibm_param(const char *val, struct kernel_param *kp)
+static int __init set_ibm_param(const char *val, struct kernel_param *kp)
 {
 	unsigned int i;
 
@@ -2660,7 +2664,8 @@ static void acpi_ibm_exit(void)
 	for (i = ARRAY_SIZE(ibms) - 1; i >= 0; i--)
 		ibm_exit(&ibms[i]);
 
-	remove_proc_entry(IBM_DIR, acpi_root_dir);
+	if (proc_dir)
+		remove_proc_entry(IBM_DIR, acpi_root_dir);
 
 	if (ibm_thinkpad_ec_found)
 		kfree(ibm_thinkpad_ec_found);
@@ -2711,9 +2716,6 @@ static int __init acpi_ibm_init(void)
 
 	/* Models with newer firmware report the EC in DMI */
 	ibm_thinkpad_ec_found = check_dmi_for_ec();
-	if (ibm_thinkpad_ec_found)
-		printk(IBM_INFO "ThinkPad EC firmware %s\n",
-		       ibm_thinkpad_ec_found);
 
 	/* these handles are not required */
 	IBM_HANDLE_INIT(vid);
@@ -2743,6 +2745,7 @@ static int __init acpi_ibm_init(void)
 	proc_dir = proc_mkdir(IBM_DIR, acpi_root_dir);
 	if (!proc_dir) {
 		printk(IBM_ERR "unable to create proc dir %s", IBM_DIR);
+		acpi_ibm_exit();
 		return -ENODEV;
 	}
 	proc_dir->owner = THIS_MODULE;
-- 
1.4.4.4

