From: Venkatesh Pallipadi <venki@google.com>
Subject: [PATCH] acpi: Minor cleanup eliminating redundant PMTIMER_TICKS to NS conversion
Date: Thu, 22 Apr 2010 16:48:33 -0700
Message-ID: <1271980113-5624-1-git-send-email-venki@google.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35324 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab0DVXtY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Apr 2010 19:49:24 -0400
Received: from kpbe14.cbf.corp.google.com (kpbe14.cbf.corp.google.com [172.25.105.78])
	by smtp-out.google.com with ESMTP id o3MNnMOH015555
	for <linux-acpi@vger.kernel.org>; Thu, 22 Apr 2010 16:49:23 -0700
Received: from gwaa20 (gwaa20.prod.google.com [10.200.27.20])
	by kpbe14.cbf.corp.google.com with ESMTP id o3MNnLTQ028857
	for <linux-acpi@vger.kernel.org>; Thu, 22 Apr 2010 16:49:22 -0700
Received: by gwaa20 with SMTP id a20so3559169gwa.39
        for <linux-acpi@vger.kernel.org>; Thu, 22 Apr 2010 16:49:21 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI list <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venki@google.com>

acpi_enter_[simple,bm] does
idle timing in ns, convert it to timeval, then to us, then to
pmtimer_ticks and then back to ns.

This patch changes things to
idle timing in ns, convert it to us, and then to pmtimer_ticks.

Just saves an imul along this path, but makes the code cleaner.

Signed-off-by: Venkatesh Pallipadi <venki@google.com>
---
 drivers/acpi/processor_idle.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5939e7f..9e734ce 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -869,6 +869,7 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	struct acpi_processor *pr;
 	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
 	ktime_t  kt1, kt2;
+	s64 idle_time_ns;
 	s64 idle_time;
 	s64 sleep_ticks = 0;
 
@@ -910,12 +911,14 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	sched_clock_idle_sleep_event();
 	acpi_idle_do_entry(cx);
 	kt2 = ktime_get_real();
-	idle_time =  ktime_to_us(ktime_sub(kt2, kt1));
+	idle_time_ns = ktime_to_ns(ktime_sub(kt2, kt1));
+	idle_time = idle_time_ns;
+	do_div(idle_time, NSEC_PER_USEC);
 
 	sleep_ticks = us_to_pm_timer_ticks(idle_time);
 
 	/* Tell the scheduler how much we idled: */
-	sched_clock_idle_wakeup_event(sleep_ticks*PM_TIMER_TICK_NS);
+	sched_clock_idle_wakeup_event(idle_time_ns);
 
 	local_irq_enable();
 	current_thread_info()->status |= TS_POLLING;
@@ -943,6 +946,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	struct acpi_processor *pr;
 	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
 	ktime_t  kt1, kt2;
+	s64 idle_time_ns;
 	s64 idle_time;
 	s64 sleep_ticks = 0;
 
@@ -1025,11 +1029,13 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 		spin_unlock(&c3_lock);
 	}
 	kt2 = ktime_get_real();
-	idle_time =  ktime_to_us(ktime_sub(kt2, kt1));
+	idle_time_ns = ktime_to_us(ktime_sub(kt2, kt1));
+	idle_time = idle_time_ns;
+	do_div(idle_time, NSEC_PER_USEC);
 
 	sleep_ticks = us_to_pm_timer_ticks(idle_time);
 	/* Tell the scheduler how much we idled: */
-	sched_clock_idle_wakeup_event(sleep_ticks*PM_TIMER_TICK_NS);
+	sched_clock_idle_wakeup_event(idle_time_ns);
 
 	local_irq_enable();
 	current_thread_info()->status |= TS_POLLING;
-- 
1.7.0.1

