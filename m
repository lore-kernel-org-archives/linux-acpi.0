From: Nico Schottelius <nico-kernel-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org>
Subject: Re: [nico-kernel-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org: [BUG] pdc202xx_new and ACPI fails]
Date: Tue, 7 Dec 2004 18:35:32 +0100
Message-ID: <20041207173531.GA2289@schottelius.org>
References: <16A54BF5D6E14E4D916CE26C9AD30575B640E1@pdsmsx402.ccr.corp.intel.com> <F7DC2337C7631D4386A2DF6E8FB22B30022F857C@hdsmsx401.amr.corp.intel.com> <20041205211754.GB7695@schottelius.org> <1102286168.2308.13.camel@d845pe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575B640E1-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org> <F7DC2337C7631D4386A2DF6E8FB22B30022F857C-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org> <1102286168.2308.13.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Li, Shaohua [Tue, Dec 07, 2004 at 03:13:36PM +0800]:
> Yes, it should print something. Very strange. Let us check it with
> below:

Got it:

LSH-TEST:Found IRQ -1??

(rest is like everytime)

What to do now?

Nico

> [patch from Shaohua]
> +++ drivers/acpi/pci_irq.c   2004-12-07 15:05:38.709781248 +0800
> @@ -354,6 +354,13 @@ acpi_pci_irq_enable (
>          */
>         irq =3D acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
> &edge_level, &active_high_low);
>=20
> +       if (!irq) {
> +               printk("LSH-TEST:PCI interrupt %s[%c]: no GSI\n",
> +                       pci_name(dev), ('A' + pin));
> +               printk("LSH-TEST:BIOS assign IRQ %d\n", dev->irq);
> +       }else {
> +               printk("LSH-TEST:Found IRQ %d??\n", irq);
> +       }
>         /*
>          * If no PRT entry was found, we'll try to derive an IRQ from
> the

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQbXp4bOTBMvCUbrlAQIINg//dWRtPZL11/09y+zYVw8Xd6N85J9LJlQc
TGZYBh+MHOCE+Z6XUdTYyvTy6I6e+RobWUiPSsEPhpxV9MWeR4cH4tVdeNTSKtZm
U33VOcflVBckvDbRasFgauKS2n6qYaqbyLRfBObL5ETrgFJxz2le0N93e0SFXvoK
9t1AL7KCLHhhGY0TzlYfjkGOIP2HGNjGOsUlocH83rh/igjqTpe1LLmPBVlBKHuU
N/dcXUj+Y9t+P1+0BBcmnJCs6IqKcJwNWyJrFN9eOYB2Rg3R/sLv7Icbkdt/OiNm
Hgrbp/HfWSJtrezuvDYs4ePcuJRRmUCjE8+/l2npsA0NOlLPn3ApZZ7qixPYNJNW
4DvaO2yEtbIjyp9f4bqxN+2hAZ6q558T1jiLhqH18tKn1022UD3LCuJKV7YzUZBz
70otL+7QXjxBA4EKokqR8SAywJZA2GA9gH77dL5bBARpl0TBbc8bacsTz8Rtj0ir
Hwc4h/rl0wNCZqF5s73Ka7K6MDsFVrKBsXqnGZU+4EUPnd6YaaNo2tIHJYkrbYRv
AfSbX/KdmA+64qKF7v4Sy5oYWSeGih8fynvjyn/xYsgH2PmPXOI6PNI7COEFszQ+
BjoFpuVev5k+fMz+9V4o08JtCir15TTVhxlD6GZh9MUXVmd8N2f2penEJqxBrd6V
twf27wVK/Ew=
=RMyU
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
