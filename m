From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/41] ACPI: ibm-acpi: cleanup init and exit paths
Date: Tue, 13 Feb 2007 00:49:27 -0500
Message-ID: <11713458152188-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39554 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751082AbXBMFuQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:16 -0500
In-Reply-To: <11713458143449-git-send-email-lenb@kernel.org>
Message-Id: <3945ac36af3da6014cde9836c5acc5b3adaaa379.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix a small memory leak on module removal, and other
assorted minor cleanups on the module init codepath.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ibm_acpi.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index c6144ca..2429e11 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -496,6 +496,10 @@ static int ibm_acpi_driver_init(void)
 	printk(IBM_INFO "%s v%s\n", IBM_DESC, IBM_VERSION);
 	printk(IBM_INFO "%s\n", IBM_URL);
 
+	if (ibm_thinkpad_ec_found)
+		printk(IBM_INFO "ThinkPad EC firmware %s\n",
+		       ibm_thinkpad_ec_found);
+
 	return 0;
 }
 
@@ -2617,7 +2621,7 @@ static void __init ibm_handle_init(char *name,
 	ibm_handle_init(#object, &object##_handle, *object##_parent,	\
 		object##_paths, ARRAY_SIZE(object##_paths), &object##_path)
 
-static int set_ibm_param(const char *val, struct kernel_param *kp)
+static int __init set_ibm_param(const char *val, struct kernel_param *kp)
 {
 	unsigned int i;
 
@@ -2659,7 +2663,8 @@ static void acpi_ibm_exit(void)
 	for (i = ARRAY_SIZE(ibms) - 1; i >= 0; i--)
 		ibm_exit(&ibms[i]);
 
-	remove_proc_entry(IBM_DIR, acpi_root_dir);
+	if (proc_dir)
+		remove_proc_entry(IBM_DIR, acpi_root_dir);
 
 	if (ibm_thinkpad_ec_found)
 		kfree(ibm_thinkpad_ec_found);
@@ -2710,9 +2715,6 @@ static int __init acpi_ibm_init(void)
 
 	/* Models with newer firmware report the EC in DMI */
 	ibm_thinkpad_ec_found = check_dmi_for_ec();
-	if (ibm_thinkpad_ec_found)
-		printk(IBM_INFO "ThinkPad EC firmware %s\n",
-		       ibm_thinkpad_ec_found);
 
 	/* these handles are not required */
 	IBM_HANDLE_INIT(vid);
@@ -2742,6 +2744,7 @@ static int __init acpi_ibm_init(void)
 	proc_dir = proc_mkdir(IBM_DIR, acpi_root_dir);
 	if (!proc_dir) {
 		printk(IBM_ERR "unable to create proc dir %s", IBM_DIR);
+		acpi_ibm_exit();
 		return -ENODEV;
 	}
 	proc_dir->owner = THIS_MODULE;
-- 
1.5.0.rc4.345.gb4d2
