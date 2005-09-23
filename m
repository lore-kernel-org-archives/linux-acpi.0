From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] PNPACPI: handle address descriptors in _PRS
Date: Fri, 23 Sep 2005 10:06:35 -0600
Message-ID: <200509231006.35547.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

PNPACPI complained about and ignored devices with ADDRESS16, ADDRESS32, or
ADDRESS64 descriptors in _PRS.  HP firmware uses them for built-in serial
ports, so this patch adds support for parsing these descriptors from _PRS.

Note that this does not add the corresponding support for encoding them
in preparation for _SRS, because I don't have any machine that supports
_SRS on these descriptors, so I couldn't test that support.  Attempts to
encode them will cause a warning and an -EINVAL return.

Previous discussion:
    http://sourceforge.net/mailarchive/forum.php?thread_id=8250154&forum_id=6102

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: work-vga2/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work-vga2.orig/drivers/pnp/pnpacpi/rsparser.c	2005-09-20 16:12:47.000000000 -0600
+++ work-vga2/drivers/pnp/pnpacpi/rsparser.c	2005-09-23 09:45:37.000000000 -0600
@@ -453,6 +453,45 @@
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
+		pnp_warn("PnPACPI: failed to convert resource type %d", r->id);
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
+		mem->min = mem->max = p->min_address_range;
+		mem->size = p->address_length;
+		mem->align = 0;
+		mem->flags = (p->attribute.memory.read_write_attribute ==
+		    ACPI_READ_WRITE_MEMORY) ? IORESOURCE_MEM_WRITEABLE : 0;
+		pnp_register_mem_resource(option,mem);
+	} else if (p->resource_type == ACPI_IO_RANGE) {
+		port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+		if (!port)
+			return;
+		port->min = port->max = p->min_address_range;
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
@@ -495,6 +534,11 @@
 			pnpacpi_parse_fixed_mem32_option(option,
 				&res->data.fixed_memory32);
 			break;
+		case ACPI_RSTYPE_ADDRESS16:
+		case ACPI_RSTYPE_ADDRESS32:
+		case ACPI_RSTYPE_ADDRESS64:
+			pnpacpi_parse_address_option(option, res);
+			break;
 		case ACPI_RSTYPE_START_DPF:
 			switch (res->data.start_dpf.compatibility_priority) {
 				case ACPI_GOOD_CONFIGURATION:
@@ -568,11 +612,9 @@
 	case ACPI_RSTYPE_MEM24:
 	case ACPI_RSTYPE_MEM32:
 	case ACPI_RSTYPE_FIXED_MEM32:
-#if 0
 	case ACPI_RSTYPE_ADDRESS16:
 	case ACPI_RSTYPE_ADDRESS32:
 	case ACPI_RSTYPE_ADDRESS64:
-#endif
 		(*res_cnt) ++;
 	default:
 		return AE_OK;
@@ -593,11 +635,9 @@
 	case ACPI_RSTYPE_MEM24:
 	case ACPI_RSTYPE_MEM32:
 	case ACPI_RSTYPE_FIXED_MEM32:
-#if 0
 	case ACPI_RSTYPE_ADDRESS16:
 	case ACPI_RSTYPE_ADDRESS32:
 	case ACPI_RSTYPE_ADDRESS64:
-#endif
 		(*resource)->id = res->id;
 		(*resource)++;
 	default:


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
