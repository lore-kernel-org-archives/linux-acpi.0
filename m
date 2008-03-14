From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [2.6.25-rc5-mm1] WARNING: at drivers/base/sys.c:173
Date: Fri, 14 Mar 2008 10:58:17 +0100
Message-ID: <47DA4C39.2030304@imap.cc>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>	 <47D87238.8080305@imap.cc> <20080313195656.GA32463@codemonkey.org.uk>	 <47D9C04E.3060208@imap.cc> <1205456231.4082.2.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0805B2AAF6E7448CC847E1BD"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755740AbYCNJ7S@vger.kernel.org>
In-Reply-To: <1205456231.4082.2.camel@yakui_zhao.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0805B2AAF6E7448CC847E1BD
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Mar 2008 08:57:11 +0800, Zhao Yakui wrote:
> Please set CONFIG_ACPI_DEBUG and boot the system with the option of
> "acpi.debug_layer=3D0x01010000 acpi.debug_level=3D0x1f".

CONFIG_ACPI_DEBUG is already set, but I cannot reboot the machine
right now. I'll probably get a chance for that in about 12 hours.

> It will be great if the acpidump output is attached.

Available now at
http://gollum.phnxsoft.com/~ts/linux/acpidump.out

HTH
T.

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig0805B2AAF6E7448CC847E1BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH2kw5Q3+did9BuFsRAiQfAJ9ktPJAi7bfpWv+cejecN2unJs+VACeLvtV
LpkxqJ7GwcPKg8Xj5VOaYQE=
=Cdst
-----END PGP SIGNATURE-----

--------------enig0805B2AAF6E7448CC847E1BD--
