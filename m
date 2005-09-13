From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [patch 5/5] PNPACPI: clean blacklist
Date: Tue, 13 Sep 2005 16:17:54 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F165A95B@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: akpm-3NddpPZAyC0@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, castet.matthieu-GANU6spQydw@public.gmane.org, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi matthieu,
>
>From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
>
>Clean the blacklist.  Battery, Button, Fan don't have a CRS and should
be
>removed.  PCI root, PIC, Timer are in pnpbios and are harmless.
>
>Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>Cc: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
>Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
>---
>
> drivers/pnp/pnpacpi/core.c |   12 ++++++------
> 1 files changed, 6 insertions(+), 6 deletions(-)
>
>diff -puN drivers/pnp/pnpacpi/core.c~pnpacpi-clean-blacklist
>drivers/pnp/pnpacpi/core.c
>--- devel/drivers/pnp/pnpacpi/core.c~pnpacpi-clean-blacklist	2005-09-
>11 03:21:48.000000000 -0700
>+++ devel-akpm/drivers/pnp/pnpacpi/core.c	2005-09-11
03:21:48.000000000 -
>0700
>@@ -27,15 +27,15 @@
>
> static int num =3D 0;
>
>+/* We need only to blacklist device that have already an acpi driver
that
>+ * can't use pnp layer. We don't need to blacklist device that are
>directly
>+ * used by the kernel (PIC, Timer, ...), as it is harmless and there
were
>+ * already present in pnpbios. Finaly only devices that have a CRS
method
>+ * need to be in this list.
>+ */
> static char __initdata excluded_id_list[] =3D
>-	"PNP0C0A," /* Battery */
>-	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
> 	"PNP0C09," /* EC */
>-	"PNP0C0B," /* Fan */
>-	"PNP0A03," /* PCI root */
> 	"PNP0C0F," /* Link device */
>-	"PNP0000," /* PIC */
>-	"PNP0100," /* Timer */
PNPACPI will call an 'acpi_register_gsi' for device's IRQ. If you remove
PIC/TIMER from the list, their irq will be called. It sounds not safe to
me, especially, in the ioapic mode.
It's meaningless to export PCI root to PNP layer to me. Could we remove
it?
Others look good to me.

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
