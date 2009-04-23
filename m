From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/29] x86, acpi_cpufreq: Fix the NULL pointer dereference in
 get_measured_perf
Date: Thu, 23 Apr 2009 02:23:44 -0400
Message-ID: <093f13e23137b9e5f7629dd5932ceea1419e2b61.1240467665.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:58416 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381AbZDWGYI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:08 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00BLQJ47E8YW@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:08 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>

Fix for a regression that was introduced by earlier commit
18b2646fe3babeb40b34a0c1751e0bf5adfdc64c on Mon Apr 6 11:26:08 2009

Regression resulted in the below error happened on systems with
software coordination where per_cpu acpi data will not be initiated for
secondary CPUs in a P-state domain.

On Tue, 2009-04-14 at 23:01 -0700, Zhang, Yanmin wrote:
 My machine hanged with kernel 2.6.30-rc2 when script read
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor.
>
> opps happens in get_measured_perf:
>
>         cur.aperf.whole = readin.aperf.whole -
>                                 per_cpu(drv_data, cpu)->saved_aperf;
>
> Because per_cpu(drv_data, cpu)=NULL.
>
> So function get_measured_perf should check if (per_cpu(drv_data,
> cpu)==NULL)
> and return 0 if it's NULL.

--------------sys log------------------

BUG: unable to handle kernel NULL pointer dereference at
0000000000000020
IP: [<ffffffff8021af75>] get_measured_perf+0x4a/0xf9
PGD a7dd88067 PUD a7ccf5067 PMD 0
Oops: 0000 [#1] SMP
last sysfs file: /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
CPU 0
Modules linked in: video output
Pid: 2091, comm: kondemand/0 Not tainted 2.6.30-rc2 #1 MP Server
RIP: 0010:[<ffffffff8021af75>]  [<ffffffff8021af75>]
get_measured_perf+0x4a/0xf9
RSP: 0018:ffff880a7d56de20  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000046241a42b6 RCX: ffff88004d219000
RDX: 000000000000b660 RSI: 0000000000000020 RDI: 0000000000000001
RBP: ffff880a7f052000 R08: 00000046241a42b6 R09: ffffffff807639f0
R10: 00000000ffffffea R11: ffffffff802207f4 R12: ffff880a7f052000
R13: ffff88004d20e460 R14: 0000000000ddd5a6 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88004d200000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000020 CR3: 0000000a7f1bf000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process kondemand/0 (pid: 2091, threadinfo ffff880a7d56c000, task
ffff880a7d4d18c0)
Stack:
 ffff880a7f052078 ffffffff803efd54 00000046241a42b6 000000462ffa9e95
 0000000000000001 0000000000000001 00000000ffffffea ffffffff8064f41a
 0000000000000012 0000000000000012 ffff880a7f052000 ffffffff80650547
Call Trace:
 [<ffffffff803efd54>] ? kobject_get+0x12/0x17
 [<ffffffff8064f41a>] ? __cpufreq_driver_getavg+0x42/0x57
 [<ffffffff80650547>] ? do_dbs_timer+0x147/0x272
 [<ffffffff80650400>] ? do_dbs_timer+0x0/0x272
 [<ffffffff802474ca>] ? worker_thread+0x15b/0x1f5
 [<ffffffff8024a02c>] ? autoremove_wake_function+0x0/0x2e
 [<ffffffff8024736f>] ? worker_thread+0x0/0x1f5
 [<ffffffff80249f0d>] ? kthread+0x54/0x83
 [<ffffffff8020c87a>] ? child_rip+0xa/0x20
 [<ffffffff80249eb9>] ? kthread+0x0/0x83
 [<ffffffff8020c870>] ? child_rip+0x0/0x20
Code: 99 a6 03 00 31 c9 85 c0 0f 85 c3 00 00 00 89 df 4c 8b 44 24 10 48
c7 c2 60 b6 00 00 48 8b 0c fd e0 30 a5 80 4c 89 c3 48 8b 04 0a <48> 2b
58 20 48 8b 44 24 18 48 89 1c 24 48 8b 34 0a 48 2b 46 28
RIP  [<ffffffff8021af75>] get_measured_perf+0x4a/0xf9
 RSP <ffff880a7d56de20>
CR2: 0000000000000020
---[ end trace 2b8fac9a49e19ad4 ]---

Tested-by: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index ecdb682..dd0bd76 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -68,11 +68,16 @@ struct acpi_cpufreq_data {
 	unsigned int max_freq;
 	unsigned int resume;
 	unsigned int cpu_feature;
-	u64 saved_aperf, saved_mperf;
 };
 
 static DEFINE_PER_CPU(struct acpi_cpufreq_data *, drv_data);
 
+struct acpi_msr_data {
+	u64 saved_aperf, saved_mperf;
+};
+
+static DEFINE_PER_CPU(struct acpi_msr_data, msr_data);
+
 DEFINE_TRACE(power_mark);
 
 /* acpi_perf_data is a pointer to percpu data. */
@@ -287,11 +292,11 @@ static unsigned int get_measured_perf(struct cpufreq_policy *policy,
 		return 0;
 
 	cur.aperf.whole = readin.aperf.whole -
-				per_cpu(drv_data, cpu)->saved_aperf;
+				per_cpu(msr_data, cpu).saved_aperf;
 	cur.mperf.whole = readin.mperf.whole -
-				per_cpu(drv_data, cpu)->saved_mperf;
-	per_cpu(drv_data, cpu)->saved_aperf = readin.aperf.whole;
-	per_cpu(drv_data, cpu)->saved_mperf = readin.mperf.whole;
+				per_cpu(msr_data, cpu).saved_mperf;
+	per_cpu(msr_data, cpu).saved_aperf = readin.aperf.whole;
+	per_cpu(msr_data, cpu).saved_mperf = readin.mperf.whole;
 
 #ifdef __i386__
 	/*
-- 
1.6.0.6

