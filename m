From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: Add INPUT support to toshiba_acpi
Date: Tue, 3 Jul 2007 07:38:34 +0200
Message-ID: <200707030738.39980.eike-kernel@sf-tec.de>
References: <1180614979.2693.26.camel@localhost.localdomain> <200706281327.29962.eike-kernel@sf-tec.de> <4683A80E.4070006@mandic.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9037258.MZ5o41Lbe6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:41859 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbXGCFzS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Jul 2007 01:55:18 -0400
In-Reply-To: <4683A80E.4070006@mandic.com.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Cc: Richard Hughes <hughsient@gmail.com>, John Belmonte <john@neggie.net>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>, Mathieu.Berard@crans.org

--nextPart9037258.MZ5o41Lbe6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Renato S. Yamane wrote:
> Rolf Eike Beer wrote:
> > Richard Hughes wrote:
> >> Yes, although this is out of my area or expertise, sorry.
> >
> > I've looked a bit but can't find any driver interaction of those
> > programs. Any further ideas welcome.
>
> Do you try omnibook driver?
> svn export https://svn.sourceforge.net/svnroot/omnibook/omnibook/trunk
>
> toshiba_acpi don't work on my Toshiba M45-S355 (Toshiba BIOS) and I try
> this module above and now I can change brightness writing in
> /proc/omnibook/lcd and kpowersave can change brightness too.
>
> But, is impossible use multimedia keys (play, pause, browser, etc) and
> couple keys (fn-fx), because Fn key and Multimedia keys don't is
> recognized.

Oh wow! Even my Multimedia keys get recognized. Thanks very much for your=20
pointer.

Eike

--nextPart9037258.MZ5o41Lbe6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGieDfXKSJPmm5/E4RArIHAJ0TIxNDBoJa3BF27psfUUuz9g7/gACgjlq/
2J5E8rLntBTClsJGWyMuSwQ=
=+1eI
-----END PGP SIGNATURE-----

--nextPart9037258.MZ5o41Lbe6--
