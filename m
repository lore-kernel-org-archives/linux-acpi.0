From: akpm@osdl.org
Subject: + updated-acpi-add-state-propagation-for-dynamic-broadcasting.patch added to -mm tree
Date: Thu, 09 Nov 2006 17:32:15 -0800
Message-ID: <200611100132.kAA1WF2Z007408@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:65475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424338AbWKJBcd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Nov 2006 20:32:33 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mm-commits@vger.kernel.org
Cc: tglx@linutronix.de, ak@suse.de, len.brown@intel.com, linux-acpi@vger.kernel.org, mingo@elte.hu


The patch titled
     ACPI: Add state propagation for dynamic broadcasting
has been added to the -mm tree.  Its filename is
     updated-acpi-add-state-propagation-for-dynamic-broadcasting.patch

See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
out what to do about this

------------------------------------------------------
Subject: ACPI: Add state propagation for dynamic broadcasting
From: Thomas Gleixner <tglx@linutronix.de>

This is a preparatory patch for high resolution timers and dynticks.

The local APIC timer is fast and per CPU, but it gets stopped in C3 state.  On
some broken systems, especially AMD based ones it gets stopped in C2.  This
also affects akpm's jinxed VAIO.

The broadcast function informs the local APIC management code that a state
which stops the local APIC is going to be entered/exited.  This switches the
local APIC timer to the PIT broadcast mode.  The clockevents layer takes care
of the distribution of events.

The lapic_timer_idle_broadcast() function is an empty inline for now, which
will be replaced by the later clockevents patches for the affected
architectures.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: <linux-acpi@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_idle.c |   20 ++++++++++++++++++++
 include/asm-i386/apic.h       |    1 +
 include/asm-x86_64/apic.h     |    1 +
 3 files changed, 22 insertions(+)

diff -puN drivers/acpi/processor_idle.c~updated-acpi-add-state-propagation-for-dynamic-broadcasting drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~updated-acpi-add-state-propagation-for-dynamic-broadcasting
+++ a/drivers/acpi/processor_idle.c
@@ -281,11 +281,27 @@ static void acpi_propagate_timer_broadca
 		on_each_cpu(switch_ipi_to_APIC_timer, &mask, 1, 1);
 }
 
+/* Power(C) State timer broadcast control */
+static void acpi_state_timer_broadcast(struct acpi_processor *pr,
+				       struct acpi_processor_cx *cx,
+				       int broadcast)
+{
+	int state = cx - pr->power.states;
+
+	if (state >= pr->power.timer_broadcast_on_state)
+		lapic_timer_idle_broadcast(broadcast);
+}
+
 #else
 
 static void acpi_timer_check_state(int state, struct acpi_processor *pr,
 				   struct acpi_processor_cx *cstate) { }
 static void acpi_propagate_timer_broadcast(struct acpi_processor *pr) { }
+static void acpi_state_timer_broadcast(struct acpi_processor *pr,
+				       struct acpi_processor_cx *cx,
+				       int broadcast)
+{
+}
 
 #endif
 
@@ -431,6 +447,7 @@ static void acpi_processor_idle(void)
 		/* Get start time (ticks) */
 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Invoke C2 */
+		acpi_state_timer_broadcast(pr, cx, 1);
 		acpi_cstate_enter(cx);
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
@@ -445,6 +462,7 @@ static void acpi_processor_idle(void)
 		/* Compute time (ticks) that we were actually asleep */
 		sleep_ticks =
 		    ticks_elapsed(t1, t2) - cx->latency_ticks - C2_OVERHEAD;
+		acpi_state_timer_broadcast(pr, cx, 0);
 		break;
 
 	case ACPI_STATE_C3:
@@ -467,6 +485,7 @@ static void acpi_processor_idle(void)
 		/* Get start time (ticks) */
 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Invoke C3 */
