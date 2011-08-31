From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC]cpuidle: disable menu governor if nohz is disabled
Date: Wed, 31 Aug 2011 09:56:07 +0800
Message-ID: <1314755767.29510.57.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7878 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551Ab1HaBxz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Aug 2011 21:53:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>, "Li, Aubrey" <aubrey.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

Lenb,
Aubrey is asking me to fix the issue. So either we delete disable nohz
code or fix cpuidle. if you want to fix cpuidle, here it is.

Thanks,
SHaohua

Subject: cpuidle: disable menu governor if nohz is disabled

Aubrey is asking why nohz disables C-state. nohz has no dependency with idle,
but menu governor does. If nohz is disabled, using menu governor is pointless,
because we never get correct sleep length, so let's use ladder governor just
like nohz isn't compiled in.

Frankly, disabling nohz is strange, but in case somebody cares, here is the
fix.

Reported-by: Aubrey Li <aubrey.li@intel.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index c47f3d0..cbf9afa 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -408,6 +408,8 @@ static struct cpuidle_governor menu_governor = {
  */
 static int __init init_menu(void)
 {
+	if (!tick_nohz_enabled)
+		return 0;
 	return cpuidle_register_governor(&menu_governor);
 }
 
diff --git a/include/linux/tick.h b/include/linux/tick.h
index b232ccc..88895c7 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -126,6 +126,7 @@ extern void tick_nohz_restart_sched_tick(void);
 extern ktime_t tick_nohz_get_sleep_length(void);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
+extern int tick_nohz_enabled;
 # else
 static inline void tick_nohz_stop_sched_tick(int inidle) { }
 static inline void tick_nohz_restart_sched_tick(void) { }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d5097c4..6a270fe 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -105,7 +105,7 @@ static ktime_t tick_init_jiffy_update(void)
 /*
  * NO HZ enabled ?
  */
-static int tick_nohz_enabled __read_mostly  = 1;
+int tick_nohz_enabled __read_mostly  = 1;
 
 /*
  * Enable / Disable tickless mode


