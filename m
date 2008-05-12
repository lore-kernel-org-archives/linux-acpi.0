From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [2.6.26-rc1] WARNING: at drivers/base/sys.c:183
Date: Tue, 13 May 2008 00:57:51 +0200
Message-ID: <4828CB6F.5060808@imap.cc>
References: <48273860.1000103@imap.cc> <20080511202416.GA5771@beyonder.ift.unesp.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig533BCCE4AC90BF2D5638D5B7"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40970 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755691AbYELW6G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 May 2008 18:58:06 -0400
In-Reply-To: <20080511202416.GA5771@beyonder.ift.unesp.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Carlos R. Mafra" <crmafra2@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, yakui.zhao@intel.com, davej@codemonkey.org.uk

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig533BCCE4AC90BF2D5638D5B7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 11.05.2008 22:24 schrieb Carlos R. Mafra:
> On Sun 11.May'08 at 20:18:08 +0200, Tilman Schmidt wrote:
>> This warning, first reported for 2.6.25-rc5-mm1
>> (see http://lkml.org/lkml/2008/3/12/444)
>> has now made it into mainline:
[...]
> Isn't it fixed by db176c6ed8974fae94328ad5ac9e70b094ff22fd=20
> ("Fix bogus warning in sysdev_driver_register()") ?


It is indeed. After applying that patch to 2.6.26-rc1, the warning does n=
ot appear anymore.

Thanks,
Tilman


--------------enig533BCCE4AC90BF2D5638D5B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIKMt6Q3+did9BuFsRAncEAJ9qcupYbrvUUIp+u0gwWlEw9Rrb/ACgjMn4
U3nl8Z5ZpXzcPS17WiFzNxM=
=FfIm
-----END PGP SIGNATURE-----

--------------enig533BCCE4AC90BF2D5638D5B7--
