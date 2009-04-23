From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/29] acpi-cpufreq: style-only: add parens to math expression
Date: Thu, 23 Apr 2009 02:23:46 -0400
Message-ID: <d91758f5ddb80e91176fa2cf80c88c1633950b3d.1240467665.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:45086 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbZDWGYJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:09 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ006PQJ48QHO4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:09 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index 4eab747..aec3161 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -340,7 +340,7 @@ static unsigned int get_measured_perf(struct cpufreq_policy *policy,
 
 #endif
 
-	retval = per_cpu(drv_data, policy->cpu)->max_freq * perf_percent / 100;
+	retval = (per_cpu(drv_data, policy->cpu)->max_freq * perf_percent) / 100;
 
 	return retval;
 }
-- 
1.6.0.6

