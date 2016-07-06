From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Wed, 6 Jul 2016 02:00:09 +0200
Message-ID: <CAJZ5v0iFUH3CgN2d1t8V13aRYdibiZSy+26sNLz3E-8mNvsn6Q@mail.gmail.com>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <57714bed-3f9c-90c2-ac30-2d462d8a06d4@linaro.org> <20160701152340.GO12735@arm.com>
 <2183745.J7YpvxXQ47@vostro.rjw.lan> <CAJZ5v0iFcjxQV9YV2KaXGAPRBM8M2xxPm5e2b4uhwYAZZtndPg@mail.gmail.com>
 <20160705141858.GD18338@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36247 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcGFAAM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jul 2016 20:00:12 -0400
In-Reply-To: <20160705141858.GD18338@xora-haswell.xora.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Will Deacon <will.deacon@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Fu Wei <fu.wei@linaro.org>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>

On Tue, Jul 5, 2016 at 4:18 PM, Graeme Gregory <gg@slimlogic.co.uk> wrote:
> On Mon, Jul 04, 2016 at 02:53:20PM +0200, Rafael J. Wysocki wrote:
>> On Fri, Jul 1, 2016 at 11:04 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Friday, July 01, 2016 04:23:40 PM Will Deacon wrote:
>> >> On Thu, Jun 30, 2016 at 09:48:02PM +0800, Hanjun Guo wrote:
>> >> > On 2016/6/30 21:27, Rafael J. Wysocki wrote:
>> >> > >On Thursday, June 30, 2016 10:10:02 AM Hanjun Guo wrote:
>> >> > >>GTDT is part of ACPI spec, drivers/acpi/ is for driver code of
>> >> > >>ACPI spec, I think it can stay in drivers/acpi/ from this point
>> >> > >>of view, am I right?
>> >> > >
>> >> > >The question is not "Can it?", but "Does it need to?".
>> >> > >
>> >> > >It is in the spec, but still there's only one architecture needing it.
>> >> > >
>> >> > >There is no way to test it on any other architecture and no reason to build it
>> >> > >for any other architecture, so why does it need to be located in drivers/acpi/ ?
>> >> >
>> >> > I'm fine to move it to other places such as arch/arm64/kernel/, but I
>> >> > would like to ask ARM64 maintainer's suggestion for this.
>> >> >
>> >> > Will, Catalin, what's your opinion on this?
>> >>
>> >> We don't have any device-tree code for the architected timer under
>> >> arch/arm64, so I don't see why we should need anything for ACPI either.
>> >
>> > And I don't see a reason for the GTDT code to be there in drivers/acpi/.
>> >
>> > What gives?
>>
>> Well, since there are things like acpi_lpss in there, my position here
>> is kind of weak. :-)
>>
>> That said I'm not particularly happy with having them in
>> drivers/acpi/, so I definitely won't object against attempts to moving
>> them somewhere else.
>>
>> > Maybe it should go to the same place as the analogus DT code, then?
>>
>> I'm mostly concerned about how (and by whom) that code is going to be
>> maintained going forward, though.  I also think it should be made
>> clear that it is ARM64-only.
>>
>
> So is this a documentation issue in which case Fu Wei can add that to
> the file to explain its limited to ARM64. Or we could even rename the
> file acpi_arm64_gtdt.c
>
> It seems a pity as the comment on this series were minors to block
> things on a filename/location.

Let me repeat what I said above:

I'm mostly concerned about how (and by whom) that code is going to be
maintained going forward.

This is not about documentation, it is about responsibility.

Honestly, I don't think I'm the right maintainer to apply the patch
introducing this code and then handle bug reports regarding it and so
on.  That has to be done by somebody else.

That's one thing.

Another one is the question I asked a few messages ago: Why having the
GTDT code in drivers/acpi/ is actually useful to anyone?  It
definitely would not be useful to me as the maintainer of
drivers/acpi/, but maybe it would be useful to somebody for a specific
practical reason.  Or is it just "let's put this into drivers/acpi/
for the lack of a better place"?

I have not received a good answer to this one yet.

Thanks,
Rafael
