From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 08/19] ACPI / table: Print GIC information when MADT is
 parsed
Date: Wed, 30 Jul 2014 19:21:41 +0100
Message-ID: <53D937B5.5040404@arm.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org> <1406206825-15590-9-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406206825-15590-9-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@linaro.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.or>
List-Id: linux-acpi@vger.kernel.org



On 24/07/14 14:00, Hanjun Guo wrote:
> When MADT is parsed, print GIC information to make the boot
> log look pretty.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> ---
>   drivers/acpi/tables.c |   39 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 6d5a6cd..8bb8159 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -183,6 +183,44 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>   		}
>   		break;
>
> +	case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
> +		{
> +			struct acpi_madt_generic_interrupt *p =
> +				(struct acpi_madt_generic_interrupt *)header;
> +			pr_info("GICC (acpi_id[0x%04x] cpu_address[0x%08llx] MPDIR[0x%llx] %s)\n",

What exactly does cpu_address mean ? Better s/cpu_address/address

> +				p->uid, p->base_address, p->mpidr,
> +				(p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> +
> +		}
> +		break;
> +
> +	case ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR:
> +		{
> +			struct acpi_madt_generic_distributor *p =
> +				(struct acpi_madt_generic_distributor *)header;
> +			pr_info("GIC Distributor (id[0x%04x] address[0x%08llx] gsi_base[%d])\n",
> +				p->gic_id, p->base_address, p->global_irq_base);
> +		}
> +		break;
> +
> +	case ACPI_MADT_TYPE_GIC_MSI_FRAME:
> +		{
> +			struct acpi_madt_gic_msi_frame *p =
> +				(struct acpi_madt_gic_msi_frame *)header;
> +			pr_info("GIC MSI Frame (address[0x%08llx] msi_fame_id[%d])\n",
> +				p->base_address, p->gic_msi_frame_id);
> +		}
> +		break;
> +
> +	case ACPI_MADT_TYPE_GIC_REDISTRIBUTOR:
> +		{
> +			struct acpi_madt_gic_redistributor *p =
> +				(struct acpi_madt_gic_redistributor *)header;
> +			pr_info("GIC Redistributor (address[0x%08llx] region_size[0x%x])\n",
> +				p->base_address, p->region_size);
> +		}
> +		break;
> +

You may need to rework on the variable names when you rebase on ACPICA 
20140724

Regards,
Sudeep
