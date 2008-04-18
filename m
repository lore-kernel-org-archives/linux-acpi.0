From: Philippe Coval <rzr@users.sf.net>
Subject: Re: [PATCH] Override DSDT and SSDTs via initramfs
Date: Sat, 19 Apr 2008 00:07:06 +0200
Message-ID: <48091B8A.3000800@users.sf.net>
References: <4798E2A5.6020804@users.sf.net> <47A0FBD4.6090603@tremplin-utc.net> <1201861297.14573.66.camel@queen.suse.de> <200802062151.48404.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDF670D0E57C923BD1445A3FA"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2-g19.free.fr ([212.27.42.28]:48764 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbYDRWHO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Apr 2008 18:07:14 -0400
In-Reply-To: <200802062151.48404.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: trenn@suse.de, =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDF670D0E57C923BD1445A3FA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

First let me introduce myself, my name does not appear,
  but I am the quoted one by Andrew Morton on his 1st post of this thread=
 :

  http://thread.gmane.org/gmane.linux.acpi.devel/27726

  > > I am annoyed by this missing (or rejected) feature upstream : DSDT
  > >   http://gaugusch.at/kernel.shtml
  > > So to use "custom DSDT loading" I have to patch my laptop buggy BIO=
S
  ...
  > > Hopefully many distro already include this patch, but not all of th=
em
  > > such as debian :
  > >   http://bugs.debian.org/251023

You may be aware of that yet, but It seems that the patch was rejected
for 2.6.25

=20
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmit;h=3D9a9e0d685553af76cb6ae2af93cca4913e7fcd47

Quoting linus : "the relevant ACPI code should either run much later,"

So was next then ? how can we help to fix this recurrent issue ?

Anyway I'd like to thank you all for all time spent on this job,
and I am happy with the patch as it is...

Regards

--=20
 # mailto:rzr[a]users.sf.net -- gpg:0x467094BC
 # http://rzr.online.fr/contribs.htm -- Libre Software Addict
 # xmpp:rzr[a]jabber.fr -- sip:rzr[a]ekiga.net



--------------enigDF670D0E57C923BD1445A3FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFICRuLlNXo+kZwlLwRAljhAKCPZn+6GV0NYtcAUiZNDbevL+0URwCdHShf
wMmc50XzmTpIXEB/p7Dn4rw=
=aVGc
-----END PGP SIGNATURE-----

--------------enigDF670D0E57C923BD1445A3FA--
