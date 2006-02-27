From: "Hesse, Christian" <mail@earthworm.de>
Subject: Re: hald in status D with 2.6.16-rc4
Date: Mon, 27 Feb 2006 23:48:37 +0100
Message-ID: <200602272348.37288.mail@earthworm.de>
References: <200602202034.29413.mail@earthworm.de> <200602221110.44813.mail@earthworm.de> <200602222112.09567.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart39355267.8HGVQ3LJXq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lugor.de ([212.112.242.222]:40917 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1751758AbWB0Wsx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Feb 2006 17:48:53 -0500
In-Reply-To: <200602222112.09567.mail@earthworm.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

--nextPart39355267.8HGVQ3LJXq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 22 February 2006 21:12, Hesse, Christian wrote:
> On Wednesday 22 February 2006 11:10, Hesse, Christian wrote:
> > On Tuesday 21 February 2006 23:49, Andrew Morton wrote:
> > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > On Tuesday 21 February 2006 06:19, Andrew Morton wrote:
> > > > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > > > Hello everybody,
> > > > > >
> > > > > > since using kernel version 2.6.16-rc4 the hal daemon is in stat=
us
> > > > > > D after resume. I use suspend2 2.2.0.1 for 2.6.16-rc3. Any hints
> > > > > > what could be the problem? It worked perfectly with 2.6.15.x and
> > > > > > suspend2 2.2.
> > > > >
> > > > > a) Look in the logs for any oopses, other nasties
> > > >
> > > > Nothing.
> > > >
> > > > > b) Do `echo t > /proc/sysrq-trigger', `dmesg -s 1000000 > foo' th=
en
> > > > > find the trace for `hald' in `foo', send it to this list.
> > > >
> > > > Ok, here it is:
> > > >
> > > > [ trace snipped ]
> > > >
> > > > This is with 2.6.16-rc4-git1 + suspend2 2.2.0.1.
> > >
> > > Hopefully suspend2 isn't involved.  People would feel more comfortable
> > > if you could test a vanilla mainline tree..
> > >
> > > Could the ACPI team please take a look at fixing this regression?
> >
> > I did two cycles with mainline suspend now and did not hit the problem.=
=2E.
> > I will keep an eye on it.
>
> It is independent from suspend version, hald hangs with mainline suspend =
as
> well.

I think this is a big regression since 2.5.15. Is anybody working on it? I =
did=20
not get a reply for nearly a week now...
If anybody needs more information let me know.
=2D-=20
Regards,
Christian

--nextPart39355267.8HGVQ3LJXq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.20 (GNU/Linux)

iD8DBQBEA4HFlZfG2c8gdSURAtfHAKC/NIY8RpYHug4Z8rRF7QowW/2vuwCggs4K
Rrs8sUtwg0lzdBUnsUUYRxA=
=V3Me
-----END PGP SIGNATURE-----

--nextPart39355267.8HGVQ3LJXq--
