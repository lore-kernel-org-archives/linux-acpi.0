From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT support in arm_arch_timer
Date: Sun, 10 Jul 2016 03:26:49 +0200
Message-ID: <3119857.QuQfKUSRGs@vostro.rjw.lan>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org> <20160708132201.GD3784@red-moon> <21ec2b0d-cde9-f86a-c39a-0fba5d02fd03@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44887 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756809AbcGJBWK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Jul 2016 21:22:10 -0400
In-Reply-To: <21ec2b0d-cde9-f86a-c39a-0fba5d02fd03@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Fu Wei <fu.wei@linaro.org>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.comA

On Saturday, July 09, 2016 11:44:47 AM Hanjun Guo wrote:
> On 2016/7/8 21:22, Lorenzo Pieralisi wrote:
> > On Thu, Jul 07, 2016 at 03:58:04PM +0200, Rafael J. Wysocki wrote:
> >
> > [...]
> >
> >>> Anyway let's avoid these petty arguments, I agree there must be some
> >>> sort of ARM64 ACPI maintainership for the reasons you mentioned above.
> >>
> >> To avoid confusion on who's going to push stuff to Linus, I can do
> >> that, but it must be clear whose ACKs are needed for that to happen.
> >> That may be one person or all of you, whatever you decide.
> >
> > I think the reasoning is the same, to avoid confusion and avoid stepping
> > on each other toes it is best to have a single gatekeeper (still
> > multiple maintainer entries to keep patches reviewed correctly), if no
> > one complains I will do that and a) provide ACKs (I will definitely
> > require and request Hanjun and Sudeep ones too appropriately on a per
> > patch basis) and b) send you pull requests.
> 
> Fine to me.
> 
> >
> > Having a maintainer per file would be farcical, I really do not
> 
> Agree, but having three of us in maintainer entries in MAINTAINERS
> file will help the patches be reviewed correctly with more eyes.
> 
> > expect that amount of traffic for drivers/acpi/arm64 therefore I
> > really doubt there is any risk of me slowing things down.
> >
> > Does this sound reasonable ? Comments/complaints welcome, please
> > manifest yourselves.
> 
> Fair enough. What I'm concern most is land ACPI on ARM64 soundly,
> let's do that :)
> 
> OK, let's back to this patch set, Fuwei already prepared a new version
> of patches [1] (moving acpi_gtdt.c to drivers/acpi/arm64/ and add a
> maintainer entries patch), shall we review and comment on this patch
> set for now, or just let Fuwei send out the new version?

Frankly, I don't see a point in discussing the old version only if a new
one is available already.  Post it, please.

Thanks,
Rafael

