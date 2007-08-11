From: Robert Lemmen <robertle@semistable.com>
Subject: Re: fan problem on new mainboard
Date: Sat, 11 Aug 2007 17:13:25 +0200
Message-ID: <20070811151325.GA17406@semistable.com>
References: <20070809085429.GA22070@semistable.com> <1186653689.6830.37.camel@rzhang-asus.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from debian.semistable.com ([80.237.144.212]:35378 "EHLO
	debian.semistable.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003AbXHKPNV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Aug 2007 11:13:21 -0400
Received: from sandbender (dslb-084-057-060-226.pools.arcor-ip.net [84.57.60.226])
	by debian.semistable.com (Postfix) with ESMTP id C4307405E00B
	for <linux-acpi@vger.kernel.org>; Sat, 11 Aug 2007 17:13:19 +0200 (CEST)
Received: from robertle by sandbender with local (Exim 4.63)
	(envelope-from <robertle@semistable.com>)
	id 1IJseb-0004Y6-3m
	for linux-acpi@vger.kernel.org; Sat, 11 Aug 2007 17:13:25 +0200
Content-Disposition: inline
In-Reply-To: <1186653689.6830.37.camel@rzhang-asus.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2007 at 06:01:29PM +0800, Zhang Rui wrote:
> Hi, Robert,
> Please attach the full _dmesg_ output as well as the acpidump.

sorry for the delay, the list seems to eat mails with lareg attachemnts,
therefore you can find the files here:

http://www.semistable.com/files/dmesg
http://www.semistable.com/files/acpidump

(perhaps) interestingly acpidump also said (on stderr):
Wrong checksum for generic table!

as a reminder because it took so long: the problem is that i have
nothing in /proc/acpi/thermal_zone or proc/acpi//fan, and my cpu fan is
spinning like crazy even though my cpu is ice cold

thanks  robert

--=20
Robert Lemmen                               http://www.semistable.com=20

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGvdIVS6AOchRbaWYRAmKYAJ4uAO/Zc5IVux5VJA9Vx9vctmbftwCgkz0g
BHRFwb+ZDagi64X2Q043to0=
=ZRGc
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
