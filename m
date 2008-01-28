From: Rolf Kutz <rk@vzsze.de>
Subject: Re: New: After Hibernation the battery charging information is not
	working any more.
Date: Mon, 28 Jan 2008 19:29:36 +0100
Message-ID: <20080128182935.GA7136@vzsze.de>
References: <bug-9835-10286@http.bugzilla.kernel.org/> <200801281734.07679.rjw@sisk.pl> <20080128170548.GF8471@vzsze.de> <200801281834.36823.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.netcologne.de ([194.8.194.112]:62254 "EHLO
	smtp2.netcologne.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbYA1S3i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Jan 2008 13:29:38 -0500
Content-Disposition: inline
In-Reply-To: <200801281834.36823.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28/01/08 18:34 +0100, Rafael J. Wysocki wrote:
>On Monday, 28 of January 2008, Rolf Kutz wrote:
>> On 28/01/08 17:34 +0100, Rafael J. Wysocki wrote:
>> >On Monday, 28 of January 2008, Rolf Kutz wrote:
>> >> On 28/01/08 17:06 +0100, Rafael J. Wysocki wrote:
>> >> >On Monday, 28 of January 2008, Rolf Kutz wrote:
>> >> >> On 28/01/08 16:16 +0100, Rafael J. Wysocki wrote:
>> >> >> >On Monday, 28 of January 2008, Rolf Kutz wrote:
>> >> >
>> >> >Would you be able to install git and use it for downloading kernel s=
ources?
>> >>=20
>> >> Yes, I can install it, but I'm not familiar with it.
>> >
>> >No problem.  http://linux.yyz.us/git-howto.html#getting_started should =
be
>> >sufficient for starters and I'll tell you what to do next.
>>=20
>> Installed git and pulled Linus tree, like described in the howto.
>
>OK, thanks.
>
>We're going to carry out a bisection over several commits.
>
>Please go to the linux-2.6 directory and do:
>
>$ git checkout 88fb61e4ba263685a0d5b82c7e9cd6f22a9e6a9d
>
>Then, compile the kernel and test it.

Done, the regression is still there.

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHnh8P+ZqCAlXyvMsRAnpeAJwOJpQfy6VvXoD5oUFRFRi2MyynGACcDFfT
5jpPo5Pkffu6iq0jwbFlFSI=
=sGSW
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
