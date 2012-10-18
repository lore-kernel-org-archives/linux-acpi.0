From: Youquan Song <youquan.song@intel.com>
Subject: [PATCH V2 3/4] x86,idle: Set residency to 0 if target Cstate not enter
Date: Thu, 18 Oct 2012 17:12:23 -0400
Message-ID: <1350594744-22353-4-git-send-email-youquan.song@intel.com>
References: <1350594744-22353-1-git-send-email-youquan.song@intel.com>
 <1350594744-22353-2-git-send-email-youquan.song@intel.com>
 <1350594744-22353-3-git-send-email-youquan.song@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350594744-22353-3-git-send-email-youquan.song@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, arjan@linux.intel.com, lenb@kernel.org, rjw@sisk.pl
Cc: Rik van Riel <riel@redhat.com>, Youquan Song <youquan.song@linux.intel.com>, Youquan Song <youquan.song@intel.com>
List-Id: linux-acpi@vger.kernel.org

When cpuidle governor choose a C-state to enter for idle CPU, but it notice that
there is tasks request to be executed. So the idle CPU will not really enter
the target C-state and go to run task.

In this situation, it will use the residency of previous really entered target 
C-states. Obviously, it is not reasonable. 

So, this patch fix it by set the target C-state residency to 0. 

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Rik van Riel <riel@redhat.com>
---
 drivers/cpuidle/cpuidle.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index e28f6ea..01dca54 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -144,6 +144,10 @@ int cpuidle_idle_call(void)
 	/* ask the governor for the next state */
 	next_state = cpuidle_curr_governor->select(drv, dev);
 	if (need_resched()) {
+		dev->last_residency = 0;
+		/* give the governor an opportunity to reflect on the outcome */
+		if (cpuidle_curr_governor->reflect)
+			cpuidle_curr_governor->reflect(dev, next_state);
 		local_irq_enable();
 		return 0;
 	}
-- 
1.7.7.4
