From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 3/6] x86: Minimize SRAT messages
Date: Sat, 19 Feb 2011 17:51:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1102191725150.27722@chino.kir.corp.google.com>
References: <20110219024705.308511527@gulag1.americas.sgi.com> <20110219024705.828947738@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110219024705.828947738@gulag1.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 18 Feb 2011, Mike Travis wrote:

> Condense the SRAT: messages to show all APIC id's for the
> node on a single line.
> 
> v1: Added pertinent __init & __initdata specifiers.
> v2: updated to apply to x86-tip
> 
> Signed-off-by: Mike Travis <travis@sgi.com>
> Reviewed-by: Jack Steiner <steiner@sgi.com>
> Reviewed-by: Robin Holt <holt@sgi.com>
> ---
>  arch/x86/mm/srat_64.c |   22 ++++++++++++++++++----
>  drivers/acpi/numa.c   |    3 +++
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> --- linux.orig/arch/x86/mm/srat_64.c
> +++ linux/arch/x86/mm/srat_64.c
> @@ -110,6 +110,12 @@ void __init acpi_numa_slit_init(struct a
>  	memblock_x86_reserve_range(phys, phys + length, "ACPI SLIT");
>  }
>  
> +/*
> + * Keep track of previous node and PXM values to reduce clutter
> + * in message and reduce the byte count in the kernel log.
> + */
> +static int __initdata last_node = -1, last_pxm = -1;

NUMA_NO_NODE and PXM_INVAL, respectively?

> +
>  /* Callback for Proximity Domain -> x2APIC mapping */
>  void __init
>  acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
> @@ -141,8 +147,17 @@ acpi_numa_x2apic_affinity_init(struct ac
>  	set_apicid_to_node(apic_id, node);
>  	node_set(node, cpu_nodes_parsed);
>  	acpi_numa = 1;
> -	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u\n",
> -	       pxm, apic_id, node);
> +	if (node != last_node) {
> +		pr_info("SRAT: Node %u: PXM:APIC %u:%u",
> +		       node, pxm, apic_id);
> +		last_node = node;
> +		last_pxm = pxm;
> +	} else if (pxm != last_pxm) {
> +		pr_cont(" %u:%u", pxm, apic_id);
> +		last_pxm = pxm;
> +	} else {
> +		pr_cont(" :%u", apic_id);
> +	}
>  }
>  
>  /* Callback for Proximity Domain -> LAPIC mapping */
> @@ -301,8 +316,7 @@ acpi_numa_memory_affinity_init(struct ac
>  			nd->end = end;
>  	}
>  
> -	printk(KERN_INFO "SRAT: Node %u PXM %u %lx-%lx\n", node, pxm,
> -	       start, end);
> +	pr_info("SRAT: Node %u PXM %u %lx+%lx\n", node, pxm, start, end-start);

I still don't see the benefit of printing the length rather than the end 
address.  We care about the range of memory that this node and pxm 
represent, not its size.

>  
>  	if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
>  		update_nodes_add(node, start, end);
> --- linux.orig/drivers/acpi/numa.c
> +++ linux/drivers/acpi/numa.c
> @@ -286,6 +286,9 @@ int __init acpi_numa_init(void)
>  	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
>  		acpi_table_parse_srat(ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY,
>  				     acpi_parse_x2apic_affinity, 0);
> +		/* insure trailing newline is output */
> +		pr_cont("\n");

Same two comments as first patch.

> +
>  		acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
>  				     acpi_parse_processor_affinity, 0);
>  		ret = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
