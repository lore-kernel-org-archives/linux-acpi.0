From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v10 1/1] Mailbox: Add support for Platform Communication
 Channel
Date: Wed, 12 Nov 2014 14:03:38 +0000
Message-ID: <546368BA.6060209@arm.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>	<CAJ5Y-eZ+q2dHuuWwVjMCcVtXqSwg0o9Zj-kqQS95K40VakwReQ@mail.gmail.com>	<546224C8.7050502@arm.com>	<1620095.ORCbaZ8QlJ@wuerfel>	<5463615C.90306@arm.com> <CAJ5Y-ea_DDc_kpD+ZMvdw4-UqzKU=nEpafhRTR6B6dfdtaPgvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:46986 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbaKLODo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2014 09:03:44 -0500
In-Reply-To: <CAJ5Y-ea_DDc_kpD+ZMvdw4-UqzKU=nEpafhRTR6B6dfdtaPgvQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Arnd Bergmann <arnd@arndb.de>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "lv.zheng@intel.com" <lv.zheng@intel.com>



On 12/11/14 13:48, Ashwin Chaugule wrote:
> On 12 November 2014 08:32, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 11/11/14 20:25, Arnd Bergmann wrote:
>>>
>>> On Tuesday 11 November 2014 15:01:28 Sudeep Holla wrote:
>>>>
>>>> On 11/11/14 13:18, Ashwin Chaugule wrote:
>>>>>
>>>>> On 11 November 2014 05:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>>>>
>>>>>> On 07/11/14 14:52, Ashwin Chaugule wrote:
>>>>>
>>>>> The IRQ part of the spec seems to be under discussion (single irq per
>>>>> subspace / common IRQ across all) and as you may be aware we're
>>>>> working on trying it out on Juno. That'll guide the design. What I
>>>>> have here is good enough to start off with and has been tested. I dont
>>>>> think we should have a problem using the mailbox API for asyn tx
>>>>> though, but I'd really^n prefer if we get something out there first.
>>>>>
>>>>
>>>> That's the different and still under discussion. But you need to support
>>>> Type 1 subspace as it stands in ACPI v5.1
>>>
>>>
>>> Why? We should only implement whatever is required to support existing
>>> hardware,
>>> not because something is in the spec.
>>
>>
>> Agreed. I assumed that this was tested on some hardware which adhere to
>> Type 1 subspace of the spec and I asked to implement interrupt mode as
>> it is always better compared to polling mode and current spec. has
>> support for the interrupts.
>
> I do not have hardware to test the IRQ parts as of now, so the plan
> was to at least get polling mode out there. That will enable a lot of
> folks and will be useful as a fallback mode later on as well. We can
> add IRQ mode stuff once it is tested. I dont see the point in
> supporting it all from the start.
>

Agreed, sorry I was not clear. I didn't mean to say you need to add it
now. Since you mentioned about the ongoing proposal, I just wanted to
make it clear that there might be hardware adhering to Type 1 and if
they want to use interrupts we need to support it and that's different
from the new proposal.

>>
>> Also, the existing Type1 is not sufficient for the mailbox/PCC on Juno
>> platform, hence the new proposal.
>
> Just as Juno is proving that the IRQ mode in the current spec is
> insufficient, we may find similar issues with other hardware as it
> becomes available. It makes more sense to tackle this once we have
> some hardware to test this part of PCC properly. Just because its in
> the spec doesn't mean its right. ;)
>

Agreed. But I was just curious to know will any ACPI implementation use
the polling mode for PCC and use Type 1 subspace as is ;).

> Btw, if you or anyone has any hardware to test it on, patches are more
> than welcome. :)
>

No, unfortunately I have only Juno and it doesn't fit this Type of PCC
Subspace. Even if it fits, I need firmware/platform changes to
understand PCC. So I am currently not in a position to test this.

Regards,
Sudeep

