From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: acpi_ex_system_memory_space_handler oops
Date: Thu, 13 Aug 2009 15:46:47 +0300
Message-ID: <20090813124647.GA19195@localdomain.by>
References: <20090812201034.GA2983@localdomain.by>
 <alpine.LFD.2.00.0908122009170.22946@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:5340 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352AbZHMMne (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Aug 2009 08:43:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0908122009170.22946@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Looks like regression is in the current RC.

Looks like it isn't. On 17th reboot rc5-git0 crashed.
(I'll recompile and try more.)
I think bisecting here is kind of senseless. You never know how much reboot=
s you need.
Simple delay (like vga=3D791) - and everything is ok. We need to come up wi=
th something=20
more clever, I guess.

Any thougths?

	Sergey
--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iJwEAQECAAYFAkqECzcACgkQfKHnntdSXjRzxAQAwSiILqK8tSW586mdem1FZefu
gYnqzwagUI7YmSyRwrtXYJMNo0jBsMSSoEm9wHuCk3euMKaNSa9HugGVtZGtKW3a
i30UVWCHtFI84DATrGckMDIjwGDq3NgO7SsAhC/CA4RAtkUbuTsiPYn+tDRwc2V3
jGc7tEVrynri3CkunvA=
=iZvp
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
