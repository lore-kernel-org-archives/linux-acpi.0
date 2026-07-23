Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF683DDDDD;
	Thu, 23 Jul 2026 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794038; cv=none; b=bIBzKj+7kBdSNLNOn+nvNA6IJGBAbs9O8RrMH2DT5TUBTqAm+0mbGRsgfGu6T5KnT1tI+RzqaVFTC0YI0nAgXa9jGn10lSxxSDLd52eQItag9MjtrNefHz6uMTURf6oM1ik/dgT1VqYAYf1aBpbRMZqaqQxp8/GL5qHj+jVR5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794038; c=relaxed/simple;
	bh=9Hp3anZffpy0TWooiCdNIelm+yPdA/cXRjw7YlT+qgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jmwevcuntr9/bIGBIlbacI/KgNXALNLYACuqgrXm/BsIH/a6FyAbwoi0orW8vma9Ef5X0D/Zh9foefHGpqrasdz8PsnE7uzZzp8vGpKAuRdIGtPBEksJxSkO4Dv8bounaWxzlNfMPBnAoEzSbvqz57YCHU22VgCzHj+GadOGRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7db55a04866d11f1aa26b74ffac11d73-20260723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9d0f65d0-af7d-4b88-8ac0-0ea2e852552e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:db4545cf1b46186f1b641c16fbf4bb61,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7db55a04866d11f1aa26b74ffac11d73-20260723
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1716256921; Thu, 23 Jul 2026 16:07:04 +0800
From: Riwen Lu <luriwen@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v4 1/1] ACPI: PM: Introduce CONFIG_ACPI_S2IDLE for platform-independent S2Idle support
Date: Thu, 23 Jul 2026 16:07:00 +0800
Message-Id: <20260723080700.1953260-1-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI S2Idle (suspend-to-idle) code is currently located in sleep.c
and guarded by CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT. This config is
historically tied to x86/ia64 sleep states (S3/S4), which prevents
ACPI-based platforms like ARM64 from using the OS-centric s2idle
framework and its associated wakeup event handling (e.g., from ACPI
buttons or the lid).

Since S2Idle is a software-driven low-power state that does not rely on
firmware sleep states (S3/S4), it should be available to all
ACPI-enabled platforms.

To achieve this, introduce a new, independent Kconfig option,
CONFIG_ACPI_S2IDLE. It is selected by ACPI_SYSTEM_POWER_STATES_SUPPORT
for backward compatibility, but can now also be enabled separately by
other platforms.

Move all s2idle-specific code into a dedicated file,
drivers/acpi/s2idle.c. This creates a clear and independent ACPI s2idle
framework, centered around a default acpi_s2idle_ops and a weakly
defined acpi_s2idle_setup() hook.

The change allows all ACPI platforms to use this common s2idle
infrastructure. Platforms with unique requirements can override the
defaults via the weak function, while others (like ARM64) can now simply
enable the config to obtain functional s2idle support with standard ACPI
wakeup handling.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
v1 -> v2:
 - Fix acpi_s2idle_setup() declaration error when SUSPEND is disabled in
   x86 builds.

v2 -> v3:
 - Select ACPI_S2IDLE if SUSPEND is enabled for
   ACPI_SYSTEM_POWER_STATES_SUPPORT, so the select no longer violates the
   ACPI_S2IDLE dependency on SUSPEND.

v3 -> v4:
 - Add pr_fmt() in s2idle.c so log messages keep the "ACPI: PM: " prefix
   that sleep.c used; without it the moved pr_info/pr_warn would lose the
   subsystem prefix.
 - Drop the redundant #ifdef CONFIG_SUSPEND / #else wrapper in s2idle.c.
   The !SUSPEND branch was dead code, because CONFIG_ACPI_S2IDLE itself
   depends on SUSPEND, so s2idle.c is only compiled when SUSPEND is set.
 - Make acpi_s2idle_init() return void.  The int return value was always 0
   in the real implementation and -ENXIO in the stub, and the only caller
   (acpi_bus_init()) ignores it; a void interface is honest and the stub
   becomes a clean no-op.
 - Mark the weak acpi_s2idle_setup() default __init, matching the x86
   override (which is already __init) and allowing the code to be discarded
   after init.
 - Use SPDX-License-Identifier: GPL-2.0-only in s2idle.c for consistency
   with sleep.c (the file the code was split out from).
 - Trivial cleanups: remove a double blank line in the Makefile and drop
   the redundant "Warning: " prefix from a pr_warn() message.

 drivers/acpi/Kconfig    |  14 ++++
 drivers/acpi/Makefile   |   1 +
 drivers/acpi/bus.c      |   3 +
 drivers/acpi/internal.h |  10 ++-
 drivers/acpi/s2idle.c   | 162 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/sleep.c    | 145 -----------------------------------
 6 files changed, 188 insertions(+), 147 deletions(-)
 create mode 100644 drivers/acpi/s2idle.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f165d14cf61a..8c0918747bbb 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -55,6 +55,7 @@ config ACPI_GENERIC_GSI
 
 config ACPI_SYSTEM_POWER_STATES_SUPPORT
 	bool
