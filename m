From: "Hesse, Christian" <mail@earthworm.de>
Subject: Re: hald in status D with 2.6.16-rc4
Date: Tue, 28 Feb 2006 08:47:45 +0100
Message-ID: <200602280847.51677.mail@earthworm.de>
References: <200602202034.29413.mail@earthworm.de> <200602272348.37288.mail@earthworm.de> <200602281040.44957.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6720020.FOX7EZvp2u";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lugor.de ([212.112.242.222]:52402 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1751914AbWB1Hs5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Feb 2006 02:48:57 -0500
In-Reply-To: <200602281040.44957.ncunningham@cyclades.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

--nextPart6720020.FOX7EZvp2u
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 28 February 2006 01:40, Nigel Cunningham wrote:
> On Tuesday 28 February 2006 08:48, Hesse, Christian wrote:
> > On Wednesday 22 February 2006 21:12, Hesse, Christian wrote:
> > > On Wednesday 22 February 2006 11:10, Hesse, Christian wrote:
> > > > On Tuesday 21 February 2006 23:49, Andrew Morton wrote:
> > > > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > > > On Tuesday 21 February 2006 06:19, Andrew Morton wrote:
> > > > > > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > > > > > Hello everybody,
> > > > > > > >
> > > > > > > > since using kernel version 2.6.16-rc4 the hal daemon is in
> > > > > > > > status D after resume. I use suspend2 2.2.0.1 for 2.6.16-rc=
3.
> > > > > > > > Any hints what could be the problem? It worked perfectly wi=
th
> > > > > > > > 2.6.15.x and suspend2 2.2.
> > > > > > >
> > > > > > > a) Look in the logs for any oopses, other nasties
> > > > > >
> > > > > > Nothing.
> > > > > >
> > > > > > > b) Do `echo t > /proc/sysrq-trigger', `dmesg -s 1000000 > foo'
> > > > > > > then find the trace for `hald' in `foo', send it to this list.
> > > > > >
> > > > > > Ok, here it is:
> > > > > >
> > > > > > [ trace snipped ]
> > > > > >
> > > > > > This is with 2.6.16-rc4-git1 + suspend2 2.2.0.1.
> > > > >
> > > > > Hopefully suspend2 isn't involved.  People would feel more
> > > > > comfortable if you could test a vanilla mainline tree..
> > > > >
> > > > > Could the ACPI team please take a look at fixing this regression?
> > > >
> > > > I did two cycles with mainline suspend now and did not hit the
> > > > problem... I will keep an eye on it.
> > >
> > > It is independent from suspend version, hald hangs with mainline
> > > suspend as well.
> >
> > I think this is a big regression since 2.5.15. Is anybody working on it?
> > I did not get a reply for nearly a week now...
> > If anybody needs more information let me know.
>
> I would suggest bugging the acpi guys :)

They are in cc, but nobody cares. :(
=2D-=20
Christian

--nextPart6720020.FOX7EZvp2u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.20 (GNU/Linux)

iD8DBQBEBAAnlZfG2c8gdSURAjQ6AKC62G4ihhjgBhs1+eS7tV1gWjKmHwCfcz8B
k+kka2GcdLnOaT9nk8GL/Sk=
=A0ne
-----END PGP SIGNATURE-----

--nextPart6720020.FOX7EZvp2u--
