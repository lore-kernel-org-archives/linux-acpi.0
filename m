From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI:  Remove code related to dead ACPI_PROCFS_SLEEP config variable.
Date: Fri, 31 Aug 2007 16:36:16 -0400
Message-ID: <200708311636.17043.lenb@kernel.org>
References: <Pine.LNX.4.64.0708310811530.2720@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39384 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933155AbXHaUxf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Aug 2007 16:53:35 -0400
In-Reply-To: <Pine.LNX.4.64.0708310811530.2720@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-acpi@vger.kernel.org

Good eye,
but actually, the real fix is in the queue already, as below.

thanks,
-Len


commit 134c21715ac3cb36db13c8d362cc80ccc87ee48d
Author: Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Tue Aug 28 14:58:56 2007 -0400

    ACPI: (more) delete CONFIG_ACPI_PROCFS_SLEEP (again)
    
    Commit 2bcf9dddeb8e79a4ba55bf191533f70f39ce
    ('ACPI: delete CONFIG_ACPI_PROCFS_SLEEP (again)')
    was incomplete.
    
    Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 66b62b0..3839efd 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -23,7 +23,7 @@
  */
 
 ACPI_MODULE_NAME("sleep")
-#ifdef	CONFIG_ACPI_PROCFS_SLEEP
+#ifdef	CONFIG_ACPI_PROCFS
 static int acpi_system_sleep_seq_show(struct seq_file *seq, void *offset)
 {
 	int i;
@@ -76,7 +76,7 @@ acpi_system_write_sleep(struct file *file,
       Done:
 	return error ? error : count;
 }
-#endif				/* CONFIG_ACPI_PROCFS_SLEEP */
+#endif				/* CONFIG_ACPI_PROCFS */
 
 #if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || !defined(CONFIG_X86)
 /* use /sys/class/rtc/rtcX/wakealarm instead; it's not ACPI-specific */
@@ -471,7 +471,7 @@ static const struct file_operations acpi_system_wakeup_device_fops = {
 	.release = single_release,
 };
 
-#ifdef	CONFIG_ACPI_PROCFS_SLEEP
+#ifdef	CONFIG_ACPI_PROCFS
 static const struct file_operations acpi_system_sleep_fops = {
 	.open = acpi_system_sleep_open_fs,
 	.read = seq_read,
@@ -479,7 +479,7 @@ static const struct file_operations acpi_system_sleep_fops = {
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-#endif				/* CONFIG_ACPI_PROCFS_SLEEP */
+#endif				/* CONFIG_ACPI_PROCFS */
 
 #ifdef	HAVE_ACPI_LEGACY_ALARM
 static const struct file_operations acpi_system_alarm_fops = {
@@ -506,7 +506,7 @@ static int __init acpi_sleep_proc_init(void)
 	if (acpi_disabled)
 		return 0;
 
-#ifdef	CONFIG_ACPI_PROCFS_SLEEP
+#ifdef	CONFIG_ACPI_PROCFS
 	/* 'sleep' [R/W] */
 	entry =
 	    create_proc_entry("sleep", S_IFREG | S_IRUGO | S_IWUSR,