+	select ACPI_S2IDLE if SUSPEND
 
 config ACPI_CCA_REQUIRED
 	bool
@@ -113,6 +114,19 @@ config ACPI_SLEEP
 	depends on ACPI_SYSTEM_POWER_STATES_SUPPORT
 	default y
 
+config ACPI_S2IDLE
+	bool "ACPI suspend-to-idle support"
+	depends on SUSPEND
+	help
+	  This option enables the core ACPI framework for the suspend-to-idle
+	  (S2Idle) power state. This state is software-driven and does not
+	  require platform firmware sleep states (S3/S4).
+
+	  It is automatically selected by platforms with
+	  CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT (like x86), but can also
+	  be enabled independently by other ACPI platforms (e.g., ARM64) to
+	  gain support for low-power idle and ACPI wakeup events.
+
 config ACPI_REV_OVERRIDE_POSSIBLE
 	bool "Allow supported ACPI revision to be overridden"
 	depends on X86
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d1b0affb844f..f1e89e45e876 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -35,6 +35,7 @@ acpi-$(CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT) += sleep.o
 acpi-y				+= device_sysfs.o device_pm.o
 acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
 
+acpi-$(CONFIG_ACPI_S2IDLE)	+= s2idle.o
 
 #
 # ACPI Bus and Device Drivers
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a30a904f6535..eedcd940859c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1534,6 +1534,9 @@ static int __init acpi_bus_init(void)
 	/* Initialize sleep structures */
 	acpi_sleep_init();
 
+	/* Initialize default acpi s2idle ops */
+	acpi_s2idle_init();
+
 	/*
 	 * Get the system interrupt model and evaluate \_PIC.
 	 */
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 40f875b265a9..5a08315d308a 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -267,13 +267,19 @@ static inline bool acpi_ec_dispatch_gpe(void)
                                   Suspend/Resume
   -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
-extern bool acpi_s2idle_wakeup(void);
 extern int acpi_sleep_init(void);
 #else
-static inline bool acpi_s2idle_wakeup(void) { return false; }
 static inline int acpi_sleep_init(void) { return -ENXIO; }
 #endif
 
+#ifdef CONFIG_ACPI_S2IDLE
+extern bool acpi_s2idle_wakeup(void);
+extern void acpi_s2idle_init(void);
+#else
+static inline bool acpi_s2idle_wakeup(void) { return false; }
+static inline void acpi_s2idle_init(void) {}
+#endif
+
 #ifdef CONFIG_ACPI_SLEEP
 void acpi_sleep_proc_init(void);
 int suspend_nvs_alloc(void);
