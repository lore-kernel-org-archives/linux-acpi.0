From: Nico Schottelius <nico-linux-20090213@schottelius.org>
Subject: Re: X200: Brightness broken since 2.6.29-rc4-58-g4c098bc
Date: Mon, 16 Feb 2009 16:54:34 +0100
Message-ID: <20090216155434.GA5503@denkbrett.schottelius.org>
References: <20090213093354.GA10175@denkbrett.schottelius.org> <20090213094200.GC17774@elte.hu> <alpine.LFD.2.00.0902131302240.3671@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.schottelius.org ([77.109.138.221]:51314 "EHLO
	mx3.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbZBPPyh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Feb 2009 10:54:37 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0902131302240.3671@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Nico Schottelius <nico-linux-20090213@schottelius.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Len Brown [Fri, Feb 13, 2009 at 01:05:28PM -0500]:
> Nico,
> there are not a lot of changes between rc4 and the breakage,
> (and none of them jump out at me) can you git-bisect?

The result of git-bisecting and some reboots:

ikn% git bisect start 4c098bc d5b5623
[compile....reboot...]
[16:50] ikn:linux-2.6% git describe=20
v2.6.29-rc3-432-g9b8d5a1
[16:50] ikn:linux-2.6% git bisect good
e806b4957412bf472d826bd8cc571da041248799 is first bad commit
commit e806b4957412bf472d826bd8cc571da041248799
Author: Eric Anholt <eric@anholt.net>
Date:   Thu Jan 22 09:56:58 2009 -0800

    drm/i915: Suppress GEM teardown on X Server exit in KMS mode.
   =20
    Fixes hangs when starting X for the second time.
   =20
    Signed-off-by: Eric Anholt <eric@anholt.net>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

:040000 040000 5405babd9cab9d53791a0b58b5ad7f823f76ec9c 70f9a79c6b3072ea077=
7d6ab307330da37af076c M
        drivers

I saved almost all dmesg outputs, if you need some ;-)

Sincerly,

Nico

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmZjDoACgkQuL75KpiFGIwFewCg0Sp+PqzXnzeFHiZCLLFnVhuQ
TWcAn2hrokbUYTT236fArL/l9OQUWv1v
=q+rY
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
