From: Nico Golde <nion@gmx.net>
Subject: inconsistency in /proc/acpi directory structure?
Date: Thu, 9 Aug 2007 14:39:43 +0200
Message-ID: <20070809123943.GD3939@ngolde.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:53110 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452AbXHIMjq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Aug 2007 08:39:46 -0400
Received: from ngolde.de (e178112220.adsl.alicedsl.de [85.178.112.220])
	by post.webmailer.de (klopstock mo22) (RZmta 10.3)
	with ESMTP id R0628fj79AQR6v for <linux-acpi@vger.kernel.org>;
	Thu, 9 Aug 2007 14:39:44 +0200 (MEST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I wrote some shared library to get ACPI values for user=20
space acpi tools and came to a problem.

I check if an ACPI feature exists by checking for its=20
directory, e.g. /proc/acpi/fan.

The problem with this is, that this gets created when the=20
specific module is loaded, so if you load the module but=20
your system does not support it properly you get an empty=20
directory.

But even checking for an empty directory is not enough since=20
there comes ibm-acpi (maybe others).

With working fan and usage of ibm-acpi you also get an empty=20
/proc/acpi/fan dir because you have /proc/acpi/ibm/fan where=20
you can then find the relevant files.
This sucks, I mean I can implement a workaround for this,=20
but if asus-acpi would do the same and maybe others would=20
exists I have to check alot of directories. So why not using=20
the existing directory structure?

I am not sure if this is a bug in ibm-acpi or an=20
inconsistency in the kernel since to me it is not obvious to=20
just create the directory in module modprobing, why not=20
doing it when dumping the first data to a file?

Why is ibm-acpi not using the existing directory structure=20
(also wrote to the ibm-acpi guys but with no answer so far,=20
so I try to get answers here)? Do I miss anything?


I hope this is the right list for my questions, please point=20
me to the right direction if not.
Kind regards
Nico
P.S Please Cc me, I am not subscribed.

--=20
Nico Golde - http://ngolde.de - nion@jabber.ccc.de - GPG: 0x73647CFF
For security reasons, all text in this mail is double-rot13 encrypted.

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGuwsPHYflSXNkfP8RAn7MAJ9PEEzUkR9dkOsqKxCUn6vDI/yLUACfT+lR
e8OqIO4A/hv2dr41DXIUS2M=
=gFnz
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
