From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: Add INPUT support to toshiba_acpi
Date: Tue, 26 Jun 2007 07:03:13 +0200
Message-ID: <200706260703.22994.eike-kernel@sf-tec.de>
References: <1180614979.2693.26.camel@localhost.localdomain> <200706231656.39597.eike-kernel@sf-tec.de> <1182765156.2519.0.camel@work>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2318034.MoRjYlpp8a";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:57082 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbXFZGNZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jun 2007 02:13:25 -0400
In-Reply-To: <1182765156.2519.0.camel@work>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: John Belmonte <john@neggie.net>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>

--nextPart2318034.MoRjYlpp8a
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Richard Hughes wrote:
> On Sat, 2007-06-23 at 16:56 +0200, Rolf Eike Beer wrote:
> > None of the above keys generated a key event. Neither does "Brightness
> > down", but it still works. "Brightness up" generates an event and works.
> > Kpowersave tells me it can't do brightness switching in software (which
> > works in WinXtraPain).
>
> Do you know how windows does this? Do you have to load a special
> system-try thing to make the keys work?

Yes, I need a special process running for this. Would it be of some use if =
I=20
take a look with IRPtracker on it or is that all you need to know?

Eike

--nextPart2318034.MoRjYlpp8a
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGgJ4aXKSJPmm5/E4RApYnAJ9me/3Z5bLly9UJMiEtiZASXGuW0gCfYUcS
IlQ0pmwMjseP3QA8w1PnF/Q=
=awjh
-----END PGP SIGNATURE-----

--nextPart2318034.MoRjYlpp8a--
