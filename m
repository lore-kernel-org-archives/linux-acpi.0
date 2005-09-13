From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Subject: Re: [patch 5/5] PNPACPI: clean blacklist
Date: Tue, 13 Sep 2005 11:34:01 +0200
Message-ID: <43269D09.506@free.fr>
References: <59D45D057E9702469E5775CBB56411F165A95B@pdsmsx406>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090705000502060003080902"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <59D45D057E9702469E5775CBB56411F165A95B@pdsmsx406>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: akpm-3NddpPZAyC0@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090705000502060003080902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shaohua,

Li, Shaohua wrote:
> Hi matthieu,
> 
>>From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>

> PNPACPI will call an 'acpi_register_gsi' for device's IRQ. If you remove
> PIC/TIMER from the list, their irq will be called. It sounds not safe to
> me, especially, in the ioapic mode.
Yes, I remembered this yesterday. I started to try to understand how 
work acpi_register_gsi and if it was safe.

I was wondering if we shouln't call it only when a driver register the 
device (to do something like pci_enable), but it will need pnp layer 
modification.

I updated the patch in order to keep PIC and TIMER.

> It's meaningless to export PCI root to PNP layer to me. Could we remove
> it?
I know, but it is already in pnpbios and I believe we should only put 
device that are problematic.

Thanks,

Matthieu

--------------090705000502060003080902
Content-Type: text/x-patch;
 name="pnpacpi_clean_blacklist.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi_clean_blacklist.patch"

Index: linux-2.6.13rc/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux-2.6.13rc.orig/drivers/pnp/pnpacpi/core.c	2005-08-28 19:26:35.000000000 +0200
+++ linux-2.6.13rc/drivers/pnp/pnpacpi/core.c	2005-09-13 11:31:15.000000000 +0200
@@ -27,12 +27,15 @@
 
 static int num = 0;
 
+/* We need only to blacklist devices that have already an acpi driver that
+ * can't use pnp layer. We don't need to blacklist device that are directly
+ * used by the kernel (PCI root, ...), as it is harmless and there were
+ * already present in pnpbios. But there is an exception for devices that
+ * have irqs (PIC, Timer) because we call acpi_register_gsi.
+ * Finaly only devices that have a CRS method need to be in this list.
+ */
 static char __initdata excluded_id_list[] =
-	"PNP0C0A," /* Battery */
-	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
 	"PNP0C09," /* EC */
-	"PNP0C0B," /* Fan */
-	"PNP0A03," /* PCI root */
 	"PNP0C0F," /* Link device */
 	"PNP0000," /* PIC */
 	"PNP0100," /* Timer */

--------------090705000502060003080902--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
