From: "Hesse, Christian" <mail@earthworm.de>
Subject: Re: hald in status D with 2.6.16-rc4
Date: Wed, 22 Feb 2006 11:10:40 +0100
Message-ID: <200602221110.44813.mail@earthworm.de>
References: <200602202034.29413.mail@earthworm.de> <200602212322.48645.mail@earthworm.de> <20060221144907.1ac11799.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3847742.ymNGRa4gJc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932584AbWBVKKy@vger.kernel.org>
In-Reply-To: <20060221144907.1ac11799.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--nextPart3847742.ymNGRa4gJc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 21 February 2006 23:49, Andrew Morton wrote:
> "Hesse, Christian" <mail@earthworm.de> wrote:
> > On Tuesday 21 February 2006 06:19, Andrew Morton wrote:
> > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > Hello everybody,
> > > >
> > > > since using kernel version 2.6.16-rc4 the hal daemon is in status D
> > > > after resume. I use suspend2 2.2.0.1 for 2.6.16-rc3. Any hints what
> > > > could be the problem? It worked perfectly with 2.6.15.x and suspend2
> > > > 2.2.
> > >
> > > a) Look in the logs for any oopses, other nasties
> >
> > Nothing.
> >
> > > b) Do `echo t > /proc/sysrq-trigger', `dmesg -s 1000000 > foo' then
> > > find the trace for `hald' in `foo', send it to this list.
> >
> > Ok, here it is:
> >
> > [ trace snipped ]
> >
> > This is with 2.6.16-rc4-git1 + suspend2 2.2.0.1.
>
> Hopefully suspend2 isn't involved.  People would feel more comfortable if
> you could test a vanilla mainline tree..
>
> Could the ACPI team please take a look at fixing this regression?

I did two cycles with mainline suspend now and did not hit the problem... I=
=20
will keep an eye on it.
=2D-=20
Christian

--nextPart3847742.ymNGRa4gJc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.20 (GNU/Linux)

iD8DBQBD/DiklZfG2c8gdSURAtg/AKCG5pGesZvwq/7v/cK/mKrdXM3SegCaA4PQ
dtrRwr9/FVeKSzSUt/80eyA=
=HB41
-----END PGP SIGNATURE-----

--nextPart3847742.ymNGRa4gJc--
