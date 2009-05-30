From: Len Brown <lenb@kernel.org>
Subject: [PATCH 64/65] acpi-cpufreq: fix printk typo and indentation
Date: Fri, 29 May 2009 21:42:42 -0400
Message-ID: <61c8c67e3ad67ea1d1360f2e88688bd942834756.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51488 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077AbZE3BnD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:03 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00A1HORTUKB5@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:05 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Joe Perches <joe@perches.com>

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index 208ecf6..54b6de2 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -693,8 +693,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (perf->control_register.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE &&
 	    policy->cpuinfo.transition_latency > 20 * 1000) {
 		policy->cpuinfo.transition_latency = 20 * 1000;
-			printk_once(KERN_INFO "Capping off P-state tranision"
-				    " latency at 20 uS\n");
+		printk_once(KERN_INFO
+			    "P-state transition latency capped at 20 uS\n");
 	}
 
 	/* table init */
-- 
1.6.0.6

