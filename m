From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: 2.6.12-rc4-mm2
Date: Tue, 24 May 2005 01:45:43 -0700
Message-ID: <20050524014543.49dd3159.akpm@osdl.org>
References: <20050516021302.13bd285a.akpm@osdl.org>
	<1116447964.23209.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1116447964.23209.26.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexander Nyberg <alexn-auIyqT/O9BSzQB+pC5nmwQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Alexander Nyberg <alexn-auIyqT/O9BSzQB+pC5nmwQ@public.gmane.org> wrote:
>
> m=E5n 2005-05-16 klockan 02:13 -0700 skrev Andrew Morton:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc=
4/2.6.12-rc4-mm2/
> >=20
> >=20
> > - davem has set up a mm-commits mailing list so people can review things
> >   which are added to or removed from the -mm tree.  Do
> >=20
> > 	echo subscribe mm-commits | mail majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >=20
> > - x86_64 architecture update from Andi.
> >=20
> > - Everything up to and including `spurious-interrupt-fix.patch' is plan=
ned
> >   for 2.6.12 merging.  Plus a few other things in there.
> >=20
> > - Another DVB subsystem update
> >=20
>=20
> I need this to be able to compile on x64 without CONFIG_ACPI (yeah it's
> probably wrong all the way, but can someone that knows acpi fix it
> please?). Tested on i386 & x64 w & w/o CONFIG_ACPI.
>=20

This breaks the build on ppc64 - pci/quirks.c includes acpi.h which now
wants asm/acpi.h which doesn't exist.

So I'll drop it.  Wanna take another look at the problem?

> Index: kexec/include/linux/acpi.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- kexec.orig/include/linux/acpi.h	2005-05-18 22:04:11.000000000 +0200
> +++ kexec/include/linux/acpi.h	2005-05-18 22:13:13.000000000 +0200
> @@ -25,8 +25,6 @@
>  #ifndef _LINUX_ACPI_H
>  #define _LINUX_ACPI_H
> =20
> -#ifdef CONFIG_ACPI
> -
>  #ifndef _LINUX
>  #define _LINUX
>  #endif
> @@ -419,6 +417,8 @@
> =20
>  #else	/*!CONFIG_ACPI_BOOT*/
> =20
> +static inline int acpi_boot_init (void) { return 0; }
> +static inline int acpi_boot_table_init (void) { return 0; }
>  #define acpi_mp_config	0
> =20
>  #endif 	/*!CONFIG_ACPI_BOOT*/
> @@ -531,18 +531,4 @@
> =20
>  extern int pnpacpi_disabled;
> =20
> -#else	/* CONFIG_ACPI */
> -
> -static inline int acpi_boot_init(void)
> -{
> -	return 0;
> -}
> -
> -static inline int acpi_boot_table_init(void)
> -{
> -	return 0;
> -}
> -
> -#endif	/* CONFIG_ACPI */
> -
>  #endif	/* _LINUX_ACPI_H */
>=20


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
