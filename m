From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: acpi_ex_system_memory_space_handler oops
Date: Fri, 14 Aug 2009 10:53:57 +0300
Message-ID: <20090814075357.GA3545@localdomain.by>
References: <20090812201034.GA2983@localdomain.by>
 <alpine.LFD.2.00.0908122009170.22946@localhost.localdomain>
 <20090813124647.GA19195@localdomain.by>
 <1250217283.2987.16.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.211.193]:59164 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845AbZHNHul (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 03:50:41 -0400
Content-Disposition: inline
In-Reply-To: <1250217283.2987.16.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Could you please help to locate the line of code that causes oops, as
> below?
>=20

$ addr2line -e ./vmlinux -i -f c12a77ca
acpi_ex_system_memory_space_handler
/media/dev/kernel/kernel-git/linux-2.6/drivers/acpi/acpica/exregion.c:129

exregion.c:129
        [...]=20
        /*
         * Does the request fit into the cached memory mapping?
         * Is 1) Address below the current mapping? OR        =20
         *    2) Address beyond the current mapping? =20
         */
        if ((address < mem_info->mapped_physical_address) ||
            (((acpi_integer) address + length) > ((acpi_integer)
                                                  mem_info->
                                                  mapped_physical_address +=
  =20
                                                  mem_info->mapped_length))=
) {
                /*
                 * The request cannot be resolved by the current memory map=
ping;
                 * Delete the existing mapping and create a new one.       =
    =20
                 */
                if (mem_info->mapped_length) {
        [...]
            =20

        Sergey

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iJwEAQECAAYFAkqFGBUACgkQfKHnntdSXjRM4AQAn12hwvEv2TRn/CiaYNMwWb0E
y3JX0ybU17dYp+BbhA68ta1gkbMaH7ozfqWtfZ+OSNeqFte6faMhDBuMFydrldzk
p+LzNssbM/9bVb0iKxVo7KrDj0kkmsbOyKRILK8hwjmzvhTdMUAP4CxfarELU51X
rkup6O7fDW+5UKlULz4=
=jpCt
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
