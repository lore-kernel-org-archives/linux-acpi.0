From: mizu <michal-VaXaUECoPuY@public.gmane.org>
Subject: Re: [Solved] Re: power-off (Acer TM632)
Date: Tue, 1 Jun 2004 20:29:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040601182933.GA3046@zimen.sk>
References: <20040531213726.GA3298@zimen.sk> <16572.19517.483958.68645@aber.ac.uk> <Pine.LNX.4.60.0406011854270.17375@frog.athome>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0406011854270.17375-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi


=20
On Tue, Jun 01, 2004 at 07:03:51PM +0200, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Salut Fred, Mizu and Emma,
> (if this fixed it for Emma too????),
> from which kernel-version did you update. In other words, which is the=20
> latest kernel version where you did not had trouble powering-off when the=
=20
i think, maybe since 2.6.[34] ?? (i'm not sure,it is very old problem)
> rtc-module was loaded? I think we should open a bug-report on=20



 I can post this bug.

 I found some similar bug :
=20
 Bugzilla Bug 2719:
 	  	[ATI 9100IGP, Award/Phoenix BIOS]: halt becomes reboot
		when BIOS "Wake up on RTC" is enabled

 but, i don't think, that this is the same problem, or not ?


=20

 			mizu



> http://bugme.osdl.org/
>=20
> On Tue, 1 Jun 2004, Fred Labrosse wrote:
> >mizu writes:
> >> salut
> >>
> >>   :) Yes !
> >>
> >>   now, it works wery well for me.
> >
> >YESSSSS
> >
> >Worked for me too.  Replaced the enhanced by the generic with extended, =
and
> >it worked.
> >
> >How did you spot that?  Anyway, it was well spotted indeed.  Might be wo=
rth
> >reporting to people responsible for that (?).
> >
> >Thanks.
> >
> >Fred
> >
> >
> >>
> >>   I played with kernel configuration, i found this:
> >>
> >>   I guess, Problem was in "Enhanced RTC driver". If i have this driver
> >>   inside a kernel (or like module), my laptop will never poweroff().
> >>   last message was like this:
> >>   		...
> >> 		call_power_off()
> >> 		...HANG...
> >>
> >>
> >>
> >>
> >>   (also i have inserted HPET timer inside kernel, not like module)
> >>
> >>
> >>   Is this some unresolved dependency with RTC ?
> >>   Can i have both timers ? (RTC, HPET)
>=20
> Gru?
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
> iD8DBQFAvLcA9bBoTzOf1pMRAunYAKCz/GDXBkP4stvEGC7rBpZo7rFvfgCg4Kse
> 38oIbJpOryUKxWccYGy6npw=3D
> =3D60zS
> -----END PGP SIGNATURE-----


--=20
              mizu
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
[-> E-mail:michal_AT_zimen_DOT_sk   =20
[-> ICQ:97165392
[-> WWW: http://michal.zimen.sk
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAvMsM9kFXwDL4DRkRAuY6AKCe60hg8iucPulAEk69WyXRFHsiIACggBSo
j3nlKuUgvkc3yIgViuXdBck=
=PxmR
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
