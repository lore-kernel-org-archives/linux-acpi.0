From: Takayoshi Kochi <t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org>
Subject: Re: 2.6.8-rc2 acpi numa warnings
Date: Thu, 29 Jul 2004 10:44:37 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040729.104437.78704661.t-kochi@bq.jp.nec.com>
References: <26489.1090140921@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <26489.1090140921-1LO6/iIh+iQ0n/F98K4Iww@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kaos-sJ/iWh9BUns@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Len,

Please apply the attached patch to prevent warning messages
in drivers/acpi/numa.c.  Reported by Keith Owens.
This applies to 2.6.8-rc2 or 2.6.8-rc2-mm1.

From: Keith Owens <kaos-sJ/iWh9BUns@public.gmane.org>
Subject: 2.6.8-rc2 acpi numa warnings
Date: Sun, 18 Jul 2004 18:55:21 +1000

> Building 2.6.8-rc2 for ia64 NUMA gets these warnings.
> 
> drivers/acpi/numa.c: In function `acpi_table_print_srat_entry':
> drivers/acpi/numa.c:55: warning: unused variable `p'
> drivers/acpi/numa.c:65: warning: unused variable `p'
> drivers/acpi/numa.c: In function `acpi_numa_init':
> drivers/acpi/numa.c:179: warning: passing arg 2 of `acpi_table_parse_srat' from incompatible pointer type
> drivers/acpi/numa.c:182: warning: passing arg 2 of `acpi_table_parse_srat' from incompatible pointer type
> 

Signed-off-by: Takayoshi Kochi <t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org>

--- linux-2.6.7.orig/drivers/acpi/numa.c	2004-07-28 21:55:43.694641000 +0900
+++ linux-2.6.7/drivers/acpi/numa.c	2004-07-28 22:07:45.154962520 +0900
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
+#endif /* ACPI_DEBUG_OUTPUT */
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
+#endif /* ACPI_DEBUG_OUTPUT */
 		break;
 
 	default:
@@ -103,7 +107,9 @@
 
 
 static int __init
-acpi_parse_processor_affinity (acpi_table_entry_header *header)
+acpi_parse_processor_affinity (
+	acpi_table_entry_header *header,
+	const unsigned long end)
 {
 	struct acpi_table_processor_affinity *processor_affinity;
 
@@ -121,7 +127,9 @@
 
 
 static int __init
-acpi_parse_memory_affinity (acpi_table_entry_header *header)
+acpi_parse_memory_affinity (
+	acpi_table_entry_header *header,
+	const unsigned long end)
 {
 	struct acpi_table_memory_affinity *memory_affinity;
 


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
