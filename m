From: Johannes Berg <johannes@sipsolutions.net>
Subject: ACPI vs. hibernate on MacBook5,1
Date: Wed, 15 Apr 2009 15:34:39 +0200
Message-ID: <1239802480.9071.14.camel@johannes.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-7ANVFGYe52NwZEk/HnQs"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:59420 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbZDONfP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Apr 2009 09:35:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>


--=-7ANVFGYe52NwZEk/HnQs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Recently, since I upgraded to -rc1, I've been seeing this at hibernate:

[13875.384603] ACPI: Preparing to enter system sleep state S4
[13875.385232] ACPI Error (hwvalid-0186): Denied AML access to port 0x00000=
00000000080/2 (DMA1 0x0081-0x0083) [20090320]
[13875.385745] ACPI Exception (evregion-0422): AE_AML_ILLEGAL_ADDRESS, Retu=
rned by Handler for [SystemIO] [20090320]
[13875.386244] ACPI Error (psparse-0537): Method parse/execution failed [\P=
8XH] (Node ffff88007e44ef70), AE_AML_ILLEGAL_ADDRESS
[13875.386896] ACPI Error (psparse-0537): Method parse/execution failed [\_=
PTS] (Node ffff88007e44edd0), AE_AML_ILLEGAL_ADDRESS
[13875.387584] PM: Saving platform NVS memory

[13875.960748] ACPI: Waking up from system sleep state S4
[13875.969861] ACPI Error (hwvalid-0186): Denied AML access to port 0x00000=
00000000080/2 (DMA1 0x0081-0x0083) [20090320]
[13875.979217] ACPI Exception (evregion-0422): AE_AML_ILLEGAL_ADDRESS, Retu=
rned by Handler for [SystemIO] [20090320]
[13875.988885] ACPI Error (psparse-0537): Method parse/execution failed [\P=
8XH] (Node ffff88007e44ef70), AE_AML_ILLEGAL_ADDRESS
[13875.998930] ACPI Error (psparse-0537): Method parse/execution failed [\_=
WAK] (Node ffff88007e44ee38), AE_AML_ILLEGAL_ADDRESS
[13876.008648] ACPI Exception (hwsleep-0589): AE_AML_ILLEGAL_ADDRESS, Durin=
g Method _WAK [20090320]

Sometimes it also delays hibernate and/or resume a long time. Or maybe
that's unrelated:

[55143.680741] ACPI: Waking up from system sleep state S4
[55143.689834] ACPI Error (hwvalid-0186): Denied AML access to port 0x00000=
00000000080/2 (DMA1 0x0081-0x0083) [20090320]
[55143.699183] ACPI Exception (evregion-0422): AE_AML_ILLEGAL_ADDRESS, Retu=
rned by Handler for [SystemIO] [20090320]
[55143.708843] ACPI Error (psparse-0537): Method parse/execution failed [\P=
8XH] (Node ffff88007e44ef70), AE_AML_ILLEGAL_ADDRESS
[55143.718881] ACPI Error (psparse-0537): Method parse/execution failed [\_=
WAK] (Node ffff88007e44ee38), AE_AML_ILLEGAL_ADDRESS
[55143.728585] ACPI Exception (hwsleep-0589): AE_AML_ILLEGAL_ADDRESS, Durin=
g Method _WAK [20090320]
[55143.738613] HDA Intel 0000:00:08.0: restoring config space at offset 0x1=
 (was 0xb00006, writing 0xb00002)
[55143.748157] forcedeth 0000:00:0a.0: restoring config space at offset 0x1=
 (was 0xb00003, writing 0xb00007)
[55143.757701] ahci 0000:00:0b.0: restoring config space at offset 0x1 (was=
 0xb00403, writing 0xb00407)
[55164.200732] pci 0000:00:03.2: PME# disabled

(look at the timing)

johannes

--=-7ANVFGYe52NwZEk/HnQs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5eJtAAoJEKVg1VMiehFYD5YP/RwdGWX3tKv74D6f3+JASBPV
2gSjCzcnUmyITQNkva60nOAZRoW+0hgdBki6u9WAUJG6G3QIcEG5D9ULhYbpi79V
D439JxIQpc9JWSOtG1ERimkWgas3e0na2omCl+olQ0/588mNyKTYg8ttpR+Oaog/
Kng3c9SamT2A2GKtpwhQoln2ta8jiSdVCh7BFThBV0iNfrer+fgjR5tJQUUuKary
W0thuigSXvmoHIROOq0Wu6mzSveO1hTkol4zYJmbr6g0peSYhkiCrrQR+4u9GZpl
eo4YewfEmOVYnbGvwO7TqApwqA2w5rbswDRpZx8oHDVfLDGT41flyrTko8+ueTzi
iMCwi65wgLV9++2ygsh4qSbE9v8hPxq4fv0X1kKzaRijpMpd+M/aAnr+x456fKWc
eBtRYwdYjUAzjxPQDy5LoIkGjVynILxSmGpGQ/lVsY7L55o14qx3SJFX7odqUCb1
6h0mxcjnpo/ARjlDbfR4Bq6DrF7BzZO0nBuJ24PZknoqPKH++rzLeERWx1C6Zd28
1HuLPFCvA/ixgziHB+KbMPDIRA9xA9MbLIdZLYzBJ85iE0SA/aB/hrxldZHhHCZM
XGA4peIWxRvNU7o6GauXRUk8DBeZVDjG9dpXyDcYsnVgpC+esq7etZcKqRRE3xJf
yp+Vp91LTA01BIqoqe+r
=O+Mn
-----END PGP SIGNATURE-----

--=-7ANVFGYe52NwZEk/HnQs--

