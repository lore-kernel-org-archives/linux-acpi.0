From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/3] cpuidle: Rename X86 specific idle poll state[0] from C0 to CPUIDLE
Date: Fri, 12 Nov 2010 18:02:13 +0100
Message-ID: <1289581334-26836-3-git-send-email-trenn@suse.de>
References: <1289581334-26836-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:34171 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396Ab0KLRCR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Nov 2010 12:02:17 -0500
In-Reply-To: <1289581334-26836-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, arjan@linux.intel.com, trenn@suse.de

C0 means and is well know as "not idle".
All documentation out there uses this term as "running"/"not idle"
state. Also Linux userspace tools (e.g. cpufreq-aperf and turbostat)
show C0 residency which there is correct, but means something totally
else than cpuidle "CPUIDLE" state.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: arjan@linux.intel.com
CC: lenb@kernel.org
CC: linux-acpi@vger.kernel.org
---
 drivers/cpuidle/cpuidle.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 08d5f05..535df42 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -260,8 +260,8 @@ static void poll_idle_init(struct cpuidle_device *dev)
 
 	cpuidle_set_statedata(state, NULL);
 
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C0");
-	snprintf(state->desc, CPUIDLE_DESC_LEN, "CPUIDLE CORE POLL IDLE");
+	snprintf(state->name, CPUIDLE_NAME_LEN, "CPUIDLE");
+	snprintf(state->desc, CPUIDLE_DESC_LEN, "CORE POLL IDLE");
 	state->exit_latency = 0;
 	state->target_residency = 0;
 	state->power_usage = -1;
-- 
1.6.3

