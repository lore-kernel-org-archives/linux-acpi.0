From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/29] ACPI: idle: mark_tsc_unstable() at init-time,
 not run-time
Date: Thu, 23 Apr 2009 02:23:50 -0400
Message-ID: <a71e4917dc0ebbcb5a0ecb7ca3486643c1c9a6e2.1240467665.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:58836 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbZDWGYK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:10 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ003FGJ49EQ73@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:10 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

The c2 and c3 idle handlers check tsc_halts_in_c()
after every time they return from idle.  Um, when?:-)

Move this check to init-time to remove the unnecessary
run-time overhead, and also to have the check complete before
the first entry into the idle handler.

ff69f2bba67bd45514923aaedbf40fe351787c59
(acpi: fix of pmtimer overflow that make Cx states time incorrect)
replaced the hard-coded use of the PM-timer inside idle,
with ktime_get_readl(), which possibly uses the TSC --
so it is now especially prudent to detect a broken TSC
before entering idle.

http://bugzilla.kernel.org/show_bug.cgi?id=13087

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6fe1214..9d1f01e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -581,6 +581,11 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
 		struct acpi_processor_cx *cx = &pr->power.states[i];
 
+#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
+		/* TSC could halt in idle, so notify users */
+		if (tsc_halts_in_c(cx->type))
+			mark_tsc_unstable("TSC halts in idle");;
+#endif
 		switch (cx->type) {
 		case ACPI_STATE_C1:
 			cx->valid = 1;
@@ -871,11 +876,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	kt2 = ktime_get_real();
 	idle_time =  ktime_to_us(ktime_sub(kt2, kt1));
 
-#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
-	/* TSC could halt in idle, so notify users */
-	if (tsc_halts_in_c(cx->type))
-		mark_tsc_unstable("TSC halts in idle");;
-#endif
 	sleep_ticks = us_to_pm_timer_ticks(idle_time);
 
 	/* Tell the scheduler how much we idled: */
@@ -989,11 +989,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 		spin_unlock(&c3_lock);
 	}
 
-#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
-	/* TSC could halt in idle, so notify users */
-	if (tsc_halts_in_c(ACPI_STATE_C3))
-		mark_tsc_unstable("TSC halts in idle");
-#endif
 	sleep_ticks = us_to_pm_timer_ticks(idle_time);
 	/* Tell the scheduler how much we idled: */
 	sched_clock_idle_wakeup_event(sleep_ticks*PM_TIMER_TICK_NS);
-- 
1.6.0.6

