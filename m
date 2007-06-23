From: Len Brown <len.brown@intel.com>
Subject: [PATCH 3/3] ACPI: fix 2.6.20 SMP boot regression
Date: Sat, 23 Jun 2007 11:04:48 -0400
Message-ID: <11826110912721-git-send-email-len.brown@intel.com>
References: <1182611088203-git-send-email-len.brown@intel.com>
 <11826110891391-git-send-email-len.brown@intel.com>
 <11826110902815-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19465 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758108AbXFWPE5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Jun 2007 11:04:57 -0400
In-Reply-To: <11826110902815-git-send-email-len.brown@intel.com>
Message-Id: <d5a3d32a042126f65a008e0e5204ef92ad2ee55d.1182611002.git.len.brown@intel.com>
In-Reply-To: <e7c746ef098770f863ba294adac5b30d124ba469.1182611002.git.len.brown@intel.com>
References: <e7c746ef098770f863ba294adac5b30d124ba469.1182611002.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Always disable/enable interrupts in the acpi idle routine,
even in the error path.

This is required as the 2.6.20 change in git commit d331e739f5ad2aaa9...
"Fix interrupt race in idle callback" expects the idle handler
to enable interrupt before returning.

There was a case in acpi idle routine, in which interrupt was not being
enabled before return, which caused the system to hang at bootup, while
enabling C-states on an SMP system.

The signature of the hang was that "processor.nocst"
was required to enable boot.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ee5759b..80ffc78 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -332,16 +332,18 @@ static void acpi_processor_idle(void)
 	int sleep_ticks = 0;
 	u32 t1, t2 = 0;
 
-	pr = processors[smp_processor_id()];
-	if (!pr)
-		return;
-
 	/*
 	 * Interrupts must be disabled during bus mastering calculations and
 	 * for C2/C3 transitions.
 	 */
 	local_irq_disable();
 
+	pr = processors[smp_processor_id()];
+	if (!pr) {
+		local_irq_enable();
+		return;
+	}
+
 	/*
 	 * Check whether we truly need to go idle, or should
 	 * reschedule:
-- 
1.5.2.1.255.gca6c0
