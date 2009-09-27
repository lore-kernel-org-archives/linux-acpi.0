From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/5] ACPI: Kill overly verbose "power state" log messages
Date: Sun, 27 Sep 2009 04:32:44 -0400
Message-ID: <3d5b6fb47a8e68fa311ca2c3447e7f8a7c3a9cf3.1254040242.git.len.brown@intel.com>
References: <1254040365-18971-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:40892 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbZI0Ics (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Sep 2009 04:32:48 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KQM00HGWFQQ9U23@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 27 Sep 2009 03:32:51 -0500 (CDT)
In-reply-to: <1254040365-18971-1-git-send-email-lenb@kernel.org>
In-reply-to: <b684a3637e0887683a0a3d6fd471fc41d7c1606a.1254040242.git.len.brown@intel.com>
References: <b684a3637e0887683a0a3d6fd471fc41d7c1606a.1254040242.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Roland Dreier <rdreier@cisco.com>, Roland Dreier <rolandd@cisco.com>, Len Brown <len.brown@intel.com>

From: Roland Dreier <rdreier@cisco.com>

I was recently lucky enough to get a 64-CPU system, so my kernel log
ends up with 64 lines like:

    ACPI: CPU0 (power states: C1[C1] C2[C3])

This is pretty useless clutter because this info is already available
after boot from both /sys/devices/system/cpu/cpu*/cpuidle/state?/ as
well as /proc/acpi/processor/CPU*/power.

So just delete the code that prints the C-states in processor_idle.c.

Signed-off-by: Roland Dreier <rolandd@cisco.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index cc61a62..706eacf 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1214,13 +1214,6 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 		acpi_processor_setup_cpuidle(pr);
 		if (cpuidle_register_device(&pr->power.dev))
 			return -EIO;
-
-		printk(KERN_INFO PREFIX "CPU%d (power states:", pr->id);
-		for (i = 1; i <= pr->power.count; i++)
-			if (pr->power.states[i].valid)
-				printk(" C%d[C%d]", i,
-				       pr->power.states[i].type);
-		printk(")\n");
 	}
 #ifdef CONFIG_ACPI_PROCFS
 	/* 'power' [R] */
-- 
1.6.0.6

