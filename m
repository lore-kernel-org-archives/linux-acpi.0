From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [RFC] ACPI / Processor: add sysfs support for low power idle
Date: Thu, 27 Apr 2017 15:04:51 -0600
Message-ID: <717bfc22-4e6e-c9de-343f-aa40dd8ef408@codeaurora.org>
References: <1490832795-27441-1-git-send-email-pprakash@codeaurora.org>
 <2e633ef7-5155-7eb7-0f1b-8bc36bd25da7@arm.com>
 <37544927-1f7d-ab59-63d5-32ac1d777bb6@codeaurora.org>
 <a6544dab-4ae4-22d6-4fe5-08f7919072ca@arm.com>
 <c9ab5b6c-ad86-1a03-2d1f-c8526e8684b1@codeaurora.org>
 <0ac023c3-4bda-ba33-4634-6108e0631962@arm.com>
 <e92d05d4-c9a1-f94b-854b-bb57bb479234@codeaurora.org>
 <6e02cc0d-52a8-05f9-7227-7a9e6018621b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966071AbdD0VEy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Apr 2017 17:04:54 -0400
In-Reply-To: <6e02cc0d-52a8-05f9-7227-7a9e6018621b@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, al.stone@linaro.org, linux-acpi@vger.kernel.org


On 4/27/2017 3:16 AM, Sudeep Holla wrote:
>
> On 27/04/17 00:21, Prakash, Prashanth wrote:
>> Hi Sudeep,
>>
>> On 4/25/2017 4:28 AM, Sudeep Holla wrote:
>>>> With hierarchy, it is possible to get information about relationship between cpus
>>>> and  higher order shared resources. If we flatten the hierarchy we lose information
>>>> about relationships and it gets a little hard to clearly represent the idle states of
>>>> shared resources and which cpus share those resources.
>>>>
>>> No, what I meant is to have complete information broken down to the
>>> lowest possible level, but just one file access to get that information.
>>>
>>> IIUC, you had some format already for summary_stat file, just extend
>>> to get all the information you would get reading individual sysfs files
>>> organized hierarchically. I don't think that should matter much as you
>>> would have all these information, just the representation differs. I am
>>> assuming all this data is not used/interpreted on the fly, but mostly
>>> used offline for analysis. Otherwise it's already misuse and we don't
>>> want to expose such user ABI IMO.
>>>
>>> Just to summarize, though I agree this LPI stats are more accurate and
>>> more representative summary, I think it may fade away as we move towards
>>> hardware controlled lower power states. Since we already have cpuidle
>>> stats, I prefer to keep this LPI stats interface to userspace as simple
>>> and minimal as possible and yet helpful to get all the information.
>> Sounds good. I will remove summary_stats and make other changes based on
>> feedback and post next rev.
> I am sorry if I was not clear earlier, I was infact asking you what if
> we just have single summary_stat file with all statistics broken down to
> minuet details you want instead of creating the hierarchy of individual
> files which you say has overhead to read.
>
> Do you process the stats on the fly when workload is running, I assume not.
I don't see any use-cases for on the fly analysis. The most we might want to
do it capture this data periodically and then post-process it to see how different
phases of a workload did. The overhead of reading multiple files comes down what
could be the duration between reads to this sysfs without drastically impacting the
workload - so it is probably not such a big issue.

While it is possible to simplify by having all the data aggregated into a single
file at each level in the hierarchy, we end up trading some inefficiencies:
- We are reducing the number of file access but increasing the amount of
data read (which user-space may or may not be interested in), including
re-reading the constant fields(desc, latency etc..) every time.
- Adding all info on the same file increases the probability we might break
userspace parsing of this single file when we want add a new piece of
information. While this was possible earlier, the probability was little
lower as it was restricted to only time and usage.
- Another reason to avoid collapsing all the fields to single file is to keep
it consistent with cpudile interface

I was thinking about some of the above issues and when you mentioned
simple and minimal, I interpreted it as lets keep the interface simple by
removing summary_stats and few other fields we discussed. Sorry, my bad.

--
Thanks,
Prashanth

