From: "L. A. Linden Levy" <lindenle@uiuc.edu>
Subject: Re: Suspend Medion Akoya LS
Date: Thu, 23 Mar 2006 05:59:39 -0600
Message-ID: <20060323055939.5c6ffb36@toodles.lindenlevy.com>
References: <20060320235923.5b6c948b@toodles.lindenlevy.com>
	<1143110861.12702.4.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_mQ5NJOU1G_hCfUGW8y2c1wr;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ylpvm25-ext.prodigy.net ([207.115.57.56]:39595 "EHLO
	ylpvm25.prodigy.net") by vger.kernel.org with ESMTP id S965123AbWCWMBx
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Mar 2006 07:01:53 -0500
In-Reply-To: <1143110861.12702.4.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Garry Williams <gtwilliams@gmail.com>
Cc: lindenle@gmail.com, linux-acpi@vger.kernel.org

--Sig_mQ5NJOU1G_hCfUGW8y2c1wr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Garry,

Thanks. I had actually just figured this out on my own this morning. I
just commented out the shutdown part of my powerbtn.sh script. Since I
dont care to shutdown with the power button I am just going to leave
it this way.

On Thu, 23 Mar 2006 05:47:40 -0500
Garry Williams <gtwilliams@gmail.com> wrote:

> On Mon, 2006-03-20 at 23:59 -0600, L. A. Linden Levy wrote:
> > Hi when I use suspend my machine wont wake up unless i hit the power
> > button but then it shuts down. It is like the keyboard is not
> > registering when it is suspended. Can anyone help me make this work?
> >=20
> > kernel 2.6.15
>=20
> Try removing the button action that is specified in a file
> in /etc/acpi/events.  It may be named sample.conf, depending on your
> distribution.  Then you can safely wake by pressing the power button.
>=20
> If that solves your problem and you still want to be able to call
> shutdown(8) by hitting the power button, then disable/enable this
> button rule in your suspend script.
>=20


--=20
---------------------------------------------
Loren A. Linden Levy
481 Loomis, Department of Physics
University of Illinois at Urbana-Champaign
1110 W. Green St., Urbana, IL 61801-3080
Tel:   217-244-7995   Fax: 217-333-1215
Email: lindenle@uiuc.edu
url:   http://w3.physics.uiuc.edu/~lindenle/
_____________________________________________
---------------------------------------------
This email has been cryptographically signed.
Search for "lindenle" at pgp.mit.edu
to obtain my public key which can be used=20
to verify the authenticity of this message.
_____________________________________________
---------------------------------------------

--Sig_mQ5NJOU1G_hCfUGW8y2c1wr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIo2vlZX6YS+3ZksRAnqRAJ9SV4H6m3eE1H3GMD2GwL3aAuEAyACfYFd0
bxhYDDqKwqTX0Ksh0BSp7ps=
=mQXO
-----END PGP SIGNATURE-----

--Sig_mQ5NJOU1G_hCfUGW8y2c1wr--
