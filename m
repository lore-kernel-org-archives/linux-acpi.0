From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 0/2] additional sysfs entries for CPPC
Date: Mon, 27 Mar 2017 11:00:03 -0600
Message-ID: <20e9f41b-d0b5-6e92-efb6-bfd3fafc8bec@codeaurora.org>
References: <1481763994-28146-1-git-send-email-pprakash@codeaurora.org>
 <11d1f119-1dac-1045-cd86-14972982bb29@codeaurora.org>
 <e2721cec-0ad0-636d-9652-60cd440e2d01@codeaurora.org>
 <2559450.4I6KQ8XthE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbdC0RAt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2017 13:00:49 -0400
In-Reply-To: <2559450.4I6KQ8XthE@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Al Stone <ahs3@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Klimov <alexey.klimov@arm.com>, Hoan Tran <hotran@apm.com>, Christopher Covington <cov@codeaurora.org>


On 3/25/2017 7:32 AM, Rafael J. Wysocki wrote:
> On Friday, March 24, 2017 10:34:42 AM Prakash, Prashanth wrote:
>> On 3/3/2017 11:32 AM, Prakash, Prashanth wrote:
>>> Hi Rafael,
>>>
>>> On 2/13/2017 9:38 AM, Prakash, Prashanth wrote:
>>> [...]
>>>>>> Tested-by: Al Stone <ahs3@redhat.com>
>>>>> I'm not actually sure about the assumption this series is based on.
>>>>>
>>>>> I don't see anything in the spec to guarantee that it will always be
>>>>> safe to evaluate _CPC only once and cache its output.
>>>> Among the Performance capabilities registers(section 8.4.7.1.1), the only
>>>> register that can change dynamically is Guaranteed performance register.
>>>> We are not supporting/using Guaranteed performance at the moment.
>>>>
>>>> Guaranteed performance Register has an associated Notify event which will be
>>>> invoked when it changes. No such events are associated with other capabilities
>>>> register. Similar distinction is made in the beginning of section 8.4.7.1.1:
>>>> "Figure 8-47 outlines the static performance thresholds of the platform
>>>>  and the dynamic guaranteed performance threshold."
>>>>
>>>> I agree spec isn't very clear about marking these registers as static except
>>>> that one sentence I quoted above, but there is enough in spec to guarantee
>>>> that the capabilities we are using will not change dynamically.
>>> Does the above sound reasonable? Any other feedback on this patch set?
>> Gentle Ping
> There are concerns that some CPPC parameters may change at run time on some
> systems even though the spec doesn't mention that possibility, so the optimization
> here may be premature.
Thanks Rafael!  I will remove the caching of CPPC perf caps and submit a patch to
add the sysfs entries with existing interface.

--
Thanks,
Prashanth

