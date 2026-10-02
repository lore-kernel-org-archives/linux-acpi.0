Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B5433046;
	Fri,  2 Oct 2026 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928439; cv=none; b=In/j2BhJ+vABStimtck0GE24GG+GWN2+Jx4q0MQD2foWUX9L/UTuLDI3l2WfJrNP4vV/zVjdZS0HGz3WNCgrcUvUiuZuJxXroJ35+iUUMiuwnh5ACWl3QAkV3vg3N3YuU8F/qiRm0xUYiJaZDdp+NFMYgX/Z1OlI/iujTsmrnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928439; c=relaxed/simple;
	bh=AFzkYDMxFoNA91DxoEfvZldntizHvRhfzV8yeV8OUxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CezgJPMmcom/6gtzFpWNYvFVqWSKSsWbgHTQJSuLWSAEGqIcz7OefDqmg4BmGn/vZZ39nNfL+SVe2H9zRDUw6KZ6d4fOm+4ornuTUnSUmerovdULmL8L/92ncfyB5VbqbHP2c8npG1OopUD7Aj49oVsF8rZK1BjrFvovhaZxwoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4251b018be3811f19a56ed5b684f684d-20261002
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d7266629-fdc1-49c2-9f38-a3b4151e88ea,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:a1972435764a004f2aa0c1bfd37aaad0,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4251b018be3811f19a56ed5b684f684d-20261002
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1199432532; Fri, 02 Oct 2026 16:07:06 +0800
From: Riwen Lu <luriwen@kylinos.cn>
To: rafael@kernel.org
Cc: luriwen@kylinos.cn,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] ACPI: PM: Make s2idle available on all ACPI platforms with suspend support
Date: Fri,  2 Oct 2026 16:07:03 +0800
Message-Id: <20261002080703.77402-1-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI s2idle code lives in sleep.c and is guarded by
ACPI_SYSTEM_POWER_STATES_SUPPORT, which is only selected by x86 and
loongarch.  Consequently, ACPI platforms using HW-reduced ACPI (like
arm64) have no ACPI s2idle support at all and cannot handle ACPI
wakeup events (power button, lid, GPEs) during suspend-to-idle.

s2idle is a pure software suspend state that does not depend on
firmware S-states, so move it out of sleep.c into a new s2idle.c and
tie it to a separate hidden symbol, ACPI_S2IDLE, that is enabled by
default whenever suspend support is there (following the ACPI_LPIT
pattern).  No user-visible option is introduced, no platform needs to
select anything, and x86/loongarch builds are unaffected.

The s2idle code is initialized from acpi_bus_init() via
acpi_s2idle_init() which replaces the acpi_s2idle_setup() call from
acpi_sleep_suspend_setup().  The weak acpi_s2idle_setup() is kept
unchanged for the existing x86 override.

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

v4 -> v5:
 - Add #include <linux/interrupt.h> to s2idle.c.  enable_irq_wake(),
   disable_irq_wake() and rearm_wake_irq() are declared there.

v5 -> v6:
 - Turn ACPI_S2IDLE into a hidden bool with default y, following the
   ACPI_LPIT pattern, instead of a user-visible option selected by
   ACPI_SYSTEM_POWER_STATES_SUPPORT.  No prompt, no conditional select
   and no arch-specific changes: x86 and loongarch builds stay as they
   are and arm64 gets s2idle automatically.


 drivers/acpi/Kconfig    |   5 ++
 drivers/acpi/Makefile   |   1 +
 drivers/acpi/bus.c      |   3 +
 drivers/acpi/internal.h |  10 ++-
 drivers/acpi/s2idle.c   | 163 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/sleep.c    | 145 -----------------------------------
 6 files changed, 180 insertions(+), 147 deletions(-)
 create mode 100644 drivers/acpi/s2idle.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f165d14cf61a..11b574b394a4 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -113,6 +113,11 @@ config ACPI_SLEEP
 	depends on ACPI_SYSTEM_POWER_STATES_SUPPORT
 	default y
 
+config ACPI_S2IDLE
+	bool
+	depends on SUSPEND
+	default y
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
index 808c6746be14..afde30bb17aa 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1428,6 +1428,9 @@ static int __init acpi_bus_init(void)
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
index 000000000000..b5cd9649acda
--- /dev/null
+++ b/drivers/acpi/s2idle.c
@@ -0,0 +1,163 @@
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
+#include <linux/interrupt.h>
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

