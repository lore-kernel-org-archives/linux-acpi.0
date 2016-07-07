From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Thu, 7 Jul 2016 23:21:17 +0800
Message-ID: <CADyBb7uaTzwH3RB31K5ALNy=U9UkfStXqtFYXKgm1N_2TA2xnA@mail.gmail.com>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <1890708.ZTyM2PUGdP@vostro.rjw.lan> <20160707134023.GA655@red-moon> <1603704.EGiVTcCxLR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34640 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbcGGPVU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jul 2016 11:21:20 -0400
Received: by mail-oi0-f53.google.com with SMTP id s66so27480224oif.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 Jul 2016 08:21:19 -0700 (PDT)
In-Reply-To: <1603704.EGiVTcCxLR@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redh

Hi Rafael,

On 7 July 2016 at 21:58, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, July 07, 2016 02:40:23 PM Lorenzo Pieralisi wrote:
>> [+Sudeep]
>>
>> On Thu, Jul 07, 2016 at 02:03:17PM +0200, Rafael J. Wysocki wrote:
>>
>> [...]
>>
>> > > >> So is this a documentation issue in which case Fu Wei can add that to
>> > > >> the file to explain its limited to ARM64. Or we could even rename the
>> > > >> file acpi_arm64_gtdt.c
>> > > >>
>> > > >> It seems a pity as the comment on this series were minors to block
>> > > >> things on a filename/location.
>> > > >
>> > > > Let me repeat what I said above:
>> > > >
>> > > > I'm mostly concerned about how (and by whom) that code is going to be
>> > > > maintained going forward.
>> > > >
>> > > > This is not about documentation, it is about responsibility.
>> > > >
>> > > > Honestly, I don't think I'm the right maintainer to apply the patch
>> > > > introducing this code and then handle bug reports regarding it and so
>> > > > on.  That has to be done by somebody else.
>> > >
>> > > I'm working on ACPI for years and upstreamed the ARM64 ACPI core
>> > > support (with lots of people's help), I'm willing to maintain the ARM64
>> > > ACPI code under drivers/acpi/ if no objections.
>> >
>> > OK
>>
>> I would ask you please to add Sudeep and myself for the ARM64 specific
>> ACPI code maintainership too.
>
> OK

For this, it seems we have a decision now, so I will post  v7 tomorrow
following this decision:
drivers/acpi/arm64/acpi_gtdt.c

I think that is a very good idea, I also believe Hanjun can maintain it well.

>
>> > Can the ARM64-specific code go under drivers/acpi/arm64/ then, for clarity?
>>
>> It can, but I do not understand why x86 should not have a separate
>> directory for all x86 specific stuff too then.
>
> It should. :-)
>
> It doesn't have it ATM, but that doesn't mean it's all OK.
>
> Well, some of the x86-specific stuff goes into arch/x86/kernel/acpi/, so it
> has something at least.
>
> In any case, IMO, if some code is only used by one architecture, it should be
> clear that this is the case, and moving that code into a separate directory
> helps to achieve that.
>
>> Anyway let's avoid these petty arguments, I agree there must be some
>> sort of ARM64 ACPI maintainership for the reasons you mentioned above.
>
> To avoid confusion on who's going to push stuff to Linus, I can do that,
> but it must be clear whose ACKs are needed for that to happen.  That may be
> one person or all of you, whatever you decide.
>
> I can take pull requests too if that's more convenient.
>
> Thanks,
> Rafael
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
