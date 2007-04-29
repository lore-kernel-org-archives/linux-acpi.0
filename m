From: Len Brown <len.brown@intel.com>
Subject: [PATCH 060/105] ACPI: thinkpad-acpi: clean up hotkey subdriver
Date: Sun, 29 Apr 2007 00:51:00 -0400
Message-ID: <11778223612093-git-send-email-len.brown@intel.com>
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
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11191 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756141AbXD2Ewn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:43 -0400
In-Reply-To: <11778223602019-git-send-email-len.brown@intel.com>
Message-Id: <b86c4722de62f336b82dff3c47ef59ba2a587ec1.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Cleanup hotkey subdriver code.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   46 ++++++++++++++++++++++++++---------------
 1 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 809ec84..344eb55 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -511,6 +511,8 @@ static int hotkey_orig_mask;
 
 static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
+	int res;
+
 	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
 
 	IBM_ACPIHANDLE_INIT(hkey);
@@ -530,8 +532,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		vdbg_printk(TPACPI_DBG_INIT, "hotkey masks are %s\n",
 			str_supported(tp_features.hotkey_mask));
 
-		if (!hotkey_get(&hotkey_orig_status, &hotkey_orig_mask))
-			return -ENODEV;
+		res = hotkey_get(&hotkey_orig_status, &hotkey_orig_mask);
+		if (res)
+			return res;
 	}
 
 	return (tp_features.hotkey)? 0 : 1;
@@ -539,9 +542,13 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 static void hotkey_exit(void)
 {
+	int res;
+
 	if (tp_features.hotkey) {
 		dbg_printk(TPACPI_DBG_EXIT, "restoring original hotkey mask\n");
-		hotkey_set(hotkey_orig_status, hotkey_orig_mask);
+		res = hotkey_set(hotkey_orig_status, hotkey_orig_mask);
+		if (res)
+			printk(IBM_ERR "failed to restore hotkey to BIOS defaults\n");
 	}
 }
 
@@ -560,13 +567,13 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 static int hotkey_get(int *status, int *mask)
 {
 	if (!acpi_evalf(hkey_handle, status, "DHKC", "d"))
-		return 0;
+		return -EIO;
 
 	if (tp_features.hotkey_mask)
 		if (!acpi_evalf(hkey_handle, mask, "DHKN", "d"))
-			return 0;
+			return -EIO;
 
-	return 1;
+	return 0;
 }
 
 static int hotkey_set(int status, int mask)
@@ -574,22 +581,22 @@ static int hotkey_set(int status, int mask)
 	int i;
 
 	if (!acpi_evalf(hkey_handle, NULL, "MHKC", "vd", status))
-		return 0;
+		return -EIO;
 
 	if (tp_features.hotkey_mask)
 		for (i = 0; i < 32; i++) {
 			int bit = ((1 << i) & mask) != 0;
 			if (!acpi_evalf(hkey_handle,
 					NULL, "MHKM", "vdd", i + 1, bit))
-				return 0;
+				return -EIO;
 		}
 
-	return 1;
+	return 0;
 }
 
 static int hotkey_read(char *p)
 {
-	int status, mask;
+	int res, status, mask;
 	int len = 0;
 
 	if (!tp_features.hotkey) {
@@ -597,8 +604,9 @@ static int hotkey_read(char *p)
 		return len;
 	}
 
-	if (!hotkey_get(&status, &mask))
-		return -EIO;
+	res = hotkey_get(&status, &mask);
+	if (res)
+		return res;
 
 	len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 0));
 	if (tp_features.hotkey_mask) {
@@ -615,15 +623,16 @@ static int hotkey_read(char *p)
 
 static int hotkey_write(char *buf)
 {
-	int status, mask;
+	int res, status, mask;
 	char *cmd;
 	int do_cmd = 0;
 
 	if (!tp_features.hotkey)
 		return -ENODEV;
 
-	if (!hotkey_get(&status, &mask))
-		return -EIO;
+	res = hotkey_get(&status, &mask);
+	if (res)
+		return res;
 
 	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "enable") == 0) {
@@ -642,8 +651,11 @@ static int hotkey_write(char *buf)
 		do_cmd = 1;
 	}
 
-	if (do_cmd && !hotkey_set(status, mask))
-		return -EIO;
+	if (do_cmd) {
+		res = hotkey_set(status, mask);
+		if (res)
+			return res;
+	}
 
 	return 0;
 }
-- 
1.5.2.rc0.34.gda94
