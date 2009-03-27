From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] x86, acpi: add support for x2apic ACPI extensions
Date: Fri, 27 Mar 2009 18:20:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903271816420.26419@localhost.localdomain>
References: <1238013838.27006.435.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:8336 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758986AbZC0WUc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 18:20:32 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH60013URE2LSMB@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 17:20:27 -0500 (CDT)
In-reply-to: <1238013838.27006.435.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, mingo@elte.hu, hpa@linux.intel.com, steiner@sgi.com


On Wed, 25 Mar 2009, Suresh Siddha wrote:

> All logical processors with APIC ID values of 255 and greater will have their
> APIC reported through Processor X2APIC structure (type-9 entry type) and all
> logical processors with APIC ID less than 255 will have their APIC reported
> through legacy Processor Local APIC (type-0 entry type) only. This is the
> same case even for NMI structure reporting.
> 
> The Processor X2APIC Affinity structure provides the association between the
> X2APIC ID of a logical processor and the proximity domain to which the logical
> processor belongs.
> 
> For OSPM, Procssor IDs outside the 0-254 range are to be declared as Device()
> objects in the ACPI namespace.
> 
> Add support for these x2apic ACPI extensions.
> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> ---
> 
> Index: tip/arch/x86/kernel/acpi/boot.c
> ===================================================================
> --- tip.orig/arch/x86/kernel/acpi/boot.c
> +++ tip/arch/x86/kernel/acpi/boot.c
> @@ -230,6 +230,35 @@ static void __cpuinit acpi_register_lapi
>  }
>  
>  static int __init
> +acpi_parse_x2apic(struct acpi_subtable_header * header, const unsigned long end)
> +{
> +	struct acpi_madt_local_x2apic *processor = NULL;
> +
> +	processor = (struct acpi_madt_local_x2apic *)header;
> +
> +	if (BAD_MADT_ENTRY(processor, end))
> +		return -EINVAL;
> +
> +	acpi_table_print_madt_entry(header);
> +
> +#ifdef CONFIG_X86_X2APIC
> +	/*
> +	 * We need to register disabled CPU as well to permit
> +	 * counting disabled CPUs. This allows us to size
> +	 * cpus_possible_map more accurately, to permit
> +	 * to not preallocating memory for all NR_CPUS
> +	 * when we use CPU hotplug.
> +	 */
> +	acpi_register_lapic(processor->local_apic_id,	/* APIC ID */
> +			    processor->lapic_flags & ACPI_MADT_ENABLED);
> +#else
> +	printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
> +#endif
> +
> +	return 0;
> +}
> +
> +static int __init
>  acpi_parse_lapic(struct acpi_subtable_header * header, const unsigned long end)
>  {
>  	struct acpi_madt_local_apic *processor = NULL;
> @@ -289,6 +318,24 @@ acpi_parse_lapic_addr_ovr(struct acpi_su
>  }
>  
>  static int __init
> +acpi_parse_x2apic_nmi(struct acpi_subtable_header * header, const unsigned long end)
> +{
> +	struct acpi_madt_local_x2apic_nmi *x2apic_nmi = NULL;
> +
> +	x2apic_nmi = (struct acpi_madt_local_x2apic_nmi *)header;
> +
> +	if (BAD_MADT_ENTRY(x2apic_nmi, end))
> +		return -EINVAL;
> +
> +	acpi_table_print_madt_entry(header);
> +
> +	if (x2apic_nmi->lint != 1)
> +		printk(KERN_WARNING PREFIX "NMI not connected to LINT 1!\n");
> +
> +	return 0;
> +}
> +
> +static int __init
>  acpi_parse_lapic_nmi(struct acpi_subtable_header * header, const unsigned long end)
>  {
>  	struct acpi_madt_local_apic_nmi *lapic_nmi = NULL;
> @@ -816,9 +863,12 @@ static int __init acpi_parse_madt_lapic_
>  	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_SAPIC,
>  				      acpi_parse_sapic, MAX_APICS);
>  
> -	if (!count)
> +	if (!count) {
> +		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
> +					      acpi_parse_x2apic, MAX_APICS);
>  		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
>  					      acpi_parse_lapic, MAX_APICS);

I'm not fond of the idiom

count = a();
count = b();

if (count)...

here and below.

if we really don't care if the x2apic parse routines return,
and we always care what the traditional apic parse routines return,
we should have

a();
count = b();
...

Ingo, this one is probably more ACPI than it is x86 -- shall I handle it?

thanks,
-Len

