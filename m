From: rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Subject: [patch 2/2] x86_64: Collect host bridge resources
Date: Fri, 20 May 2005 17:42:41 -0700
Message-ID: <20050521004506.842235000@csdlinux-1>
References: <20050521004239.581618000@csdlinux-1>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=x86_64-host-bridge-resources.patch
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ak-l3A5Bk7waGM@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This patch reads and stores host bridge resources reported by
ACPI BIOS for x86_64 systems. This is needed since ACPI hotplug
code now uses the PCI core for resource management. This patch
simply adds the boot parameter (acpi=root_resources) to enable
the functionality that is implemented in arch/i386.

Signed-off-by: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Index: linux-2.6.12-rc4-mm2/include/asm-x86_64/acpi.h
===================================================================
--- linux-2.6.12-rc4-mm2.orig/include/asm-x86_64/acpi.h
+++ linux-2.6.12-rc4-mm2/include/asm-x86_64/acpi.h
@@ -143,10 +143,16 @@ static inline void acpi_disable_pci(void
 	acpi_noirq_set();
 }
 extern int acpi_irq_balance_set(char *str);
+extern int acpi_read_root_resources;
+static inline void acpi_set_read_root_resources(void)
+{
+	acpi_read_root_resources = 1;
+}
 #else
 static inline void acpi_noirq_set(void) { }
 static inline void acpi_disable_pci(void) { }
 static inline int acpi_irq_balance_set(char *str) { return 0; }
+static inline void acpi_set_read_root_resources(void) { }
 #endif
 
 #ifdef CONFIG_ACPI_SLEEP
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/setup.c
@@ -319,6 +319,9 @@ static __init void parse_cmdline_early (
 			acpi_disable_pci();
 		else if (!memcmp(from, "acpi=noirq", 10))
 			acpi_noirq_set();
+		/* Use ACPI to read host bridge resources */
+		else if (!memcmp(from, "acpi=root_resources", 19))
+			acpi_set_read_root_resources();
 
 		else if (!memcmp(from, "acpi_sci=edge", 13))
 			acpi_sci_flags.trigger =  1;

--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
