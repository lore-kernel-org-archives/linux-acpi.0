From: Forest Bond <forest@alittletooquiet.net>
Subject: acpi-cpufreq; Intel Johnstown (Atom N270)
Date: Thu, 13 Aug 2009 13:25:57 -0400
Message-ID: <20090813172556.GB9385@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:58179 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbZHMRbq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Aug 2009 13:31:46 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm using an Intel Johnstown board with an Atom N270 processor.  Performance
seems to improve dramatically with acpi-cpufreq loaded.  This caught me by
surprise.  I had assumed that without loading acpi-cpufreq the CPU would be
running at its maximum speed all the time.

I have a few questions:

* Is it normal for performance to improve with acpi-cpufreq loaded?
* /proc/cpuinfo always reports the CPU's maximum clock speed when acpi-cpuf=
req
  is not loaded, which seems to be inconsistent with my performance
  observations.  Does that seem normal?
* Does acpi-cpufreq impact performance in any way besides controlling CPU
  frequency?
* What governs CPU frequency when acpi-cpufreq is not loaded?

Any input would be appreciated.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFKhEykRO4fQQdv5AwRAqlQAJ9mcAmqIpdKiTHqnnM1y3x68y8XJACeKpsd
KyLCuNop8mhhtkyXmkxrZHI=
=wqwQ
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
