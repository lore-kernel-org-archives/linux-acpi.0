From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 05/18] ARM64 / ACPI: Parse FADT table to get PSCI
 flags for PSCI init
Date: Tue, 19 Aug 2014 12:10:00 +0100
Message-ID: <20140819111000.GG3302@leverpostej>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-6-git-send-email-hanjun.guo@linaro.org>
 <20140818142721.GR20043@localhost>
 <53F2C983.8000800@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53F2C983.8000800@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kerne>
List-Id: linux-acpi@vger.kernel.org

> >> @@ -47,6 +49,26 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
> >>  	early_memunmap(map, size);
> >>  }
> >>  
> >> +static int __init acpi_parse_fadt(struct acpi_table_header *table)
> >> +{
> >> +	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
> >> +
> >> +	/*
> >> +	 * Revision in table header is the FADT Major version,
> >> +	 * and there is a minor version of FADT which was introduced
> >> +	 * by ACPI 5.1, we only deal with ACPI 5.1 or higher version
> >> +	 * to get arm boot flags, or we will disable ACPI.
> >> +	 */
> >> +	if (table->revision < 5 || fadt->minor_revision < 1) {
> > 
> > If we ever get revision 6.0, this would trigger.
> 
> Yes, good catch, actually I already fixed that in my local git repo,
> 
> +       if (table->revision > 5 ||
> +           (table->revision == 5 && fadt->minor_revision >= 1)) {
> +               return 0;
> +       } else {
> +               pr_info("FADT revision is %d.%d, no PSCI support, should be 5.1
> or higher\n",
> +                       table->revision, fadt->minor_revision);
> +               disable_acpi();
> +               return -EINVAL;
> +       }

Given you return in the first path, you don't need the remaining code to
live in an else block.

Mark.
