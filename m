From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [2.6.24-rc1][BUG] Oops on battery removal
Date: Fri, 2 Nov 2007 09:37:33 +0100
Message-ID: <200711020937.33672.eike-kernel@sf-tec.de>
References: <200711020803.49608.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6457516.6vRJRSPn98";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:48854 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705AbXKBIhk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Nov 2007 04:37:40 -0400
In-Reply-To: <200711020803.49608.eike-kernel@sf-tec.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de, kernel list <linux-kernel@vger.kernel.org>

--nextPart6457516.6vRJRSPn98
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Rolf Eike Beer wrote:
> Hi,
>
> this happened while I removed my battery on bootup. Complete dmesg is
> attached. Kernel is 2.6.24-rc1-git of yesterday (last commit was
> d919fd433b5823d1cf9d0688eb2eec183de9b74c).

Ok, I found out that it has nothing to do with the actual removal as it see=
ms.=20
When I start the laptop with battery already detached I get the same error.

Eike

--nextPart6457516.6vRJRSPn98
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBHKuHNXKSJPmm5/E4RAsGkAKCPJsedt8FGTavlgecZX41cw3IMxwCgne5x
gIaxpyVhVZXGY95RGXVwihM=
=gx7D
-----END PGP SIGNATURE-----

--nextPart6457516.6vRJRSPn98--
