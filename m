From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [linux-pm] Re: Hibernate after alarm wakes from STR
Date: Wed, 11 Jul 2007 13:14:03 +1000
Message-ID: <200707111314.04221.nigel@nigel.suspend2.net>
References: <20070330235759.GC4252@cosmic.amd.com> <200707111139.38667.nigel@nigel.suspend2.net> <20070711015948.GA30659@srcf.ucam.org>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1377537.9kxNPZrQyW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nigel.suspend2.net ([203.171.70.205]:42804 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322AbXGKDNy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jul 2007 23:13:54 -0400
In-Reply-To: <20070711015948.GA30659@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: nigel@suspend2.net, David Brownell <david-b@pacbell.net>, linux-pm@lists.linux-foundation.org, Marcelo Tosatti <marcelo@kvack.org>, linux-acpi@vger.kernel.org, Richard Hughes <hughsient@gmail.com>, rtc-linux@googlegroups.com

--nextPart1377537.9kxNPZrQyW
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 11 July 2007 11:59:48 Matthew Garrett wrote:
> On Wed, Jul 11, 2007 at 11:39:37AM +1000, Nigel Cunningham wrote:
>=20
> > Yeah, that is a bit confusing. At the moment, I'm doing the suspend to =
ram=20
> > platform dependent preparation and cleanup in this scenario. That's=20
> > definitely the right thing to do in the case where we write an image, t=
hen=20
> > suspend to ram, wake and continue working without running running out o=
f=20
> > battery (writing the image is redundant in that case). Where we end up=
=20
> > properly powering down after suspending to ram, I believe we don't run =
the=20
> > pm_ops->finish after doing the atomic restore when resuming the image.
>=20
> I'm not convinced this can work terribly well. It's not unlikely that=20
> hardware will need different state stored over different types of=20
> suspend. Can you separate out the saving of kernel memory and userspace=20
> memory, then resume/suspend/save the new kernel state without touching=20
> the userspace state?

Yeah, we could redo and resave the atomic copy, but it doesn't seem to be=20
necessary at the moment; it has been working reliably, regardless of which=
=20
combination of events occurs. If/when I come across a case where we have=20
problems, I'll give resaving the atomic copy a go.

(Thinks some more). Ah, I think we're already doing the right thing, if I'm=
=20
recalling the order of actions right. If I'm remembering correctly, prior t=
o=20
the atomic copy, we do hibernation prep, then after the atomic copy,=20
hibernation cleanup. Then, if suspending to ram, we do the prep/enter/clean=
up=20
after the image has finished writing. If we lose power from suspend to ram,=
=20
it doesn't matter because we're just doing a normal resume then, with the=20
hibernation cleanup post atomic restore machine the prep that was done prio=
r=20
to the atomic copy.

To summarise:

Hibernate + STR + full wake.
 Hibernation prep
 (Atomic copy)
 Hibernation cleanup
 STR prep
 STR enter
 STR cleanup	=09
 Remove hibernation image

Hibernate + STR + poweroff + hibernate resume:

 Hibernation prep
 (Atomic copy)
 Hibernation cleanup
 STR prep
 STR enter
 <power out> or <STR wake + power off> (STR prep/enter no longer matters)
 (Fresh boot)
 Atomic restore
 Hibernation cleanup (matching prep at start)
 Remove hibernation image

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1377537.9kxNPZrQyW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGlEr8N0y+n1M3mo0RAkSeAJ0RUFhR0kbEA7IEmgKrPgs7JrrKigCgg0eE
j+CJEL4nzmp8QBI0Gn0rWbo=
=ALRU
-----END PGP SIGNATURE-----

--nextPart1377537.9kxNPZrQyW--
