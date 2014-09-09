From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH v3 09/17] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Tue, 9 Sep 2014 11:46:49 +0100
Message-ID: <20140909104649.GJ6558@xora-haswell.xora.org.uk>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-10-git-send-email-hanjun.guo@linaro.org>
 <20140903172138.GG1824@e102568-lin.cambridge.arm.com>
 <5408854B.9010703@linaro.org>
 <540E7A4C.7050401@redhat.com>
 <20140909102256.GB27786@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.xora.org.uk ([80.68.91.202]:38032 "EHLO
	xora.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbaIIKqy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2014 06:46:54 -0400
Content-Disposition: inline
In-Reply-To: <20140909102256.GB27786@leverpostej>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jon Masters <jcm@redhat.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>Charles Garcia-Tobin <C>

On Tue, Sep 09, 2014 at 11:22:56AM +0100, Mark Rutland wrote:
> On Tue, Sep 09, 2014 at 04:55:56AM +0100, Jon Masters wrote:
> > Hi Hanjun, Lorenzo,
> > 
> > On 09/04/2014 11:29 AM, Hanjun Guo wrote:
> > 
> > > Hi Lorenzo,
> > 
> > >>> +	} else {
> > >>> +		/* Fist GICC entry must be BSP as ACPI spec said */
> > >> s/Fist/First/
> > >>
> > >>> +		if  (cpu_logical_map(0) != mpidr) {
> > >>> +			pr_err("First GICC entry is not BSP for MPIDR 0x%llx\n",
> > >>> +			       mpidr);
> > >>> +			return -EINVAL;
> > >>> +		}
> > >> Interesting, this means that if I want to change the boot CPU I have to
> > >> recompile the ACPI tables. Is that really true ?
> > 
> > Well, the ACPI5.1 specification does require that the PEs (cores) be
> > listed in a very specific order, with the boot CPU first, and then a
> > precisely defined sequence of interleaving of any possible SMT threads
> > with other cores. So I think you would in practice update your tables.
> 
> That'll be fun if we ever want to do a kexec from a CPU other than the
> BSP (where logical CPU0 may be arbitrary), but perhaps that's
> inadvisable for other reasons?
> 
> Regardless, we should make a lot of noise if the spec says one thing and
> the platform does another. Is there any other way of distinguishing the
> BSP from the APs?
> 

The x86 guys already found this and there is a work around in the
kernel. One of the patches that was acepted for 3.17 was my fix for the
workaround to make it not x86 specific.

Graeme

