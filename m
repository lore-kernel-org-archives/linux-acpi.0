From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 06/19] ARM64 / ACPI: Parse FADT table to get PSCI flags
 for PSCI init
Date: Wed, 20 Aug 2014 16:29:44 +0100
Message-ID: <20140820152944.GR24600@localhost>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-7-git-send-email-hanjun.guo@linaro.org>
 <20140820150029.0BB3FC41205@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:11109 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750916AbaHTPaI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Aug 2014 11:30:08 -0400
Content-Disposition: inline
In-Reply-To: <20140820150029.0BB3FC41205@trevor.secretlab.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@linaro.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.>

On Wed, Aug 20, 2014 at 04:00:28PM +0100, Grant Likely wrote:
> On Thu, 24 Jul 2014 21:00:12 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > @@ -345,13 +378,19 @@ int __init psci_init(void)
> >  	const struct of_device_id *matched_np;
> >  	psci_initcall_t init_fn;
> >  
> > -	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
> > +	if (acpi_disabled) {
> > +		np = of_find_matching_node_and_match(NULL,
> > +				psci_of_match, &matched_np);
> >  
> > -	if (!np)
> > -		return -ENODEV;
> > +		if (!np)
> > +			return -ENODEV;
> > +
> > +		init_fn = (psci_initcall_t)matched_np->data;
> > +
> > +		return init_fn(np);
> > +	}
> >  
> > -	init_fn = (psci_initcall_t)matched_np->data;
> > -	return init_fn(np);
> > +	return psci_0_2_init_acpi();
> >  }
> 
> So, while the functionality is sound, this is kind of a stinky diff. The
> ACPI path should not push the OF code into a sub branch. Make it look
> like this instead (with the advantage that the diff will be simpler):
> 
> +	if (IS_ENABLED(CONFIG_ACPI) && !acpi_disabled)
> +		return psci_0_2_init_acpi();

Minor point: we should define acpi_disabled to 1 when !CONFIG_ACPI and
avoid additional IS_ENABLED(CONFIG_ACPI) checks (unless already don this
way).

-- 
Catalin
