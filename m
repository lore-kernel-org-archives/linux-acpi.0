From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/42] ACPI / PM: Drop acpi_restore_state_mem()
Date: Wed, 23 Mar 2011 02:42:23 -0400
Message-ID: <c41b93fb8551148a93d3bba870365e8489317f02.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36985 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab1CWHHc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:32 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:32 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

The function acpi_restore_state_mem() has never been and most likely
never will be used, so remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/ia64/include/asm/acpi.h |    4 ++--
 arch/ia64/kernel/acpi.c      |    5 -----
 arch/x86/include/asm/acpi.h  |    3 +--
 arch/x86/kernel/acpi/sleep.c |    8 --------
 drivers/acpi/sleep.c         |    4 ----
 5 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index 837dc82..db3986a 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -128,9 +128,9 @@ static inline const char *acpi_get_sysname (void)
 int acpi_request_vector (u32 int_type);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 
-/* routines for saving/restoring kernel state */
+/* Routine for saving kernel state during suspend. */
 extern int acpi_save_state_mem(void);
-extern void acpi_restore_state_mem(void);
+
 extern unsigned long acpi_wakeup_address;
 
 /*
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 90ebceb..7cf2d10 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -1041,11 +1041,6 @@ EXPORT_SYMBOL(acpi_unregister_ioapic);
 int acpi_save_state_mem(void) { return 0; } 
 
 /*
- * acpi_restore_state()
- */
-void acpi_restore_state_mem(void) {}
-
-/*
  * do_suspend_lowlevel()
  */
 void do_suspend_lowlevel(void) {}
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 211ca3f..47981f0 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -112,9 +112,8 @@ static inline void acpi_disable_pci(void)
 	acpi_noirq_set();
 }
 
-/* routines for saving/restoring kernel state */
+/* Routine for saving kernel state during suspend. */
 extern int acpi_save_state_mem(void);
-extern void acpi_restore_state_mem(void);
 
 extern unsigned long acpi_wakeup_address;
 
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 68d1537..c27a483 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -110,14 +110,6 @@ int acpi_save_state_mem(void)
 	return 0;
 }
 
-/*
- * acpi_restore_state - undo effects of acpi_save_state_mem
- */
-void acpi_restore_state_mem(void)
-{
-}
-
-
 /**
  * acpi_reserve_wakeup_memory - do _very_ early ACPI initialisation
  *
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index d6a8cd1..67dcd38 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -293,10 +293,6 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 
-	/* restore processor state */
-	if (acpi_state == ACPI_STATE_S3)
-		acpi_restore_state_mem();
-
 	suspend_nvs_restore();
 
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
-- 
1.7.4.1.343.ga91df

