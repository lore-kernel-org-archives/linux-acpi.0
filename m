From: Jesse Barnes <jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] quiet some ACPI boot messages
Date: Tue, 24 Aug 2004 15:20:08 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408241520.08211.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Y87KBBSLHwrjOTr"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_Y87KBBSLHwrjOTr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch kills a couple of NUMA related printks and makes the tables parsing 
ones use KERN_DEBUG instead of KERN_INFO since most people don't really care 
where their ACPI tables are located.

Signed-off-by: Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>

Thanks,
Jesse

--Boundary-00=_Y87KBBSLHwrjOTr
Content-Type: text/plain;
  charset="us-ascii";
  name="acpi-quiet.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi-quiet.patch"

===== drivers/acpi/numa.c 1.10 vs edited =====
--- 1.10/drivers/acpi/numa.c	2004-02-18 01:19:31 -08:00
+++ edited/drivers/acpi/numa.c	2004-08-24 15:16:12 -07:00
@@ -94,8 +94,6 @@
 	/* downcast just for %llu vs %lu for i386/ia64  */
 	localities = (u32) slit->localities;
 
-	printk(KERN_INFO PREFIX "SLIT localities %ux%u\n", localities, localities);
-
 	acpi_numa_slit_init(slit);
 
 	return 0;
@@ -147,8 +145,6 @@
 		return -EINVAL;
 
 	srat = (struct acpi_table_srat *) __va(phys_addr);
-
-	printk(KERN_INFO PREFIX "SRAT revision %d\n", srat->table_revision);
 
 	return 0;
 }
===== drivers/acpi/tables.c 1.25 vs edited =====
--- 1.25/drivers/acpi/tables.c	2004-06-30 08:45:45 -07:00
+++ edited/drivers/acpi/tables.c	2004-08-24 15:12:20 -07:00
@@ -101,7 +101,7 @@
 	else
 		name = header->signature;
 
-	printk(KERN_INFO PREFIX "%.4s (v%3.3d %6.6s %8.8s 0x%08x %.4s 0x%08x) @ 0x%p\n",
+	printk(KERN_DEBUG PREFIX "%.4s (v%3.3d %6.6s %8.8s 0x%08x %.4s 0x%08x) @ 0x%p\n",
 		name, header->revision, header->oem_id,
 		header->oem_table_id, header->oem_revision,
 		header->asl_compiler_id, header->asl_compiler_revision,
@@ -587,7 +587,7 @@
 		return -ENODEV;
 	}
 
-	printk(KERN_INFO PREFIX "RSDP (v%3.3d %6.6s                                    ) @ 0x%p\n",
+	printk(KERN_DEBUG PREFIX "RSDP (v%3.3d %6.6s                                ) @ 0x%p\n",
 		rsdp->revision, rsdp->oem_id, (void *) rsdp_phys);
 
 	if (rsdp->revision < 2)

--Boundary-00=_Y87KBBSLHwrjOTr--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
