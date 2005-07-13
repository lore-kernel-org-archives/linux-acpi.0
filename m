From: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: [01/11] If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.
Date: Wed, 13 Jul 2005 11:43:02 -0700
Message-ID: <20050713184302.GE9330@kroah.com>
References: <20050713184130.GA9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050713184130.GA9330-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: alexn-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Justin Forbes <jmforbes-a5Mqy2EUIFVAfugRpC6u6w@public.gmane.org>, Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Theodore Ts'o <tytso-3s7WtUTddSA@public.gmane.org>, "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Chuck Wolber <chuckw-lrwSPXAIdEw7YuNMryXyOw@public.gmane.org>, torvalds-3NddpPZAyC0@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

[resend to get threading correct, sorry]

-stable review patch.  If anyone has any objections, please let us know.

------------------

If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.
That zero just means that nothing else found any irq information either.

Fixes http://bugme.osdl.org/show_bug.cgi?id=4824

Signed-off-by: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
Signed-off-by: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
---
 drivers/acpi/pci_irq.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12.2.orig/drivers/acpi/pci_irq.c	2005-07-13 10:53:01.000000000 -0700
+++ linux-2.6.12.2/drivers/acpi/pci_irq.c	2005-07-13 10:56:30.000000000 -0700
@@ -433,7 +433,7 @@
 		printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: no GSI",
 			pci_name(dev), ('A' + pin));
 		/* Interrupt Line values above 0xF are forbidden */
-		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
+		if (dev->irq > 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
 			acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
 			return_VALUE(0);


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
