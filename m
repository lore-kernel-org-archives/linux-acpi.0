From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [RFC] [PATCH] panasonic-laptop.c: add support for CD power
	management
Date: Wed, 14 Jan 2009 14:08:34 +0800
Message-ID: <20090114060834.GN4791@prithivi.gnumonks.org>
References: <20090113163233.GA734@dezo.moloch.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:50311 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbZANGIp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jan 2009 01:08:45 -0500
Content-Disposition: inline
In-Reply-To: <20090113163233.GA734@dezo.moloch.sk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Lucina <mato@kotelna.sk>
Cc: linux-acpi@vger.kernel.org


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Martin,

thanks for your patch, here some comments:

* please provide Signed-off-by line
* please invert the logic (as discussed earlier in the thread)
* please don't use the goto construct in pcc_hotkey_add(), since it
  makes it easy to introduce future bugs while adding more code,
  just check for the ODD drive presence and put the entire block
  in an 'if ()  { }' construct.
* I agree, checking for _SB.FBAY and _SB.STAT is probably the better
  solution.  I would accept both versions, though.
* Please run your patch through checkpatch.pl, I think there were some
  indentation errors in it (just spotted them with my eye, didn't run
  the script)

> 3) Please advise on the correct way to propagate an error result from
> the functions that call the ACPI methods {get,set}optd_power_state() to
> userspace in the sysfs interface.  I couldn't find a straightforward
> example anywhere.

I cannot help with that either, sorry.  I'm not the ACPI expert here, just
happening to have merged the panasonic driver ;)

Oh, and with regard to 'who in userspace is responsible': This is actually a
good question.  I've had many of this kind of cases in embedded development,
where you had to explicitly have to enable the power to a certain peripheral
before using.  I personally believe this doesn't belong into userspace, and
the kernel should provide hooks for it, i.e. issue some kind of
event/notifier/... to call any power-up hanlers before using, and then doing
the inverse after use.

Regards,
--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJbYFiXaXGVTD0i/8RAt/vAJ4tYyMPNI4LNkHAcZp8pFhOwPBSOQCgj7w2
W0dgFyCH2EKD1umXTeu2Tbo=
=HgCX
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
