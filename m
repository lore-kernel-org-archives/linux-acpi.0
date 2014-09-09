From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 09/17] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Tue, 9 Sep 2014 11:22:56 +0100
Message-ID: <20140909102256.GB27786@leverpostej>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-10-git-send-email-hanjun.guo@linaro.org>
 <20140903172138.GG1824@e102568-lin.cambridge.arm.com>
 <5408854B.9010703@linaro.org>
 <540E7A4C.7050401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40068 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753366AbaIIKXA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2014 06:23:00 -0400
Content-Disposition: inline
In-Reply-To: <540E7A4C.7050401@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jon Masters <jcm@redhat.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>

On Tue, Sep 09, 2014 at 04:55:56AM +0100, Jon Masters wrote:
> Hi Hanjun, Lorenzo,
> 
> On 09/04/2014 11:29 AM, Hanjun Guo wrote:
> 
> > Hi Lorenzo,
> 
> >>> +	} else {
> >>> +		/* Fist GICC entry must be BSP as ACPI spec said */
> >> s/Fist/First/
> >>
> >>> +		if  (cpu_logical_map(0) != mpidr) {
> >>> +			pr_err("First GICC entry is not BSP for MPIDR 0x%llx\n",
> >>> +			       mpidr);
> >>> +			return -EINVAL;
> >>> +		}
> >> Interesting, this means that if I want to change the boot CPU I have to
> >> recompile the ACPI tables. Is that really true ?
> 
> Well, the ACPI5.1 specification does require that the PEs (cores) be
> listed in a very specific order, with the boot CPU first, and then a
> precisely defined sequence of interleaving of any possible SMT threads
> with other cores. So I think you would in practice update your tables.

That'll be fun if we ever want to do a kexec from a CPU other than the
BSP (where logical CPU0 may be arbitrary), but perhaps that's
inadvisable for other reasons?

Regardless, we should make a lot of noise if the spec says one thing and
the platform does another. Is there any other way of distinguishing the
BSP from the APs?

> >>> +	/*
> >>> +	 * ACPI 5.1 only has two explicit methods to boot up SMP,
> >>> +	 * PSCI and Parking protocol, but the Parking protocol is
> >>> +	 * only specified for ARMv7 now, so make PSCI as the only
> >>> +	 * way for the SMP boot protocol before some updates for
> >>> +	 * the ACPI spec or the Parking protocol spec.
> >>> +	 */
> 
> The Parking Protocol may be updated for a (limited) number of platforms
> that may use it in the early days. The preferred option (as described in
> the SBBR) is to use PSCI when at all possible. Some implementations of
> the architecture may not be able to use PSCI for MP-Boot. Thus while
> there may be some limited early use of the parking protocol (including
> while PSCI firmware is being finalized during bringup activities), it
> will ultimately be completely replaced by PSCI based boot over time.

I would expect that any platform with EL3 uses PSCI. It's fundamentally
stupid to use the parking protocol if your platform does have EL3, and
barely adviseable if your platform does not.

Mark.
