From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [patch v11 09/23] ARM64 / ACPI: If we chose to boot from acpi
 then disable FDT
Date: Thu, 26 Mar 2015 10:57:46 +0000
Message-ID: <20150326105746.GA11095@red-moon>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-10-git-send-email-hanjun.guo@linaro.org>
 <20150325170027.GG14585@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52887 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbbCZK5l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Mar 2015 06:57:41 -0400
Content-Disposition: inline
In-Reply-To: <20150325170027.GG14585@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, Ashwin Chaugule <ashwinc@codeaurora.org>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, "msalter@redhat.com" <msalter@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holla@arm.c>

On Wed, Mar 25, 2015 at 05:00:27PM +0000, Catalin Marinas wrote:
> On Tue, Mar 24, 2015 at 10:02:42PM +0800, Hanjun Guo wrote:
> > If the early boot methods of acpi are happy that we have valid ACPI
> > tables and acpi=force has been passed, then do not unflat devicetree
> > effectively disabling further hardware probing from DT.
> [...]
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -390,7 +390,8 @@ void __init setup_arch(char **cmdline_p)
> >  
> >  	early_ioremap_reset();
> >  
> > -	unflatten_device_tree();
> > +	if (acpi_disabled)
> > +		unflatten_device_tree();
> 
> So if we have acpi=force but the acpi failed, do we have acpi_disabled
> set? Or this requires Lorenzo's patch?

Hanjun did not squash with this patch a later patch in the series that
caters for that, I reverted it and added my change on top to make things
simpler, it is all done.

Lorenzo
