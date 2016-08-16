From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] mailbox: pcc: Support HW-Reduced Communication Subspace type 2
Date: Tue, 16 Aug 2016 13:56:35 +0200
Message-ID: <16935343.I93a8yB3ce@vostro.rjw.lan>
References: <1463704347-22550-1-git-send-email-hotran@apm.com> <9102573.MEe9O1jMMq@vostro.rjw.lan> <CAFHUOYyw-AmTxZnO5oEq0RXgwEcJFL4TZcQYtjBE+NjYw9D3ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47020 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751861AbcHPLvG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Aug 2016 07:51:06 -0400
In-Reply-To: <CAFHUOYyw-AmTxZnO5oEq0RXgwEcJFL4TZcQYtjBE+NjYw9D3ww@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Robert Moore <robert.moore@intel.com>, Alexey Klimov <alexey.klimov@arm.com>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>, "Prakash, Prashanth" <pprakash@codeaurora.org>

On Monday, August 15, 2016 04:41:22 PM Hoan Tran wrote:
> Hi Rafael,
> 
> On Mon, Aug 15, 2016 at 4:18 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, August 15, 2016 09:45:24 AM Hoan Tran wrote:
> >> On Mon, Jun 27, 2016 at 2:32 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> >
> >> > On Monday, June 27, 2016 11:27:42 AM Hoan Tran wrote:
> >> > > Hi Jassi and Rafael,
> >> > >
> >> > > On Wed, Jun 15, 2016 at 9:19 AM, Prakash, Prashanth
> >> > > <pprakash@codeaurora.org> wrote:
> >> > > >
> >> > > >
> >> > > > On 6/9/2016 4:43 PM, Hoan Tran wrote:
> >> > > >> Hi Prashanth,
> >> > > >>
> >> > > >> On Thu, Jun 9, 2016 at 3:25 PM, Prakash, Prashanth
> >> > > >> <pprakash@codeaurora.org> wrote:
> >> > > >>>
> >> > > >>> On 6/9/2016 2:47 PM, Hoan Tran wrote:
> >> > > >>>> Hi Ashwin and Prashanth,
> >> > > >>>>
> >> > > >>>> On Wed, Jun 8, 2016 at 5:41 PM, Hoan Tran <hotran@apm.com> wrote:
> >> > > >>>>> Hi Prashanth,
> >> > > >>>>>
> >> > > >>>>>
> >> > > >>>>> On Wed, Jun 8, 2016 at 5:32 PM, Prakash, Prashanth
> >> > > >>>>> <pprakash@codeaurora.org> wrote:
> >> > > >>>>>> On 6/8/2016 10:24 AM, Hoan Tran wrote:
> >> > > >>>>>>> Hi Ashwin,
> >> > > >>>>>>>
> >> > > >>>>>>> On Wed, Jun 8, 2016 at 5:18 AM, Ashwin Chaugule
> >> > > >>>>>>> <ashwin.chaugule@linaro.org> wrote:
> >> > > >>>>>>>> + Prashanth (Can you please have a look as well?)
> >> > > >>>>>>>>
> >> > > >>>>>>>> On 31 May 2016 at 15:35, Hoan Tran <hotran@apm.com> wrote:
> >> > > >>>>>>>>> Hi Ashwin,
> >> > > >>>>>>>> Hi,
> >> > > >>>>>>>>
> >> > > >>>>>>>> Sorry about the delay. I'm in the middle of switching jobs and
> >> > > >>>>>>>> locations, so its been a bit crazy lately.
> >> > > >>>>>>> It's ok and hope you're doing well.
> >> > > >>>>>>>
> >> > > >>>>>>>> I dont have any major
> >> > > >>>>>>>> concerns with this code, although there could be subtle issues with
> >> > > >>>>>>>> this IRQ thing. In this patchset, your intent is to add support for
> >> > > >>>>>>>> PCC subspace type 2. But you're also adding support for tx command
> >> > > >>>>>>>> completion which is not specific to Type 2. We could support that even
> >> > > >>>>>>>> in Type 1. Hence I wanted to separate the two, not just for review,
> >> > > >>>>>>>> but also the async IRQ completion has subtle issues esp. in the case
> >> > > >>>>>>>> of async platform notification, where you could have a PCC client in
> >> > > >>>>>>>> the OS writing to the cmd bit and the platform sending an async
> >> > > >>>>>>>> notification by writing to some bits in the same 8byte address as the
> >> > > >>>>>>>> cmd bit. So we need some mutual exclusivity there, otherwise the OS
> >> > > >>>>>>>> and platform could step on each other. Perhaps Prashanth has better
> >> > > >>>>>>>> insight into this.
> >> > > >>>>>>> I think, this mutual exclusivity could be in another patch.
> >> > > >>>>>> Ashwin,
> >> > > >>>>>> Sorry, I am not sure how we can prevent platform and OSPM from stepping on
> >> > > >>>>>> each other.  There is a line is spec that says "all operations on status field
> >> > > >>>>>> must be made using interlocked operations", but not sure what these
> >> > > >>>>>> interlocked operation translates to.
> >> > > >>>>> Yes, I had the same question about how to prevent it.
> >> > > >>>> For platform notification, if the hardware doesn't support interlocked
> >> > > >>>> operations. I think we can use a workaround that, platform triggers
> >> > > >>>> interrupt to OSPM without touching status field. The OSPM PCC client
> >> > > >>>> will decide what to do with this interrupt. For example, OSPM sends a
> >> > > >>>> consumer command to check it.
> >> > > >>> How do we decide which platform can support this interlocked operation?
> >> > > >>> and how do we decide between a completion notification and platform
> >> > > >>> notification?
> >> > > >> Truly, we should follow the specification. But I don't know if there's
> >> > > >> any hardware support this interlocked operation.
> >> > > >> For the decide between a completion notification and platform notification
> >> > > >>  - Completion notification: Bit "Command Complete" is set.
> >> > > >>  - Platform notification: Bit "Command Complete" is not set.
> >> > > >>
> >> > > >>> I think the ACPI spec on platform notification is quite ambiguous and it is
> >> > > >>> best to get the necessary clarification and/or correction before implementing
> >> > > >>> anything related to platform notification.
> >> > > >> Agreed, a clarification inside ACPI Specification is needed
> >> > > > This patch look good to me, as it doesn't deal with platform notification.
> >> > > > We can try to get some clarification from spec side before handling the platform
> >> > > > notification pieces.
> >> > > >
> >> > > > Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>
> >> > >
> >> > > Do you have plan to apply this patch ?
> >> >
> >> > Yes.
> >> >
> >> > Thanks,
> >> > Rafael
> >> >
> >>
> >> Hi Rafael,
> >>
> >> This patch had an ACK from Prashanth.  Can you consider to merge
> >> this patch please?
> >
> > Can you please resend it with the ACK?
> 
> Correcting, it got a "Reviewed-by: Prashanth Prakash
> <pprakash@codeaurora.org>". Is it OK?

Yes, it is.

Thanks,
Rafael

