From: Venkatesh Pallipadi <venki@google.com>
Subject: Re: [PATCH] acpi: Minor cleanup eliminating redundant PMTIMER_TICKS
	to NS conversion
Date: Mon, 17 May 2010 18:47:00 -0700
Message-ID: <AANLkTikdLzwZmbJ4kubmdmArqgo7ya1ooN7XQzqN-39z@mail.gmail.com>
References: <1271980113-5624-1-git-send-email-venki@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:15755 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab0ERBrE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2010 21:47:04 -0400
Received: from kpbe15.cbf.corp.google.com (kpbe15.cbf.corp.google.com [172.25.105.79])
	by smtp-out.google.com with ESMTP id o4I1l1gZ025315
	for <linux-acpi@vger.kernel.org>; Mon, 17 May 2010 18:47:02 -0700
Received: from gxk21 (gxk21.prod.google.com [10.202.11.21])
	by kpbe15.cbf.corp.google.com with ESMTP id o4I1l0l9022902
	for <linux-acpi@vger.kernel.org>; Mon, 17 May 2010 18:47:01 -0700
Received: by gxk21 with SMTP id 21so957722gxk.14
        for <linux-acpi@vger.kernel.org>; Mon, 17 May 2010 18:47:00 -0700 (PDT)
In-Reply-To: <1271980113-5624-1-git-send-email-venki@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI list <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venki@google.com>

An incremental patch that removes some more redundancy in idle entry/exit.

Subject: [PATCH] acpi: Eliminate us to pm ticks conversion in common path

acpi_enter_[simple|bm] routines does us to pm tick conversion on every
idle wakeup and the value is only used in /proc/acpi display. We can
store the time in us and convert it into pm ticks before printing instead and
avoid the conversion in the common path. That also means no
unnecessary conversion overhead when ACPI_PROCFS is disabled.

Signed-off-by: Venkatesh Pallipadi <venki@google.com>
---
 drivers/acpi/processor_idle.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9e734ce..336da8d 100644
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
@@ -741,10 +741,10 @@ static int acpi_processor_power_seq_show(struct
seq_file *seq, void *offset)
 		else
 			seq_puts(seq, "demotion[--] ");

-		seq_printf(seq, "latency[%03d] usage[%08d] duration[%020llu]\n",
+		seq_printf(seq, "latency[%03d] usage[%08d] duration[%020Lu]\n",
 			   pr->power.states[i].latency,
 			   pr->power.states[i].usage,
-			   (unsigned long long)pr->power.states[i].time);
+			   us_to_pm_timer_ticks(pr->power.states[i].time));
 	}

       end:
@@ -871,7 +871,6 @@ static int acpi_idle_enter_simple(struct
cpuidle_device *dev,
 	ktime_t  kt1, kt2;
 	s64 idle_time_ns;
 	s64 idle_time;
-	s64 sleep_ticks = 0;

 	pr = __get_cpu_var(processors);

@@ -915,8 +914,6 @@ static int acpi_idle_enter_simple(struct
cpuidle_device *dev,
 	idle_time = idle_time_ns;
 	do_div(idle_time, NSEC_PER_USEC);

-	sleep_ticks = us_to_pm_timer_ticks(idle_time);
-
 	/* Tell the scheduler how much we idled: */
 	sched_clock_idle_wakeup_event(idle_time_ns);

@@ -926,7 +923,7 @@ static int acpi_idle_enter_simple(struct
cpuidle_device *dev,
 	cx->usage++;

 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += sleep_ticks;
+	cx->time += idle_time;
 	return idle_time;
 }

@@ -948,7 +945,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	ktime_t  kt1, kt2;
 	s64 idle_time_ns;
 	s64 idle_time;
-	s64 sleep_ticks = 0;


 	pr = __get_cpu_var(processors);
@@ -1033,7 +1029,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	idle_time = idle_time_ns;
 	do_div(idle_time, NSEC_PER_USEC);

-	sleep_ticks = us_to_pm_timer_ticks(idle_time);
 	/* Tell the scheduler how much we idled: */
 	sched_clock_idle_wakeup_event(idle_time_ns);

@@ -1043,7 +1038,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	cx->usage++;

 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += sleep_ticks;
+	cx->time += idle_time;
 	return idle_time;
 }

-- 
1.7.0.1
