From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v3] mailbox: pcc: Support HW-Reduced Communication
 Subspace type 2
Date: Wed, 15 Jun 2016 10:19:36 -0600
Message-ID: <b498099e-4ffe-21da-f97b-4899c59201bf@codeaurora.org>
References: <1463704347-22550-1-git-send-email-hotran@apm.com>
 <CAJ5Y-eZaaK_pbfgPxDfqJgtUOpxrCvHngM4_VT9p-fzFaPz28Q@mail.gmail.com>
 <CAFHUOYy0TEqdHzwXCTNtK+UVF_PhMHfr-gPTOkUwRks=MgTaVg@mail.gmail.com>
 <CAJ5Y-eYV+vf_GDCX6iX53Q5jLtOTzRktRHBfmZzW-yd5ffu2jg@mail.gmail.com>
 <CAFHUOYxV8Jj_wUXqA7jqj3SZ4uqCSSgKuYmsC2k1MxvVyX3EfQ@mail.gmail.com>
 <0f07c6dc-76b7-ab28-541b-090f6a2432a6@codeaurora.org>
 <CAFHUOYyzQiUtpDL_oULCdbvMXxoXK5_bAvkW8SZV0BcrvPqa-Q@mail.gmail.com>
 <CAFHUOYyMpRgLzXN0XtFKG08Z9dLuhC7WNbJi8+nNTNET=m2qEA@mail.gmail.com>
 <4652800c-b518-6b9a-967f-bb31e6a496b0@codeaurora.org>
 <CAFHUOYwQhyjnmQyP2Vf2FctOoXRkB39yJujN09VQbBbpRtB43Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35644 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbcFOQTj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2016 12:19:39 -0400
In-Reply-To: <CAFHUOYwQhyjnmQyP2Vf2FctOoXRkB39yJujN09VQbBbpRtB43Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Alexey Klimov <alexey.klimov@arm.com>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>



On 6/9/2016 4:43 PM, Hoan Tran wrote:
> Hi Prashanth,
>
> On Thu, Jun 9, 2016 at 3:25 PM, Prakash, Prashanth
> <pprakash@codeaurora.org> wrote:
>>
>> On 6/9/2016 2:47 PM, Hoan Tran wrote:
>>> Hi Ashwin and Prashanth,
>>>
>>> On Wed, Jun 8, 2016 at 5:41 PM, Hoan Tran <hotran@apm.com> wrote:
>>>> Hi Prashanth,
>>>>
>>>>
>>>> On Wed, Jun 8, 2016 at 5:32 PM, Prakash, Prashanth
>>>> <pprakash@codeaurora.org> wrote:
>>>>> On 6/8/2016 10:24 AM, Hoan Tran wrote:
>>>>>> Hi Ashwin,
>>>>>>
>>>>>> On Wed, Jun 8, 2016 at 5:18 AM, Ashwin Chaugule
>>>>>> <ashwin.chaugule@linaro.org> wrote:
>>>>>>> + Prashanth (Can you please have a look as well?)
>>>>>>>
>>>>>>> On 31 May 2016 at 15:35, Hoan Tran <hotran@apm.com> wrote:
>>>>>>>> Hi Ashwin,
>>>>>>> Hi,
>>>>>>>
>>>>>>> Sorry about the delay. I'm in the middle of switching jobs and
>>>>>>> locations, so its been a bit crazy lately.
>>>>>> It's ok and hope you're doing well.
>>>>>>
>>>>>>> I dont have any major
>>>>>>> concerns with this code, although there could be subtle issues with
>>>>>>> this IRQ thing. In this patchset, your intent is to add support for
>>>>>>> PCC subspace type 2. But you're also adding support for tx command
>>>>>>> completion which is not specific to Type 2. We could support that even
>>>>>>> in Type 1. Hence I wanted to separate the two, not just for review,
>>>>>>> but also the async IRQ completion has subtle issues esp. in the case
>>>>>>> of async platform notification, where you could have a PCC client in
>>>>>>> the OS writing to the cmd bit and the platform sending an async
>>>>>>> notification by writing to some bits in the same 8byte address as the
>>>>>>> cmd bit. So we need some mutual exclusivity there, otherwise the OS
>>>>>>> and platform could step on each other. Perhaps Prashanth has better
>>>>>>> insight into this.
>>>>>> I think, this mutual exclusivity could be in another patch.
>>>>> Ashwin,
>>>>> Sorry, I am not sure how we can prevent platform and OSPM from stepping on
>>>>> each other.  There is a line is spec that says "all operations on status field
>>>>> must be made using interlocked operations", but not sure what these
>>>>> interlocked operation translates to.
>>>> Yes, I had the same question about how to prevent it.
>>> For platform notification, if the hardware doesn't support interlocked
>>> operations. I think we can use a workaround that, platform triggers
>>> interrupt to OSPM without touching status field. The OSPM PCC client
>>> will decide what to do with this interrupt. For example, OSPM sends a
>>> consumer command to check it.
>> How do we decide which platform can support this interlocked operation?
>> and how do we decide between a completion notification and platform
>> notification?
> Truly, we should follow the specification. But I don't know if there's
> any hardware support this interlocked operation.
> For the decide between a completion notification and platform notification
>  - Completion notification: Bit "Command Complete" is set.
>  - Platform notification: Bit "Command Complete" is not set.
>
>> I think the ACPI spec on platform notification is quite ambiguous and it is
>> best to get the necessary clarification and/or correction before implementing
>> anything related to platform notification.
> Agreed, a clarification inside ACPI Specification is needed
This patch look good to me, as it doesn't deal with platform notification.
We can try to get some clarification from spec side before handling the platform
notification pieces.

Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>

Thanks,
Prashanth
