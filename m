From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: [PATCH] IRQ derive fix
Date: Tue, 8 Oct 2002 01:53:51 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021008015351.A16060@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This fixes the IRQ routing for my AGP slot. I'm not sure it's correct but
at least it works and the IO APIC code does things this way. Now my G400
get's the IRQ assigned by the BIOS.

--- linux-2.4.20-pre7/drivers/acpi/pci_irq.c~   Thu Sep 19 17:17:58 2002
+++ linux-2.4.20-pre7/drivers/acpi/pci_irq.c    Tue Oct  8 01:45:29 2002
@@ -285,7 +285,7 @@
         * PCI interrupt routing entry (a.k.a. the "bridge swizzle").
         */
        while (!irq && (bridge = bridge->bus->self)) {
-               pin = (pin + PCI_SLOT(bridge->devfn)) % 4;
+               pin = (pin + PCI_SLOT(dev->devfn)) % 4;
                irq = acpi_pci_irq_lookup(0, bridge->bus->number, PCI_SLOT(bridge->devfn), pin);
        }

-- 
Ville Syrjälä
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
