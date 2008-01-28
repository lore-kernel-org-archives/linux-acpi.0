From: Rolf Kutz <rk@vzsze.de>
Subject: Re: New: After Hibernation the battery charging information is not
	working any more.
Date: Tue, 29 Jan 2008 00:29:05 +0100
Message-ID: <20080128232904.GA7723@vzsze.de>
References: <bug-9835-10286@http.bugzilla.kernel.org/> <200801281834.36823.rjw@sisk.pl> <20080128182935.GA7136@vzsze.de> <200801282319.13950.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.netcologne.de ([194.8.194.112]:61816 "EHLO
	smtp2.netcologne.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbYA1X3J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Jan 2008 18:29:09 -0500
Content-Disposition: inline
In-Reply-To: <200801282319.13950.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28/01/08 23:19 +0100, Rafael J. Wysocki wrote:
>>=20
>> Done, the regression is still there.
>
>Hm, there are no ACPI patches between -rc7 and this one ...
>
>(in the linux-2.6 directory) please do
>
>$ git checkout 3ce54450461bad18bbe1f9f5aa3ecd2f8e8d1235
>
>(this should be 2.6.24-rc7, actually) and try to build and test this kerne=
l.

The regression is sitting between keyboard and
chair. :/ The testkernel wasn't working, so I did
a diff of the know to work kernelconfig and the
testkernel:

3,4c3,4
< # Linux kernel version: 2.6.24-rc7-midori20
< # Mon Jan  7 02:56:41 2008
---
> # Linux kernel version: 2.6.24-rc7-test2
> # Mon Jan 28 23:26:04 2008
273c273
< CONFIG_ACPI_SBS=3Dm
---
> # CONFIG_ACPI_SBS is not set

I then compiled 2.6.24 with sbs and it works.
Don't know how it got missing, but I take the
blame.=20

Sorry for my ignorance and thanks for the help,

Rolf

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHnmVA+ZqCAlXyvMsRAi/+AJ9PhkxrXjoINrGV6RKkgdn7DMkpuACffWa9
Xl6Vs6j0Cp5bTmh5hEFs9iY=
=/t5H
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
