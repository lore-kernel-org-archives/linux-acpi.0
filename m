From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/6] cpuidle: fix 100% C0 statistics regression
Date: Wed, 26 Mar 2008 01:13:40 -0400
Message-ID: <8e92b6605da989c0aa8ff7e33306f36f0efd957c.1206508358.git.len.brown@intel.com>
References: <1206508420-2755-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:44118 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753330AbYCZFVj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 01:21:39 -0400
In-Reply-To: <1206508420-2755-1-git-send-email-lenb@kernel.org>
In-Reply-To: <7642d2113098f1270e9f9f0120f44d0035091636.1206508358.git.len.brown@intel.com>
References: <7642d2113098f1270e9f9f0120f44d0035091636.1206508358.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venki Pallipadi <venkatesh.pallipadi@intel.com>

commit 9b12e18cdc1553de62d931e73443c806347cd974
'ACPI: cpuidle: Support C1 idle time accounting'
was implicated in a 100% C0 idle regression.
http://bugzilla.kernel.org/show_bug.cgi?id=10076

It pointed out a potential problem where the menu governor
may get confused by the C-state residency time from poll
idle or C1 idle, where this timing info is not accurate.
This inaccuracy is due to interrupts being handled
before we account for C-state exit.

Do not mark TIME_VALID for CO poll state.
Mark C1 time as valid only with the MWAIT (CSTATE_FFH) entry method.

This makes governors use the timing information only when it is correct and
eliminates any wrong policy decisions that may result from invalid timing
information.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    4 +++-
 drivers/cpuidle/cpuidle.c     |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 1468f1e..788da97 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1693,7 +1693,9 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 		switch (cx->type) {
 			case ACPI_STATE_C1:
 			state->flags |= CPUIDLE_FLAG_SHALLOW;
-			state->flags |= CPUIDLE_FLAG_TIME_VALID;
+			if (cx->entry_method == ACPI_CSTATE_FFH)
+				state->flags |= CPUIDLE_FLAG_TIME_VALID;
+
 			state->enter = acpi_idle_enter_c1;
 			dev->safe_state = state;
 			break;
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d42deb3..fc555a9 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -224,7 +224,7 @@ static void poll_idle_init(struct cpuidle_device *dev)
 	state->exit_latency = 0;
 	state->target_residency = 0;
 	state->power_usage = -1;
-	state->flags = CPUIDLE_FLAG_POLL | CPUIDLE_FLAG_TIME_VALID;
+	state->flags = CPUIDLE_FLAG_POLL;
 	state->enter = poll_idle;
 }
 #else
-- 
1.5.5.rc1.6.g5cc8f

