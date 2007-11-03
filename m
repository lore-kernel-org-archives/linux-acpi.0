From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [regression] v2.6.24-rc1-497-gb1d08ac: kde battery icon gone
Date: Sat, 3 Nov 2007 13:19:00 +0300
Message-ID: <200711031319.04664.arvidjaar@mail.ru>
References: <472B5C01.7090508@m3y3r.de> <20071103063520.13EA59AFABF@smtp05.mtu.ru> <20071103082808.GB10760@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1710816.yTvNyEqPkc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757772AbXKCKTV@vger.kernel.org>
In-Reply-To: <20071103082808.GB10760@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Meyer <thomas@m3y3r.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

--nextPart1710816.yTvNyEqPkc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 03 November 2007, Ingo Molnar wrote:
> * Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> > > # CONFIG_ACPI_PROCFS is not set
> >
> > And if you enable it (ACPI_PROCFS)?
>
> ACPI_PROCFS was newly introduced i think but without a 'default y'
> Kconfig entry. That was a mistake i think - it broke some power
> management tools on my laptop too.
>

It is not that new but battery started to make use of it only now. It provi=
des=20
replacement interface via sysfs power_supply object; this should be support=
ed=20
by modern power tools - at least hal/kpowersave do not have any issues.

=2Dandrey

--nextPart1710816.yTvNyEqPkc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHLEsVR6LMutpd94wRArBrAJ9tusYx8Jr9NRUEV6pGhUW0ZvE2bACgrGhL
tP5M1OttYhsfRyTb4KypO4E=
=xinj
-----END PGP SIGNATURE-----

--nextPart1710816.yTvNyEqPkc--
