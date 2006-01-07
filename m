From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: + pnpacpi-handle-address-descriptors-in-_prs-2.patch added to -mm tree
Date: Sat, 7 Jan 2006 05:23:02 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A1336C@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: akpm-3NddpPZAyC0@public.gmane.org, bjorn.helgaas-VXdhtT5mjnY@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

applied to acpi-test, both before and after the acpica re-name --
so this is on the train to linus even if the interpreter
update gets side-tracked.

thanks,
-len  

>-----Original Message-----
>From: akpm-3NddpPZAyC0@public.gmane.org [mailto:akpm-3NddpPZAyC0@public.gmane.org] 
>Sent: Saturday, January 07, 2006 2:10 AM
>To: bjorn.helgaas-VXdhtT5mjnY@public.gmane.org; Brown, Len; mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: + pnpacpi-handle-address-descriptors-in-_prs-2.patch 
>added to -mm tree
>
>
>The patch titled
>
>     pnpacpi: handle address descriptors in _prs
>
>has been added to the -mm tree.  Its filename is
>
>     pnpacpi-handle-address-descriptors-in-_prs-2.patch
>
>
>From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
>
>PNPACPI complained about and ignored devices with ADDRESS16, 
>ADDRESS32, or
>ADDRESS64 descriptors in _PRS.  HP firmware uses them for 
>built-in serial
>ports, so this patch adds support for parsing these 
>descriptors from _PRS.
>
>Note that this does not add the corresponding support for 
>encoding them in
>preparation for _SRS, because I don't have any machine that 
>supports _SRS
>on these descriptors, so I couldn't test that support.  
>Attempts to encode
>them will cause a warning and an -EINVAL return.
>
>Previous discussion:
>    
>http://sourceforge.net/mailarchive/forum.php?thread_id=8250154&
>forum_id=6102
>
>Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
>Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
>---
>
> drivers/pnp/pnpacpi/rsparser.c |   50 ++++++++++++++++++++++++++++---
> 1 files changed, 46 insertions(+), 4 deletions(-)
>
>diff -puN 
>drivers/pnp/pnpacpi/rsparser.c~pnpacpi-handle-address-descripto
>rs-in-_prs-2 drivers/pnp/pnpacpi/rsparser.c
>--- 
>devel/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-handle-address-des
>criptors-in-_prs-2	2006-01-06 23:09:49.000000000 -0800
>+++ devel-akpm/drivers/pnp/pnpacpi/rsparser.c	2006-01-06 
>23:09:49.000000000 -0800
>@@ -453,6 +453,47 @@ pnpacpi_parse_fixed_mem32_option(struct 
> 	return;
> }
> 
>+static void
>+pnpacpi_parse_address_option(struct pnp_option *option, 
>struct acpi_resource *r)
>+{
>+	struct acpi_resource_address64 addr, *p = &addr;
>+	acpi_status status;
>+	struct pnp_mem * mem;
>+	struct pnp_port * port;
>+
>+	status = acpi_resource_to_address64(r, p);
>+	if (!ACPI_SUCCESS(status)) {
>+		pnp_warn("PnPACPI: failed to convert resource type %d",
>+			r->type);
>+		return;
>+	}
>+
>+	if (p->address_length == 0)
>+		return;
>+
>+	if (p->resource_type == ACPI_MEMORY_RANGE) {
>+		mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
>+		if (!mem)
>+			return;
>+		mem->min = mem->max = p->minimum;
>+		mem->size = p->address_length;
>+		mem->align = 0;
>+		mem->flags =
>+		    (ACPI_READ_WRITE_MEMORY == 
>p->info.mem.write_protect) ?
>+			IORESOURCE_MEM_WRITEABLE : 0;
>+		pnp_register_mem_resource(option,mem);
>+	} else if (p->resource_type == ACPI_IO_RANGE) {
>+		port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
>+		if (!port)
>+			return;
>+		port->min = port->max = p->minimum;
>+		port->size = p->address_length;
>+		port->align = 0;
>+		port->flags = PNP_PORT_FLAG_FIXED;
>+		pnp_register_port_resource(option,port);
>+	}
>+}
>+
> struct acpipnp_parse_option_s {
> 	struct pnp_option *option;
> 	struct pnp_option *option_independent;
>@@ -495,6 +536,11 @@ static acpi_status pnpacpi_option_resour
> 			pnpacpi_parse_fixed_mem32_option(option,
> 				&res->data.fixed_memory32);
> 			break;
>+		case ACPI_RESOURCE_TYPE_ADDRESS16:
>+		case ACPI_RESOURCE_TYPE_ADDRESS32:
>+		case ACPI_RESOURCE_TYPE_ADDRESS64:
>+			pnpacpi_parse_address_option(option, res);
>+			break;
> 		case ACPI_RESOURCE_TYPE_START_DEPENDENT:
> 			switch 
>(res->data.start_dpf.compatibility_priority) {
> 				case ACPI_GOOD_CONFIGURATION:
>@@ -568,11 +614,9 @@ static acpi_status pnpacpi_count_resourc
> 	case ACPI_RESOURCE_TYPE_MEMORY24:
> 	case ACPI_RESOURCE_TYPE_MEMORY32:
> 	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
>-#if 0
> 	case ACPI_RESOURCE_TYPE_ADDRESS16:
> 	case ACPI_RESOURCE_TYPE_ADDRESS32:
> 	case ACPI_RESOURCE_TYPE_ADDRESS64:
>-#endif
> 		(*res_cnt) ++;
> 	default:
> 		return AE_OK;
>@@ -593,11 +637,9 @@ static acpi_status pnpacpi_type_resource
> 	case ACPI_RESOURCE_TYPE_MEMORY24:
> 	case ACPI_RESOURCE_TYPE_MEMORY32:
> 	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
>-#if 0
> 	case ACPI_RESOURCE_TYPE_ADDRESS16:
> 	case ACPI_RESOURCE_TYPE_ADDRESS32:
> 	case ACPI_RESOURCE_TYPE_ADDRESS64:
>-#endif
> 		(*resource)->type = res->type;
> 		(*resource)++;
> 	default:
>_
>
>Patches currently in -mm which might be from bjorn.helgaas-VXdhtT5mjnY@public.gmane.org are
>
>pnpacpi-handle-address-descriptors-in-_prs-2.patch
>dev-mem-__have_phys_mem_access_prot-tidy-up.patch
>dev-mem-validate-mmap-requests.patch
>ia64-drop-arch-specific-ide-max_hwifs-definition.patch
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
