From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: linux-next 20160512 - ACPI issue with screen brightness
Date: Tue, 17 May 2016 14:41:02 -0400
Message-ID: <4736.1463510462@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1463510462_2853P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:58364 "EHLO
	omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751707AbcEQSmI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2016 14:42:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

--==_Exmh_1463510462_2853P
Content-Type: text/plain; charset=us-ascii

next-20160512 sets the screen brightness to about 40%-ish or so, rather
than the 100% intensity I want.

Dell Latitude E6530 laptop.

git bisect tells me:

059500940defe285222d3b189b366dfe7f299cae is the first bad commit
commit 059500940defe285222d3b189b366dfe7f299cae
Author: Aaron Lu <aaron.lu@intel.com>
Date:   Wed Apr 27 20:45:04 2016 +0800

    ACPI/video: export acpi_video_get_levels

    The acpi_video_get_levels is useful for other drivers, i.e. the
    to-be-added int3406 thermal driver, so export it.

    Signed-off-by: Aaron Lu <aaron.lu@intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

:040000 040000 24f4f5abe8beda2fa219dee7549faacc2f63e29f dfbe3a3bb4f58d82d5be768263d91172276fed98 M      drivers
:040000 040000 603ffbf36e76717fe4f4ecb0418c9dbc59c76e25 a559bcd81c949a6471ffd045866df9b4e3fa4406 M      include


but I've stared at the code and don't see what would do this....


--==_Exmh_1463510462_2853P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVztlvgdmEQWDXROgAQKJqg//TQSr4rfJ7E9AvJMdK2ghPEklXDI+3R18
D4H3NNg2Dt1UoVSS3QF6mt07kIpI7CT28OLVjsuF8V+I5xAEfZTNVZ6LlE45N6TS
+nYZTiEpIK6O/nHV8Riux5G1ugfukkXkOFnyCdCInmux/4B6zX5NuNgejH3fctan
Qs1dO4kYgwwlwtoXzLLl72khdXD86QoWN93dVOQCaxVVthPKi3D/q9nAgvRFD5oZ
VXM5bnrZ1yicxjmktU5/nwxbBFEpV54iu5y2easpbwgBbd5J8hmlBwsC+UVdg8ik
HFz18v//gvQYjyFOd9AQ/hewBWBVqdEDTO7pA1WbklF060pWttjn5d3a8JqB+T1r
K7EFdLjttBgfKGxjOaQ7+OV8/gImnj2wvgatHkqhOLeIbq/7qXV4Byylo6NQZB49
F1tkvnUQbxJUws3Dz0j9CkkFS4l7oQGBBmtNCsHAjzcm5jygFJV3Dsvo0A8LHrBZ
ClJxzax9Xjpov9G1zNScPGb8X2jgVtx9kevmdWdZNgIwSy//ILyqJlPolbaeQiqP
KjzXx2iNBrUavjDFJrLe83jGfr94ghJBwtLsDHElmInDraHFomDFSVgg5ZT5Oeop
geLxxfnE9QZALtZ/jniPrM7vtMohabeFKdP4wfrll59MiLuIceHgfUzN0BjprFmF
Jo745wj4M0M=
=IGVO
-----END PGP SIGNATURE-----

--==_Exmh_1463510462_2853P--
