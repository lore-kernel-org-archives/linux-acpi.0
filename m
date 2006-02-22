From: "Hesse, Christian" <mail@earthworm.de>
Subject: Re: hald in status D with 2.6.16-rc4
Date: Wed, 22 Feb 2006 23:36:31 +0100
Message-ID: <200602222336.31562.mail@earthworm.de>
References: <200602202034.29413.mail@earthworm.de> <200602221110.44813.mail@earthworm.de> <200602222109.21816.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2813255.RpKh75hPNk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lugor.de ([212.112.242.222]:40158 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1751575AbWBVWg4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Feb 2006 17:36:56 -0500
In-Reply-To: <200602222109.21816.ncunningham@cyclades.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

--nextPart2813255.RpKh75hPNk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 22 February 2006 12:09, Nigel Cunningham wrote:
> Hi.

Hi Nigel,

> On Wednesday 22 February 2006 20:10, Hesse, Christian wrote:
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
> Could you let me know how you go? I didn't make any changes between 2.2 a=
nd
> 2.2.0.1 that I think could cause this, but if you can't reproduce it
> otherwise, I'll happily look again.

You just missed my last mail. It happens with mainline suspend as well, so =
it=20
is not your fault.

Regards,
=2D-=20
Christian

--nextPart2813255.RpKh75hPNk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.20 (GNU/Linux)

iD8DBQBD/OdvlZfG2c8gdSURAmGWAJ9m4+BfFryXNwWpaDk1YBdqfJ7cvACgnVDO
bpQEXcWoGYmY3b8+5Fa3ET0=
=MJBg
-----END PGP SIGNATURE-----

--nextPart2813255.RpKh75hPNk--
