From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/5] ACPI: Eliminate us to pm ticks conversion in common path
Date: Fri, 04 Jun 2010 15:47:25 -0400
Message-ID: <bceefad59ab66d1b1a815a1738744ea013da966e.1275680785.git.len.brown@intel.com>
References: <1275680845-8352-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:41440 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab0FDTrv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:47:51 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I00CYM9N6BJB6@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 14:47:36 -0500 (CDT)
In-reply-to: <1275680845-8352-1-git-send-email-lenb@kernel.org>
In-reply-to: <d5a64513c6a171262082c250592c062e97a2c693.1275680785.git.len.brown@intel.com>
References: <d5a64513c6a171262082c250592c062e97a2c693.1275680785.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venki@google.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venki@google.com>

acpi_enter_[simple|bm] routines does us to pm tick conversion on every
idle wakeup and the value is only used in /proc/acpi display. We can
store the time in us and convert it into pm ticks before printing instead and
avoid the conversion in the common path.

Signed-off-by: Venkatesh Pallipadi <venki@google.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6b38a6b..b1b3856 100644
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
1.6.0.6

