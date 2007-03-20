From: Franklin Marmon <marmon@hydeco.com>
Subject: Re: Ambient Light Sensor?
Date: Tue, 20 Mar 2007 09:39:51 -0600
Message-ID: <200703200939.55625.marmon@hydeco.com>
References: <200703191341.41823.lenb@kernel.org> <20070320151342.GA8667@redhat.com>
Reply-To: marmon@hydeco.com
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1606876.GIrCeRxCzh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpstatic.blackfoot.net ([12.32.45.18]:13004 "EHLO
	ali.hydeco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbXCTPs1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:48:27 -0400
In-Reply-To: <20070320151342.GA8667@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

--nextPart1606876.GIrCeRxCzh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Ambient light sensors are on the Dell Latitude D820, a buddy of mine purcha=
sed=20
one not to long ago.

frm

On Tuesday March 20 2007 09:13, Dave Jones wrote:
> On Mon, Mar 19, 2007 at 01:41:41PM -0400, Len Brown wrote:
>  > Has anybody seen ACPI-based ambient light sensor support on a commerci=
al
>  > system?
>  >
>  > You'd recognize it by a device with PNPid ACPI0008 exported via the AML
>  > device tree.
>  >
>  > I've seen it on an Intel Capell Valley CRB, but I was wondering
>  > if anybody is using it in the "real world" yet.
>  >
>  > I've seen just the dmesg from a MacBook Pro on the web
>  > suggesting that system exports ACPI0008:
>  > http://www.uwsg.iu.edu/hypermail/linux/kernel/0703.0/1475.html
>
> Right. Under OSX, it uses it to adjust the keyboard backlight.
> (It may also do something fancy wrt gamma correction with the
>  built-in webcam)
>
> 	Dave

=2D-=20
=46ranklin Marmon
The Hyde Company
331 East Broadway
Missoula, MT 59801
http://www.hydeco.com
406-541-4777
JabberID: marmon@jabber.montana.com

--nextPart1606876.GIrCeRxCzh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBGAABLRs+XHRHsYPIRAgYjAJ9+jxJmGso/kiwfeo0j6DA3rm4jqwCfTQ/U
C9FTiO5Nk+d2GHoVLIg2p2Q=
=O3Uh
-----END PGP SIGNATURE-----

--nextPart1606876.GIrCeRxCzh--
