From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 07/10] ACPI: thinkpad-acpi: refactor hotkey_get and hotkey_set
Date: Sat, 13 Oct 2007 17:22:56 -0300
Message-ID: <1192306979-26886-8-git-send-email-hmh@hmh.eng.br>
References: <1192306979-26886-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45406 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753532AbXJMUXS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Oct 2007 16:23:18 -0400
In-Reply-To: <1192306979-26886-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This patch:

1. Splits hotkey_get/set into hotkey_status_get/set and hotkey_mask_get/set;
2. Caches the status of hot key mask for later driver use;
3. Makes sure the cache of hot key mask is refreshed when needed;
4. logs a printk notice when the firmware doesn't set the hot key
   mask to exactly what we asked it to;
5. Do the proper locking on the data structures.

Only (4) is user-noticeable, unless (5) fixes some corner-case races.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |  184 +++++++++++++++++++++++++-----------------
 drivers/misc/thinkpad_acpi.h |    2 -
 2 files changed, 109 insertions(+), 77 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 3b78d51..6c560c4 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -777,6 +777,7 @@ static int hotkey_orig_status;
 static u32 hotkey_orig_mask;
 static u32 hotkey_all_mask;
 static u32 hotkey_reserved_mask;
+static u32 hotkey_mask;
 
 static u16 *hotkey_keycode_map;
 
@@ -789,15 +790,76 @@ static int hotkey_get_wlsw(int *status)
 	return 0;
 }
 
+/*
+ * Call with hotkey_mutex held
+ */
+static int hotkey_mask_get(void)
+{
+	if (tp_features.hotkey_mask) {
+		if (!acpi_evalf(hkey_handle, &hotkey_mask, "DHKN", "d"))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * Call with hotkey_mutex held
+ */
+static int hotkey_mask_set(u32 mask)
+{
+	int i;
+	int rc = 0;
+
+	if (tp_features.hotkey_mask) {
+		for (i = 0; i < 32; i++) {
+			u32 m = 1 << i;
+			if (!acpi_evalf(hkey_handle,
+					NULL, "MHKM", "vdd", i + 1,
+					!!(mask & m))) {
+				rc = -EIO;
+				break;
+			} else {
+				hotkey_mask = (hotkey_mask & ~m) | (mask & m);
+			}
+		}
+
+		/* hotkey_mask_get must be called unconditionally below */
+		if (!hotkey_mask_get() && !rc && hotkey_mask != mask) {
+			printk(IBM_NOTICE
+			       "requested hot key mask 0x%08x, but "
+			       "firmware forced it to 0x%08x\n",
+			       mask, hotkey_mask);
+		}
+	}
+
+	return rc;
+}
+
+static int hotkey_status_get(int *status)
+{
+	if (!acpi_evalf(hkey_handle, status, "DHKC", "d"))
+		return -EIO;
+
+	return 0;
+}
+
+static int hotkey_status_set(int status)
+{
+	if (!acpi_evalf(hkey_handle, NULL, "MHKC", "vd", status))
+		return -EIO;
+
+	return 0;
+}
+
 /* sysfs hotkey enable ------------------------------------------------- */
 static ssize_t hotkey_enable_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
 	int res, status;
-	u32 mask;
 
-	res = hotkey_get(&status, &mask);
+	res = hotkey_status_get(&status);
 	if (res)
 		return res;
 
@@ -809,15 +871,12 @@ static ssize_t hotkey_enable_store(struct device *dev,
 			    const char *buf, size_t count)
 {
 	unsigned long t;
-	int res, status;
-	u32 mask;
+	int res;
 
 	if (parse_strtoul(buf, 1, &t))
 		return -EINVAL;
 
-	res = hotkey_get(&status, &mask);
-	if (!res)
-		res = hotkey_set(t, mask);
+	res = hotkey_status_set(t);
 
 	return (res) ? res : count;
 }
@@ -831,14 +890,15 @@ static ssize_t hotkey_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	int res, status;
-	u32 mask;
+	int res;
 
-	res = hotkey_get(&status, &mask);
-	if (res)
-		return res;
+	if (mutex_lock_interruptible(&hotkey_mutex))
+		return -ERESTARTSYS;
+	res = hotkey_mask_get();
+	mutex_unlock(&hotkey_mutex);
 
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", mask);
+	return (res)?
+		res : snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_mask);
 }
 
 static ssize_t hotkey_mask_store(struct device *dev,
@@ -846,15 +906,16 @@ static ssize_t hotkey_mask_store(struct device *dev,
 			    const char *buf, size_t count)
 {
 	unsigned long t;
-	int res, status;
-	u32 mask;
+	int res;
 
 	if (parse_strtoul(buf, 0xffffffffUL, &t))
 		return -EINVAL;
 
-	res = hotkey_get(&status, &mask);
-	if (!res)
-		hotkey_set(status, t);
+	if (mutex_lock_interruptible(&hotkey_mutex))
+		return -ERESTARTSYS;
+
+	res = hotkey_mask_set(t);
+	mutex_unlock(&hotkey_mutex);
 
 	return (res) ? res : count;
 }
@@ -1065,11 +1126,16 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			}
 		}
 
-		res = hotkey_get(&hotkey_orig_status, &hotkey_orig_mask);
+		res = hotkey_status_get(&hotkey_orig_status);
 		if (!res && tp_features.hotkey_mask) {
-			res = add_many_to_attr_set(hotkey_dev_attributes,
-				hotkey_mask_attributes,
-				ARRAY_SIZE(hotkey_mask_attributes));
+			res = hotkey_mask_get();
+			hotkey_orig_mask = hotkey_mask;
+			if (!res) {
+				res = add_many_to_attr_set(
+					hotkey_dev_attributes,
+					hotkey_mask_attributes,
+					ARRAY_SIZE(hotkey_mask_attributes));
+			}
 		}
 
 		/* Not all thinkpads have a hardware radio switch */
