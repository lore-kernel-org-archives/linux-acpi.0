From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [linux-pm] acpi_idle and max_cpus
Date: Tue, 19 Jun 2012 12:24:43 +0530
Message-ID: <4FE02233.2060809@linux.vnet.ibm.com>
References: <4FDB549F.1020002@linaro.org> <4FDE3B96.8030306@linaro.org> <4FDF1E3A.6010200@linux.vnet.ibm.com> <4FDF24FE.1010108@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:48608 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab2FSGy5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jun 2012 02:54:57 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <deepthi@linux.vnet.ibm.com>;
	Tue, 19 Jun 2012 12:24:53 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5J6sofu61735024
	for <linux-acpi@vger.kernel.org>; Tue, 19 Jun 2012 12:24:51 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5JCPLDZ010389
	for <linux-acpi@vger.kernel.org>; Tue, 19 Jun 2012 22:25:22 +1000
In-Reply-To: <4FDF24FE.1010108@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

On 06/18/2012 06:24 PM, Daniel Lezcano wrote:

> On 06/18/2012 02:25 PM, Deepthi Dharwar wrote:
>> Hi Daniel,
>>
>> On 06/18/2012 01:48 AM, Daniel Lezcano wrote:
>>
>>> On 06/15/2012 05:28 PM, Daniel Lezcano wrote:
>>>>
>>>> Hi all,
>>>>
>>>> I have a dual core Intel T9500.
>>>>
>>>> I boot the cpu with the acpi_idle driver and intel_idle enabled in the
>>>> config.
>>>>
>>>> The kernel is booted with maxcpus=1.
>>>>
>>>> After the system has boot, I put cpu1 online via sysfs.
>>>>
>>>> But I don't see any 'cpuidle' directory in the cpu's sysfs entry:
>>>>
>>>> /sys/devices/system/cpu/cpu1/cpuidle (?)
>>>>
>>>> When I look at the code I see the notifier is present for hotplug in
>>>> processor_driver.c and the cpuidle intel init routine should be called
>>>> there.
>>>>
>>
>>
>> Yes, we have a hotplug notifier.
>> Commit 99b72508  by Thomas Renninger fixed this issue.
>>
>> Please let me know which kernel version you are running and what is idle
>> driver registered ?
> 
> The kernel version is 3.5.0-rc1
> The registered driver is acpi_idle (with intel_idle if I am not wrong).
> 
> Thomas's patch is in this version.
> 
> Maybe I am wrong but I think the patch is not correct because:
> 
> static int __cpuinit acpi_processor_add(struct acpi_device *device)
> {
> 
>  ...
> 
> #ifdef CONFIG_SMP
> 	if (pr->id >= setup_max_cpus && pr->id != 0)
> 		return 0;
> #endif
> 
>  ...
> 
> 	per_cpu(processors, pr->id) = pr;
> 
> ...
> }
> 
> With max_cpus=1 we exit before setting up 'pr'.
> 
> So the condition in:
> 
> static int acpi_cpu_soft_notify(...)
> {
> 
> 	unsigned int cpu = (unsigned long)hcpu;
> 	struct acpi_processor *pr = per_cpu(processors, cpu);
> 
> 	if (action == CPU_ONLINE && pr) {
> 
> ...
> }
> 
> Is always false because pr == NULL
> 
> I did the change but I don't still see the 'cpuidle' directory
> appearing, I suspect also pr->flags.need_hotplug_init is not correctly
> initialized but I did not investigate more.
> 


Well looks like variable maxcpus holds the key here.

When I am booting the system, say with 2 out of 4 available cpus,
set via maxcpus variable with intel_idle or acpi_idle and onlining the
other 2 cpus later via sysfs, I dont see cpufreq or cpuidle dir in the
sysfs path.

# cd /sys/devices/system/cpu/cpu2
xxx:/sys/devices/system/cpu/cpu2# ls
	crash_notes  node0  online
xxx:/sys/devices/system/cpu/cpu2# echo 1 > online
xxx:/sys/devices/system/cpu/cpu2# ls
cache  crash_notes  node0  online  thermal_throttle  topology

So looks like its designed that way for now.
So if maxcpus=X, X<Y where Y is no of available cpus.
Enabling the Y-X cpus later after the boot via sysfs is not enabling
cpuidle and cpufreq .

The question is, do we want to modify this behavior ?

Cheers,
Deepthi

