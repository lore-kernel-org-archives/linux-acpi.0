From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RFC 4/4: fix semaphore issue
Date: Wed, 19 Jan 2005 11:17:20 +0800
Message-ID: <1106104627.12957.276.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
we track all ACPI semaphore usage, and do suspend till all ACPI
semaphores are free.

Thanks,
Shaohua

---

 2.5-root/drivers/acpi/osl.c         |   64 ++++++++++++++++++++++++++++++++++++
 2.5-root/drivers/acpi/sleep/main.c  |   13 +++++++
 2.5-root/drivers/acpi/sleep/sleep.h |    2 +
 2.5-root/include/linux/pm.h         |    2 +
 2.5-root/kernel/power/main.c        |   13 +++++++
 5 files changed, 94 insertions(+)

diff -puN drivers/acpi/osl.c~acpica_semaphore_fix drivers/acpi/osl.c
--- 2.5/drivers/acpi/osl.c~acpica_semaphore_fix	2005-01-18 13:55:15.648781504 +0800
+++ 2.5-root/drivers/acpi/osl.c	2005-01-18 13:55:15.655780440 +0800
@@ -881,6 +881,67 @@ acpi_os_delete_semaphore(
 }
 EXPORT_SYMBOL(acpi_os_delete_semaphore);
 
+static DECLARE_MUTEX(linux_acpica_sem);
+static DECLARE_WAIT_QUEUE_HEAD(linux_sem_waitqueue);
+static int linux_acpica_sem_level;
+static inline void acpica_enter_semaphore(void)
+{
+	down(&linux_acpica_sem);
+	linux_acpica_sem_level ++;
+	up(&linux_acpica_sem);
+}
+
+static inline void acpica_leave_semaphore(void)
+{
+	down(&linux_acpica_sem);
+	linux_acpica_sem_level --;
+	if (linux_acpica_sem_level == 0)
+		wake_up(&linux_sem_waitqueue);
+	up(&linux_acpica_sem);
+}
+
+/* This should be called before freeze_process */
+int wait_acpi_semaphores(u32 ms)
+{
+	long sleep_jiffies = msecs_to_jiffies(ms);
+	unsigned long leave_jiffies = jiffies + sleep_jiffies;
+	long ret;
+
+	while (1) {
+		sleep_jiffies = leave_jiffies - jiffies;
+		/* has been timeout */
+		if (sleep_jiffies <= 0) {
+			if (down_trylock(&linux_acpica_sem))
+				return -EBUSY;
+			if (linux_acpica_sem_level == 0)
+				return 0;
+			up(&linux_acpica_sem);
+			return -EBUSY;
+		}
+
+		ret = wait_event_timeout(linux_sem_waitqueue,
+			linux_acpica_sem_level == 0, sleep_jiffies);
+		/* has been timeout */
+		if (!ret)
+			continue;
+		/* linux_acpica_sem_level == 0 but somebody else locks */
+		if (down_trylock(&linux_acpica_sem))
+			continue;
+
+		if (linux_acpica_sem_level > 0) {
+			up(&linux_acpica_sem);
+			continue;
+		}
+		return 0;
+	}
+	return 0;
+}
+
+/* This should be called after freeze_process but before acpi_sleep_prep */
+void finish_acpi_semaphores(void)
+{
+	up(&linux_acpica_sem);
+}
 
 /*
  * TODO: The kernel doesn't have a 'down_timeout' function -- had to
@@ -914,6 +975,7 @@ acpi_os_wait_semaphore(
 	if (in_atomic())
 		timeout = 0;
 
+	acpica_enter_semaphore();
 	switch (timeout)
 	{
 		/*
@@ -960,6 +1022,7 @@ acpi_os_wait_semaphore(
 	}
 
 	if (ACPI_FAILURE(status)) {
+		acpica_leave_semaphore();
 		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Failed to acquire semaphore[%p|%d|%d], %s\n", 
 			handle, units, timeout, acpi_format_exception(status)));
 	}
@@ -994,6 +1057,7 @@ acpi_os_signal_semaphore(
 
 	up(sem);
 
+	acpica_leave_semaphore();
 	return_ACPI_STATUS (AE_OK);
 }
 EXPORT_SYMBOL(acpi_os_signal_semaphore);
diff -puN kernel/power/main.c~acpica_semaphore_fix kernel/power/main.c
--- 2.5/kernel/power/main.c~acpica_semaphore_fix	2005-01-18 13:55:15.649781352 +0800
+++ 2.5-root/kernel/power/main.c	2005-01-18 14:14:35.409471080 +0800
@@ -58,11 +58,23 @@ static int suspend_prepare(suspend_state
 
 	pm_prepare_console();
 
+	if (pm_ops->prepare_freeze_process(state)) {
+		error = pm_ops->prepare_freeze_process(state);
+		if (error)
+			goto Console;
+	}
+
 	if (freeze_processes()) {
 		error = -EAGAIN;
 		goto Thaw;
 	}
 
+	if (pm_ops->after_freeze_process(state)) {
+		error = pm_ops->after_freeze_process(state);
+		if (error)
+			goto Thaw;
+	}
+
 	/* This should be done after processes frozen and other CPUs are died */
 	system_state = SYSTEM_SUSPEND;
 	smp_wmb();
