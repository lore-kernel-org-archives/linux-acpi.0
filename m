From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: PROBLEM: Executing /sbin/hwclock hangs 2.4.21-rc[12]
	with ACPI snapshot patches
Date: 01 Jun 2003 15:35:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1054478150.1395.1.camel@darkstar.portugal>
References: <Pine.LNX.4.33.0306011606390.675-200000@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0306011606390.675-200000-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Ok thanks

so the patch can be forget it

S=E9rgio
On Sun, 2003-06-01 at 15:08, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Salut S=E9rgio,
> On 1 Jun 2003, S=E9rgio Monteiro Basto wrote:
> > I this is just a hint (of my imagination) ,
> > this isn't really a patch, it is the return back of
> > ACPI: Indicate whether we handled the interrupt or not.
> > that is been introduction in 20030424acpi.
> >
> > I try in my computer and works ok, but I don't have the problem of
> > hwclock
> > so if you try this patch and if it works. we can solve this problem
> > putting  this problematic boards on blacklist etc.
> > So can you try this patch and tell me something.
> >
> > Note: you just need apply this patch and
> > make bzImage;
> > and install it with:
> > make install.
> I had problems to apply the patch... maybe I was starting with the wrong
> kernel-source. I used the rc3-kernel together with the acpi-rc1-patch. I
> then applied as much of your patch as possible (see attachement, for what
> I applied).
> But I am sorry to say, that it did not cure the Ali (et al.)
> hwclock-/dev/rtc freezing.
> If you issue
>  hwclock --debug
> the last words it says are:
>  waiting for clock tick
>=20
> The problem with the freezing, that was introduced with acpi-rc1-patch is=
,
> that there are 5840 lines, that are the difference to the
> acpi-pre6-patch...
>=20
> Regards
>   hartwig felger
>=20
> Hartwig Felger informatics
>=20
> - --=20
> 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
> Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
> For the pulic keys, please visit my page.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
>=20
> iD8DBQE+2gjT9bBoTzOf1pMRAuv3AJ48tjzXCxuM/Kl3+gdo5cHq5ZfbagCdHpIH
> 2Uuk6igEfKvPC5FDqCVhKqw=3D
> =3DFmHJ
> -----END PGP SIGNATURE-----
> ----
>=20

> --- rc1/arch/i386/kernel/mpparse.c	2003-05-31 13:24:29.000000000 +0200
> +++ wk2/arch/i386/kernel/mpparse.c	2003-06-01 15:06:01.000000000 +0200
> @@ -1274,14 +1274,10 @@
>  	list_for_each(node, &acpi_prt.entries) {
>  		entry =3D list_entry(node, struct acpi_prt_entry, node);
> =20
> -		/* Need to get irq for dynamic entry */
> -		if (entry->link.handle) {
> -			irq =3D acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
> -			if (!irq)
> -				continue;
> -		}
> -		else
> -			irq =3D entry->link.index;
> +		/* We're only interested in static (non-link) entries. */
> +                if (entry->link.handle)
> +		  continue;
> +		irq =3D entry->link.index;
> =20
>  		ioapic =3D mp_find_ioapic(irq);
>  		if (ioapic < 0)
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
