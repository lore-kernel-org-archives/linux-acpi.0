From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Fix compilation with CONFIG_ACPI_PCI off
Date: Thu, 20 Feb 2003 22:58:13 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030220215813.GA18394@elf.ucw.cz>
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
To: Rusty trivial patch monkey Russell <trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

This fixes compilation... Please apply,
						Pavel

--- linux/drivers/acpi/osl.c	2003-02-15 18:52:16.000000000 +0100
+++ linux-tablet/drivers/acpi/osl.c	2003-02-20 21:58:04.000000000 +0100
@@ -527,7 +534,7 @@
 
 acpi_status
 acpi_os_write_pci_configuration (
-	acpi_pci_id             *pci_id,
+	struct acpi_pci_id	*pci_id,
 	u32                     reg,
 	acpi_integer            value,
 	u32                     width)
@@ -537,7 +544,7 @@
 
 acpi_status
 acpi_os_read_pci_configuration (
-	acpi_pci_id             *pci_id,
+	struct acpi_pci_id      *pci_id,
 	u32                     reg,
 	void                    *value,
 	u32                     width)

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