+		acpi_state_timer_broadcast(pr, cx, 1);
 		acpi_cstate_enter(cx);
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
@@ -487,6 +506,7 @@ static void acpi_processor_idle(void)
 		/* Compute time (ticks) that we were actually asleep */
 		sleep_ticks =
 		    ticks_elapsed(t1, t2) - cx->latency_ticks - C3_OVERHEAD;
+		acpi_state_timer_broadcast(pr, cx, 0);
 		break;
 
 	default:
diff -puN include/asm-i386/apic.h~updated-acpi-add-state-propagation-for-dynamic-broadcasting include/asm-i386/apic.h
--- a/include/asm-i386/apic.h~updated-acpi-add-state-propagation-for-dynamic-broadcasting
+++ a/include/asm-i386/apic.h
@@ -113,6 +113,7 @@ extern void setup_secondary_APIC_clock (
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
+static inline void lapic_timer_idle_broadcast(int broadcast) { }
 
 extern void enable_NMI_through_LVT0 (void * dummy);
 
diff -puN include/asm-x86_64/apic.h~updated-acpi-add-state-propagation-for-dynamic-broadcasting include/asm-x86_64/apic.h
--- a/include/asm-x86_64/apic.h~updated-acpi-add-state-propagation-for-dynamic-broadcasting
+++ a/include/asm-x86_64/apic.h
@@ -84,6 +84,7 @@ extern int APIC_init_uniprocessor (void)
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
 extern void clustered_apic_check(void);
+static inline void lapic_timer_idle_broadcast(int broadcast) { }
 
 extern void setup_APIC_extened_lvt(unsigned char lvt_off, unsigned char vector,
 				   unsigned char msg_type, unsigned char mask);
_

Patches currently in -mm which might be from tglx@linutronix.de are

setup_irq-better-mismatch-debugging.patch
gtod-exponential-update_wall_time.patch
gtod-persistent-clock-support-core.patch
gtod-persistent-clock-support-i386.patch
time-uninline-jiffiesh.patch
time-uninline-jiffiesh-fix.patch
time-fix-msecs_to_jiffies-bug.patch
time-fix-timeout-overflow.patch
cleanup-uninline-irq_enter-and-move-it-into-a-function.patch
dynticks-extend-next_timer_interrupt-to-use-a-reference-jiffie.patch
dynticks-extend-next_timer_interrupt-to-use-a-reference-jiffie-remove-incorrect-warning-in-kernel-timerc.patch
hrtimers-namespace-and-enum-cleanup.patch
hrtimers-clean-up-locking.patch
updated-hrtimers-state-tracking.patch
updated-hrtimers-clean-up-callback-tracking.patch
updated-hrtimers-move-and-add-documentation.patch
updated-add-a-framework-to-manage-clock-event-devices.patch
updated-acpi-include-apich.patch
updated-acpi-keep-track-of-timer-broadcast.patch
updated-acpi-add-state-propagation-for-dynamic-broadcasting.patch
updated-i386-cleanup-apic-code.patch
updated-i386-convert-to-clock-event-devices.patch
updated-pm_timer-allow-early-access-and-move-externs-to-a-header-file.patch
updated-i386-rework-local-apic-calibration.patch
updated-high-res-timers-core.patch
updated-gtod-mark-tsc-unusable-for-highres-timers.patch
updated-dynticks-core-code.patch
updated-dyntick-add-nohz-stats-to-proc-stat.patch
updated-dynticks-i386-arch-code.patch
updated-dynticks-fix-nmi-watchdog.patch
updated-high-res-timers-dynticks-enable-i386-support.patch
updated-debugging-feature-timer-stats.patch
clockevents-core-check-for-clock-event-device-handler-being-non-null-before-calling-it.patch
round_jiffies-infrastructure.patch
round_jiffies-infrastructure-fix.patch
clocksource-add-usage-of-config_sysfs.patch
clocksource-small-cleanup-2.patch
clocksource-small-cleanup-2-fix.patch
clocksource-small-acpi_pm-cleanup.patch