@@ -93,6 +105,7 @@ static int suspend_prepare(suspend_state
 	smp_wmb();
  Thaw:
 	thaw_processes();
+ Console:
 	pm_restore_console();
 	return error;
 }
diff -puN include/linux/pm.h~acpica_semaphore_fix include/linux/pm.h
--- 2.5/include/linux/pm.h~acpica_semaphore_fix	2005-01-18 13:55:15.651781048 +0800
+++ 2.5-root/include/linux/pm.h	2005-01-18 13:55:15.655780440 +0800
@@ -206,6 +206,8 @@ typedef int __bitwise suspend_disk_metho
 
 struct pm_ops {
 	suspend_disk_method_t pm_disk_mode;
+	int (*prepare_freeze_process)(suspend_state_t state);
+	int (*after_freeze_process)(suspend_state_t state);
 	int (*prepare)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
diff -puN drivers/acpi/sleep/main.c~acpica_semaphore_fix drivers/acpi/sleep/main.c
--- 2.5/drivers/acpi/sleep/main.c~acpica_semaphore_fix	2005-01-18 13:56:58.716112888 +0800
+++ 2.5-root/drivers/acpi/sleep/main.c	2005-01-18 14:01:46.887304208 +0800
@@ -170,7 +170,20 @@ int acpi_suspend(u32 acpi_state)
 	return -EINVAL;
 }
 
+int acpi_pm_prepare_freeze_process(suspend_state_t state)
+{
+	return wait_acpi_semaphores(1000);
+}
+
+int acpi_pm_after_freeze_process(suspend_state_t state)
+{
+	finish_acpi_semaphores();
+	return 0;
+}
+
 static struct pm_ops acpi_pm_ops = {
+	.prepare_freeze_process = acpi_pm_prepare_freeze_process,
+	.after_freeze_process = acpi_pm_after_freeze_process,
 	.prepare	= acpi_pm_prepare,
 	.enter		= acpi_pm_enter,
 	.finish		= acpi_pm_finish,
diff -puN drivers/acpi/sleep/sleep.h~acpica_semaphore_fix drivers/acpi/sleep/sleep.h
--- 2.5/drivers/acpi/sleep/sleep.h~acpica_semaphore_fix	2005-01-18 13:57:03.403400312 +0800
+++ 2.5-root/drivers/acpi/sleep/sleep.h	2005-01-18 13:58:09.050420448 +0800
@@ -1,6 +1,8 @@
 
 extern u8 sleep_states[];
 extern int acpi_suspend (u32 state);
+extern int wait_acpi_semaphores(u32);
+extern void finish_acpi_semaphores(void);
 
 extern void acpi_enable_wakeup_device_prep(u8 sleep_state);
 extern void acpi_enable_wakeup_device(u8 sleep_state);
_




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
