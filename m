From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 3/4] PNPACPI: handle address descriptors in _PRS
Date: Fri, 28 Oct 2005 15:01:43 -0700
Message-ID: <200510282201.j9SM1PUp021817@shell0.pdx.osdl.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


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
---

 drivers/pnp/pnpacpi/rsparser.c |   48 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 44 insertions(+), 4 deletions(-)

diff -puN drivers/pnp/pnpacpi/rsparser.c~pnpacpi-handle-address-descriptors-in-_prs drivers/pnp/pnpacpi/rsparser.c
--- 25/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-handle-address-descriptors-in-_prs	Fri Oct 28 15:01:33 2005
+++ 25-akpm/drivers/pnp/pnpacpi/rsparser.c	Fri Oct 28 15:01:33 2005
@@ -453,6 +453,45 @@ pnpacpi_parse_fixed_mem32_option(struct 
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
@@ -495,6 +534,11 @@ static acpi_status pnpacpi_option_resour
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
@@ -568,11 +612,9 @@ static acpi_status pnpacpi_count_resourc
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
@@ -593,11 +635,9 @@ static acpi_status pnpacpi_type_resource
 	case ACPI_RSTYPE_MEM24:
 	case ACPI_RSTYPE_MEM32:
 	case ACPI_RSTYPE_FIXED_MEM32:
-#if 0
 	case ACPI_RSTYPE_ADDRESS16:
 	case ACPI_RSTYPE_ADDRESS32:
 	case ACPI_RSTYPE_ADDRESS64:
-#endif
 		(*resource)->type = res->type;
 		(*resource)++;
 	default:
_


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
