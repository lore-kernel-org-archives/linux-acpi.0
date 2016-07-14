From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/3] ACPI / debugger: Add kernel flushing support
Date: Thu, 14 Jul 2016 10:52:37 +0800
Message-ID: <71c8414d9520dcdf460a6559ff312a1da839af79.1468464391.git.lv.zheng@intel.com>
References: <cover.1468464391.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:58335 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbcGNCwp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jul 2016 22:52:45 -0400
In-Reply-To: <cover.1468464391.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch adds debugger log flushing support in kernel via .fsync()
callback. The in-kernel flushing is more efficient, because it reduces
useless log IOs by bypassing log user_read/kern_write during the flush
period.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpi_dbg.c |   94 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index dee8692..90d6922 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -46,6 +46,8 @@
 #define ACPI_AML_KERN		(ACPI_AML_IN_KERN | ACPI_AML_OUT_KERN)
 #define ACPI_AML_BUSY		(ACPI_AML_USER | ACPI_AML_KERN)
 #define ACPI_AML_OPEN		(ACPI_AML_OPENED | ACPI_AML_CLOSED)
+#define ACPI_AML_FLUSHING_LOG	0x0040 /* flushing log output */
+#define ACPI_AML_WAITING_CMD	0x0080 /* waiting for cmd input */
 
 struct acpi_aml_io {
 	wait_queue_head_t wait;
@@ -120,6 +122,20 @@ static inline bool __acpi_aml_busy(void)
 	return false;
 }
 
+static inline bool __acpi_aml_waiting_cmd(void)
+{
+	if (acpi_aml_io.flags & ACPI_AML_WAITING_CMD)
+		return true;
+	return false;
+}
+
+static inline bool __acpi_aml_flushing_log(void)
+{
+	if (acpi_aml_io.flags & ACPI_AML_FLUSHING_LOG)
+		return true;
+	return false;
+}
+
 static inline bool __acpi_aml_opened(void)
 {
 	if (acpi_aml_io.flags & ACPI_AML_OPEN)
@@ -152,6 +168,26 @@ static bool acpi_aml_busy(void)
 	return ret;
 }
 
+static inline bool acpi_aml_waiting_cmd(void)
+{
+	bool ret;
+
+	mutex_lock(&acpi_aml_io.lock);
+	ret = __acpi_aml_waiting_cmd();
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static inline bool acpi_aml_flushing_log(void)
+{
+	bool ret;
+
+	mutex_lock(&acpi_aml_io.lock);
+	ret = __acpi_aml_flushing_log();
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
 static bool acpi_aml_used(void)
 {
 	bool ret;
@@ -183,7 +219,8 @@ static bool acpi_aml_kern_writable(void)
 
 	mutex_lock(&acpi_aml_io.lock);
 	ret = !__acpi_aml_access_ok(ACPI_AML_OUT_KERN) ||
-	      __acpi_aml_writable(&acpi_aml_io.out_crc, ACPI_AML_OUT_KERN);
+	      __acpi_aml_writable(&acpi_aml_io.out_crc, ACPI_AML_OUT_KERN) ||
+	      __acpi_aml_flushing_log();
 	mutex_unlock(&acpi_aml_io.lock);
 	return ret;
 }
@@ -264,6 +301,9 @@ static int acpi_aml_write_kern(const char *buf, int len)
 	int n;
 	char *p;
 
+	if (acpi_aml_flushing_log())
+		return len;
+
 	ret = acpi_aml_lock_write(crc, ACPI_AML_OUT_KERN);
 	if (ret < 0)
 		return ret;
@@ -458,9 +498,18 @@ static int acpi_aml_wait_command_ready(bool single_step,
 	else
 		acpi_os_printf("\n%1c ", ACPI_DEBUGGER_COMMAND_PROMPT);
 
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.flags |= ACPI_AML_WAITING_CMD;
+	wake_up_interruptible(&acpi_aml_io.wait);
+	mutex_unlock(&acpi_aml_io.lock);
+
 	status = acpi_os_get_line(buffer, length, NULL);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
+
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.flags &= ~ACPI_AML_WAITING_CMD;
+	mutex_unlock(&acpi_aml_io.lock);
 	return 0;
 }
 
@@ -593,9 +642,11 @@ static int acpi_aml_read_user(char __user *buf, int len)
 	smp_rmb();
 	p = &crc->buf[crc->tail];
 	n = min(len, circ_count_to_end(crc));
-	if (copy_to_user(buf, p, n)) {
-		ret = -EFAULT;
-		goto out;
+	if (!acpi_aml_flushing_log()) {
+		if (copy_to_user(buf, p, n)) {
+			ret = -EFAULT;
+			goto out;
+		}
 	}
 	/* sync tail after removing logs */
 	smp_mb();
@@ -731,10 +782,45 @@ static unsigned int acpi_aml_poll(struct file *file, poll_table *wait)
 	return masks;
 }
 
+static int acpi_aml_flush(void)
+{
+	int ret;
+
+	/*
+	 * Discard output buffer and put the driver into a state waiting
+	 * for the new user input.
+	 */
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.flags |= ACPI_AML_FLUSHING_LOG;
+	mutex_unlock(&acpi_aml_io.lock);
+
+	ret = wait_event_interruptible(acpi_aml_io.wait,
+		acpi_aml_waiting_cmd());
+	(void)acpi_aml_read_user(NULL, ACPI_AML_BUF_SIZE);
+
+	mutex_lock(&acpi_aml_io.lock);
+	acpi_aml_io.flags &= ~ACPI_AML_FLUSHING_LOG;
+	mutex_unlock(&acpi_aml_io.lock);
+	return ret;
+}
+
+static int acpi_aml_fsync(struct file *file,
+			  loff_t start, loff_t end, int datasync)
+{
+	struct inode *inode = file_inode(file);
+	int ret;
+
+	inode_lock(inode);
+	ret = acpi_aml_flush();
+	inode_unlock(inode);
+	return ret;
+}
+
 static const struct file_operations acpi_aml_operations = {
 	.read		= acpi_aml_read,
 	.write		= acpi_aml_write,
 	.poll		= acpi_aml_poll,
+	.fsync		= acpi_aml_fsync,
 	.open		= acpi_aml_open,
 	.release	= acpi_aml_release,
 	.llseek		= generic_file_llseek,
-- 
1.7.10

