From: Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>
Subject: ACPI with CONFIG_PCI turned off
Date: Wed, 5 Mar 2003 16:01:29 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030306000129.GF18785@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I recently tried compiling ACPI w/o CONFIG_PCI turned on for debugging
purposes and only ran into a few small problems.  Here's a patch
against 2.5.60-ia64 that works for me, but I'm not sure if it's
entirely correct as this is my first time messing with the code.

Thanks,
Jesse


diff -Naur -X /usr/people/jbarnes/dontdiff linux-2.5.60-ia64-sn/arch/ia64/kernel/acpi.c work-sn2/arch/ia64/kernel/acpi.c
--- linux-2.5.60-ia64-sn/arch/ia64/kernel/acpi.c	Mon Feb 24 12:27:12 2003
+++ work-sn2/arch/ia64/kernel/acpi.c	Sat Mar  1 12:38:05 2003
@@ -825,6 +825,7 @@
 /* --------------------------------------------------------------------------
                              PCI Interrupt Routing
    -------------------------------------------------------------------------- */
+#ifdef CONFIG_PCI
 
 int __init
 acpi_get_prt (struct pci_vector_struct **vectors, int *count)
@@ -866,7 +867,7 @@
 	*count = acpi_prt.count;
 	return 0;
 }
-
+#endif
 /* Assume IA64 always use I/O SAPIC */
 
 int __init
diff -Naur -X /usr/people/jbarnes/dontdiff linux-2.5.60-ia64-sn/drivers/acpi/osl.c work-sn2/drivers/acpi/osl.c
--- linux-2.5.60-ia64-sn/drivers/acpi/osl.c	Mon Feb 24 12:27:12 2003
+++ work-sn2/drivers/acpi/osl.c	Sat Mar  1 13:12:41 2003
@@ -534,7 +534,7 @@
 
 acpi_status
 acpi_os_write_pci_configuration (
-	acpi_pci_id             *pci_id,
+	struct acpi_pci_id      *pci_id,
 	u32                     reg,
 	acpi_integer            value,
 	u32                     width)
@@ -544,13 +544,22 @@
 
 acpi_status
 acpi_os_read_pci_configuration (
-	acpi_pci_id             *pci_id,
+	struct acpi_pci_id      *pci_id,
 	u32                     reg,
 	void                    *value,
 	u32                     width)
 {
 	return (AE_SUPPORT);
 }
+
+void
+acpi_os_derive_pci_id (
+	acpi_handle		rhandle,        /* upper bound  */
+	acpi_handle		chandle,        /* current node */
+	struct acpi_pci_id	**id)
+{
+	return (AE_SUPPORT);
+}
 
 #endif /*CONFIG_ACPI_PCI*/
 


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
