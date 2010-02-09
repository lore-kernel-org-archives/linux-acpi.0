From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: closing lid on laptop suspends it
Date: Tue, 09 Feb 2010 07:33:07 -0500
Message-ID: <1265718787.2459.56.camel@pc.interlinx.bc.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-K5iURAWN6K3D953FUWbL"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:48627 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822Ab0BIMfK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Feb 2010 07:35:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1NepJ4-00014K-HO
	for linux-acpi@vger.kernel.org; Tue, 09 Feb 2010 13:35:06 +0100
Received: from d67-193-197-208.home3.cgocable.net ([67.193.197.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 09 Feb 2010 13:35:06 +0100
Received: from brian by d67-193-197-208.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 09 Feb 2010 13:35:06 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-K5iURAWN6K3D953FUWbL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have a Toshiba Tecra M9 laptop running a 2.6.31 kernel.

I'm not even sure if this is really the correct list, but if not,
hopefully somebody can give me a gentle shove in the right direction.

The problem I'm having with this laptop is that once it has booted up,
prior to logging into the gnome desktop, if I (open if not already
opened and then) close the lid, it suspends, even when plugged into AC.

If I log into gnome, my gnome-power-manager preferences are applied and
closing the lid with AC plugged in only blanks the screen, it does not
suspend the laptop.

Additionally, after this suspend-on-lid-close operation, I get the
following complaints on the kernel message buffer:

Feb  8 12:33:58 brian-laptop kernel: [14735.616976] NVRM: rm_init_adapter(0=
) failed
Feb  8 12:34:03 brian-laptop kernel: [14739.756068] NVRM: RmInitAdapter fai=
led! (0x26:0x38:1096)
Feb  8 12:34:03 brian-laptop kernel: [14739.756075] NVRM: rm_init_adapter(0=
) failed
Feb  8 12:34:07 brian-laptop kernel: [14744.044665] NVRM: RmInitAdapter fai=
led! (0x26:0x38:1096)
Feb  8 12:34:07 brian-laptop kernel: [14744.044671] NVRM: rm_init_adapter(0=
) failed
Feb  8 12:34:11 brian-laptop kernel: [14748.200786] NVRM: RmInitAdapter fai=
led! (0x26:0x38:1096)

and the graphic display is no longer working.  The above of course may
or may not be related, but might just be a casualty of some other
problem.  I just offer it in hopes that it provides more clue as to what
is going on.

Thots?

b.



--=-K5iURAWN6K3D953FUWbL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAktxVgEACgkQl3EQlGLyuXAZiwCg3CljNIw954UvEUw1OrctvY5m
cVkAnA4q0Sw+9A16SrWWM59Nc/mwQQ76
=F8JF
-----END PGP SIGNATURE-----

--=-K5iURAWN6K3D953FUWbL--


