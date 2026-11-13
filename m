Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530670;
	b=rDk4IRoQOyWb8mfPEQLAcLi2UonqwuuZCj2UXN07ZEMu1dwlwvxPxQZuTC9JjNEPRnKf
	 6NE7Zn3BzAuwazI4sCQ27v86B0pEvPGiPaI32Fj2jSO6kO88AbQxxbi4TX/6mNxz8pILr
	 qKRPNrYOPySUFnKArDMviTmCG1+OcjjeLWVsTuGnHK/HdYof6r16Yv2LDHzVM20Mj3uFW
	 wiJXYgfFBDQ6keOKKwlYbqEsyBrmeu/P5NiMnu5Fybqpc1fycvGuZv/Xo8dAO+GM7sYsB
	 l24iBqKvZ0ipyM2P3kAb1hTGf3P1MZ57bdObzk1FM7tKaCX1O5BLYOctXIOcPNTtQFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530670;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qk9MPy6Npw1ZCCumf8cujp4oJUl8nPKip11lWWoNcbQ=;
	b=jkFpYaLV2KXXCZCmxQIELv4wkKHlfwgBY+/AW66ElktmqP3Kjb80otcmq8lnfuCHyc1c
	 bcJ4jBDSxMYS03Dk9/RGj6pBQMeeTwujpevSVtJG0396ufSGxASPBok9fodZTc7qKKhsT
	 pzN6ibo/TZyrClVhe343LIOsPuRLciCId5R7DACadtH9n0r9tLOEsNoG2ytqnj1R9I7pr
	 NeiRM8v3mJ0jvKCb0cX8qQSVufTk8Y+ZHCvhbDo983+PqaaRVOxTs9YcNgggKL44rVDdo
	 dFo4dNlDr0uN5f86c43rT9qorCDY/CNUMDq/3FYQn7aF79LkFxHH/v31g59aRqPaG7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F7606A885;
	Fri, 13 Nov 2026 00:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 588F7606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5dd0f284defb11f19a56ed5b684f684d-20261113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:201c943b-613b-42aa-a102-655a3e16884c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:d47035176f9f8d75a6a0c96e5a45fcbf,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5dd0f284defb11f19a56ed5b684f684d-20261113
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 343206682; Fri, 13 Nov 2026 08:44:21 +0800
From: Riwen Lu <luriwen@kylinos.cn>
To: rafael@kernel.org
Cc: luriwen@kylinos.cn,
	lenb@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7] ACPI: PM: Make s2idle available on HW-reduced ACPI platforms
Date: Fri, 13 Nov 2026 08:44:19 +0800
Message-Id: <20261113004419.1877837-1-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI s2idle code in sleep.c is only compiled when
ACPI_SYSTEM_POWER_STATES_SUPPORT is set, which is selected by x86 and
loongarch alone, so ACPI platforms using HW-reduced ACPI (like arm64
or riscv) have no ACPI s2idle support at all and cannot handle ACPI
wakeup events (power button, lid, GPEs) during suspend-to-idle.

The majority of that code, however, is specific to systems with full
ACPI HW support: the SCI IRQ handling, the wakeup device and global
GPE management, the wakeup arbitration loop and the EC event draining
are all not configured on HW-reduced platforms, so those platforms
should not compile them at all.

Therefore move the s2idle code into a new s2idle.c with the parts
usable on every ACPI platform (scan lock, event draining) provided
under a new hidden ACPI_S2IDLE symbol that is enabled by default
whenever suspend support is there.  The HW-specific parts are only
built for CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT and the reduced
callbacks do not install a wake() one at all: with nothing to
arbitrate there, the PM core's default pm_wakeup_pending() check is
the desired wakeup rule.

x86 and loongarch builds are not affected and the LPS0 path in
drivers/acpi/x86/s2idle.c keeps working as before.

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

