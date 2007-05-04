From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: Why don't we use _TTS method?
Date: Fri, 4 May 2007 08:34:42 +0400
Message-ID: <8f8ff01d0705032134s4758d675qe1b37febb5745770@mail.gmail.com>
References: <B28E9812BAF6E2498B7EC5C427F293A40267F659@orsmsx415.amr.corp.intel.com>
	 <200705040122.56563.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:15028 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767678AbXEDEem (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 May 2007 00:34:42 -0400
Received: by an-out-0708.google.com with SMTP id b33so727193ana
        for <linux-acpi@vger.kernel.org>; Thu, 03 May 2007 21:34:42 -0700 (PDT)
In-Reply-To: <200705040122.56563.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Moore, Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

Rafael,

code in prepare() and enter() is split as code with interrupts on and
code with interrupts off.
thus it doesn't quite follow a spec in regards of driver suspend.
Basically we need to either split it to smaller pieces or have hooks
to control interrupts/driver suspend from this code.

Regards,
Alex.

On 5/4/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, 4 May 2007 00:57, Moore, Robert wrote:
> >
> > > -----Original Message-----
> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > > Sent: Thursday, May 03, 2007 1:02 PM
> > > To: ACPI Devel Maling List
> > > Cc: pm list; Pavel Machek
> > > Subject: Why don't we use _TTS method?
> > >
> > > Hi,
> > >
> > > I've got two questions regarding the implementation of the ACPI
> > > poweroff/sleep
> > > code in drivers/acpi/sleep and drivers/acpi/hardware .
> > >
> > > 1) We don't seem to use the _TTS system-control method, although the
> > ACPI
> > > specification (ACPI 3.0b) says that this method should be used for
> > > intiating
> > > and finishing power transitions.  Could you please tell me why we
> > don't
> > > use it?
> > >
> > [Moore, Robert]
> >
> > Probably because it's fairly new and it takes a long time for these
> > things to appear in real machines. Also, needs to be supported in
> > Windows before we ever see it in real machines.
>
> Hmm, it already was in the 3.0 spec from 2004, so it doesn't seem to be
> that new.  Still, I'm not an expert ...
>
> > > 2) In the functions acpi_enter_sleep_state_prep(),
> > > acpi_enter_sleep_state(),
> > > acpi_leave_sleep_state() we manipulate GPEs quite extensively (we
> > disable
> > > and enable them for a couple of times during a transition), although
> > the
> > > specification doesn't tell anything about that explicitly.  Could you
> > > please
> > > explain to me what the purpose of that is?
> > >
> > [Moore, Robert]
> >
> > There a wake GPEs and runtime GPEs that need to be managed separately.
> > We want to make sure that only the "Wake" GPEs are enabled as we goto
> > sleep.
>
> I understand that, but the runtime GPEs seem to be disabled before we call
> device drivers' .suspend() routines (ie. before the devices are placed in the
> appropriate Dx states) and that's the point I don't quite get.  Is there a
> technical reason for doing it in this particular place?
>
> Thanks a lot for your reply.
>
> Greetings,
> Rafael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
