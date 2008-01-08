From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 02/20] ACPI: thinkpad-acpi: refactor
	hotkey_get and hotkey_set (v2)
Date: Tue,  8 Jan 2008 13:02:39 -0200
Message-ID: <1199804577-32017-3-git-send-email-hmh@hmh.eng.br>
References: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1199804577-32017-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Refactor and organize the code a bit for the NVRAM polling support:

1. Split hotkey_get/set into hotkey_status_get/set and hotkey_mask_get/set;
2. Cache the status of hot key mask for later driver use;
3. Make sure the cache of hot key mask is refreshed when needed;
4. log a printk notice when the firmware doesn't set the hot key
   mask to exactly what we asked it to;
5. Add proper locking to the data structures.

Only (4) should be user-noticeable, but there is a chance (5) fixes
some unknown/unreported race conditions.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |  184 +++++++++++++++++++++++++-----------------
 drivers/misc/thinkpad_acpi.h |    2 -
 2 files changed, 109 insertions(+), 77 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 7b1080f..49d4f4a 100644
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
@@ -1123,11 +1184,16 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
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
@@ -1191,7 +1257,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
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
@@ -1207,13 +1276,12 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
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
@@ -1349,50 +1417,15 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 
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
@@ -1402,14 +1435,16 @@ static int hotkey_read(char *p)
 
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
@@ -1425,7 +1460,6 @@ static int hotkey_write(char *buf)
 	int res, status;
 	u32 mask;
 	char *cmd;
-	int do_cmd = 0;
 
 	if (!tp_features.hotkey)
 		return -ENODEV;
@@ -1433,9 +1467,8 @@ static int hotkey_write(char *buf)
 	if (mutex_lock_interruptible(&hotkey_mutex))
 		return -ERESTARTSYS;
 
-	res = hotkey_get(&status, &mask);
-	if (res)
-		goto errexit;
+	status = -1;
+	mask = hotkey_mask;
 
 	res = 0;
 	while ((cmd = next_cmd(&buf))) {
@@ -1454,11 +1487,12 @@ static int hotkey_write(char *buf)
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
index 8fba2bb..3b03134 100644
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
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
