From: Rolf Kutz <rk@vzsze.de>
Subject: Re: New: After Hibernation the battery charging information is not
	working any more.
Date: Mon, 28 Jan 2008 13:57:55 +0100
Message-ID: <20080128125755.GB8471@vzsze.de>
References: <bug-9835-10286@http.bugzilla.kernel.org/> <20080128045053.a07f6539.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp3.netcologne.de ([194.8.194.66]:43362 "EHLO
	smtp3.netcologne.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbYA1NTM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Jan 2008 08:19:12 -0500
Content-Disposition: inline
In-Reply-To: <20080128045053.a07f6539.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28/01/08 04:50 -0800, Andrew Morton wrote:
>On Mon, 28 Jan 2008 04:43:49 -0800 (PST) bugme-daemon@bugzilla.kernel.org =
wrote:
>
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D9835
>>=20
>>            Summary: After Hibernation the battery charging information is
>>                     not working any more.
>>            Product: Power Management
>>            Version: 2.5
>>      KernelVersion: 2.6.24
>>           Platform: All
>>         OS/Version: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: Hibernation/Suspend
>>         AssignedTo: power-management_other@kernel-bugs.osdl.org
>>         ReportedBy: rk@vzsze.de
>>=20
>>=20
>> Latest working kernel version: 2.6.24-rc7
>> Earliest failing kernel version: 2.6.24-rc8
>> Distribution: Kubuntu 7.10
>> Hardware Environment: Lenovo Thinkpad T60
>> Software Environment: Kubuntu with KDE
>> Problem Description: After hibernating the system and resuming, the char=
ging
>> information is not shown any more in guidance-power-manager.
>>=20
>> Steps to reproduce: Hibernate laptop and resume.
>>=20
>
>This regression apparently occurred very late in 2.6.24 development.  It
>should be easy to pinpoint?

I noticed that ACPI_SYSFS_POWER was added in -rc8.
But neither enabling it nor disabling it resolves
the bug.

I will provide additional information if needed.

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHndFT+ZqCAlXyvMsRAtYpAJ9+tMWRv2S3jk5THicKXZF1uzCHlQCcC1va
4HZ4JSA/rW4M7vdi2kGeTvk=
=/yOr
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
