From: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ACPI] Re: [PATCH/RFC] exposing ACPI objects in sysfs
Date: Tue, 21 Sep 2004 21:21:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1095794482.21532.17.camel@laptop.fenrus.com>
References: <1095716476.5360.61.camel@tdi>
	 <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi>
	 <20040921172625.GA30425@elf.ucw.cz>  <20040921190606.GE18938@wotan.suse.de>
	 <1095794035.24751.54.camel@tdi>
Reply-To: arjanv@redhat.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2Uc9tMqMO7Ykamqqpj04"
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267993AbUIUTWE@vger.kernel.org>
In-Reply-To: <1095794035.24751.54.camel@tdi>
To: Alex Williamson <alex.williamson@hp.com>
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>, acpi-devel <acpi-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


--=-2Uc9tMqMO7Ykamqqpj04
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-21 at 21:13, Alex Williamson wrote:
> this interface.  They are not actually pointers.  I believe the 32bit
> emulation problem is limited to an ILP32 application generating data
> structures appropriate for an LP64 kernel.  While difficult, it can be
> done.

more like a LP64 kernel getting data structures a ILP32 application
generated and needing to make sense of it.


--=-2Uc9tMqMO7Ykamqqpj04
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBUH8xxULwo51rQBIRAqrpAKCeJmEwOddXdiEtgTBEDTbTzWbP9gCfXWqf
9mVJFTj2nLLH3lcEHoJU9n0=
=yhfj
-----END PGP SIGNATURE-----

--=-2Uc9tMqMO7Ykamqqpj04--
