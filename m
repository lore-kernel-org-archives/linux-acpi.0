From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: RFC: ACPI table overflow handling
Date: Mon, 12 Jan 2004 09:24:06 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401120924.06881.bjorn.helgaas@hp.com>
References: <16381.27904.580087.442358@gargle.gargle.HOWL> <200401080920.04906.bjorn.helgaas@hp.com> <yq0ad4uimm7.fsf@wildopensource.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <yq0ad4uimm7.fsf-UC6nUKlm/0l5V+5IkYBVeNBPR1lH4CV8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jes Sorensen <jes-UC6nUKlm/0l5V+5IkYBVeNBPR1lH4CV8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, jbarnes-sJ/iWh9BUns@public.gmane.org, steiner-sJ/iWh9BUns@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 11 January 2004 7:30 am, Jes Sorensen wrote:
> +++ linux-2.6.0-test11-ia64/arch/ia64/kernel/acpi.c	Sun Jan 11 05:15:22 2004
> -	if (acpi_table_parse_madt(ACPI_MADT_IOSAPIC, acpi_parse_iosapic) < 1)
> +	if (acpi_table_parse_madt(ACPI_MADT_IOSAPIC, acpi_parse_iosapic, 256) < 1)

The "256" looks like it's based on the "iosapic_lists[256]" definition.
We probably should introduce a #define for those cases (sorry, I should
have noticed this the first time).

> +++ linux-2.6.0-test11-ia64/arch/x86_64/kernel/acpi/boot.c	Sun Jan 11 05:31:58 2004
> +	result = acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr, NR_IRQ_VECTORS);
>...
> +	result = acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src,
> +				       NO_IRQ_VECTORS);

Is NO_IRQ_VECTORS a typo for NR_IRQ_VECTORS?

> +++ linux-2.6.0-test11-ia64/drivers/acpi/numa.c	Thu Jan  8 02:49:24 2004
>  acpi_table_parse_srat (
>  	enum acpi_srat_entry_id	id,
> -	acpi_madt_entry_handler	handler)
> +	acpi_madt_entry_handler	handler,
> +	int max_entries)

Should "max_entries" be unsigned?  I notice you used unsigned types in the
implementation, i.e., "count".

Bjorn



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
