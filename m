From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v9 01/21] ACPI / table: Use pr_debug() instead of
 pr_info() for MADT table scanning
Date: Fri, 06 Mar 2015 12:31:16 -0800
Message-ID: <1425673876.12017.50.camel@perches.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
	 <1424853601-6675-2-git-send-email-hanjun.guo@linaro.org>
	 <20150306201718.9363CC40AA9@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150306201718.9363CC40AA9@trevor.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2015-03-06 at 20:17 +0000, Grant Likely wrote:
> On Wed, 25 Feb 2015 16:39:41 +0800 Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > This patch just use pr_debug() instead of pr_info() for ioapic/iosapic,
> > local apic/x2apic/sapic structures when scanning the MADT table to remove
> > those verbose information, but leave other structures unchanged.
[]
> One nitpick below, but don't respin over this, and don't do a fixup.
[]
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
[]
> > @@ -61,9 +63,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
> >  		{
> >  			struct acpi_madt_local_apic *p =
> >  			    (struct acpi_madt_local_apic *)header;
> > -			pr_info("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
> > -				p->processor_id, p->id,
> > -				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> > +			pr_debug("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
> > +				 p->processor_id, p->id,
> > +				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> 
> The whitespace changes makes each 1 line change into 3 line changes. In
> these situations, I would chose to leave the whitespace alone to keep
> the diffstat as small as possible. It makes it less likely to conflict
> with other patches and easier to find context.

I think it's mostly better to use a consistent indentation style
regardless of the number in whitespace changes surrounding the change.