diff --git a/drivers/acpi/s2idle.c b/drivers/acpi/s2idle.c
new file mode 100644
index 000000000000..29ab5602ab45
--- /dev/null
+++ b/drivers/acpi/s2idle.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * s2idle.c - ACPI suspend-to-idle support.
+ *
+ */
+
+#define pr_fmt(fmt) "ACPI: PM: " fmt
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/suspend.h>
+#include <linux/irq.h>
+
+#include "internal.h"
+#include "sleep.h"
+
+static bool s2idle_wakeup;
+
+int acpi_s2idle_begin(void)
+{
+	acpi_scan_lock_acquire();
+	return 0;
+}
+
+int acpi_s2idle_prepare(void)
+{
+	if (acpi_sci_irq_valid()) {
+		int error;
+
+		error = enable_irq_wake(acpi_sci_irq);
+		if (error)
+			pr_warn("Failed to enable wakeup from IRQ %d: %d\n",
+				acpi_sci_irq, error);
+
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
+	}
+
+	acpi_enable_wakeup_devices(ACPI_STATE_S0);
+
+	/* Change the configuration of GPEs to avoid spurious wakeup. */
+	acpi_enable_all_wakeup_gpes();
+	acpi_os_wait_events_complete();
+
+	s2idle_wakeup = true;
+	return 0;
+}
+
+bool acpi_s2idle_wake(void)
+{
+	if (!acpi_sci_irq_valid())
+		return pm_wakeup_pending();
+
+	while (pm_wakeup_pending()) {
+		/*
+		 * If IRQD_WAKEUP_ARMED is set for the SCI at this point, the
+		 * SCI has not triggered while suspended, so bail out (the
+		 * wakeup is pending anyway and the SCI is not the source of
+		 * it).
+		 */
+		if (irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
+			pm_pr_dbg("Wakeup unrelated to ACPI SCI\n");
+			return true;
+		}
+
+		/*
+		 * If the status bit of any enabled fixed event is set, the
+		 * wakeup is regarded as valid.
+		 */
+		if (acpi_any_fixed_event_status_set()) {
+			pm_pr_dbg("ACPI fixed event wakeup\n");
+			return true;
+		}
+
+		/* Check wakeups from drivers sharing the SCI. */
+		if (acpi_check_wakeup_handlers()) {
+			pm_pr_dbg("ACPI custom handler wakeup\n");
+			return true;
+		}
+
+		/*
+		 * Check non-EC GPE wakeups and if there are none, cancel the
+		 * SCI-related wakeup and dispatch the EC GPE.
+		 */
+		if (acpi_ec_dispatch_gpe()) {
+			pm_pr_dbg("ACPI non-EC GPE wakeup\n");
+			return true;
+		}
+
+		acpi_os_wait_events_complete();
+
+		/*
+		 * The SCI is in the "suspended" state now and it cannot produce
+		 * new wakeup events till the rearming below, so if any of them
+		 * are pending here, they must be resulting from the processing
+		 * of EC events above or coming from somewhere else.
+		 */
+		if (pm_wakeup_pending()) {
+			pm_pr_dbg("Wakeup after ACPI Notify sync\n");
+			return true;
+		}
+
+		pm_pr_dbg("Rearming ACPI SCI for wakeup\n");
+
+		pm_wakeup_clear(acpi_sci_irq);
+		rearm_wake_irq(acpi_sci_irq);
+	}
+
+	return false;
+}
+
+void acpi_s2idle_restore(void)
+{
+	/*
+	 * Drain pending events before restoring the working-state configuration
+	 * of GPEs.
+	 */
+	acpi_os_wait_events_complete(); /* synchronize GPE processing */
+	acpi_ec_flush_work(); /* flush the EC driver's workqueues */
+	acpi_os_wait_events_complete(); /* synchronize Notify handling */
+
+	s2idle_wakeup = false;
+
+	acpi_enable_all_runtime_gpes();
+
+	acpi_disable_wakeup_devices(ACPI_STATE_S0);
+
+	if (acpi_sci_irq_valid()) {
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
+		disable_irq_wake(acpi_sci_irq);
+	}
+}
+
+void acpi_s2idle_end(void)
+{
+	acpi_scan_lock_release();
+}
+
+static const struct platform_s2idle_ops acpi_s2idle_ops = {
+	.begin = acpi_s2idle_begin,
+	.prepare = acpi_s2idle_prepare,
+	.wake = acpi_s2idle_wake,
+	.restore = acpi_s2idle_restore,
+	.end = acpi_s2idle_end,
+};
+
+void __init __weak acpi_s2idle_setup(void)
+{
+	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
+		pr_info("Efficient low-power S0 idle declared\n");
+
+	s2idle_set_ops(&acpi_s2idle_ops);
+}
+
+bool acpi_s2idle_wakeup(void)
+{
+	return s2idle_wakeup;
+}
+
+void __init acpi_s2idle_init(void)
+{
+	acpi_s2idle_setup();
+}
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 132a9df98471..eeaacc354c48 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -724,143 +724,6 @@ static const struct platform_suspend_ops acpi_suspend_ops_old = {
 	.recover = acpi_pm_finish,
 };
 
