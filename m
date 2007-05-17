From: Matija =?utf-8?q?=C5=A0uklje?= <matija.suklje@rutka.net>
Subject: Re: Why is it so hard to (get) help on ACPI?
Date: Thu, 17 May 2007 21:52:11 +0200
Message-ID: <200705172152.13046.matija.suklje@rutka.net>
References: <200705172005.47845.matija.suklje@rutka.net> <8f8ff01d0705171158q3412f0f1o4465562bb961d774@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart32784197.s6ameE5x44";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mta1.siol.net ([193.189.160.87]:64871 "EHLO mta1.siol.net"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754243AbXEQTwR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 15:52:17 -0400
Received: from mailhub-5.siol.net ([10.10.10.105]) by mta1.siol.net
          with ESMTP
          id <20070517195216.OZKS21179.mta1.siol.net@mailhub-5.siol.net>
          for <linux-acpi@vger.kernel.org>; Thu, 17 May 2007 21:52:16 +0200
Received: from [192.168.1.3] (really [86.61.66.55]) by mailhub-5.siol.net
          with ESMTP
          id <20070517195219.XSEN13546.mailhub-5.siol.net@[192.168.1.3]>
          for <linux-acpi@vger.kernel.org>; Thu, 17 May 2007 21:52:19 +0200
In-Reply-To: <8f8ff01d0705171158q3412f0f1o4465562bb961d774@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart32784197.s6ameE5x44
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne =C4=8Detrtek 17 maj 2007 20:58 ste napisali:
> First of all, why do you want/need to change your DSDT?
> Second, patching DSDT is meant to be a last resort if any other
> method, like finding error in our implementation of ACPI or drivers.

Thank you for the reply.

I *think* I need it because I didn't find any better solution. On my Acer=20
Aspire 5022 for some time I've been getting APIC errors (most commonly "40
(40)") - which seem to cause system hangups, high cpu io-wait for (to me) n=
o=20
apparent reasons, high temperature and disability to resume from a suspend.=
=20
This has been happening for quite a few kernel versions (gentoo kernel=20
flavour). I was told the APIC errors should go away with a BIOS upgrade - s=
o=20
I did ...with no luck.

Then someone suggested trying the Linux-ready Firmware Developer Kit (=20
http://www.linuxfirmwarekit.org ), on which my laptop('s BIOS) failed on 9=
=20
tests out of 21 (some of which even from DSDT). I can attach the results if=
=20
you find them useful.

Currently I run my system with the "noapic" kernel flag and with my DSDT=20
patch. It seems to be happier then before I did this, but I feel it's still=
=20
far from optimal.

> So "better" DSDT patch is patch of zero length -- don't touch it, fix
> ACPI or drivers.

I agree that a solution by someone who knows what they're doing is a lot=20
better then me (being a non-coder) trying to fiddle with ASL code. But it=20
just drove me nuts...

Btw, the patch I wrote eliminates 9 errors which seem to be connected with=
=20
memory.

But this still doesn't explain why it seems like I cannot make a user accou=
nt=20
on the acpi.sf.net/dsdt page and why my previous e-mail did not arrive to t=
he=20
list. Is the attachment size quota set to less then 1 MiB?

best regards and kudos for all your hard work on ACPI!

Matija =C5=A0uklje

=2D-=20
gsm: +386 41 849 552
e-mail: matija.suklje@rutka.net
www: http://matija.suklje.name

aim: hookofsilver
icq: 110183360
jabber/g-talk: matija.suklje@jabber.com
msn: matija.suklje@rutka.net
yahoo: matija_suklje

--nextPart32784197.s6ameE5x44
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGTLJtK2gLUQVJ0ngRAh+8AJ9HR7NnK8xbxDJc3SDBGk1qQzRHqwCfXl/a
o7z++QjwJaFRY26vNKGkBS8=
=CMKv
-----END PGP SIGNATURE-----

--nextPart32784197.s6ameE5x44--
