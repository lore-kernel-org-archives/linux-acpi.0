From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/19] ACPI: Idle C-states disabled by max_cstate should not
 disable the TSC
Date: Sat, 16 May 2009 02:02:16 -0400
Message-ID: <a0bf284bfedd6dc95bbee7ebf5ccf3b5f753a008.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:16618 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbZEPGCf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:35 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ00MR33G7NNEL@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:32 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Processor idle power states C2 and C3 stop the TSC on many machines.
Linux recognizes this situation and marks the TSC as unstable:

Marking TSC unstable due to TSC halts in idle

But if those same machines are booted with "processor.max_cstate=1",
then there is no need to validate C2 and C3, and no need to
disable the TSC, which can be reliably used as a clocksource.

Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/acpi/processor_idle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e39a40a..e65476f 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -582,7 +582,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 
 	pr->power.timer_broadcast_on_state = INT_MAX;
 
-	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
+	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
 		struct acpi_processor_cx *cx = &pr->power.states[i];
 
 		switch (cx->type) {
-- 
1.6.0.6

