From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [update][PATCH v10 06/21] ACPI / sleep: Introduce CONFIG_ACPI_GENERIC_SLEEP
Date: Tue, 17 Mar 2015 15:30:04 +0100
Message-ID: <2398042.a98hWjBeFo@vostro.rjw.lan>
References: <1426234469-6434-1-git-send-email-hanjun.guo@linaro.org> <10995588.scpoK3KRg2@vostro.rjw.lan> <20150317123536.GB14984@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59826 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752816AbbCQOGL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2015 10:06:11 -0400
In-Reply-To: <20150317123536.GB14984@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "guohanjun@huawei.com" <guohanjun@huawei.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>"linux-kernel@vger.kernel.org" <li>

On Tuesday, March 17, 2015 12:35:36 PM Lorenzo Pieralisi wrote:
> On Tue, Mar 17, 2015 at 03:23:11AM +0000, Rafael J. Wysocki wrote:
> 
> [...]
> 
> > > Do you mean remove CONFIG_ACPI_GENERIC_SLEEP and
> > > 
> > > +acpi-$(CONFIG_ACPI_SLEEP) += sleep.o
> > > 
> > > as well (also need to remove duplicate #ifdef CONFIG_ACPI_SLEEP in sleep.c if
> > > we doing so)?
> > 
> > Well, almost.  There is one problem with that, becuase sleep.c contains code
> > outside of the ACPI_SLEEP-dependent blocks.  That code is used for powering
> > off ACPI platforms.
> > 
> > I guess you don't want that code on ARM too, right?
> > 
> > Perhaps we can use ACPI_REDUCED_HARDWARE_ONLY for that?  ARM64 will be the
> > only arch setting it at least for the time being, is that correct?
> 
> HW reduced only platforms are still required to support sleep
> states that on arm64 are totally meaningless at present, so I do
> not think ACPI_REDUCED_HARDWARE_ONLY will cut it.
> 
> Factoring out power_off methods from sleep.c ? I know, it is not nicer
> since you split the S-states management in multiple files.
> 
> Side note: is the acpi_suspend() function in sleep.c used in the kernel ?

No, it isn't.  I've just sent a patch to drop it.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
