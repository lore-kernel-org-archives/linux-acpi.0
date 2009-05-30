From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/11] cpuidle: makes AMD C1E work in acpi_idle
Date: Fri, 29 May 2009 21:37:11 -0400
Message-ID: <87ad57bacb25c3f24c54f142ef445f68277705f0.1243647311.git.len.brown@intel.com>
References: <1243647441-31392-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:46125 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576AbZE3Bhj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:37:39 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00IHTOIEHY12@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:37:32 -0500 (CDT)
In-reply-to: <1243647441-31392-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

When AMD C1E is enabled, local APIC timer will stop even in C1.
This patch uses broadcast IPI to replace local APIC timer in C1.

http://bugzilla.kernel.org/show_bug.cgi?id=13233

[ impact: avoid boot hang in AMD CPU with C1E enabled ]

Tested-by: Dmitry Lyzhyn <thisistempbox@yahoo.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 72069ba..6b7bcc7 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -148,6 +148,9 @@ static void acpi_timer_check_state(int state, struct acpi_processor *pr,
 	if (cpu_has(&cpu_data(pr->id), X86_FEATURE_ARAT))
 		return;
 
+	if (boot_cpu_has(X86_FEATURE_AMDC1E))
+		type = ACPI_STATE_C1;
+
 	/*
 	 * Check, if one of the previous states already marked the lapic
 	 * unstable
@@ -611,6 +614,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 		switch (cx->type) {
 		case ACPI_STATE_C1:
 			cx->valid = 1;
+			acpi_timer_check_state(i, pr, cx);
 			break;
 
 		case ACPI_STATE_C2:
@@ -835,6 +839,7 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 		return 0;
 	}
 
+	acpi_state_timer_broadcast(pr, cx, 1);
 	kt1 = ktime_get_real();
 	acpi_idle_do_entry(cx);
 	kt2 = ktime_get_real();
@@ -842,6 +847,7 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 
 	local_irq_enable();
 	cx->usage++;
+	acpi_state_timer_broadcast(pr, cx, 0);
 
 	return idle_time;
 }
-- 
1.6.0.6

