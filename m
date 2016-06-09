From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v3] mailbox: pcc: Support HW-Reduced Communication
 Subspace type 2
Date: Wed, 8 Jun 2016 18:32:32 -0600
Message-ID: <0f07c6dc-76b7-ab28-541b-090f6a2432a6@codeaurora.org>
References: <1463704347-22550-1-git-send-email-hotran@apm.com>
 <CAJ5Y-eZaaK_pbfgPxDfqJgtUOpxrCvHngM4_VT9p-fzFaPz28Q@mail.gmail.com>
 <CAFHUOYy0TEqdHzwXCTNtK+UVF_PhMHfr-gPTOkUwRks=MgTaVg@mail.gmail.com>
 <CAJ5Y-eYV+vf_GDCX6iX53Q5jLtOTzRktRHBfmZzW-yd5ffu2jg@mail.gmail.com>
 <CAFHUOYxV8Jj_wUXqA7jqj3SZ4uqCSSgKuYmsC2k1MxvVyX3EfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44121 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230AbcFIAcg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jun 2016 20:32:36 -0400
In-Reply-To: <CAFHUOYxV8Jj_wUXqA7jqj3SZ4uqCSSgKuYmsC2k1MxvVyX3EfQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hoan Tran <hotran@apm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Alexey Klimov <alexey.klimov@arm.com>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>



On 6/8/2016 10:24 AM, Hoan Tran wrote:
> Hi Ashwin,
>
> On Wed, Jun 8, 2016 at 5:18 AM, Ashwin Chaugule
> <ashwin.chaugule@linaro.org> wrote:
>> + Prashanth (Can you please have a look as well?)
>>
>> On 31 May 2016 at 15:35, Hoan Tran <hotran@apm.com> wrote:
>>> Hi Ashwin,
>> Hi,
>>
>> Sorry about the delay. I'm in the middle of switching jobs and
>> locations, so its been a bit crazy lately.
> It's ok and hope you're doing well.
>
>> I dont have any major
>> concerns with this code, although there could be subtle issues with
>> this IRQ thing. In this patchset, your intent is to add support for
>> PCC subspace type 2. But you're also adding support for tx command
>> completion which is not specific to Type 2. We could support that even
>> in Type 1. Hence I wanted to separate the two, not just for review,
>> but also the async IRQ completion has subtle issues esp. in the case
>> of async platform notification, where you could have a PCC client in
>> the OS writing to the cmd bit and the platform sending an async
>> notification by writing to some bits in the same 8byte address as the
>> cmd bit. So we need some mutual exclusivity there, otherwise the OS
>> and platform could step on each other. Perhaps Prashanth has better
>> insight into this.
> I think, this mutual exclusivity could be in another patch.
Ashwin,
Sorry, I am not sure how we can prevent platform and OSPM from stepping on
each other.  There is a line is spec that says "all operations on status field
must be made using interlocked operations", but not sure what these
interlocked operation translates to.

Hoan,
Even if we are not using platform notification, we still need to clear the doorbell
interrupt bit in the PCC interrupt handler (Section14.2.2 and 14.4).  I didn't see
clearing the doorbell interrupt bit in this patch (and platform is supposed to set
it again when it is sending the interrupt again). Did I miss it? or is it intentionally
left out to avoid the race that Ashwin mentioned above?


Thanks,
Prashanth


