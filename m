From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: acpi_ex_system_memory_space_handler oops
Date: Fri, 14 Aug 2009 12:12:02 +0300
Message-ID: <20090814091202.GB3545@localdomain.by>
References: <20090812201034.GA2983@localdomain.by>
 <alpine.LFD.2.00.0908122009170.22946@localhost.localdomain>
 <20090813124647.GA19195@localdomain.by>
 <1250217283.2987.16.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:51465 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbZHNJIp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 05:08:45 -0400
Content-Disposition: inline
In-Reply-To: <1250217283.2987.16.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>which I belive is (marked with __):
>        /*
>         * Does the request fit into the cached memory mapping?
>         * Is 1) Address below the current mapping? OR
>         *    2) Address beyond the current mapping?
>         */
>        if ((__ address __ < mem_info->mapped_physical_address) ||
>            (((acpi_integer) address + length) > ((acpi_integer)
>

I was wrong. Sorry.

	Sergey

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iJwEAQECAAYFAkqFKmIACgkQfKHnntdSXjT7OwP+Mp308FS3KFmfIOfYdXL12Kze
nHgVGZrTkc7aOUQtzxWNL6pmJiCHINACvh4MVKVOJpqIiKBRLNboZ5fu/+6tQWoR
rSToH8KbQNeMtquXfAwlwMcR1tuwX0cxUBaCZTAXBaAPWRZ2gejf6RUmRvXqM8jj
utSR6B7HUKKhD1Gc3U0=
=5IU9
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
