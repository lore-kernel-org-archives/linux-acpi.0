From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Abit KT7 IRQ routing
Date: Mon, 7 Oct 2002 01:48:59 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021007014859.A24132@sci.fi>
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

As I reported earlier my AGP card seems to get the wrong IRQ. It works but
one IRQ remains completely unused. I just turned on debugging in the PCI
code...

The AGP slot 01:00.0 doesn't have an entry in the PRT so the code will try
to derive it from the AGP bridge 00:01.0

I'm not sure this is relevant but I included it here anyway:
pci_irq-0318 [0001] [02] acpi_pci_irq_enable : No interrupt pin configured
for device 00:01.0

Here's the interesting output:
pci_irq-0242 [0001] [03] acpi_pci_irq_lookup   : Searching for PRT entry
for 00:01:00[A]
<snip>
pci_irq-0248 [0001] [03] acpi_pci_irq_lookup   : PRT entry not found
<snip>
pci_irq-0242 [0001] [04] acpi_pci_irq_lookup   : Searching for PRT entry
for 00:00:01[B]
            ^^^
Why does it think 01:00.0[A] == 00:01.0[B]? This is what causes it to get
the IRQ from LNKB instead of LNKA.

Looking at the code in pci_irq.c:

while (!irq && (bridge = bridge->bus->self)) {
  pin = (pin + PCI_SLOT(bridge->devfn)) % 4;
  irq = acpi_pci_irq_lookup(0, bridge->bus->number, PCI_SLOT(bridge->devfn), pin);
}

So it seems that PCI_SLOT(brigde->devfn) is doing something wrong.

Any ideas?


PS.
I "fixed" the ISA sound card + SCSI CDROM problem by using a PCI sound
card. Something ISA related gets configured in a funny manner with ACPI.

-- 
Ville Syrjälä
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
