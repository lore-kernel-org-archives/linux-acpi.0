From: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] cleanup ACPI numa warnings
Date: Thu, 05 Aug 2004 14:01:43 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1091739702.31490.245.camel@nighthawk>
References: <1091738798.22406.9.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1091738798.22406.9.camel@tdi>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-08-05 at 13:46, Alex Williamson wrote:
> +#ifdef ACPI_DEBUG_OUTPUT
> +#define acpi_print_srat_processor_affinity(header) { \
> +	struct acpi_table_processor_affinity *p = \
> +	                      (struct acpi_table_processor_affinity*) header; \
> +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Processor (id[0x%02x] " \
> +	                 "eid[0x%02x]) in proximity domain %d %s\n", \
> +	                 p->apic_id, p->lsapic_eid, p->proximity_domain, \
> +	                 p->flags.enabled?"enabled":"disabled")); }
> +
> +#define acpi_print_srat_memory_affinity(header) { \
> +	struct acpi_table_memory_affinity *p = \
> +	                         (struct acpi_table_memory_affinity*) header; \
> +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Memory (0x%08x%08x length " \
> +	                 "0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",\
> +	                 p->base_addr_hi, p->base_addr_lo, p->length_hi, \
> +	                 p->length_lo, p->memory_type, p->proximity_domain, \
> +	                 p->flags.enabled ? "enabled" : "disabled", \
> +	                 p->flags.hot_pluggable ? " hot-pluggable" : "")); }

Is there a reason that this can't be a normal function instead of a
9-line #define?

-- Dave



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
