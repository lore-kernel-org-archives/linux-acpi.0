From: Len Brown <len.brown@intel.com>
Subject: [PATCH 048/105] ACPI: thinkpad-acpi: rename module glue
Date: Sun, 29 Apr 2007 00:50:48 -0400
Message-ID: <11778223502745-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54971 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108AbXD2Ewf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:35 -0400
In-Reply-To: <11778223493327-git-send-email-len.brown@intel.com>
Message-Id: <1def7115f0277ce9d2a54efd0ae187aa88d5c7fa.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Rename module init and exit functions, now that we are not called ibm-acpi
anymore.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   12 ++++++------
 drivers/misc/thinkpad_acpi.h |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 4b43486..80ef195 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2707,7 +2707,7 @@ IBM_PARAM(brightness);
 IBM_PARAM(volume);
 IBM_PARAM(fan);
 
-static int __init acpi_ibm_init(void)
+static int __init thinkpad_acpi_module_init(void)
 {
 	int ret, i;
 
@@ -2754,7 +2754,7 @@ static int __init acpi_ibm_init(void)
 	proc_dir = proc_mkdir(IBM_DIR, acpi_root_dir);
 	if (!proc_dir) {
 		printk(IBM_ERR "unable to create proc dir %s", IBM_DIR);
-		acpi_ibm_exit();
+		thinkpad_acpi_module_exit();
 		return -ENODEV;
 	}
 	proc_dir->owner = THIS_MODULE;
@@ -2764,7 +2764,7 @@ static int __init acpi_ibm_init(void)
 		if (ret >= 0 && *ibms[i].param)
 			ret = ibms[i].write(ibms[i].param);
 		if (ret < 0) {
-			acpi_ibm_exit();
+			thinkpad_acpi_module_exit();
 			return ret;
 		}
 	}
@@ -2772,7 +2772,7 @@ static int __init acpi_ibm_init(void)
 	return 0;
 }
 
-static void acpi_ibm_exit(void)
+static void thinkpad_acpi_module_exit(void)
 {
 	int i;
 
@@ -2786,5 +2786,5 @@ static void acpi_ibm_exit(void)
 		kfree(ibm_thinkpad_ec_found);
 }
 
-module_init(acpi_ibm_init);
-module_exit(acpi_ibm_exit);
+module_init(thinkpad_acpi_module_init);
+module_exit(thinkpad_acpi_module_exit);
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index b86e574..8b2fd1a 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -115,8 +115,8 @@ static int experimental;
 static char *ibm_thinkpad_ec_found;
 
 static char* check_dmi_for_ec(void);
-static int acpi_ibm_init(void);
-static void acpi_ibm_exit(void);
+static int thinkpad_acpi_module_init(void);
+static void thinkpad_acpi_module_exit(void);
 
 
 /****************************************************************************
-- 
1.5.2.rc0.34.gda94
