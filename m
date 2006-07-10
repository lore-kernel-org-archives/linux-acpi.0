From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 5/5] acpi: initialise cm_sbs_sem
Date: Sun, 9 Jul 2006 22:53:08 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECFA26@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20113 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161310AbWGJCxM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 22:53:12 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, pauldrynoff@gmail.com, rhdt@bartol.udel.edu

applied.

thanks,
-Len
 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Friday, July 07, 2006 2:53 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; 
>pauldrynoff@gmail.com; rhdt@bartol.udel.edu
>Subject: [patch 5/5] acpi: initialise cm_sbs_sem
>
>From: Andrew Morton <akpm@osdl.org>
>
>cm_sbs_sem is being downed (via 
>acpi_ac_init->acpi_lock_ac_dir) before it is
>initialised, with grave results.
>
>- Make it a mutex
>
>- Initialise it
>
>- Make it static
>
>- Clean other stuff up.
>
>Thanks to Paul Drynoff <pauldrynoff@gmail.com> for reporting 
>and testing.
>
>Cc: "Brown, Len" <len.brown@intel.com>
>Cc: Rich Townsend <rhdt@bartol.udel.edu>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/cm_sbs.c |   46 ++++++++++++----------------------------
> 1 file changed, 14 insertions(+), 32 deletions(-)
>
>diff -puN drivers/acpi/cm_sbs.c~acpi-initialise-cm_sbs_sem 
>drivers/acpi/cm_sbs.c
>--- a/drivers/acpi/cm_sbs.c~acpi-initialise-cm_sbs_sem
>+++ a/drivers/acpi/cm_sbs.c
>@@ -39,50 +39,43 @@ ACPI_MODULE_NAME("cm_sbs")
> static struct proc_dir_entry *acpi_ac_dir;
> static struct proc_dir_entry *acpi_battery_dir;
> 
>-static struct semaphore cm_sbs_sem;
>+static DEFINE_MUTEX(cm_sbs_mutex);
> 
>-static int lock_ac_dir_cnt = 0;
>-static int lock_battery_dir_cnt = 0;
>+static int lock_ac_dir_cnt;
>+static int lock_battery_dir_cnt;
> 
> struct proc_dir_entry *acpi_lock_ac_dir(void)
> {
>-
>-	down(&cm_sbs_sem);
>-	if (!acpi_ac_dir) {
>+	mutex_lock(&cm_sbs_mutex);
>+	if (!acpi_ac_dir)
> 		acpi_ac_dir = proc_mkdir(ACPI_AC_CLASS, acpi_root_dir);
>-	}
> 	if (acpi_ac_dir) {
> 		lock_ac_dir_cnt++;
> 	} else {
> 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> 				  "Cannot create %s\n", ACPI_AC_CLASS));
> 	}
>-	up(&cm_sbs_sem);
>+	mutex_unlock(&cm_sbs_mutex);
> 	return acpi_ac_dir;
> }
>-
> EXPORT_SYMBOL(acpi_lock_ac_dir);
> 
> void acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir_param)
> {
>-
>-	down(&cm_sbs_sem);
>-	if (acpi_ac_dir_param) {
>+	mutex_lock(&cm_sbs_mutex);
>+	if (acpi_ac_dir_param)
> 		lock_ac_dir_cnt--;
>-	}
> 	if (lock_ac_dir_cnt == 0 && acpi_ac_dir_param && acpi_ac_dir) {
> 		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
> 		acpi_ac_dir = 0;
> 	}
>-	up(&cm_sbs_sem);
>+	mutex_unlock(&cm_sbs_mutex);
> }
>-
> EXPORT_SYMBOL(acpi_unlock_ac_dir);
> 
> struct proc_dir_entry *acpi_lock_battery_dir(void)
> {
>-
>-	down(&cm_sbs_sem);
>+	mutex_lock(&cm_sbs_mutex);
> 	if (!acpi_battery_dir) {
> 		acpi_battery_dir =
> 		    proc_mkdir(ACPI_BATTERY_CLASS, acpi_root_dir);
>@@ -93,39 +86,28 @@ struct proc_dir_entry *acpi_lock_battery
> 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> 				  "Cannot create %s\n", 
>ACPI_BATTERY_CLASS));
> 	}
>-	up(&cm_sbs_sem);
>+	mutex_unlock(&cm_sbs_mutex);
> 	return acpi_battery_dir;
> }
>-
> EXPORT_SYMBOL(acpi_lock_battery_dir);
> 
> void acpi_unlock_battery_dir(struct proc_dir_entry 
>*acpi_battery_dir_param)
> {
>-
>-	down(&cm_sbs_sem);
>-	if (acpi_battery_dir_param) {
>+	mutex_lock(&cm_sbs_mutex);
>+	if (acpi_battery_dir_param)
> 		lock_battery_dir_cnt--;
>-	}
> 	if (lock_battery_dir_cnt == 0 && acpi_battery_dir_param
> 	    && acpi_battery_dir) {
> 		remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
> 		acpi_battery_dir = 0;
> 	}
>-	up(&cm_sbs_sem);
>+	mutex_unlock(&cm_sbs_mutex);
> 	return;
> }
>-
> EXPORT_SYMBOL(acpi_unlock_battery_dir);
> 
> static int __init acpi_cm_sbs_init(void)
> {
>-
>-	if (acpi_disabled)
>-		return 0;
>-
>-	init_MUTEX(&cm_sbs_sem);
>-
> 	return 0;
> }
>-
> subsys_initcall(acpi_cm_sbs_init);
>_
>
