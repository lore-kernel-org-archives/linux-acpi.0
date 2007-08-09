From: Nico Golde <nion@gmx.net>
Subject: Re: inconsistency in /proc/acpi directory structure?
Date: Thu, 9 Aug 2007 19:45:28 +0200
Message-ID: <20070809174528.GA7282@ngolde.de>
References: <20070809123943.GD3939@ngolde.de> <200708091202.54943.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cg-p07-fb.rzone.de ([81.169.146.215]:56377 "EHLO
	cg-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbXHIRqm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Aug 2007 13:46:42 -0400
Received: from mo-p07-ob.rzone.de (fruni-mo-p07-ob.mail [192.168.63.183])
	by gibbsson-fb-03.store (RZmta 10.2) with ESMTP id i068c2j79GQiFs
	for <linux-acpi@vger.kernel.org>; Thu, 9 Aug 2007 19:46:40 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <200708091202.54943.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
* Len Brown <lenb@kernel.org> [2007-08-09 19:25]:
> I have to second what Henrique wrote.
> Please avoid /proc/acpi/* whenever you can can.
> We are trying to get rid of it completely,
> but that is only partly done.

I know about that and it's a typical kernel hacker argument,=20
but don't forget people want to have working software in the=20
meantime of your switch ;)

> I really resist changes to /proc/acpi/* because
> I consider it legacy and would rather the effort
> be focused on the new sysfs interfaces.

I will switch step by step. From what I can see not really=20
much things apart from the acpi version already switched to=20
sysfs. Maybe I missed it. I will answer in detail on=20
Henriques mail hopefully tomorrow.
Kind regards and thanks for your quick replies
Nico
--=20
Nico Golde - http://ngolde.de - nion@jabber.ccc.de - GPG: 0x73647CFF
For security reasons, all text in this mail is double-rot13 encrypted.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGu1K4HYflSXNkfP8RAlKdAJ9rIi3sWUa7S+Tsudjm4AaWQrowfACfZA0Z
ew/Ah9Dcsv6Boz3YlblGuko=
=nG87
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
