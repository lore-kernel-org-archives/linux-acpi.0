From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC part2 PATCH 2/9] ARM64 / ACPI: Prefill cpu
 possible/present maps and map logical cpu id to APIC id
Date: Tue, 3 Dec 2013 16:57:55 +0000
Message-ID: <20131203165755.37b07796@alan.etchedpixels.co.uk>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
 <1386088753-2850-3-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386088753-2850-3-git-send-email-hanjun.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linaro-kernel@lists.linaro.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, patches@linaro.org, Olof Johansson <olof@lixom.net>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, Jon Masters <jonathan@jonmasters.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org


> diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
> index 45ff625..8527ecc 100644
> --- a/drivers/acpi/plat/arm-core.c
> +++ b/drivers/acpi/plat/arm-core.c
> @@ -58,6 +58,13 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>   */
>  static u64 acpi_lapic_addr __initdata;
>  
> +/* available_cpus here means enabled cpu in MADT */
> +int available_cpus;
> +
> +/* Map logic cpu id to physical GIC id. */
> +int arm_cpu_to_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = -1 };
> +int boot_cpu_apic_id = -1;
> +

static ?

Really shouldn't be leaking names like "available_cpus" out of ACPI into
the global namespace


> +#ifdef CONFIG_SMP
> +	if (available_cpus == 0) {
> +		pr_info(PREFIX "Found 0 CPUs; assuming 1\n");
> +		/* FIXME: should be the real GIC id read from hardware */
> +		arm_cpu_to_apicid[available_cpus] = 0;
> +		available_cpus = 1;	/* We've got at least one of these */
> +	}
> +#endif

Isn't this true uniprocessor (by definition in fact)


> + */
> +void __init prefill_possible_map(void)

leaking more unprefixed names into the global namespace
