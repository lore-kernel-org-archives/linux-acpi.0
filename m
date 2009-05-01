From: The Holy ettlz <theholyettlz@googlemail.com>
Subject: Inconsistent processor throttling behaviour on Clevo M720R/Intel
 T8100
Date: Fri, 01 May 2009 16:43:17 +0100
Message-ID: <1241192597.2554.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-IYvZAar7noKCWVR3ac6Y"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:52319 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbZEAPnZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 May 2009 11:43:25 -0400
Received: by ewy24 with SMTP id 24so2493769ewy.37
        for <linux-acpi@vger.kernel.org>; Fri, 01 May 2009 08:43:24 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-IYvZAar7noKCWVR3ac6Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

I'm encountering a problem on my notebook (Clevo M720R) with an Intel
T8100 processor whereby Core 0 is always in the T3 throttling state
following a reboot. There is no thermal reason why this should be so,
and it is quite annoying having to force all computationally-intensive
tasks onto Core 1 (which is unthrottled). This is reflected in the
benchmarks: Core 0 takes around 21s to do what Core 1 does in 12s.

In the /proc tree,=20


$ cat /proc/acpi/processor/CPU0/throttling=20
state count:             8
active state:            T3
state available: T3 to T7
states:
    T0:                  100%
    T1:                  88%
    T2:                  75%
   *T3:                  63%
    T4:                  50%
    T5:                  38%
    T6:                  25%
    T7:                  13%

$ cat /proc/acpi/processor/CPU1/throttling=20
state count:             8
active state:            T0
state available: T0 to T7
states:
   *T0:                  100%
    T1:                  88%
    T2:                  75%
    T3:                  63%
    T4:                  50%
    T5:                  38%
    T6:                  25%
    T7:                  13% =20


If I boot with acpi=3Doff, there is no problem and I get full performance
from both cores. Now, if I suspend and resume, the situation changes.
The active state is outside the reported range:


$ cat /proc/acpi/processor/CPU0/throttling=20
state count:             8
active state:            T8
state available: T3 to T7
states:
    T0:                  100%
    T1:                  88%
    T2:                  75%
    T3:                  63%
    T4:                  50%
    T5:                  38%
    T6:                  25%
    T7:                  13%

$ cat /proc/acpi/processor/CPU1/throttling=20
state count:             8
active state:            T8
state available: T0 to T7
states:
    T0:                  100%
    T1:                  88%
    T2:                  75%
    T3:                  63%
    T4:                  50%
    T5:                  38%
    T6:                  25%
    T7:                  13%


I get full performance from both cores in this case.

Any suggestions, and what additional info would be useful? In the
meantime, is there any way to disable throttling without taking out the
rest of ACPI and thermal so that I can get my notebook's full
performance from the outset?

Many thanks,
James.

--=20
The Holy ettlz                              TheHolyettlz@googlemail.com
PGP key ID: 03F94B5D
-----------------------------------------------------------------------


--=-IYvZAar7noKCWVR3ac6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkn7GJQACgkQL/Is9AP5S122dQCfX231FVscMEKr05ozB3Go5H89
MTcAoM0mWOOZF6vxfrW/tsqT1T41Edh+
=6+G0
-----END PGP SIGNATURE-----

--=-IYvZAar7noKCWVR3ac6Y--

