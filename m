From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: Re: 2.6.31-rc7-git2: Reported regressions 2.6.29 -> 2.6.30
Date: Fri, 28 Aug 2009 12:39:30 +1000
Message-ID: <20090828123930.4678f9a4.sfr@canb.auug.org.au>
References: <JuOd1ZASH0B.A.YGB.0zGlKB@chimera>
	<200908272023.21288.rusty@rustcorp.com.au>
	<20090827211351.f9c96bfc.sfr@canb.auug.org.au>
	<200908281132.19765.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__28_Aug_2009_12_39_30_+1000_fTsk0x5/pU9Nep88"
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200908281132.19765.rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, protasnb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Signature=_Fri__28_Aug_2009_12_39_30_+1000_fTsk0x5/pU9Nep88
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rusty,

On Fri, 28 Aug 2009 11:32:18 +0930 Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org> wr=
ote:
>
> On Thu, 27 Aug 2009 08:43:51 pm Stephen Rothwell wrote:
> >=20
> > git quiltimport assumes "mail-like" patches, so it looks for "From:" and
> > "Subject:" lines.  I guess it could be made to use the first line of the
> > patch if there is no subject ...
>=20
> My scripts should all handle Subject: prefixes, I can just start using th=
at.

Thanks, that would be good.

--=20
Cheers,
Stephen Rothwell                    sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__28_Aug_2009_12_39_30_+1000_fTsk0x5/pU9Nep88
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqXQ2IACgkQjjKRsyhoI8z4YACgwFxIdfodZI0QK5USteGdBnZ9
NvoAoJt7qbLohkVVihVzZ0QzNkqjlVho
=Bh0w
-----END PGP SIGNATURE-----

--Signature=_Fri__28_Aug_2009_12_39_30_+1000_fTsk0x5/pU9Nep88--
