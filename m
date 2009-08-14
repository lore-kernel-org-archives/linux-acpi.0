From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: acpi_ex_system_memory_space_handler oops
Date: Fri, 14 Aug 2009 12:38:18 +0300
Message-ID: <20090814093818.GD3545@localdomain.by>
References: <20090812201034.GA2983@localdomain.by>
 <alpine.LFD.2.00.0908122009170.22946@localhost.localdomain>
 <20090813124647.GA19195@localdomain.by>
 <1250217283.2987.16.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:57473 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbZHNJfB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 05:35:01 -0400
Content-Disposition: inline
In-Reply-To: <1250217283.2987.16.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I suspect we are dereferencing NULL pointer:
mov    0x8(%ebx)

which is mem_info->mapped_physical_address.

	Sergey
--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iJwEAQECAAYFAkqFMIoACgkQfKHnntdSXjSI6AQAzzYtF5CbfCmcje1XEA+gy7P6
DXxsXjAEVfp2bJijmveSIKoFtGsGU39h5o5Vd1GuVzxagG4QrLlAjwiP9zR6EXz7
LjbDIlvrVFY6FTGwWWhhlge0IwZoLNEkgy22zSsCE/+blIXNJs24l90fsjsIZP9M
ZpErppwGfPKXfn2kCA0=
=Fqeo
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
