From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH] GHES: Limit # of cpus in ghes_notify_nmi()
Date: Tue, 16 Jun 2015 13:32:07 -0400
Message-ID: <1434475927-26618-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:34219 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbbFPRc2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jun 2015 13:32:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

It was found that when the perf-record command was running on large
system with many cores and GHES enabled, the performance of the
workload being monitored will slow down significantly. For example,

  # ./hackbench
  Time: 0.047
  # perf record ./hackbench
  Time: 21.392

The big slowdown was traced to the fact that too much time (more
than 1ms) was spent in each invocation of ghes_notify_nmi(). The
perf-record command will cause NMI to be generated periodically at
high frequency. If many cores are doing that, it will cause a long
queue to form in the global ghes_nmi_lock lock.

This patch limits only up to 2 cpus to be working on ghes_notify_nmi()
at any given instance. This will significantly reduce the time spent
by each CPU in ghes_notify_nmi(). With that patch, the perf slowdown
was significantly reduced.

  # perf record ./hackbench
  Time: 0.133

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 drivers/acpi/apei/ghes.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e82d097..132a014 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -803,6 +803,20 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 	int sev, sev_global = -1;
 	int ret = NMI_DONE;
 
+	/* # of CPUs processing NMI */
+	static atomic_t ghes_nmi_cnt = ATOMIC_INIT(0);
+
+	/*
+	 * Multiple CPUs may get NMI and come here to check GHES. If one has
+	 * gotten the lock and is doing the check, there is no point in having
+	 * more than one other CPU waiting just in case the active CPU has
+	 * past the point where the NMI was generated. So we set a limit of
+	 * only allowing 2 CPUs working here. The rests can just return.
+	 */
+	if (atomic_add_return(1, &ghes_nmi_cnt) > 2) {
+		atomic_dec(&ghes_nmi_cnt);
+		return ret;
+	}
 	raw_spin_lock(&ghes_nmi_lock);
 	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
 		if (ghes_read_estatus(ghes, 1)) {
@@ -863,6 +877,7 @@ next:
 #endif
 
 out:
+	atomic_dec(&ghes_nmi_cnt);
 	raw_spin_unlock(&ghes_nmi_lock);
 	return ret;
 }
-- 
1.7.1

