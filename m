From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/17] x86 ACPI: Add support for Always Running APIC timer
Date: Tue, 07 Apr 2009 19:04:25 -0400
Message-ID: <db954b5898dd3ef3ef93f4144158ea8f97deb058.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:32642 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbZDGXFQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:05:16 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR0033F6SITYCB@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:05:07 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Add support for Always Running APIC timer, CPUID_0x6_EAX_Bit2.
This bit means the APIC timer continues to run even when CPU is
in deep C-states.

The advantage is that we can use LAPIC timer on these CPUs
always, and there is no need for "slow to read and program"
external timers (HPET/PIT) and the timer broadcast logic
and related code in C-state entry and exit.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Acked-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/cpufeature.h          |    1 +
 arch/x86/kernel/apic/apic.c                |    6 ++++++
 arch/x86/kernel/cpu/addon_cpuid_features.c |    1 +
 drivers/acpi/processor_idle.c              |    3 +++
 4 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 0beba0d..bb83b1c 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -154,6 +154,7 @@
  * CPUID levels like 0x6, 0xA etc
  */
 #define X86_FEATURE_IDA		(7*32+ 0) /* Intel Dynamic Acceleration */
+#define X86_FEATURE_ARAT	(7*32+ 1) /* Always Running APIC Timer */
 
 /* Virtualization flags: Linux defined */
 #define X86_FEATURE_TPR_SHADOW  (8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 098ec84..f287092 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -431,6 +431,12 @@ static void __cpuinit setup_APIC_timer(void)
 {
 	struct clock_event_device *levt = &__get_cpu_var(lapic_events);
 
+	if (cpu_has(&current_cpu_data, X86_FEATURE_ARAT)) {
+		lapic_clockevent.features &= ~CLOCK_EVT_FEAT_C3STOP;
+		/* Make LAPIC timer preferrable over percpu HPET */
+		lapic_clockevent.rating = 150;
+	}
+
 	memcpy(levt, &lapic_clockevent, sizeof(*levt));
 	levt->cpumask = cpumask_of(smp_processor_id());
 
diff --git a/arch/x86/kernel/cpu/addon_cpuid_features.c b/arch/x86/kernel/cpu/addon_cpuid_features.c
index 8220ae6..c965e52 100644
--- a/arch/x86/kernel/cpu/addon_cpuid_features.c
+++ b/arch/x86/kernel/cpu/addon_cpuid_features.c
@@ -31,6 +31,7 @@ void __cpuinit init_scattered_cpuid_features(struct cpuinfo_x86 *c)
 
 	static const struct cpuid_bit __cpuinitconst cpuid_bits[] = {
 		{ X86_FEATURE_IDA, CR_EAX, 1, 0x00000006 },
+		{ X86_FEATURE_ARAT, CR_EAX, 2, 0x00000006 },
 		{ 0, 0, 0, 0 }
 	};
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4e6e758..6fe1214 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -145,6 +145,9 @@ static void acpi_timer_check_state(int state, struct acpi_processor *pr,
 	struct acpi_processor_power *pwr = &pr->power;
 	u8 type = local_apic_timer_c2_ok ? ACPI_STATE_C3 : ACPI_STATE_C2;
 
+	if (cpu_has(&cpu_data(pr->id), X86_FEATURE_ARAT))
+		return;
+
 	/*
 	 * Check, if one of the previous states already marked the lapic
 	 * unstable
-- 
1.6.0.6

