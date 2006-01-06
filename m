From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: pnpacpi-handle-address-descriptors-in-_prs.patch
Date: Fri, 6 Jan 2006 11:31:23 -0700
Message-ID: <200601061131.23115.bjorn.helgaas@hp.com>
References: <20060102114839.2ea6bfa8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060102114839.2ea6bfa8.akpm-3NddpPZAyC0@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 02 January 2006 12:48, Andrew Morton wrote:
> Bjorn, the two attached patches need to be redone for some great renaming
> which has happened in the acpi tree.  I'll need to drop them, sorry.

Here's an updated version against 2.6.15-mm1.


From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

PNPACPI complained about and ignored devices with ADDRESS16, ADDRESS32, or
ADDRESS64 descriptors in _PRS.  HP firmware uses them for built-in serial
ports, so this patch adds support for parsing these descriptors from _PRS.

Note that this does not add the corresponding support for encoding them in
preparation for _SRS, because I don't have any machine that supports _SRS
on these descriptors, so I couldn't test that support.  Attempts to encode
them will cause a warning and an -EINVAL return.

Previous discussion:
    http://sourceforge.net/mailarchive/forum.php?thread_id=8250154&forum_id=6102

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>

Index: work-mm2/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work-mm2.orig/drivers/pnp/pnpacpi/rsparser.c	2006-01-05 17:27:19.000000000 -0700
+++ work-mm2/drivers/pnp/pnpacpi/rsparser.c	2006-01-06 10:50:56.000000000 -0700
@@ -453,6 +453,47 @@
 	return;
 }
 
+static void
+pnpacpi_parse_address_option(struct pnp_option *option, struct acpi_resource *r)
+{
+	struct acpi_resource_address64 addr, *p = &addr;
+	acpi_status status;
+	struct pnp_mem * mem;
+	struct pnp_port * port;
+
+	status = acpi_resource_to_address64(r, p);
+	if (!ACPI_SUCCESS(status)) {
+		pnp_warn("PnPACPI: failed to convert resource type %d",
+			r->type);
+		return;
+	}
+
+	if (p->address_length == 0)
+		return;
+
+	if (p->resource_type == ACPI_MEMORY_RANGE) {
+		mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+		if (!mem)
+			return;
+		mem->min = mem->max = p->minimum;
+		mem->size = p->address_length;
+		mem->align = 0;
+		mem->flags =
+		    (ACPI_READ_WRITE_MEMORY == p->info.mem.write_protect) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+		pnp_register_mem_resource(option,mem);
+	} else if (p->resource_type == ACPI_IO_RANGE) {
+		port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+		if (!port)
+			return;
+		port->min = port->max = p->minimum;
+		port->size = p->address_length;
+		port->align = 0;
+		port->flags = PNP_PORT_FLAG_FIXED;
+		pnp_register_port_resource(option,port);
+	}
+}
+
 struct acpipnp_parse_option_s {
 	struct pnp_option *option;
 	struct pnp_option *option_independent;
@@ -495,6 +536,11 @@
 			pnpacpi_parse_fixed_mem32_option(option,
 				&res->data.fixed_memory32);
 			break;
+		case ACPI_RESOURCE_TYPE_ADDRESS16:
+		case ACPI_RESOURCE_TYPE_ADDRESS32:
+		case ACPI_RESOURCE_TYPE_ADDRESS64:
+			pnpacpi_parse_address_option(option, res);
+			break;
 		case ACPI_RESOURCE_TYPE_START_DEPENDENT:
 			switch (res->data.start_dpf.compatibility_priority) {
 				case ACPI_GOOD_CONFIGURATION:
@@ -568,11 +614,9 @@
 	case ACPI_RESOURCE_TYPE_MEMORY24:
 	case ACPI_RESOURCE_TYPE_MEMORY32:
 	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
-#if 0
 	case ACPI_RESOURCE_TYPE_ADDRESS16:
 	case ACPI_RESOURCE_TYPE_ADDRESS32:
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
-#endif
 		(*res_cnt) ++;
 	default:
 		return AE_OK;
@@ -593,11 +637,9 @@
 	case ACPI_RESOURCE_TYPE_MEMORY24:
 	case ACPI_RESOURCE_TYPE_MEMORY32:
 	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
-#if 0
 	case ACPI_RESOURCE_TYPE_ADDRESS16:
 	case ACPI_RESOURCE_TYPE_ADDRESS32:
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
-#endif
 		(*resource)->type = res->type;
 		(*resource)++;
 	default:
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