v6 -> v7:
 - Keep the code split, but stop compiling the HW-specific parts of it
   unconditionally: the SCI IRQ wakeup, the fixed event and EC GPE
   arbitration, the EC event draining, the wakeup device handling and
   the global GPE list switch over are now built only when
   CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT is set, following the review
   feedback that none of them is configured on HW-reduced platforms.
 - HW-reduced platforms get a reduced set of callbacks which does not
   install a wake() one at all: with nothing to arbitrate there, the
   PM core's default pm_wakeup_pending() check is the desired wakeup
   rule.


 drivers/acpi/Kconfig    |   5 ++
 drivers/acpi/Makefile   |   1 +
 drivers/acpi/bus.c      |   3 +
 drivers/acpi/internal.h |  10 ++-
 drivers/acpi/s2idle.c   | 178 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/sleep.c    | 145 --------------------------------
 6 files changed, 195 insertions(+), 147 deletions(-)
 create mode 100644 drivers/acpi/s2idle.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index fa3eb52b22cd..21b7aa68346d 100644
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
index 91584a3c1e01..d51207e52741 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -35,6 +35,7 @@ acpi-$(CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT) += sleep.o
 acpi-y				+= device_sysfs.o device_pm.o
 acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
 
+acpi-$(CONFIG_ACPI_S2IDLE)	+= s2idle.o
 
 #
 # ACPI Bus and Device Drivers
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 1d6867dec925..59979d862889 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1412,6 +1412,9 @@ static int __init acpi_bus_init(void)
 	/* Initialize sleep structures */
 	acpi_sleep_init();
 
+	/* Initialize default acpi s2idle ops */
+	acpi_s2idle_init();
+
 	/*
 	 * Get the system interrupt model and evaluate \_PIC.
 	 */
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 011da4ed6a80..05a576610822 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -268,13 +268,19 @@ static inline bool acpi_ec_dispatch_gpe(void)
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
index 000000000000..22cd7416ac56
--- /dev/null
+++ b/drivers/acpi/s2idle.c
@@ -0,0 +1,178 @@
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
+#include <linux/irq.h>
+#include <linux/suspend.h>
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
+#ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
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
+#endif /* CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT */
+	acpi_os_wait_events_complete();
+
+	s2idle_wakeup = true;
+	return 0;
+}
+
+#ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
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
+#endif /* CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT */
+
+void acpi_s2idle_restore(void)
+{
+	/*
+	 * Drain pending events; on systems with full ACPI HW support the
+	 * working-state GPE configuration is also restored below.
+	 */
+	acpi_os_wait_events_complete(); /* synchronize GPE processing */
+#ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
+	acpi_ec_flush_work(); /* flush the EC driver's workqueues */
+	acpi_os_wait_events_complete(); /* synchronize Notify handling */
+#endif /* CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT */
+
+	s2idle_wakeup = false;
+
+#ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
+	acpi_enable_all_runtime_gpes();
+
+	acpi_disable_wakeup_devices(ACPI_STATE_S0);
+
+	if (acpi_sci_irq_valid()) {
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
+		disable_irq_wake(acpi_sci_irq);
+	}
+#endif /* CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT */
+}
+
+void acpi_s2idle_end(void)
+{
+	acpi_scan_lock_release();
+}
+
+/*
+ * No wake() callback on HW-reduced platforms: there is nothing to
+ * arbitrate there, so the PM core's default pm_wakeup_pending()
+ * check applies.
+ */
+static const struct platform_s2idle_ops acpi_s2idle_ops = {
+	.begin = acpi_s2idle_begin,
+	.prepare = acpi_s2idle_prepare,
+#ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
+	.wake = acpi_s2idle_wake,
+#endif
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
index a94bac4422d4..b588629fb22e 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -723,143 +723,6 @@ static const struct platform_suspend_ops acpi_suspend_ops_old = {
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
@@ -874,20 +737,12 @@ static void __init acpi_sleep_suspend_setup(void)
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

