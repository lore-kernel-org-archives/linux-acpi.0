From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] cpufreq: Fix ondemand to not request targets outside policy limits
Date: Mon, 21 Dec 2009 23:40:52 +0100
Message-ID: <200912212340.54067.trenn@suse.de>
References: <20091217201800.9473.12769.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38202 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbZLUWkr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Dec 2009 17:40:47 -0500
In-Reply-To: <20091217201800.9473.12769.sendpatchset@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
Cc: davej@redhat.com, mjg@redhat.com, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org, linux@brodo.de

From: Nagananda.Chumbalkar@hp.com

Dominik said:
target_freq cannot be below policy->min or above policy->max. 
If it were, the whole cpufreq subsystem is broken.

But (answer):
I think the "ondemand" governor can ask for a target frequency that is
below policy->min.
...
A patch such as below may be needed to sanitize the target frequency 
requested by "ondemand". The "conservative" governor already has this check: 

Signed-off-by: Thomas Renninger <trenn@suse.de>

# diff -bur x/drivers/cpufreq/cpufreq_ondemand.c.orig y/drivers/cpufreq/cpufreq_ondemand.c
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 4b34ade..bd444dc 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -554,6 +554,9 @@ static void dbs_check_cpu(struct cpu_dbs_info_s *this_dbs_info)
 				(dbs_tuners_ins.up_threshold -
 				 dbs_tuners_ins.down_differential);
 
+		if (freq_next < policy->min)
+			freq_next = policy->min;
+
 		if (!dbs_tuners_ins.powersave_bias) {
 			__cpufreq_driver_target(policy, freq_next,
 					CPUFREQ_RELATION_L);