@@ -1133,7 +1199,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 		dbg_printk(TPACPI_DBG_INIT,
 				"enabling hot key handling\n");
-		res = hotkey_set(1, (hotkey_all_mask & ~hotkey_reserved_mask)
+		res = hotkey_status_set(1);
+		if (res)
+			return res;
+		res = hotkey_mask_set((hotkey_all_mask & ~hotkey_reserved_mask)
 					| hotkey_orig_mask);
 		if (res)
 			return res;
@@ -1149,13 +1218,12 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 static void hotkey_exit(void)
 {
-	int res;
-
 	if (tp_features.hotkey) {
-		dbg_printk(TPACPI_DBG_EXIT, "restoring original hotkey mask\n");
-		res = hotkey_set(hotkey_orig_status, hotkey_orig_mask);
-		if (res)
-			printk(IBM_ERR "failed to restore hotkey to BIOS defaults\n");
+		dbg_printk(TPACPI_DBG_EXIT, "restoring original hot key mask\n");
+		/* no short-circuit boolean operator below! */
+		if ((hotkey_mask_set(hotkey_orig_mask) |
+		     hotkey_status_set(hotkey_orig_status)) != 0)
+			printk(IBM_ERR "failed to restore hot key mask to BIOS defaults\n");
 	}
 
 	if (hotkey_dev_attributes) {
@@ -1291,50 +1359,15 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 
 static void hotkey_resume(void)
 {
+	if (hotkey_mask_get())
+		printk(IBM_ERR "error while trying to read hot key mask from firmware\n");
 	tpacpi_input_send_radiosw();
 }
 
-/*
- * Call with hotkey_mutex held
- */
-static int hotkey_get(int *status, u32 *mask)
-{
-	if (!acpi_evalf(hkey_handle, status, "DHKC", "d"))
-		return -EIO;
-
-	if (tp_features.hotkey_mask)
-		if (!acpi_evalf(hkey_handle, mask, "DHKN", "d"))
-			return -EIO;
-
-	return 0;
-}
-
-/*
- * Call with hotkey_mutex held
- */
-static int hotkey_set(int status, u32 mask)
-{
-	int i;
-
-	if (!acpi_evalf(hkey_handle, NULL, "MHKC", "vd", status))
-		return -EIO;
-
-	if (tp_features.hotkey_mask)
-		for (i = 0; i < 32; i++) {
-			int bit = ((1 << i) & mask) != 0;
-			if (!acpi_evalf(hkey_handle,
-					NULL, "MHKM", "vdd", i + 1, bit))
-				return -EIO;
-		}
-
-	return 0;
-}
-
 /* procfs -------------------------------------------------------------- */
 static int hotkey_read(char *p)
 {
 	int res, status;
-	u32 mask;
 	int len = 0;
 
 	if (!tp_features.hotkey) {
@@ -1344,14 +1377,16 @@ static int hotkey_read(char *p)
 
 	if (mutex_lock_interruptible(&hotkey_mutex))
 		return -ERESTARTSYS;
-	res = hotkey_get(&status, &mask);
+	res = hotkey_status_get(&status);
+	if (!res)
+		res = hotkey_mask_get();
 	mutex_unlock(&hotkey_mutex);
 	if (res)
 		return res;
 
 	len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 0));
 	if (tp_features.hotkey_mask) {
-		len += sprintf(p + len, "mask:\t\t0x%08x\n", mask);
+		len += sprintf(p + len, "mask:\t\t0x%08x\n", hotkey_mask);
 		len += sprintf(p + len,
 			       "commands:\tenable, disable, reset, <mask>\n");
 	} else {
@@ -1367,7 +1402,6 @@ static int hotkey_write(char *buf)
 	int res, status;
 	u32 mask;
 	char *cmd;
-	int do_cmd = 0;
 
 	if (!tp_features.hotkey)
 		return -ENODEV;
@@ -1375,9 +1409,8 @@ static int hotkey_write(char *buf)
 	if (mutex_lock_interruptible(&hotkey_mutex))
 		return -ERESTARTSYS;
 
-	res = hotkey_get(&status, &mask);
-	if (res)
-		goto errexit;
+	status = -1;
+	mask = hotkey_mask;
 
 	res = 0;
 	while ((cmd = next_cmd(&buf))) {
@@ -1396,11 +1429,12 @@ static int hotkey_write(char *buf)
 			res = -EINVAL;
 			goto errexit;
 		}
-		do_cmd = 1;
 	}
+	if (status != -1)
+		res = hotkey_status_set(status);
 
-	if (do_cmd)
-		res = hotkey_set(status, mask);
+	if (!res && mask != hotkey_mask)
+		res = hotkey_mask_set(mask);
 
 errexit:
 	mutex_unlock(&hotkey_mutex);
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 3c0edd8..a919fb8 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -461,8 +461,6 @@ static struct mutex hotkey_mutex;
 
 static int hotkey_init(struct ibm_init_struct *iibm);
 static void hotkey_exit(void);
-static int hotkey_get(int *status, u32 *mask);
-static int hotkey_set(int status, u32 mask);
 static void hotkey_notify(struct ibm_struct *ibm, u32 event);
 static int hotkey_read(char *p);
 static int hotkey_write(char *buf);
-- 
1.5.3.2

