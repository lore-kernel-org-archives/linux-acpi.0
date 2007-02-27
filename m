From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Tue, 27 Feb 2007 21:08:08 +0200
Message-ID: <200702272108.09665.caglar@pardus.org.tr>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org> <b637ec0b0702270614i25b6be9fmfb4b12ddd789a467@mail.gmail.com> <200702272044.56544.caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3557153.YNuL0NWIy2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:52869 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751768AbXB0THu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Feb 2007 14:07:50 -0500
In-Reply-To: <200702272044.56544.caglar@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, luming.yu@intel.com, Konstantin Karasyov <konstantin.a.karasyov@intel.com>, vladimir.p.lebedev@intel.com, hal@lists.freedesktop.org

--nextPart3557153.YNuL0NWIy2
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

27 =C5=9Eub 2007 Sal tarihinde, S.=C3=87a=C4=9Flar Onur =C5=9Funlar=C4=B1 y=
azm=C4=B1=C5=9Ft=C4=B1:=20
> 27 =C5=9Eub 2007 Sal tarihinde, Fabio Comolli =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:
> > Confirmed, although the problem I see is probably different from
> > Ismael's one: in my case /proc/acpi/adapter/AC is present but
> > kpowersave does not work (it works in 2.6.20).
> >
> > The only file I seem to be missing is /proc/acpi/info, but I don't
> > know it is important or not.
>
> Then these problems are not same, =C4=B0smail's problem was an ACPI one a=
nd im
> sure that solved but yours seems a userspace problem (hal checks
> /proc/acpi/info and kpowersave uses hal) introduced by "/proc/acpi/info
> deprecated by /sys/firmware/acpi/info" [1]. You can try untested attached
> patch against hal-git tree, so i'm adding hal list into CC also.
>
> [1] http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg04285.html

Try that one (thas one at least compiles :P) [1] instead of previous one=20
please...

[1] http://cekirdek.pardus.org.tr/~caglar/hal_acpi.patch
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart3557153.YNuL0NWIy2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBF5IGZy7E6i0LKo6YRAvYsAJ0QMKs4QC71LObGs3Dwa7N6c+FfDACfTydh
JUZxOcWvIrVGthdL94dGliA=
=zKlk
-----END PGP SIGNATURE-----

--nextPart3557153.YNuL0NWIy2--
