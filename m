From: "Chumbalkar, Nagananda" <Nagananda.Chumbalkar@hp.com>
Subject: RE: [PATCH 2/2] cpufreq: Fix ondemand to not request targets
 outside policy limits
Date: Wed, 23 Dec 2009 18:24:40 +0000
Message-ID: <66D9D2F0CDB5C9428E6166B01EC85EE161DF1FE209@GVW0676EXC.americas.hpqcorp.net>
References: <20091217201800.9473.12769.sendpatchset@localhost.localdomain>
 <200912212340.54067.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:25554 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655AbZLWSZ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2009 13:25:26 -0500
In-Reply-To: <200912212340.54067.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "davej@redhat.com" <davej@redhat.com>, "mjg@redhat.com" <mjg@redhat.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux@brodo.de" <linux@brodo.de>

Booting with debug turned on on an Intel Nehalem server, notice the
following output in "dmesg":

...
cpufreq-core: target for CPU 0: 0 kHz, relation 0
acpi-cpufreq: acpi_cpufreq_target 0 (0)
freq-table: request for target 0 kHz (relation: 0) for cpu 0
freq-table: target is 9 (1596000 kHz, 9)
cpufreq-core: notification 0 of frequency transition to 1596000 kHz
cpufreq-core: notification 1 of frequency transition to 1596000 kHz
...

There are instances where "ondemand" asks for a target frequency of even 0.
More generally, "ondemand" can ask for freq_next < policy->min, whenever
"load" on the CPU drops to a level that satisfies the equation below:

	load < ((threshold - differential) * policy->min / policy->cur)

Hence, the patch below.

NOTE:
Drivers such as "acpi-cpufreq" can make use of the freq-table helper
function, cpufreq_frequency_table_target(), which presumably can take
a target frequency < policy->min, and still provide an "index" that
corresponds to Pn (lowest supported frequency). This can be seen in the
"dmesg" output above.

- naga -
 

>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de] 
>Sent: Monday, December 21, 2009 4:41 PM
>To: Chumbalkar, Nagananda
>Cc: davej@redhat.com; mjg@redhat.com; cpufreq@vger.kernel.org; 
>linux-acpi@vger.kernel.org; linux@brodo.de
>Subject: [PATCH 2/2] cpufreq: Fix ondemand to not request 
>targets outside policy limits
>
>From: Nagananda.Chumbalkar@hp.com
>
>Dominik said:
>target_freq cannot be below policy->min or above policy->max. 
>If it were, the whole cpufreq subsystem is broken.
>
>But (answer):
>I think the "ondemand" governor can ask for a target frequency that is
>below policy->min.
>...
>A patch such as below may be needed to sanitize the target frequency 
>requested by "ondemand". The "conservative" governor already 
>has this check: 
>
>Signed-off-by: Thomas Renninger <trenn@suse.de>
>
># diff -bur x/drivers/cpufreq/cpufreq_ondemand.c.orig 
>y/drivers/cpufreq/cpufreq_ondemand.c
>diff --git a/drivers/cpufreq/cpufreq_ondemand.c 
>b/drivers/cpufreq/cpufreq_ondemand.c
>index 4b34ade..bd444dc 100644
>--- a/drivers/cpufreq/cpufreq_ondemand.c
>+++ b/drivers/cpufreq/cpufreq_ondemand.c
>@@ -554,6 +554,9 @@ static void dbs_check_cpu(struct 
>cpu_dbs_info_s *this_dbs_info)
> 				(dbs_tuners_ins.up_threshold -
> 				 dbs_tuners_ins.down_differential);
> 
>+		if (freq_next < policy->min)
>+			freq_next = policy->min;
>+
> 		if (!dbs_tuners_ins.powersave_bias) {
> 			__cpufreq_driver_target(policy, freq_next,
> 					CPUFREQ_RELATION_L);
>