-static bool s2idle_wakeup;
-
-int acpi_s2idle_begin(void)
-{
-	acpi_scan_lock_acquire();
-	return 0;
-}
-
-int acpi_s2idle_prepare(void)
-{
-	if (acpi_sci_irq_valid()) {
-		int error;
-
-		error = enable_irq_wake(acpi_sci_irq);
-		if (error)
-			pr_warn("Warning: Failed to enable wakeup from IRQ %d: %d\n",
-				acpi_sci_irq, error);
-
-		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
-	}
-
-	acpi_enable_wakeup_devices(ACPI_STATE_S0);
-
-	/* Change the configuration of GPEs to avoid spurious wakeup. */
-	acpi_enable_all_wakeup_gpes();
-	acpi_os_wait_events_complete();
-
-	s2idle_wakeup = true;
-	return 0;
-}
-
-bool acpi_s2idle_wake(void)
-{
-	if (!acpi_sci_irq_valid())
-		return pm_wakeup_pending();
-
-	while (pm_wakeup_pending()) {
-		/*
-		 * If IRQD_WAKEUP_ARMED is set for the SCI at this point, the
-		 * SCI has not triggered while suspended, so bail out (the
-		 * wakeup is pending anyway and the SCI is not the source of
-		 * it).
-		 */
-		if (irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
-			pm_pr_dbg("Wakeup unrelated to ACPI SCI\n");
-			return true;
-		}
-
-		/*
-		 * If the status bit of any enabled fixed event is set, the
-		 * wakeup is regarded as valid.
-		 */
-		if (acpi_any_fixed_event_status_set()) {
-			pm_pr_dbg("ACPI fixed event wakeup\n");
-			return true;
-		}
-
-		/* Check wakeups from drivers sharing the SCI. */
-		if (acpi_check_wakeup_handlers()) {
-			pm_pr_dbg("ACPI custom handler wakeup\n");
-			return true;
-		}
-
-		/*
-		 * Check non-EC GPE wakeups and if there are none, cancel the
-		 * SCI-related wakeup and dispatch the EC GPE.
-		 */
-		if (acpi_ec_dispatch_gpe()) {
-			pm_pr_dbg("ACPI non-EC GPE wakeup\n");
-			return true;
-		}
-
-		acpi_os_wait_events_complete();
-
-		/*
-		 * The SCI is in the "suspended" state now and it cannot produce
-		 * new wakeup events till the rearming below, so if any of them
-		 * are pending here, they must be resulting from the processing
-		 * of EC events above or coming from somewhere else.
-		 */
-		if (pm_wakeup_pending()) {
-			pm_pr_dbg("Wakeup after ACPI Notify sync\n");
-			return true;
-		}
-
-		pm_pr_dbg("Rearming ACPI SCI for wakeup\n");
-
-		pm_wakeup_clear(acpi_sci_irq);
-		rearm_wake_irq(acpi_sci_irq);
-	}
-
-	return false;
-}
-
-void acpi_s2idle_restore(void)
-{
-	/*
-	 * Drain pending events before restoring the working-state configuration
-	 * of GPEs.
-	 */
-	acpi_os_wait_events_complete(); /* synchronize GPE processing */
-	acpi_ec_flush_work(); /* flush the EC driver's workqueues */
-	acpi_os_wait_events_complete(); /* synchronize Notify handling */
-
-	s2idle_wakeup = false;
-
-	acpi_enable_all_runtime_gpes();
-
-	acpi_disable_wakeup_devices(ACPI_STATE_S0);
-
-	if (acpi_sci_irq_valid()) {
-		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
-		disable_irq_wake(acpi_sci_irq);
-	}
-}
-
-void acpi_s2idle_end(void)
-{
-	acpi_scan_lock_release();
-}
-
-static const struct platform_s2idle_ops acpi_s2idle_ops = {
-	.begin = acpi_s2idle_begin,
-	.prepare = acpi_s2idle_prepare,
-	.wake = acpi_s2idle_wake,
-	.restore = acpi_s2idle_restore,
-	.end = acpi_s2idle_end,
-};
-
-void __weak acpi_s2idle_setup(void)
-{
-	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
-		pr_info("Efficient low-power S0 idle declared\n");
-
-	s2idle_set_ops(&acpi_s2idle_ops);
-}
-
 static void __init acpi_sleep_suspend_setup(void)
 {
 	bool suspend_ops_needed = false;
@@ -875,20 +738,12 @@ static void __init acpi_sleep_suspend_setup(void)
 	if (suspend_ops_needed)
 		suspend_set_ops(old_suspend_ordering ?
 				&acpi_suspend_ops_old : &acpi_suspend_ops);
-
-	acpi_s2idle_setup();
 }
 
 #else /* !CONFIG_SUSPEND */
-#define s2idle_wakeup		(false)
 static inline void acpi_sleep_suspend_setup(void) {}
 #endif /* !CONFIG_SUSPEND */
 
-bool acpi_s2idle_wakeup(void)
-{
-	return s2idle_wakeup;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static u32 saved_bm_rld;
 
-- 
2.25.1

