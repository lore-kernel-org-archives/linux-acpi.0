From: Len Brown <len.brown@intel.com>
Subject: [PATCH 063/105] ACPI: thinkpad-acpi: clean up CMOS commands subdriver
Date: Sun, 29 Apr 2007 00:51:03 -0400
Message-ID: <11778223633408-git-send-email-len.brown@intel.com>
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
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11191 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754576AbXD2Ewp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:45 -0400
In-Reply-To: <11778223624095-git-send-email-len.brown@intel.com>
Message-Id: <c9bea99c1a712548db3437cbca52b0da8f30069c.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Some ThinkPad CMOS commands subdriver cleanups, and also rename/promote
cmos_eval to a ACPI helper function, as it is used by many other
subdrivers.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   39 ++++++++++++++++++++-------------------
 drivers/misc/thinkpad_acpi.h |    4 +++-
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 19c14bb..8829d3c 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -273,6 +273,17 @@ static int _sta(acpi_handle handle)
 	return status;
 }
 
+static int issue_thinkpad_cmos_command(int cmos_cmd)
+{
+	if (!cmos_handle)
+		return -ENXIO;
+
+	if (!acpi_evalf(cmos_handle, NULL, NULL, "vd", cmos_cmd))
+		return -EIO;
+
+	return 0;
+}
+
 /*************************************************************************
  * ACPI device model
  */
@@ -1550,14 +1561,6 @@ static int __init cmos_init(struct ibm_init_struct *iibm)
 	return (cmos_handle)? 0 : 1;
 }
 
-static int cmos_eval(int cmos_cmd)
-{
-	if (cmos_handle)
-		return acpi_evalf(cmos_handle, NULL, NULL, "vd", cmos_cmd);
-	else
-		return 1;
-}
-
 static int cmos_read(char *p)
 {
 	int len = 0;
@@ -1577,10 +1580,7 @@ static int cmos_read(char *p)
 static int cmos_write(char *buf)
 {
 	char *cmd;
-	int cmos_cmd;
-
-	if (!cmos_handle)
-		return -EINVAL;
+	int cmos_cmd, res;
 
 	while ((cmd = next_cmd(&buf))) {
 		if (sscanf(cmd, "%u", &cmos_cmd) == 1 &&
@@ -1589,8 +1589,9 @@ static int cmos_write(char *buf)
 		} else
 			return -EINVAL;
 
-		if (!cmos_eval(cmos_cmd))
-			return -EIO;
+		res = issue_thinkpad_cmos_command(cmos_cmd);
+		if (res)
+			return res;
 	}
 
 	return 0;
@@ -2093,7 +2094,7 @@ static int brightness_set(int value)
 	cmos_cmd = value > current_value ? TP_CMOS_BRIGHTNESS_UP : TP_CMOS_BRIGHTNESS_DOWN;
 	inc = value > current_value ? 1 : -1;
 	for (i = current_value; i != value; i += inc) {
-		if (!cmos_eval(cmos_cmd))
+		if (issue_thinkpad_cmos_command(cmos_cmd))
 			return -EIO;
 		if (!acpi_ec_write(brightness_offset, i + inc))
 			return -EIO;
@@ -2210,16 +2211,16 @@ static int volume_write(char *buf)
 			cmos_cmd = new_level > level ? TP_CMOS_VOLUME_UP : TP_CMOS_VOLUME_DOWN;
 			inc = new_level > level ? 1 : -1;
 
-			if (mute && (!cmos_eval(cmos_cmd) ||
+			if (mute && (issue_thinkpad_cmos_command(cmos_cmd) ||
 				     !acpi_ec_write(volume_offset, level)))
 				return -EIO;
 
 			for (i = level; i != new_level; i += inc)
-				if (!cmos_eval(cmos_cmd) ||
+				if (issue_thinkpad_cmos_command(cmos_cmd) ||
 				    !acpi_ec_write(volume_offset, i + inc))
 					return -EIO;
 
-			if (mute && (!cmos_eval(TP_CMOS_VOLUME_MUTE) ||
+			if (mute && (issue_thinkpad_cmos_command(TP_CMOS_VOLUME_MUTE) ||
 				     !acpi_ec_write(volume_offset,
 						    new_level + mute)))
 				return -EIO;
@@ -2228,7 +2229,7 @@ static int volume_write(char *buf)
 		if (new_mute != mute) {	/* level doesn't change */
 			cmos_cmd = new_mute ? TP_CMOS_VOLUME_MUTE : TP_CMOS_VOLUME_UP;
 
-			if (!cmos_eval(cmos_cmd) ||
+			if (issue_thinkpad_cmos_command(cmos_cmd) ||
 			    !acpi_ec_write(volume_offset, level + new_mute))
 				return -EIO;
 		}
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 3a8718a..fb0abb0 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -116,6 +116,9 @@ static void drv_acpi_handle_init(char *name,
 	drv_acpi_handle_init(#object, &object##_handle, *object##_parent,	\
 		object##_paths, ARRAY_SIZE(object##_paths), &object##_path)
 
+/* ThinkPad ACPI helpers */
+static int issue_thinkpad_cmos_command(int cmos_cmd);
+
 /* procfs support */
 static struct proc_dir_entry *proc_dir;
 
@@ -275,7 +278,6 @@ static int brightness_write(char *buf);
  * CMOS subdriver
  */
 
-static int cmos_eval(int cmos_cmd);
 static int cmos_read(char *p);
 static int cmos_write(char *buf);
 
-- 
1.5.2.rc0.34.gda94
