From: Len Brown <lenb@kernel.org>
Subject: [PATCH 095/112] ACPI: cpuidle: Support C1 idle time accounting
Date: Thu,  7 Feb 2008 04:34:57 -0500
Message-ID: <9b12e18cdc1553de62d931e73443c806347cd974.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754051AbYBGJgy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:54 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "venkatesh.pallipadi@intel.com" <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: venkatesh.pallipadi@intel.com <venkatesh.pallipadi@intel.com>

Show C1 idle time in /sysfs cpuidle interface. C1 idle time may not
be entirely accurate in all cases. It includes the time spent
in the interrupt handler after wakeup with "hlt" based C1. But, it will
be accurate with "mwait" based C1.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4ba3a9a..fea7159 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1407,8 +1407,10 @@ static inline void acpi_idle_do_entry(struct acpi_processor_cx *cx)
 static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 			      struct cpuidle_state *state)
 {
+	u32 t1, t2;
 	struct acpi_processor *pr;
 	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
+
 	pr = processors[smp_processor_id()];
 
 	if (unlikely(!pr))
@@ -1418,12 +1420,14 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 	if (pr->flags.bm_check)
 		acpi_idle_update_bm_rld(pr, cx);
 
+	t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 	acpi_idle_do_entry(cx);
+	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 
 	local_irq_enable();
 	cx->usage++;
 
-	return 0;
+	return ticks_elapsed_in_us(t1, t2);
 }
 
 /**
@@ -1660,6 +1664,7 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 		switch (cx->type) {
 			case ACPI_STATE_C1:
 			state->flags |= CPUIDLE_FLAG_SHALLOW;
+			state->flags |= CPUIDLE_FLAG_TIME_VALID;
 			state->enter = acpi_idle_enter_c1;
 			dev->safe_state = state;
 			break;
-- 
1.5.4.23.gef5b9

