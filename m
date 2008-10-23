From: Len Brown <lenb@kernel.org>
Subject: [PATCH 040/122] ACPI: don't load acpi_cpufreq if acpi=off
Date: Thu, 23 Oct 2008 02:38:14 -0400
Message-ID: <ee297533279a802eac8b1cbea8e65b24b36a1aac.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55856 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbYJWGj6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:58 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600FUPIIK9SV3@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:57 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, Len Brown <len.brown@intel.com>

From: Yinghai Lu <yhlu.kernel@gmail.com>

Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
index dd097b8..9943b4c 100644
--- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -779,6 +779,9 @@ static int __init acpi_cpufreq_init(void)
 {
 	int ret;
 
+	if (acpi_disabled)
+		return 0;
+
 	dprintk("acpi_cpufreq_init\n");
 
 	ret = acpi_cpufreq_early_init();
-- 
1.5.5.1

