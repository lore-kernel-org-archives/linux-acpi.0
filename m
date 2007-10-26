From: Jan Ries <yannek@web.de>
Subject: no C States on Asus L3D with 2.6.22.9
Date: Fri, 26 Oct 2007 22:27:34 +0200
Message-ID: <200710262227.48928.yannek@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1913542.6LqqmNex3d";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:37020 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbXJZU16 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Oct 2007 16:27:58 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 968C5AAA1DF6
	for <linux-acpi@vger.kernel.org>; Fri, 26 Oct 2007 22:27:57 +0200 (CEST)
Received: from [89.49.96.50] (helo=sam)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.108 #208)
	id 1IlVmf-00088G-00
	for linux-acpi@vger.kernel.org; Fri, 26 Oct 2007 22:27:57 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart1913542.6LqqmNex3d
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello to the list.

I stumbled over erratic behavior with a 2.6.22-14 (Ubuntu) Kernel.
The computer is an Asus L3D (L3000D) with an Athlon XP-M 2500+ processor.
The content of /proc/acpi/processor/power reads:
=2D-snip--
active state: C0
max_cstate: C8
bus master activity: 00000000
maximum allowed latency: 8000 usec
states:
=2D-snap--
This is reproducible with a vanilla 2.6.22.9 kernel.

Older kernelversions (e.g. 2.6.17) showed only the C1 state as available wh=
at=20
is quite few, yet more than the current state.

I would be thankful for any hint what to do to investigate this further.

Thank you, and with best regards,

	Jan Ries

=09

--nextPart1913542.6LqqmNex3d
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHIk3ESOWITABwaJQRAuv+AJ9GtP4QhEb8BSKnv09903aPHIXXlwCcD5BF
NJRSI8ru9AcVnYlWfd+914o=
=KWWH
-----END PGP SIGNATURE-----

--nextPart1913542.6LqqmNex3d--
