From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [RFC] ACPI / Processor: add sysfs support for low power idle
Date: Wed, 26 Apr 2017 17:21:15 -0600
Message-ID: <e92d05d4-c9a1-f94b-854b-bb57bb479234@codeaurora.org>
References: <1490832795-27441-1-git-send-email-pprakash@codeaurora.org>
 <2e633ef7-5155-7eb7-0f1b-8bc36bd25da7@arm.com>
 <37544927-1f7d-ab59-63d5-32ac1d777bb6@codeaurora.org>
 <a6544dab-4ae4-22d6-4fe5-08f7919072ca@arm.com>
 <c9ab5b6c-ad86-1a03-2d1f-c8526e8684b1@codeaurora.org>
 <0ac023c3-4bda-ba33-4634-6108e0631962@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49750 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032581AbdDZXVT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2017 19:21:19 -0400
In-Reply-To: <0ac023c3-4bda-ba33-4634-6108e0631962@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, al.stone@linaro.org

Hi Sudeep,

On 4/25/2017 4:28 AM, Sudeep Holla wrote:
>> With hierarchy, it is possible to get information about relationship between cpus
>> and  higher order shared resources. If we flatten the hierarchy we lose information
>> about relationships and it gets a little hard to clearly represent the idle states of
>> shared resources and which cpus share those resources.
>>
> No, what I meant is to have complete information broken down to the
> lowest possible level, but just one file access to get that information.
>
> IIUC, you had some format already for summary_stat file, just extend
> to get all the information you would get reading individual sysfs files
> organized hierarchically. I don't think that should matter much as you
> would have all these information, just the representation differs. I am
> assuming all this data is not used/interpreted on the fly, but mostly
> used offline for analysis. Otherwise it's already misuse and we don't
> want to expose such user ABI IMO.
>
> Just to summarize, though I agree this LPI stats are more accurate and
> more representative summary, I think it may fade away as we move towards
> hardware controlled lower power states. Since we already have cpuidle
> stats, I prefer to keep this LPI stats interface to userspace as simple
> and minimal as possible and yet helpful to get all the information.
Sounds good. I will remove summary_stats and make other changes based on
feedback and post next rev.

Thanks for the review and feedback!

--
Thanks,
Prashanth

