From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 01/21] ACPI / table: Use pr_debug() instead of pr_info() for MADT table scanning
Date: Wed, 04 Mar 2015 23:33:32 +0100
Message-ID: <5472111.MIDVrBN6XB@vostro.rjw.lan>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <1424853601-6675-2-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58687 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753061AbbCDWJ5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2015 17:09:57 -0500
In-Reply-To: <1424853601-6675-2-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On Wednesday, February 25, 2015 04:39:41 PM Hanjun Guo wrote:
> For a normal 8 cpu sockets system, it will up to 240 cpu threads (Xeon E7
> v2 family for now), and we need 240 entries for local apic or local x2apic
> in MADT table, so it will be much verbose information printed with a slow
> uart console when system booted, this will be even worse with large system
> with 16/32 cpu sockets.
> 
> This patch just use pr_debug() instead of pr_info() for ioapic/iosapic,
> local apic/x2apic/sapic structures when scanning the MADT table to remove
> those verbose information, but leave other structures unchanged.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/tables.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 93b8152..f4e5b88 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -23,6 +23,8 @@
>   *
>   */
>  
> +/* Uncomment next line to get verbose printout */
> +/* #define DEBUG */
>  #define pr_fmt(fmt) "ACPI: " fmt
>  
>  #include <linux/init.h>
> @@ -61,9 +63,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		{
>  			struct acpi_madt_local_apic *p =
>  			    (struct acpi_madt_local_apic *)header;
> -			pr_info("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
> -				p->processor_id, p->id,
> -				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> +			pr_debug("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
> +				 p->processor_id, p->id,
> +				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
>  		}
>  		break;
>  
> @@ -71,9 +73,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		{
>  			struct acpi_madt_local_x2apic *p =
>  			    (struct acpi_madt_local_x2apic *)header;
> -			pr_info("X2APIC (apic_id[0x%02x] uid[0x%02x] %s)\n",
> -				p->local_apic_id, p->uid,
> -				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> +			pr_debug("X2APIC (apic_id[0x%02x] uid[0x%02x] %s)\n",
> +				 p->local_apic_id, p->uid,
> +				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
>  		}
>  		break;
>  
> @@ -81,8 +83,8 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		{
>  			struct acpi_madt_io_apic *p =
>  			    (struct acpi_madt_io_apic *)header;
> -			pr_info("IOAPIC (id[0x%02x] address[0x%08x] gsi_base[%d])\n",
> -				p->id, p->address, p->global_irq_base);
> +			pr_debug("IOAPIC (id[0x%02x] address[0x%08x] gsi_base[%d])\n",
> +				 p->id, p->address, p->global_irq_base);
>  		}
>  		break;
>  
> @@ -155,9 +157,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		{
>  			struct acpi_madt_io_sapic *p =
>  			    (struct acpi_madt_io_sapic *)header;
> -			pr_info("IOSAPIC (id[0x%x] address[%p] gsi_base[%d])\n",
> -				p->id, (void *)(unsigned long)p->address,
> -				p->global_irq_base);
> +			pr_debug("IOSAPIC (id[0x%x] address[%p] gsi_base[%d])\n",
> +				 p->id, (void *)(unsigned long)p->address,
> +				 p->global_irq_base);
>  		}
>  		break;
>  
> @@ -165,9 +167,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		{
>  			struct acpi_madt_local_sapic *p =
>  			    (struct acpi_madt_local_sapic *)header;
> -			pr_info("LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
> -				p->processor_id, p->id, p->eid,
> -				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> +			pr_debug("LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
> +				 p->processor_id, p->id, p->eid,
> +				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
>  		}
>  		break;
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
