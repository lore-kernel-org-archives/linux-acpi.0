From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] acpi: simplify module_param namespace
Date: Wed, 11 Mar 2009 14:51:24 +1100
Message-ID: <20090311145124.696b2448.sfr@canb.auug.org.au>
References: <200903071328.28113.rusty@rustcorp.com.au>
	<1236565244.7060.7.camel@localhost.localdomain>
	<200903110927.12792.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__11_Mar_2009_14_51_24_+1100_JZOhDI.MCC=wDBh."
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:48683 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987AbZCKDvc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2009 23:51:32 -0400
In-Reply-To: <200903110927.12792.rusty@rustcorp.com.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: yakui_zhao <yakui.zhao@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--Signature=_Wed__11_Mar_2009_14_51_24_+1100_JZOhDI.MCC=wDBh.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rusty,

On Wed, 11 Mar 2009 09:27:12 +1030 Rusty Russell <rusty@rustcorp.com.au> wr=
ote:
>
> This version is bigger, but simpler, and doesn't change link order.  It j=
ust
> moves everything into the acpi module.

So we end up with one big acpi.ko module instead of separate modules
(like battery.ko, dock.ko) some of which we may not have needed to
load?  Just clarifying.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__11_Mar_2009_14_51_24_+1100_JZOhDI.MCC=wDBh.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkm3NTwACgkQjjKRsyhoI8yvHgCeKKvKh4MX7k6xkmU7kkGgD/Qq
9iEAn0+O7n0sAFBIgBQjtqCO06R0podc
=nGiE
-----END PGP SIGNATURE-----

--Signature=_Wed__11_Mar_2009_14_51_24_+1100_JZOhDI.MCC=wDBh.--
