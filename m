From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: Re: 2.6.31-rc7-git2: Reported regressions 2.6.29 -> 2.6.30
Date: Thu, 27 Aug 2009 21:13:51 +1000
Message-ID: <20090827211351.f9c96bfc.sfr@canb.auug.org.au>
References: <JuOd1ZASH0B.A.YGB.0zGlKB@chimera>
	<200908261833.37310.elendil@planet.nl>
	<20090826123647.e60d9555.akpm@linux-foundation.org>
	<200908272023.21288.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__27_Aug_2009_21_13_51_+1000_Q1GFTqHHfNWTZJGe"
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200908272023.21288.rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, protasnb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Signature=_Thu__27_Aug_2009_21_13_51_+1000_Q1GFTqHHfNWTZJGe
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rusty,

On Thu, 27 Aug 2009 20:23:20 +0930 Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org> wr=
ote:
>
> > Rusty/Len: please work out why the title for that patch went silly.
>=20
> git-quiltimport uses the patch names, and doesn't extract the title.  I
> assume that's what Stephen uses.  I didn't rename the patch when I rewrote
> it not to use work_on_cpu.

git quiltimport assumes "mail-like" patches, so it looks for "From:" and
"Subject:" lines.  I guess it could be made to use the first line of the
patch if there is no subject ...

--=20
Cheers,
Stephen Rothwell                    sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__27_Aug_2009_21_13_51_+1000_Q1GFTqHHfNWTZJGe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqWam8ACgkQjjKRsyhoI8xc8QCfT+TUq0Dx0zrRIjriHbIp3n+z
9k0An3u12Duw+xLno8qu8+pUYrW0+hmM
=+zdC
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Aug_2009_21_13_51_+1000_Q1GFTqHHfNWTZJGe--
