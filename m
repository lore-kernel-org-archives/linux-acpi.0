From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT support in arm_arch_timer
Date: Thu, 07 Jul 2016 15:58:04 +0200
Message-ID: <1603704.EGiVTcCxLR@vostro.rjw.lan>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org> <1890708.ZTyM2PUGdP@vostro.rjw.lan> <20160707134023.GA655@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63899 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751854AbcGGNx1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jul 2016 09:53:27 -0400
In-Reply-To: <20160707134023.GA655@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Fu Wei <fu.wei@linaro.org>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd

On Thursday, July 07, 2016 02:40:23 PM Lorenzo Pieralisi wrote:
> [+Sudeep]
> 
> On Thu, Jul 07, 2016 at 02:03:17PM +0200, Rafael J. Wysocki wrote:
> 
> [...]
> 
> > > >> So is this a documentation issue in which case Fu Wei can add that to
> > > >> the file to explain its limited to ARM64. Or we could even rename the
> > > >> file acpi_arm64_gtdt.c
> > > >>
> > > >> It seems a pity as the comment on this series were minors to block
> > > >> things on a filename/location.
> > > >
> > > > Let me repeat what I said above:
> > > >
> > > > I'm mostly concerned about how (and by whom) that code is going to be
> > > > maintained going forward.
> > > >
> > > > This is not about documentation, it is about responsibility.
> > > >
> > > > Honestly, I don't think I'm the right maintainer to apply the patch
> > > > introducing this code and then handle bug reports regarding it and so
> > > > on.  That has to be done by somebody else.
> > > 
> > > I'm working on ACPI for years and upstreamed the ARM64 ACPI core
> > > support (with lots of people's help), I'm willing to maintain the ARM64
> > > ACPI code under drivers/acpi/ if no objections.
> > 
> > OK
> 
> I would ask you please to add Sudeep and myself for the ARM64 specific
> ACPI code maintainership too.

OK

> > Can the ARM64-specific code go under drivers/acpi/arm64/ then, for clarity?
> 
> It can, but I do not understand why x86 should not have a separate
> directory for all x86 specific stuff too then.

It should. :-)

It doesn't have it ATM, but that doesn't mean it's all OK.

Well, some of the x86-specific stuff goes into arch/x86/kernel/acpi/, so it
has something at least.

In any case, IMO, if some code is only used by one architecture, it should be
clear that this is the case, and moving that code into a separate directory
helps to achieve that.

> Anyway let's avoid these petty arguments, I agree there must be some
> sort of ARM64 ACPI maintainership for the reasons you mentioned above.

To avoid confusion on who's going to push stuff to Linus, I can do that,
but it must be clear whose ACKs are needed for that to happen.  That may be
one person or all of you, whatever you decide.

I can take pull requests too if that's more convenient.

Thanks,
Rafael

