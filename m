From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] Avoid loading of ACPI tables twice
Date: Mon, 06 Jun 2005 16:21:28 +0200
Message-ID: <42A45BE8.70500@suse.de>
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
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

CC'ing Venkatesh as the syslog output and symptoms look
similar to a speedstep-centrino bug (invoking _PDC twice).

I have a machine with following DSDT code:

Processor (CPU1, 0x01, 0x00000810, 0x06)
        {
            OperationRegion (SSDT, SystemMemory, 0x1DFD4050, 0x03CC)
            ...
            Method (_PDC, 1, NotSerialized)
            {
                ...
                Load (SSDT, HNDL)
                ...
            }
        }

The machine works fine using acpi-cpufreq.

If loading the speedstep-centrino module is tried, the _PDC function is invoked
and the SSDT is loaded a second time which results in:

linux kernel: ACPI: CPU0 (power states: C1[C1] C2[C2])
linux kernel: ACPI: Processor [CPU1] (supports 8 throttling states)
linux kernel:  dswload-0294: *** Error: Looking up [ACST] in namespace, AE_ALREADY_EXISTS
linux kernel:  psparse-0601 [20] ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS
linux kernel:  psparse-1140: *** Error: Method execution failed [\_PR_.CPU1._PDC] (Node ddfcd3a8), AE_ALREADY_EXISTS

and a kernel freeze with different backtraces later:
linux kernel: Unable to handle kernel paging request at virtual address XYZ

This patch worksarounds/fixes this problem on this machine.
Could someone have a look at it, please.

The OEM id of new tables is compared with already loaded once. Loading is
denied if the table already exists in the kernel's AML namespace.

--- drivers/acpi/namespace/nsload.c.orig        2005-06-03 05:40:58.000000000 -0600
+++ drivers/acpi/namespace/nsload.c     2005-06-06 07:51:24.000000000 -0600
@@ -45,7 +45,7 @@
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acdispat.h>
-
+#include <acpi/actables.h>

 #define _COMPONENT          ACPI_NAMESPACE
         ACPI_MODULE_NAME    ("nsload")
@@ -72,7 +72,8 @@
        struct acpi_namespace_node      *node)
 {
        acpi_status                     status;
-
+       struct acpi_table_desc          *table_desc_loaded;
+       int                             count;

        ACPI_FUNCTION_TRACE ("ns_load_table");

@@ -104,6 +105,19 @@
        }

        /*
+        * Check whether the table already exists - if yes, deny loading it again
+
+       for (count = 0;count < acpi_gbl_table_lists[table_desc->type].count; count++){
+               table_desc_loaded = acpi_gbl_table_lists[table_desc->type].next;
+               if (table_desc_loaded->loaded_into_namespace &&
+                   !memcmp(table_desc_loaded->pointer->oem_table_id, table_desc->pointer->oem_table_id, 8)){
+                       ACPI_REPORT_WARNING (("Table %s has already been loaded (not bad)\n",
+                                             table_desc->pointer->oem_table_id));
+                       return (AE_ALREADY_EXISTS);
+               }
+       }
+
+       /*
         * Parse the table and load the namespace with all named
         * objects found within.  Control methods are NOT parsed
         * at this time.  In fact, the control methods cannot be






     Thomas



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
