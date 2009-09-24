From: Roland Dreier <rdreier@cisco.com>
Subject: [PATCH] ACPI: Kill overly verbose "power state" log messages
Date: Thu, 24 Sep 2009 14:52:36 -0700
Message-ID: <adapr9gypqz.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:13148 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbZIXVwg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2009 17:52:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

I was recently lucky enough to get a 64-CPU system.  The processors
actually have T-states, so my kernel log ends up with 64 lines like:

    ACPI: CPU0 (power states: C1[C1] C2[C3])

This is pretty useless clutter because this info is already available
after boot from both /sys/devices/system/cpu/cpu*/cpuidle/state?/ as
well as /proc/acpi/processor/CPU*/power.

So just delete the code that prints the throttling states in
processor_idle.c.

Signed-off-by: Roland Dreier <rolandd@cisco.com>
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
