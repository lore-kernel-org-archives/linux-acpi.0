From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/42] ACPI / PM: Merge do_suspend_lowlevel() into
 acpi_save_state_mem()
Date: Wed, 23 Mar 2011 02:42:27 -0400
Message-ID: <f1a2003e22f6b50ea21f7f4b38b38c5ebc9c8017.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36988 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab1CWHHd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:33 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:33 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

The function do_suspend_lowlevel() is specific to x86 and defined in
assembly code, so it should be called from the x86 low-level suspend
code rather than from acpi_suspend_enter().

Merge do_suspend_lowlevel() into the x86's acpi_save_state_mem() and
change the name of the latter to acpi_suspend_lowlevel(), so that the
function's purpose is better reflected by its name.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/ia64/include/asm/acpi.h |    4 ++--
 arch/ia64/kernel/acpi.c      |    9 ++-------
 arch/x86/include/asm/acpi.h  |    4 ++--
 arch/x86/kernel/acpi/sleep.c |    5 +++--
 arch/x86/kernel/acpi/sleep.h |    2 ++
 drivers/acpi/sleep.c         |    5 +----
 6 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index db3986a..a06dfb1 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -128,8 +128,8 @@ static inline const char *acpi_get_sysname (void)
 int acpi_request_vector (u32 int_type);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 
-/* Routine for saving kernel state during suspend. */
-extern int acpi_save_state_mem(void);
+/* Low-level suspend routine. */
+extern int acpi_suspend_lowlevel(void);
 
 extern unsigned long acpi_wakeup_address;
 
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 7cf2d10..a54d054 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -1034,13 +1034,8 @@ int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)
 EXPORT_SYMBOL(acpi_unregister_ioapic);
 
 /*
- * acpi_save_state_mem() - save kernel state
+ * acpi_suspend_lowlevel() - save kernel state and suspend.
  *
  * TBD when when IA64 starts to support suspend...
  */
-int acpi_save_state_mem(void) { return 0; } 
-
-/*
- * do_suspend_lowlevel()
- */
-void do_suspend_lowlevel(void) {}
+int acpi_suspend_lowlevel(void) { return 0; }
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 47981f0..aa92684 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -112,8 +112,8 @@ static inline void acpi_disable_pci(void)
 	acpi_noirq_set();
 }
 
-/* Routine for saving kernel state during suspend. */
-extern int acpi_save_state_mem(void);
+/* Low-level suspend routine. */
+extern int acpi_suspend_lowlevel(void);
 
 extern unsigned long acpi_wakeup_address;
 
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index c27a483..5f1b747 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -29,14 +29,14 @@ static char temp_stack[4096];
 #endif
 
 /**
- * acpi_save_state_mem - save kernel state
+ * acpi_suspend_lowlevel - save kernel state
  *
  * Create an identity mapped page table and copy the wakeup routine to
  * low memory.
  *
  * Note that this is too late to change acpi_wakeup_address.
  */
-int acpi_save_state_mem(void)
+int acpi_suspend_lowlevel(void)
 {
 	struct wakeup_header *header;
 
@@ -107,6 +107,7 @@ int acpi_save_state_mem(void)
        saved_magic = 0x123456789abcdef0L;
 #endif /* CONFIG_64BIT */
 
+	do_suspend_lowlevel();
 	return 0;
 }
 
diff --git a/arch/x86/kernel/acpi/sleep.h b/arch/x86/kernel/acpi/sleep.h
index adbcbaa..31ce13f 100644
--- a/arch/x86/kernel/acpi/sleep.h
+++ b/arch/x86/kernel/acpi/sleep.h
@@ -14,3 +14,5 @@ extern char swsusp_pg_dir[PAGE_SIZE];
 
 extern unsigned long acpi_copy_wakeup_routine(unsigned long);
 extern void wakeup_long64(void);
+
+extern void do_suspend_lowlevel(void);
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 2307604..0a81bf1 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -199,8 +199,6 @@ static void acpi_pm_end(void)
 #endif /* CONFIG_ACPI_SLEEP */
 
 #ifdef CONFIG_SUSPEND
-extern void do_suspend_lowlevel(void);
-
 static u32 acpi_suspend_states[] = {
 	[PM_SUSPEND_ON] = ACPI_STATE_S0,
 	[PM_SUSPEND_STANDBY] = ACPI_STATE_S1,
@@ -255,10 +253,9 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 		break;
 
 	case ACPI_STATE_S3:
-		error = acpi_save_state_mem();
+		error = acpi_suspend_lowlevel();
 		if (error)
 			return error;
-		do_suspend_lowlevel();
 		pr_info(PREFIX "Low-level resume complete\n");
 		break;
 	}
-- 
1.7.4.1.343.ga91df

