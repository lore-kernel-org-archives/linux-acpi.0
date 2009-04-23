From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/29] ACPI: delete obsolete "bus master activity" proc field
Date: Thu, 23 Apr 2009 02:23:51 -0400
Message-ID: <92614610774072ea68131f16e024ee8fc15be9be.1240467665.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:58836 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498AbZDWGYL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:11 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ006A6J49NVMR@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:10 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Linux-2.6.29 deleted the legacy ACPI idle handler, leaving
the CPU_IDLE handler, which does not track bus master activity.

So delete the unused bm_activity field -- it is confusing to
print an always zero value.

This patch could break programs that parse
/proc/acpi/processor/*/power, since it deletes this
line from that file:

bus master activity:     00000000

http://bugzilla.kernel.org/show_bug.cgi?id=13145
is not fixed by this patch, but provoked this patch.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    4 +---
 include/acpi/processor.h      |    1 -
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9d1f01e..eed3b45 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -662,11 +662,9 @@ static int acpi_processor_power_seq_show(struct seq_file *seq, void *offset)
 
 	seq_printf(seq, "active state:            C%zd\n"
 		   "max_cstate:              C%d\n"
-		   "bus master activity:     %08x\n"
 		   "maximum allowed latency: %d usec\n",
 		   pr->power.state ? pr->power.state - pr->power.states : 0,
-		   max_cstate, (unsigned)pr->power.bm_activity,
-		   pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY));
+		   max_cstate, pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY));
 
 	seq_puts(seq, "states:\n");
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index b09c4fd..4927c06 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -84,7 +84,6 @@ struct acpi_processor_power {
 	struct acpi_processor_cx *state;
 	unsigned long bm_check_timestamp;
 	u32 default_state;
-	u32 bm_activity;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 	int timer_broadcast_on_state;
-- 
1.6.0.6

