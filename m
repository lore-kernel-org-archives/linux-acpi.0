From: Len Brown <lenb@kernel.org>
Subject: [PATCH 013/112] cpuidle: default processor.latency_factor=2
Date: Thu,  7 Feb 2008 04:33:35 -0500
Message-ID: <25de5718356e264820625600a9edca1df5ff26f8.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756278AbYBGJfg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:36 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

More aggressively request deep C-states.

Note that the job of the OS is to minimize latency
impact to expected break events such as interrupts.

It is not the job of the OS to try to calculate if
the C-state will reach energy break-even.
The platform doesn't give the OS enough information
for it to make that calculation.  Thus, it is up
to the platform to decide if it is worth it to
go as deep as the OS requested it to, or if it
should internally demote to a more shallow C-state.

But the converse is not true.  The platform can not
promote into a deeper C-state than the OS requested
else it may violate latency constraints.  So it is
important that the OS be aggressive in giving the
platform permission to enter deep C-states.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 26ade1f..bc99b7b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -95,7 +95,7 @@ module_param(bm_history, uint, 0644);
 static int acpi_processor_set_power_policy(struct acpi_processor *pr);
 
 #else	/* CONFIG_CPU_IDLE */
-static unsigned int latency_factor __read_mostly = 6;
+static unsigned int latency_factor __read_mostly = 2;
 module_param(latency_factor, uint, 0644);
 #endif
 
-- 
1.5.4.23.gef5b9

