From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v9 12/21] ACPI / table: Print GIC information when MADT
 is parsed
Date: Fri, 6 Mar 2015 18:06:36 +0000
Message-ID: <20150306180636.GB26888@e102568-lin.cambridge.arm.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-13-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60726 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462AbbCFSGn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Mar 2015 13:06:43 -0500
Content-Disposition: inline
In-Reply-To: <1424853601-6675-13-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi@lists.linaro.

On Wed, Feb 25, 2015 at 08:39:52AM +0000, Hanjun Guo wrote:
> When MADT is parsed, print GIC information as debug message:
> 
> ACPI: GICC (acpi_id[0x0000] address[00000000e112f000] MPIDR[0x0] enabled)
> ACPI: GICC (acpi_id[0x0001] address[00000000e112f000] MPIDR[0x1] enabled)
> ...
> ACPI: GICC (acpi_id[0x0201] address[00000000e112f000] MPIDR[0x201] enabled)
> 
> Those debug information will be very helpful to bring up early systems to
> see if acpi_id and MPIDR are matched or not as spec defined.

Nit: "This debug information"

> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> ---
>  drivers/acpi/tables.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index f4e5b88..2e19189 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -185,6 +185,28 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		}
>  		break;
>  
> +	case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
> +		{
> +			struct acpi_madt_generic_interrupt *p =
> +				(struct acpi_madt_generic_interrupt *)header;
> +			pr_debug("GICC (acpi_id[0x%04x] address[%llx] MPIDR[0x%llx] %s)\n",
> +				 p->uid, p->base_address,
> +				 p->arm_mpidr,
> +				 (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> +
> +		}
> +		break;
> +
> +	case ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR:
> +		{
> +			struct acpi_madt_generic_distributor *p =
> +				(struct acpi_madt_generic_distributor *)header;
> +			pr_debug("GIC Distributor (gic_id[0x%04x] address[%llx] gsi_base[%d])\n",
> +				 p->gic_id, p->base_address,
> +				 p->global_irq_base);
> +		}
> +		break;
> +
>  	default:
>  		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
>  			header->type);
> -- 
> 1.9.1
> 
> 
