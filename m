From: Len Brown <len.brown@intel.com>
Subject: [PATCH 19/77] ACPI: Discard invalid elements in _PSS package
Date: Sun, 22 Jul 2007 05:14:04 -0400
Message-ID: <1185095721760-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6612 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762138AbXGVJPX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:23 -0400
In-Reply-To: <1185095721166-git-send-email-len.brown@intel.com>
Message-Id: <3cdf552be228e1ca55f9c53a78f39e8b77d6159c.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Make sure that the _PSS list is sorted in
descending order by typical power dissipation.

http://bugzilla.kernel.org/show_bug.cgi?id=7880

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
index 10baa35..9ba2b69 100644
--- a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -668,8 +668,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	data->max_freq = perf->states[0].core_frequency * 1000;
 	/* table init */
 	for (i=0; i<perf->state_count; i++) {
-		if (i>0 && perf->states[i].core_frequency ==
-		    perf->states[i-1].core_frequency)
+		if (i>0 && perf->states[i].core_frequency >=
+		    data->freq_table[valid_states-1].frequency / 1000)
 			continue;
 
 		data->freq_table[valid_states].index = i;
-- 
1.5.3.rc2.22.g69a9b
