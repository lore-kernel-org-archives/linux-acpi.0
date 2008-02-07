From: Len Brown <lenb@kernel.org>
Subject: [PATCH 012/112] cpuidle: create processor.latency_factor tunable
Date: Thu,  7 Feb 2008 04:33:34 -0500
Message-ID: <4963f62045b64f93c45fbcb6f8f0baf1e3e7a127.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756169AbYBGJff (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:35 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Start with default value of 6, so by default,
there is no functional change in this patch.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f996d0e..26ade1f 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -94,6 +94,9 @@ module_param(bm_history, uint, 0644);
 
 static int acpi_processor_set_power_policy(struct acpi_processor *pr);
 
+#else	/* CONFIG_CPU_IDLE */
+static unsigned int latency_factor __read_mostly = 6;
+module_param(latency_factor, uint, 0644);
 #endif
 
 /*
@@ -1576,7 +1579,7 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 
 		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d", i);
 		state->exit_latency = cx->latency;
-		state->target_residency = cx->latency * 6;
+		state->target_residency = cx->latency * latency_factor;
 		state->power_usage = cx->power;
 
 		state->flags = 0;
-- 
1.5.4.23.gef5b9

