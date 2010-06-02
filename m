From: Venkatesh Pallipadi <venki@google.com>
Subject: [PATCH] acpi: Eliminate us to pm ticks conversion in common path
Date: Wed,  2 Jun 2010 10:01:09 -0700
Message-ID: <1275498069-30614-1-git-send-email-venki@google.com>
References: <alpine.LFD.2.00.1005281509430.4045@localhost.localdomain>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:7560 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758220Ab0FBRBt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 13:01:49 -0400
Received: from kpbe16.cbf.corp.google.com (kpbe16.cbf.corp.google.com [172.25.105.80])
	by smtp-out.google.com with ESMTP id o52H1mlK029963
	for <linux-acpi@vger.kernel.org>; Wed, 2 Jun 2010 10:01:48 -0700
Received: from pxi15 (pxi15.prod.google.com [10.243.27.15])
	by kpbe16.cbf.corp.google.com with ESMTP id o52H1b5E012761
	for <linux-acpi@vger.kernel.org>; Wed, 2 Jun 2010 10:01:46 -0700
Received: by pxi15 with SMTP id 15so1782132pxi.16
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jun 2010 10:01:46 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005281509430.4045@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI list <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venki@google.com>

Is this one better?

Thanks,
Venki


acpi_enter_[simple|bm] routines does us to pm tick conversion on every
idle wakeup and the value is only used in /proc/acpi display. We can
store the time in us and convert it into pm ticks before printing instead and
avoid the conversion in the common path.

Signed-off-by: Venkatesh Pallipadi <venki@google.com>
---
 drivers/acpi/processor_idle.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 2e8c27d..71c9608 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -80,7 +80,7 @@ module_param(nocst, uint, 0000);
 static unsigned int latency_factor __read_mostly = 2;
 module_param(latency_factor, uint, 0644);
 
-static s64 us_to_pm_timer_ticks(s64 t)
+static u64 us_to_pm_timer_ticks(s64 t)
 {
 	return div64_u64(t * PM_TIMER_FREQUENCY, 1000000);
 }
@@ -731,10 +731,10 @@ static int acpi_processor_power_seq_show(struct seq_file *seq, void *offset)
 
 		seq_puts(seq, "demotion[--] ");
 
-		seq_printf(seq, "latency[%03d] usage[%08d] duration[%020llu]\n",
+		seq_printf(seq, "latency[%03d] usage[%08d] duration[%020Lu]\n",
 			   pr->power.states[i].latency,
 			   pr->power.states[i].usage,
-			   (unsigned long long)pr->power.states[i].time);
+			   us_to_pm_timer_ticks(pr->power.states[i].time));
 	}
 
       end:
@@ -861,7 +861,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	ktime_t  kt1, kt2;
 	s64 idle_time_ns;
 	s64 idle_time;
-	s64 sleep_ticks = 0;
 
 	pr = __get_cpu_var(processors);
 
@@ -906,8 +905,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	idle_time = idle_time_ns;
 	do_div(idle_time, NSEC_PER_USEC);
 
-	sleep_ticks = us_to_pm_timer_ticks(idle_time);
-
 	/* Tell the scheduler how much we idled: */
 	sched_clock_idle_wakeup_event(idle_time_ns);
 
@@ -918,7 +915,7 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	cx->usage++;
 
 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += sleep_ticks;
+	cx->time += idle_time;
 	return idle_time;
 }
 
@@ -940,7 +937,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	ktime_t  kt1, kt2;
 	s64 idle_time_ns;
 	s64 idle_time;
-	s64 sleep_ticks = 0;
 
 
 	pr = __get_cpu_var(processors);
@@ -1026,7 +1022,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	idle_time = idle_time_ns;
 	do_div(idle_time, NSEC_PER_USEC);
 
-	sleep_ticks = us_to_pm_timer_ticks(idle_time);
 	/* Tell the scheduler how much we idled: */
 	sched_clock_idle_wakeup_event(idle_time_ns);
 
@@ -1037,7 +1032,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	cx->usage++;
 
 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += sleep_ticks;
+	cx->time += idle_time;
 	return idle_time;
 }
 
-- 
1.7.0.1

