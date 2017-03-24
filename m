From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 0/2] additional sysfs entries for CPPC
Date: Fri, 24 Mar 2017 10:34:42 -0600
Message-ID: <e2721cec-0ad0-636d-9652-60cd440e2d01@codeaurora.org>
References: <1481763994-28146-1-git-send-email-pprakash@codeaurora.org>
 <b147a3c2-5435-84b2-f3ff-6fb96e764fd5@redhat.com>
 <72d699cd-06fb-7896-1325-5fc74c4f9888@redhat.com>
 <CAJZ5v0jKDF7fys_ZHM0FvOw+xtQv5hKBBHxeZs80NRiRx=e=AA@mail.gmail.com>
 <f09519cd-4399-5253-8e8d-30611a85b228@codeaurora.org>
 <11d1f119-1dac-1045-cd86-14972982bb29@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43132 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757554AbdCXQes (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2017 12:34:48 -0400
In-Reply-To: <11d1f119-1dac-1045-cd86-14972982bb29@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Al Stone <ahs3@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexey Klimov <alexey.klimov@arm.com>, Hoan Tran <hotran@apm.com>, Christopher Covington <cov@codeaurora.org>


On 3/3/2017 11:32 AM, Prakash, Prashanth wrote:
> Hi Rafael,
>
> On 2/13/2017 9:38 AM, Prakash, Prashanth wrote:
> [...]
>>>> Tested-by: Al Stone <ahs3@redhat.com>
>>> I'm not actually sure about the assumption this series is based on.
>>>
>>> I don't see anything in the spec to guarantee that it will always be
>>> safe to evaluate _CPC only once and cache its output.
>> Among the Performance capabilities registers(section 8.4.7.1.1), the only
>> register that can change dynamically is Guaranteed performance register.
>> We are not supporting/using Guaranteed performance at the moment.
>>
>> Guaranteed performance Register has an associated Notify event which will be
>> invoked when it changes. No such events are associated with other capabilities
>> register. Similar distinction is made in the beginning of section 8.4.7.1.1:
>> "Figure 8-47 outlines the static performance thresholds of the platform
>>  and the dynamic guaranteed performance threshold."
>>
>> I agree spec isn't very clear about marking these registers as static except
>> that one sentence I quoted above, but there is enough in spec to guarantee
>> that the capabilities we are using will not change dynamically.
> Does the above sound reasonable? Any other feedback on this patch set?

Gentle Ping

--
Thanks,
Prashanth
