From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Subject: [2.6 patch] remove ACPI S4bios support
Date: Fri, 2 Sep 2005 03:23:48 +0200
Message-ID: <20050902012348.GL3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Remove S4BIOS support. It is pretty useless, and only ever worked for
_me_ once. (I do not think anyone else ever tried it). It was in
feature-removal for a long time, and it should have been removed before.

From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Signed-off-by: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>

---

This patch was already sent on:
- 22 Aug 2005

This patch was sent by Pavel Machek on:
- 12 Aug 2005

I made the following changes to it:
- drivers/acpi/sleep/proc.c chunk did no longer apply due to
  unrelated context changes
- remove the feature-removal-schedule.txt entry

 Documentation/feature-removal-schedule.txt |    8 --------
 arch/i386/kernel/acpi/wakeup.S             |    6 ------
 drivers/acpi/sleep/main.c                  |    8 --------
 drivers/acpi/sleep/poweroff.c              |    4 +---
 drivers/acpi/sleep/proc.c                  |    2 --
 5 files changed, 1 insertion(+), 27 deletions(-)

--- linux-2.6.13-rc6-mm1-full/Documentation/feature-removal-schedule.txt.old	2005-08-22 00:32:08.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/Documentation/feature-removal-schedule.txt	2005-08-22 00:32:17.000000000 +0200
@@ -17,14 +17,6 @@
 
 ---------------------------
 
-What:	ACPI S4bios support
-When:	May 2005
-Why:	Noone uses it, and it probably does not work, anyway. swsusp is
-	faster, more reliable, and people are actually using it.
-Who:	Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
-
----------------------------
-
 What:	io_remap_page_range() (macro or function)
 When:	September 2005
 Why:	Replaced by io_remap_pfn_range() which allows more memory space
--- a/arch/i386/kernel/acpi/wakeup.S
+++ b/arch/i386/kernel/acpi/wakeup.S
@@ -320,12 +320,6 @@ ret_point:
 	call	restore_processor_state
 	ret
 
-ENTRY(do_suspend_lowlevel_s4bios)
-	call save_processor_state
-	call save_registers
-	call acpi_enter_sleep_state_s4bios
-	ret
-
 ALIGN
 # saved registers
 saved_gdt:	.long	0,0
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -23,7 +23,6 @@ u8 sleep_states[ACPI_S_STATE_COUNT];
 
 static struct pm_ops acpi_pm_ops;
 
-extern void do_suspend_lowlevel_s4bios(void);
 extern void do_suspend_lowlevel(void);
 
 static u32 acpi_suspend_states[] = {
@@ -98,8 +97,6 @@ static int acpi_pm_enter(suspend_state_t
 	case PM_SUSPEND_DISK:
 		if (acpi_pm_ops.pm_disk_mode == PM_DISK_PLATFORM)
 			status = acpi_enter_sleep_state(acpi_state);
-		else
-			do_suspend_lowlevel_s4bios();
 		break;
 	case PM_SUSPEND_MAX:
 		acpi_power_off();
@@ -206,11 +203,6 @@ static int __init acpi_sleep_init(void)
 			printk(" S%d", i);
 		}
 		if (i == ACPI_STATE_S4) {
-			if (acpi_gbl_FACS->S4bios_f) {
-				sleep_states[i] = 1;
-				printk(" S4bios");
-				acpi_pm_ops.pm_disk_mode = PM_DISK_FIRMWARE;
-			}
 			if (sleep_states[i])
 				acpi_pm_ops.pm_disk_mode = PM_DISK_PLATFORM;
 		}
diff --git a/drivers/acpi/sleep/poweroff.c b/drivers/acpi/sleep/poweroff.c
--- a/drivers/acpi/sleep/poweroff.c
+++ b/drivers/acpi/sleep/poweroff.c
@@ -21,9 +21,7 @@ int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
 	/* do we have a wakeup address for S2 and S3? */
-	/* Here, we support only S4BIOS, those we set the wakeup address */
-	/* S4OS is only supported for now via swsusp.. */
-	if (acpi_state == ACPI_STATE_S3 || acpi_state == ACPI_STATE_S4) {
+	if (acpi_state == ACPI_STATE_S3) {
 		if (!acpi_wakeup_address) {
 			return -EFAULT;
 		}
--- linux-2.6.13-rc6-mm1-full/drivers/acpi/sleep/proc.c.old	2005-08-22 00:33:58.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/drivers/acpi/sleep/proc.c	2005-08-22 00:34:55.000000000 +0200
@@ -25,8 +25,6 @@
 	for (i = 0; i <= ACPI_STATE_S5; i++) {
 		if (sleep_states[i]) {
 			seq_printf(seq, "S%d ", i);
-			if (i == ACPI_STATE_S4 && acpi_gbl_FACS->S4bios_f)
-				seq_printf(seq, "S4bios ");
 		}
 	}
 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
