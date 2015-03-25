From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch v11 12/23] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Wed, 25 Mar 2015 17:17:35 +0000
Message-ID: <20150325171735.GI14585@localhost>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-13-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427205776-5060-13-git-send-email-hanjun.guo@linaro.org>
Content-Disposition: inline
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
Cc: Mark Rutland <mark.rutland@arm.com>, linaro-acpi@lists.linaro.org, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, linux-acpi@vger.kernel.org, Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2015 at 10:02:45PM +0800, Hanjun Guo wrote:
> +/**
> + * acpi_map_gic_cpu_interface - generates a logical cpu number
> + * and map to MPIDR represented by GICC structure
> + * @mpidr: CPU's hardware id to register, MPIDR represented in MADT
> + * @enabled: this cpu is enabled or not
> + *
> + * Returns the logical cpu number which maps to MPIDR
> + */
> +static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled)

So here we have an u8 enabled.

> +static int __init
> +acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
> +				const unsigned long end)
> +{
> +	struct acpi_madt_generic_interrupt *processor;
> +
> +	processor = (struct acpi_madt_generic_interrupt *)header;
> +
> +	if (BAD_MADT_ENTRY(processor, end))
> +		return -EINVAL;
> +
> +	acpi_table_print_madt_entry(header);
> +
> +	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITMASK,
> +		processor->flags & ACPI_MADT_ENABLED);

and here processor->flags is u32. Luckily, ACPI_MADT_ENABLED is 1 and we
don't lose any information. So either make the enabled above a bool or
simply pass the flags with the check in acpi_map_gic_cpu_interface()
(personal preference for the latter).

Apart from this:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
