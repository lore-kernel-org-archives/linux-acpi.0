From: Guillaume Chazarain <guichaz@yahoo.fr>
Subject: scaling_cur_freq is broken with acpi-cpufreq driver and ondemand
 governor
Date: Sun, 24 Dec 2006 23:32:47 +0100
Message-ID: <458F000F.5050401@yahoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090502020700010909070806"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from postfix2-g20.free.fr ([212.27.60.43]:45420 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbWLXXCV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Dec 2006 18:02:21 -0500
Received: from smtp4-g19.free.fr (smtp4-g19.free.fr [212.27.42.30])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 451EC83181C
	for <linux-acpi@vger.kernel.org>; Sun, 24 Dec 2006 22:33:14 +0100 (CET)
Received: from [192.168.0.4] (bar06-2-82-224-157-131.fbx.proxad.net [82.224.157.131])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 0801588C9
	for <linux-acpi@vger.kernel.org>; Sun, 24 Dec 2006 23:32:10 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090502020700010909070806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

As of linux-2.6.20-rc2 using acpi-cpufreq and ondemand on my Pentium M 
(Asus V6VA laptop) seems broken. 
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq contains most of 
the time 1, sometimes the actual frequency or (rarely) some random value.

The problem seems to come from 
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7650b281b091f39f5e97f13b45ab3813b1526b65

The attached patch fixes the problem for me, but it was obtained from 
random mutilations of the aforementioned patch. For instance, I don't 
understand how cmd.val is used, the freqs.old = extract_freq(cmd.val, 
data); I introduced seems to use an uninitialized value from reading the 
code. But it seems to be also the case in cmd.val = (cmd.val & 
~INTEL_MSR_RANGE) | msr;

Thanks.

-- 
Guillaume


--------------090502020700010909070806
Content-Type: text/x-patch;
 name="ACPI-CPUFREQ.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ACPI-CPUFREQ.diff"

--- a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -400,6 +400,8 @@ static int acpi_cpufreq_target(struct cp
 	online_policy_cpus = policy->cpus;
 #endif
 
+	freqs.old = extract_freq(cmd.val, data);
+	freqs.new = data->freq_table[next_state].frequency;
 	next_perf_state = data->freq_table[next_state].index;
 	if (perf->state == next_perf_state) {
 		if (unlikely(data->resume)) {
@@ -439,8 +441,6 @@ static int acpi_cpufreq_target(struct cp
 	else
 		cpu_set(policy->cpu, cmd.mask);
 
-	freqs.old = data->freq_table[perf->state].frequency;
-	freqs.new = data->freq_table[next_perf_state].frequency;
 	for_each_cpu_mask(i, cmd.mask) {
 		freqs.cpu = i;
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);

--------------090502020700010909070806--
