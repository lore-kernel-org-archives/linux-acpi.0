From: Robert Lemmen <robertle@semistable.com>
Subject: Re: fan problem on new mainboard
Date: Fri, 17 Aug 2007 12:35:12 +0200
Message-ID: <20070817103512.GB8363@semistable.com>
References: <20070809085429.GA22070@semistable.com> <1186653689.6830.37.camel@rzhang-asus.sh.intel.com> <20070811151325.GA17406@semistable.com> <1187269700.8780.771.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from debian.semistable.com ([80.237.144.212]:52309 "EHLO
	debian.semistable.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbXHQKfK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Aug 2007 06:35:10 -0400
Received: from sandbender (dslb-084-057-042-002.pools.arcor-ip.net [84.57.42.2])
	by debian.semistable.com (Postfix) with ESMTP id 52DC2405E007
	for <linux-acpi@vger.kernel.org>; Fri, 17 Aug 2007 12:35:08 +0200 (CEST)
Received: from robertle by sandbender with local (Exim 4.63)
	(envelope-from <robertle@semistable.com>)
	id 1ILzAe-0002Hx-6c
	for linux-acpi@vger.kernel.org; Fri, 17 Aug 2007 12:35:12 +0200
Content-Disposition: inline
In-Reply-To: <1187269700.8780.771.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2007 at 03:08:20PM +0200, Thomas Renninger wrote:
> Your ACPI DSDT table does not show any thermal/fan control code.
> So you won't be able to do much through ACPI.
> Have you already searched for a BIOS update?
> If you still have problems, maybe you find something in the BIOS
> configuration...

bios configuration is fine, the bios changelog update doesn't say
anything about fans or such, but i'll try anyway. this is gonna be a
drag without a floppy drive or a windows boot disk...

anyway, thnks for the info, i'll do the update and see if this improves
things.

cu  robert

--=20
Robert Lemmen                               http://www.semistable.com=20

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGxXngS6AOchRbaWYRAnQkAJ9yGE/xPD4VbHwi6vzwro8QQY7eSQCgqqtx
PcC99H8DAONSXUw9mCsXXT8=
=Mdaq
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
