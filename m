From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: ACPI Source patches updated (20021022)
Date: Wed, 23 Oct 2002 11:02:22 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021023110222.A14630@sci.fi>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DF60@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DF60-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>; from andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Tue, Oct 22, 2002 at 07:19:33PM -0700
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 22, 2002 at 07:19:33PM -0700, Grover, Andrew wrote:
> Hi all,
> 
> New ACPI patches are now available on http://sf.net/projects/acpi .
> Non-Linux source releases will be up by Thursday evening.

You didn't pick up my IRQ derive fix. Is it incorrect or did you just
miss it?

--- linux-2.4.20-pre7/drivers/acpi/pci_irq.c~   Thu Sep 19 17:17:58 2002
+++ linux-2.4.20-pre7/drivers/acpi/pci_irq.c    Tue Oct  8 01:45:29 2002
@@ -285,7 +285,7 @@
 	 * PCI interrupt routing entry (a.k.a. the "bridge swizzle").
 	 */
 	while (!irq && (bridge = bridge->bus->self)) {
-		pin = (pin + PCI_SLOT(bridge->devfn)) % 4;
+		pin = (pin + PCI_SLOT(dev->devfn)) % 4;
 		irq = acpi_pci_irq_lookup(0, bridge->bus->number, PCI_SLOT(bridge->devfn), pin);
 	}
 

-- 
Ville Syrjälä
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
