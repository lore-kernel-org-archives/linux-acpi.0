From: Krzysztof Oledzki <olel-gcSpNFQc7Gg@public.gmane.org>
Subject: Re: PNP device interrupt type?
Date: Thu, 20 Oct 2005 14:28:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0510201419150.2000@bizon.gios.gov.pl>
References: <200509210916.51581.bjorn.helgaas@hp.com>
 <1127350552.3961.11.camel@linux-hp.sh.intel.com>
 <Pine.LNX.4.62.0510012142300.11416@bizon.gios.gov.pl>
 <1128908977.3955.1.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1468616658-1129811301=:2000"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1128908977.3955.1.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1468616658-1129811301=:2000
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Mon, 10 Oct 2005, Shaohua Li wrote:
<CUT>
> Sorry for the long delay. Does this workaround work for you?
>
> --- a/drivers/pnp/pnpacpi/rsparser.c=092005-10-10 09:25:31.000000000 +080=
0
> +++ b/drivers/pnp/pnpacpi/rsparser.c=092005-10-10 09:22:13.000000000 +080=
0
> @@ -89,6 +89,12 @@ pnpacpi_parse_allocated_irqresource(stru
> =09=09return;
>
> =09res->irq_resource[i].flags =3D IORESOURCE_IRQ;  // Also clears _UNSET =
flag
> +#ifdef CONFIG_X86
> +=09if (gsi < 16 && edge_level !=3D ACPI_EDGE_SENSITIVE) {
> +=09=09pnp_err("Legacy IRQ %d should be edge trigger\n", gsi);
> +=09=09edge_level =3D ACPI_EDGE_SENSITIVE;
> +=09}
> +#endif
> =09irq =3D acpi_register_gsi(gsi, edge_level, active_high_low);
> =09if (irq < 0) {
> =09=09res->irq_resource[i].flags |=3D IORESOURCE_DISABLED;
>
>

Sorry for the long delay, this patch requires 2.6.14-rc kernel so it=20
took me much longer to test it. And yes, it works for me. Thank you.

Patched 2.6.14-rc4 kernel logs:

* pnp: PnP ACPI init
* pnp: Legacy IRQ 8 should be edge trigger
*=20
* pnp: PnP ACPI: found 12 devices

Only one comment - we should remove this \n from the error message since=20
pnp_err adds it automatically:

=2E/linux/pnp.h:#define pnp_err(format, arg...) printk(KERN_ERR "pnp: " for=
mat "\n" , ## arg)

Are there any chances for putting this patch into 2.6.15?

Best regards,

 =09=09=09Krzysztof Ol=EAdzki
---187430788-1468616658-1129811301=:2000--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
