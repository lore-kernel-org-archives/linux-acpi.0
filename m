From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: Re: [Discontig-devel] RE: Cleanup of NUMA support in ACPI
Date: Thu, 15 Aug 2002 18:32:59 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020816103143.KBBXC0A8264C.1C79D883@mvf.biglobe.ne.jp>
References: <20020815092003.JBWFC0A82650.6C9EC293@mvf.biglobe.ne.jp> <200208151758.05568.efocht@ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200208151758.05568.efocht-+HQ0pkNQ8fyELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: efocht-+HQ0pkNQ8fyELgA04lAiVw@public.gmane.org
Cc: discontig-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Erich,

The "ifdef SRAT_DEBUG"'s in arch/ia64/kernel/acpi.c arn't
necessary because arch-independent acpi_table_print_srat_entry()
function does this.

> +#ifdef SRAT_DEBUG
> +	printk("CPU %x in proximity domain %x %s\n",
> +	       pa->apic_id, pa->proximity_domain,
> +	       pa->flags.enabled ? "enabled" : "disabled");
> +#endif


> +#ifdef SRAT_DEBUG
> +	printk("Memory range 0x%lx to 0x%lx (type %x) in proximity domain %x %s\n",
> +	       paddr, paddr + size - 1,
> +	       ma->memory_type, ma->proximity_domain,
> +	       ma->flags.enabled ? (ma->flags.hot_pluggable ? 
> +				    "enabled and removable" : "enabled" )
> +	       : "disabled");
> +#endif

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
