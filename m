From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC] ACPI / Processor: add sysfs support for low power idle
Date: Tue, 25 Apr 2017 11:28:20 +0100
Message-ID: <0ac023c3-4bda-ba33-4634-6108e0631962@arm.com>
References: <1490832795-27441-1-git-send-email-pprakash@codeaurora.org>
 <2e633ef7-5155-7eb7-0f1b-8bc36bd25da7@arm.com>
 <37544927-1f7d-ab59-63d5-32ac1d777bb6@codeaurora.org>
 <a6544dab-4ae4-22d6-4fe5-08f7919072ca@arm.com>
 <c9ab5b6c-ad86-1a03-2d1f-c8526e8684b1@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1429618AbdDYK2e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Apr 2017 06:28:34 -0400
In-Reply-To: <c9ab5b6c-ad86-1a03-2d1f-c8526e8684b1@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, lenb@kernel.org, al.stone@linaro.org



On 25/04/17 02:17, Prakash, Prashanth wrote:
> 
> 
> On 4/20/2017 2:46 AM, Sudeep Holla wrote:
>>
>> On 19/04/17 23:57, Prakash, Prashanth wrote:
>>> Hi Sudeep,
>>>
>>> On 4/19/2017 9:37 AM, Sudeep Holla wrote:
>>>> On 30/03/17 01:13, Prashanth Prakash wrote:
>>>>> Add support to expose idle statistics maintained by platform to
>>>>> userspace via sysfs in addition to other data of interest from
>>>>> each LPI(Low Power Idle) state.
>>>>>
>>>> While I understand this information is useful for some optimization
>>>> and also for idle characterization with different workloads, I prefer
>>>> to keep this in debugfs for:
>>>>
>>>> 1. We already have CPUIdle stats, this information may be more accurate
>>>>    which is good for above reasons but user-space applications shouldn't
>>>>    depend on it and end-up misusing it.
>>>> 2. Also as more features get pushed into hardware, even these stats may
>>>>    not remain so much accurate as it is today and hence it would be
>>>>    better if user-space applications never use/depend on them.
>>>>
>>>> Let me know if there are conflicting reasons ?
>>> The information about idle state of shared resources(Cache, interconnect ...)
>>> which cannot be deduced from the cpuidle stats is quite useful. We can use this
>>> to analyze newer workloads and to explain their power consumption, especially as
>>> the amount of time some of these shared resources spends in different LPI states
>>> can be influenced by changes to workload, kernel or firmware. And for auto
>>> promote-able states this is the only way to capture idle stats.
>>>
>> I agree that the stats are useful, no argument there. The question is
>> more in terms of whether it can be debugfs which is just useful in
>> analysis and characterization or sysfs which becomes user ABI.
>>
>>> Regarding 2, since these stats are clearly defined by ACPI spec and maintained by
>>> platform, I think it is reasonable to expect them to be accurate. If it is not accurate,
>>> it is likely that platform is breaking the spec.
>>>
>> I was considering firmware vs hardware here. If f/w tracks and updates
>> these statistics, it may not be so accurate in the future if more
>> controls that are today done in f/w will be done automatically done in 
>> h/w. If h/w updates these statistics, then yes they will be accurate.
>
> Agree with f/w tracking vs h/w tracking, but I am not sure if we can (or should even try
>  to) handle those issues at LPI driver level.

No I was not saying to control it. I just raised it to make sure we
don't allow userspace to depend on these stats too much other than just
characterization and analysis as these might be lost in future platforms.

>> I am still trying to convince myself if we need this as sysfs user ABI,
>> so just thinking aloud.
> Sure.
>>> Given above, I don't see much room for user-space applications to misuse this.
>> You never know :)
> :-)
>>
>>> Given these are defined as optional in spec, user-space application should use
>>> only if/when available and use it as complementary to cpuidle stats.
>>>
>> Fair enough.
>>
>> [...]
>>
>>>>> 	|	|-> flags
>>>>> 	|	|-> arch_flags
>>>>> 	|
>>>>> 	<<more states>>
>>>>>
>>>>> ACPI00XX can be ACPI0007(processor) or ACPI0010(processor container)
>>>>>
>>>>> stateX contains information related to a specific LPI state defined
>>>>> in the LPI ACPI tables.
>>>>>
>>>>> summary_stats shows the stats(usage and time) from all the LPI states
>>>>> under a device. The summary_stats are provided to reduce the number'
>>>>> of files to be accessed by the userspace to capture a snapshot of the'
>>>>> idle statistics.
>>>> Really ? What's the need to reduce the no. of file accesses ?
>>> When we have a large number of cores, with multiple idle state + few auto-promotable
>>> states. The amount of files we need to access to get a snapshot before/after a running
>>> a workload is quite high.
>>>
>> OK. Since I don't have much knowledge on that, I can't really comment,
>> but I wonder why is that not done for many stats that are per-cpu today.
> Good point. The only example I can think of is cpufreq stats that does something like this,
> though I am not sure of exact motivation(s) behind it.
> 
> I think one could have made the similar case with cpuidle sysfs as well. Moreover
> summary_stats only mitigates some of the overhead with frequent reading of stats and
> doesn't really fix it in a scalable manner. So, I  suppose the current reasoning to have
> summary_stats is quite weak to start with.

After you brought up this point, I was thinking to use this over
hierarchical representation. If we put this summary_stats in debugfs,
then no need to worry about user ABI.

>>> It gets worse if we want to keep the file handles open to sample it little more frequently,
>>> to get breakdown of idle state distribution during different phases of a workload.
>> On the contrary agreeing with you on issue with large no. of file
>> handles, why not we have single stat file that provides all the
>> information you need and be done with it ? Why do we need all this
>> hierarchy of sysfs if the summary_stats can provide all those
>> information broken down.
> With hierarchy, it is possible to get information about relationship between cpus
> and  higher order shared resources. If we flatten the hierarchy we lose information
> about relationships and it gets a little hard to clearly represent the idle states of
> shared resources and which cpus share those resources.
> 

No, what I meant is to have complete information broken down to the
lowest possible level, but just one file access to get that information.

IIUC, you had some format already for summary_stat file, just extend
to get all the information you would get reading individual sysfs files
organized hierarchically. I don't think that should matter much as you
would have all these information, just the representation differs. I am
assuming all this data is not used/interpreted on the fly, but mostly
used offline for analysis. Otherwise it's already misuse and we don't
want to expose such user ABI IMO.

Just to summarize, though I agree this LPI stats are more accurate and
more representative summary, I think it may fade away as we move towards
hardware controlled lower power states. Since we already have cpuidle
stats, I prefer to keep this LPI stats interface to userspace as simple
and minimal as possible and yet helpful to get all the information.

-- 
Regards,
Sudeep
