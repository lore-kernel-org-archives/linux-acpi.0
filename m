From: "David J. Wallace" <katana@onetel.com>
Subject: Re: Problems resuming from S3 in 2.6.16
Date: Fri, 7 Apr 2006 17:07:01 +0100
Message-ID: <200604071707.06159.katana@onetel.com>
References: <200604071703.16518.avvisi@spalletti.it>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1541649.8MSqCmXbRs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ironport1.mynow.co.uk ([81.91.192.235]:19260 "EHLO
	ironport1.mynow.co.uk") by vger.kernel.org with ESMTP
	id S932439AbWDGQHN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Apr 2006 12:07:13 -0400
In-Reply-To: <200604071703.16518.avvisi@spalletti.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart1541649.8MSqCmXbRs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 07 April 2006 16:03, Iacopo Spalletti wrote:
> I used to suspend/resume my Asus V6V (Radeon Mobility X600 video card)
> laptop without problems in 2.6.15 with little problems using vbetool to
> resume video card state.
> Starting from 2.6.16 resume hangs when accessing X, either by switching to
> X virtual terminal or starting X from scratch.
> Trying suspend/resume from single mode with all modules unloaded doesn't
> change situation.
> I tried with both custom-compiled vanilla kernel and debian unstable kern=
el
> without success
>
> This is the script i use to resume/suspend:
> chvt 2
> vbetool dpms off
> vbetool vbestate save >$statedir/vbe
> cat /dev/vcsa >$statedir/vcsa
> echo mem >/sys/power/state
> vbetool post
> vbetool vbestate restore <$statedir/vbe

My Panasonic R4 is similarly affected. I hadn't made the link with the upgr=
ade=20
2.6.16 and the failure to start X after resume as so much else has been=20
changing.=20

My script is very similar to the one above.

Regards,

David=20

=2D-=20
Check out Linux on the Panasonic R4 Laptop - www.laohu.co.uk/r4

--nextPart1541649.8MSqCmXbRs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBENo4qKsvwCXwmAPgRAoFoAJ9oDdIRvtjjE7KKrJupVapNf7q1iQCeLLjQ
+MZ3Qucj6gl3W6vM2/izXAc=
=aC75
-----END PGP SIGNATURE-----

--nextPart1541649.8MSqCmXbRs--
