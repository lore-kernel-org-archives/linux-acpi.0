From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: [PATCH] cleanup ACPI numa warnings
Date: Fri, 20 Aug 2004 12:55:51 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1093028151.4993.42.camel@tdi>
References: <1091738798.22406.9.camel@tdi>
	 <1091739702.31490.245.camel@nighthawk><1091741142.22406.28.camel@tdi>
	 <249150000.1091763309@[10.10.2.4]>
	 <20040805205059.3fb67b71.rddunlap@osdl.org>
	 <20040807105729.6adea633.pj@sgi.com>
	 <20040808143631.7c18cae9.rddunlap@osdl.org>
	 <2550950000.1092019997@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <2550950000.1092019997@[10.10.2.4]>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Martin J. Bligh" <mbligh-/CzTsIfkJEdBDgjK7y7TUQ@public.gmane.org>
Cc: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>, Paul Jackson <pj-sJ/iWh9BUns@public.gmane.org>, haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


   I'm not sure where we stand on this, sorry for the delay.  To recap,
the first patch I submitted cleaned up the original functions, but moved
the ugliness up into multi-line macros.  People didn't like the macros
and suggested static inlines.  However, static inlines don't work for
this application because the debug print needs state setup by the
ACPI_FUNCTION_NAME call.  IMHO, it's not worth setting up that state in
the static inline function for this little bit of cleanup.

   So, I think we left it at nobody liked the macros and static inlines
don't work.  General unhappiness.  Below is a patch that doesn't attempt
to cleanup the original code, it just adds the #ifdefs and range
checking w/ no macros.  Does this look better?  Below is the original
submit comment outlining the goal.  Thanks,

	Alex

   The patch below removes these warnings:

  CC      drivers/acpi/numa.o
drivers/acpi/numa.c: In function `acpi_table_print_srat_entry':
drivers/acpi/numa.c:55: warning: unused variable `p'
drivers/acpi/numa.c:65: warning: unused variable `p'
drivers/acpi/numa.c: In function `acpi_numa_init':
drivers/acpi/numa.c:179: warning: passing arg 2 of
`acpi_table_parse_srat' from incompatible pointer type
drivers/acpi/numa.c:182: warning: passing arg 2 of
`acpi_table_parse_srat' from incompatible pointer type

And propagates the MADT error checking code into the SRAT code.

Signed-off-by: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>

===== drivers/acpi/numa.c 1.10 vs edited =====
--- 1.10/drivers/acpi/numa.c	2004-02-18 02:19:31 -07:00
+++ edited/drivers/acpi/numa.c	2004-08-10 16:58:37 -06:00
@@ -51,6 +51,7 @@
 	switch (header->type) {
 
 	case ACPI_SRAT_PROCESSOR_AFFINITY:
+#ifdef ACPI_DEBUG_OUTPUT
 	{
 		struct acpi_table_processor_affinity *p =
 			(struct acpi_table_processor_affinity*) header;
@@ -58,9 +59,11 @@
 		       p->apic_id, p->lsapic_eid, p->proximity_domain,
 		       p->flags.enabled?"enabled":"disabled"));
 	}
+#endif
 		break;
 
 	case ACPI_SRAT_MEMORY_AFFINITY:
+#ifdef ACPI_DEBUG_OUTPUT
 	{
 		struct acpi_table_memory_affinity *p =
 			(struct acpi_table_memory_affinity*) header;
@@ -70,6 +73,7 @@
 		       p->flags.enabled ? "enabled" : "disabled",
 		       p->flags.hot_pluggable ? " hot-pluggable" : ""));
 	}
+#endif
 		break;
 
 	default:
@@ -103,12 +107,14 @@
 
 
 static int __init
-acpi_parse_processor_affinity (acpi_table_entry_header *header)
+acpi_parse_processor_affinity (acpi_table_entry_header *header, unsigned long size)
 {
 	struct acpi_table_processor_affinity *processor_affinity;
 
 	processor_affinity = (struct acpi_table_processor_affinity*) header;
-	if (!processor_affinity)
+	if (!processor_affinity || (unsigned long)processor_affinity +
+	    sizeof(*processor_affinity) > size ||
+	    header->length != sizeof(*processor_affinity))
 		return -EINVAL;
 
 	acpi_table_print_srat_entry(header);
@@ -121,12 +127,14 @@
 
 
 static int __init
-acpi_parse_memory_affinity (acpi_table_entry_header *header)
+acpi_parse_memory_affinity (acpi_table_entry_header *header, unsigned long size)
 {
 	struct acpi_table_memory_affinity *memory_affinity;
 
 	memory_affinity = (struct acpi_table_memory_affinity*) header;
-	if (!memory_affinity)
+	if (!memory_affinity || (unsigned long)memory_affinity +
+	    sizeof(*memory_affinity) > size ||
+	    header->length != sizeof(*memory_affinity))
 		return -EINVAL;
 
 	acpi_table_print_srat_entry(header);





-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
