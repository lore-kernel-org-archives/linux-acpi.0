From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: Re: Fixing ACPI compilation, fixing CONFIG_ACPI_BOOT
Date: 05 Aug 2002 23:27:37 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1028597611.1620.42.camel@darkstar.portugal>
References: <20020804185103.GA14972@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020804185103.GA14972-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!
I applied this patch in kernel 2.4.19
but what are you try to fix ?
boot parameters ?
if so what boot parameters can be used ?

pci=3Dnoacpi=20
gives again PCI: unknown option 'noacpi'

the only parameter that works is resume=3D/dev/hda5=20
when it is applied swusp patch.

I would like try =20
"pass pci=3Dnoacpi to the ACPI kernel"
I don't understand if this one boot parameter only for kernel 2.5.x or
if I am missing something or if shouldn't be acpi=3Dnopci ?.
I would like try this because since I put kernel (2.4.x) with
acpi20020726, I think: my pci hsf modem and connection to internet start
work badly, I am testing to find out where is the problem and try to
arrive to one conclusion.
Anyway this pci hsf modem serves to test pci irq routing.

  =20
thanks=20

S=E9rgiomb =20

=20
On Sun, 2002-08-04 at 14:51, Pavel Machek wrote:
> Hi!
>=20
> Here are patches to fix CONFIG_ACPI_BOOT. This is 3rd or so
> retransmit; I've seen no response at all. Please comment on the patch,
> or it is going directly to Linus.
>=20
> 								Pavel
>=20
>=20
> --- clean/arch/i386/kernel/acpi.c	Mon Jun  3 11:43:27 2002
> +++ linux-swsusp/arch/i386/kernel/acpi.c	Mon Jun 10 23:03:24 2002
> @@ -53,11 +53,9 @@
>                                Boot-time Configuration
>     ---------------------------------------------------------------------=
----- */
> =20
> -#ifdef CONFIG_ACPI_BOOT
> -
>  enum acpi_irq_model_id		acpi_irq_model;
> =20
> -
> +#ifdef CONFIG_ACPI_BOOT
>  /*
>   * Use reserved fixmap pages for physical-to-virtual mappings of ACPI ta=
bles.
>   * Note that the same range is used for each table, so tables that need =
to
> --- clean/include/linux/acpi.h	Mon Jun  3 11:43:38 2002
> +++ linux-swsusp/include/linux/acpi.h	Sun Aug  4 18:43:05 2002
> @@ -39,7 +39,7 @@
>  #include <asm/acpi.h>
> =20
> =20
> -#ifdef CONFIG_ACPI_BOOT
> +#ifdef CONFIG_ACPI
> =20
>  enum acpi_irq_model_id {
>  	ACPI_IRQ_MODEL_PIC =3D 0,
>=20




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
