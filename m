From: ak-l3A5Bk7waGM@public.gmane.org (Andreas Kleen)
Subject: [1/34 submit] Eliminate some useless printks in ACPI numa.c
Date: Thu, 25 Nov 2004 15:39:58 +0100
Message-ID: <41A5EEBE.mailH6L11JTJT@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
To: andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Eliminate some useless printks in ACPI numa.c

They trigger all the time on x86-64 with CONFIG_ACPI_NUMA

Signed-off-by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>

Index: linux/drivers/acpi/numa.c
===================================================================
--- linux.orig/drivers/acpi/numa.c	2004-10-19 01:55:09.%N +0200
+++ linux/drivers/acpi/numa.c	2004-11-24 17:56:54.%N +0100
@@ -184,17 +184,10 @@
 		result = acpi_table_parse_srat(ACPI_SRAT_MEMORY_AFFINITY,
 					       acpi_parse_memory_affinity,
 					       NR_NODE_MEMBLKS);	// IA64 specific
-	} else {
-		/* FIXME */
-		printk("Warning: acpi_table_parse(ACPI_SRAT) returned %d!\n",result);
 	}
 
 	/* SLIT: System Locality Information Table */
 	result = acpi_table_parse(ACPI_SLIT, acpi_parse_slit);
-	if (result < 1) {
-		/* FIXME */
-		printk("Warning: acpi_table_parse(ACPI_SLIT) returned %d!\n",result);
-	}
 
 	acpi_numa_arch_fixup();
 	return 0;


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
