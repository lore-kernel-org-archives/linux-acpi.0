From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Thu, 7 Jul 2016 14:40:23 +0100
Message-ID: <20160707134023.GA655@red-moon>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <CAJZ5v0iFUH3CgN2d1t8V13aRYdibiZSy+26sNLz3E-8mNvsn6Q@mail.gmail.com>
 <baf8e09d-0249-9da2-1a78-aac3bc35b8b5@linaro.org>
 <1890708.ZTyM2PUGdP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36543 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbcGGNji (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Jul 2016 09:39:38 -0400
Content-Disposition: inline
In-Reply-To: <1890708.ZTyM2PUGdP@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Fu Wei <fu.wei@linaro.org>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd

[+Sudeep]

On Thu, Jul 07, 2016 at 02:03:17PM +0200, Rafael J. Wysocki wrote:

[...]

> > >> So is this a documentation issue in which case Fu Wei can add that to
> > >> the file to explain its limited to ARM64. Or we could even rename the
> > >> file acpi_arm64_gtdt.c
> > >>
> > >> It seems a pity as the comment on this series were minors to block
> > >> things on a filename/location.
> > >
> > > Let me repeat what I said above:
> > >
> > > I'm mostly concerned about how (and by whom) that code is going to be
> > > maintained going forward.
> > >
> > > This is not about documentation, it is about responsibility.
> > >
> > > Honestly, I don't think I'm the right maintainer to apply the patch
> > > introducing this code and then handle bug reports regarding it and so
> > > on.  That has to be done by somebody else.
> > 
> > I'm working on ACPI for years and upstreamed the ARM64 ACPI core
> > support (with lots of people's help), I'm willing to maintain the ARM64
> > ACPI code under drivers/acpi/ if no objections.
> 
> OK

I would ask you please to add Sudeep and myself for the ARM64 specific
ACPI code maintainership too.

> Can the ARM64-specific code go under drivers/acpi/arm64/ then, for clarity?

It can, but I do not understand why x86 should not have a separate
directory for all x86 specific stuff too then.

Anyway let's avoid these petty arguments, I agree there must be some
sort of ARM64 ACPI maintainership for the reasons you mentioned above.

> > > That's one thing.
> > >
> > > Another one is the question I asked a few messages ago: Why having the
> > > GTDT code in drivers/acpi/ is actually useful to anyone?  It
> > > definitely would not be useful to me as the maintainer of
> > > drivers/acpi/, but maybe it would be useful to somebody for a specific
> > > practical reason.  Or is it just "let's put this into drivers/acpi/
> > > for the lack of a better place"?

The same logic applies to eg ioapic.c but anyway, see above, if it
can help having a separate subdirectory let's do it.

> > Having GTDT code in drivers/acpi/ is useful as it is code that is used
> > by two different subsystems, clocksource and watchdog,and where people
> > look by default for utility ACPI code.
> > 
> > If the mostly concerned thing (maintainer ship) is settled down, the
> > second question would be easily solved.

See above.

Thanks,
Lorenzo
