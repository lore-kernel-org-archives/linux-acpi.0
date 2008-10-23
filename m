From: Len Brown <lenb@kernel.org>
Subject: [PATCH 050/122] cpuidle: use last_state which can reflect the actual
 state entered
Date: Thu, 23 Oct 2008 02:38:24 -0400
Message-ID: <887e301aa1105326f1412a98749024263b1031c7.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58094 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969AbYJWGkE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:04 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600K89IIOSA62@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:01 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

cpuidle accounts the idle time for the C-state it was trying to enter and
not to the actual state that the driver eventually entered. The driver may
select a different state than the one chosen by cpuidle due to
constraints like bus-mastering, etc.

Change the time acounting code to look at the dev->last_state after
returning from target_state->enter(). Driver can modify dev->last_state
internally, inside the enter routine to reflect the actual C-state
entered.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/cpuidle.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 5ce07b5..eb2cade 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -67,8 +67,11 @@ static void cpuidle_idle_call(void)
 	target_state = &dev->states[next_state];
 
 	/* enter the state and update stats */
-	dev->last_residency = target_state->enter(dev, target_state);
 	dev->last_state = target_state;
+	dev->last_residency = target_state->enter(dev, target_state);
+	if (dev->last_state)
+		target_state = dev->last_state;
+
 	target_state->time += (unsigned long long)dev->last_residency;
 	target_state->usage++;
 
-- 
1.5.5.1

