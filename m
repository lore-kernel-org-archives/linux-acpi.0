From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: Re: 2.6.31-rc7-git2: Reported regressions 2.6.29 -> 2.6.30
Date: Fri, 28 Aug 2009 09:43:30 +1000
Message-ID: <20090828094330.0f7f75d7.sfr@canb.auug.org.au>
References: <JuOd1ZASH0B.A.YGB.0zGlKB@chimera>
	<200908261833.37310.elendil@planet.nl>
	<20090826123647.e60d9555.akpm@linux-foundation.org>
	<200908272023.21288.rusty@rustcorp.com.au>
	<20090827143653.52308d6d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__28_Aug_2009_09_43_30_+1000_3fCgz2za9/ojxanB"
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090827143653.52308d6d.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, protasnb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Signature=_Fri__28_Aug_2009_09_43_30_+1000_3fCgz2za9/ojxanB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew, Rusty,

On Thu, 27 Aug 2009 14:36:53 -0700 Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org=
> wrote:
>
> On Thu, 27 Aug 2009 20:23:20 +0930 Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org> =
wrote:
> >=20
> > Can you take them?  They're not really at home in my tree.
> >=20
> > arch-x86-kernel-acpi-cstatec-avoid-using-work_on_cpu.patch
> > misc:work_on_cpu-acpi.patch
> > misc:work_on_cpu-acpi-fix.patch
> > misc:work_on_cpu-dcdbas.patch
> >=20
> > You can fetch them from http://ozlabs.org/~rusty/kernel/rr-latest/
> >=20
> > (You'll want to rename the last three something sane...)
>=20
> Those patches are already in today's linux-next so I can't carry them.
>=20
> Please email them over in the traditional fashion once that situation
> has sorted itself out?

Those patches will not be in next-20090828.

--=20
Cheers,
Stephen Rothwell                    sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__28_Aug_2009_09_43_30_+1000_3fCgz2za9/ojxanB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqXGiIACgkQjjKRsyhoI8xGYgCdF1tV9fC5DVYLkjUp6rmG22vT
+kkAoKNKhLZYwSQbYUlJFhpl7mwGhxxU
=fWnF
-----END PGP SIGNATURE-----

--Signature=_Fri__28_Aug_2009_09_43_30_+1000_3fCgz2za9/ojxanB--
