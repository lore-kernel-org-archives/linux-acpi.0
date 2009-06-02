From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH]make AMC C1E work in processor_idle
Date: Tue, 2 Jun 2009 10:51:58 +0800
Message-ID: <20090602025158.GA21337@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18008 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755889AbZFBCv5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Jun 2009 22:51:57 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Below two commits should go into 2.6.27 2.6.28 2.6.29 stable as suggested by Len.
87ad57bacb25c3f24c54f142ef445f68277705f0
7d60e8ab0d5507229dfbdf456501cc378610fa01

The first commit can't be applied, below patch is updated which should apply
to the branches.
The second commit can apply directly.

When AMD C1E is enabled, local APIC timer will stop even in C1. This patch uses
broadcast ipi to replace local APIC timer in C1.

http://bugzilla.kernel.org/show_bug.cgi?id=13233

[ impact: avoid boot hang in AMD CPU with C1E enabled ]

Tested-by: Dmitry Lyzhyn <thisistempbox@yahoo.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/processor_idle.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux/drivers/acpi/processor_idle.c
===================================================================
--- linux.orig/drivers/acpi/processor_idle.c	2009-06-02 09:27:53.000000000 +0800
+++ linux/drivers/acpi/processor_idle.c	2009-06-02 09:32:36.000000000 +0800
@@ -212,6 +212,9 @@ static void acpi_timer_check_state(int s
 	struct acpi_processor_power *pwr = &pr->power;
 	u8 type = local_apic_timer_c2_ok ? ACPI_STATE_C3 : ACPI_STATE_C2;
 
+	if (boot_cpu_has(X86_FEATURE_AMDC1E))
+		type = ACPI_STATE_C1;
+
 	/*
 	 * Check, if one of the previous states already marked the lapic
 	 * unstable
@@ -648,6 +651,7 @@ static int acpi_processor_power_verify(s
 		switch (cx->type) {
 		case ACPI_STATE_C1:
 			cx->valid = 1;
+			acpi_timer_check_state(i, pr, cx);
 			break;
 
 		case ACPI_STATE_C2:
@@ -871,12 +875,14 @@ static int acpi_idle_enter_c1(struct cpu
 		return 0;
 	}
 
+	acpi_state_timer_broadcast(pr, cx, 1);
 	t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 	acpi_idle_do_entry(cx);
 	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 
 	local_irq_enable();
 	cx->usage++;
+	acpi_state_timer_broadcast(pr, cx, 0);
 
 	return ticks_elapsed_in_us(t1, t2);
 }
