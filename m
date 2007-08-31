From: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: [PATCH] ACPI:  Remove code related to dead ACPI_PROCFS_SLEEP config
 variable.
Date: Fri, 31 Aug 2007 08:15:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0708310811530.2720@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nic.NetDirect.CA ([216.16.235.2]:36631 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932565AbXHaM0q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Aug 2007 08:26:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com


Given that the ACPI_PROCFS_SLEEP config variable was deleted in commit
128a2bcf9dddeb8e79a4ba55bf191533f70f39ce, there seems to be little
point in retaining this code.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  of course, if this is already gone in the ACPI tree, ignore it.  not
compile-tested as it seemed fairly obvious.


diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 66b62b0..a777976 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -23,60 +23,6 @@
  */

 ACPI_MODULE_NAME("sleep")
-#ifdef	CONFIG_ACPI_PROCFS_SLEEP
-static int acpi_system_sleep_seq_show(struct seq_file *seq, void *offset)
-{
-	int i;
-
-	ACPI_FUNCTION_TRACE("acpi_system_sleep_seq_show");
-
-	for (i = 0; i <= ACPI_STATE_S5; i++) {
-		if (sleep_states[i]) {
-			seq_printf(seq, "S%d ", i);
-		}
-	}
-
-	seq_puts(seq, "\n");
-
-	return 0;
-}
-
-static int acpi_system_sleep_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_system_sleep_seq_show, PDE(inode)->data);
-}
-
-static ssize_t
-acpi_system_write_sleep(struct file *file,
-			const char __user * buffer, size_t count, loff_t * ppos)
-{
-	char str[12];
-	u32 state = 0;
-	int error = 0;
-
-	if (count > sizeof(str) - 1)
-		goto Done;
-	memset(str, 0, sizeof(str));
-	if (copy_from_user(str, buffer, count))
-		return -EFAULT;
-
-	/* Check for S4 bios request */
-	if (!strcmp(str, "4b")) {
-		error = acpi_suspend(4);
-		goto Done;
-	}
-	state = simple_strtoul(str, NULL, 0);
-#ifdef CONFIG_HIBERNATION
-	if (state == 4) {
-		error = hibernate();
-		goto Done;
-	}
-#endif
-	error = acpi_suspend(state);
-      Done:
-	return error ? error : count;
-}
-#endif				/* CONFIG_ACPI_PROCFS_SLEEP */

 #if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || !defined(CONFIG_X86)
 /* use /sys/class/rtc/rtcX/wakealarm instead; it's not ACPI-specific */
@@ -471,16 +417,6 @@ static const struct file_operations acpi_system_wakeup_device_fops = {
 	.release = single_release,
 };

-#ifdef	CONFIG_ACPI_PROCFS_SLEEP
-static const struct file_operations acpi_system_sleep_fops = {
-	.open = acpi_system_sleep_open_fs,
-	.read = seq_read,
-	.write = acpi_system_write_sleep,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#endif				/* CONFIG_ACPI_PROCFS_SLEEP */
-
 #ifdef	HAVE_ACPI_LEGACY_ALARM
 static const struct file_operations acpi_system_alarm_fops = {
 	.open = acpi_system_alarm_open_fs,
@@ -506,15 +442,6 @@ static int __init acpi_sleep_proc_init(void)
 	if (acpi_disabled)
 		return 0;

-#ifdef	CONFIG_ACPI_PROCFS_SLEEP
-	/* 'sleep' [R/W] */
-	entry =
-	    create_proc_entry("sleep", S_IFREG | S_IRUGO | S_IWUSR,
-			      acpi_root_dir);
-	if (entry)
-		entry->proc_fops = &acpi_system_sleep_fops;
-#endif				/* CONFIG_ACPI_PROCFS */
-
 #ifdef	HAVE_ACPI_LEGACY_ALARM
 	/* 'alarm' [R/W] */
 	entry =
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================
