From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [2.6.25-rc5-mm1] WARNING: at drivers/base/sys.c:173
Date: Sat, 15 Mar 2008 13:16:46 +0100
Message-ID: <47DBBE2E.2020704@imap.cc>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>	 <47D87238.8080305@imap.cc> <20080313195656.GA32463@codemonkey.org.uk>	 <47D9C04E.3060208@imap.cc> <1205456231.4082.2.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF2688528FC33A86F5BBF460C"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752947AbYCOMRN@vger.kernel.org>
In-Reply-To: <1205456231.4082.2.camel@yakui_zhao.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF2688528FC33A86F5BBF460C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 14.03.2008 01:57 schrieb Zhao Yakui:
>=20
> Please set CONFIG_ACPI_DEBUG and boot the system with the option of
> "acpi.debug_layer=3D0x01010000 acpi.debug_level=3D0x1f".
>=20
> It will be great if the acpidump output is attached.

Ok, that took a bit longer than I hoped, but the result is now
finally available at:

http://gollum.phnxsoft.com/~ts/linux/dmesg-acpidebug.out

Note that I doctored this a bit: the dmesg buffer had already
overflowed by the time I ran the dmesg command, so I manually
prepended the missing part from the file /var/log/boot.msg into
which SUSE saves the early kernel messages. The border between
the two is marked off by the string "~~~~~~~~splice~~~~~~~~",
and I left a line of overlap to make it very clear.

The output of acpidump is unchanged wrt what I already posted.
(Unsurprisingly, but nevertheless I checked. Call me paranoid. ;-)

HTH
T.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigF2688528FC33A86F5BBF460C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH2742MdB4Whm86/kRAv/ZAJ9wHRGJV9wZDxWkk5uUlqCQfaNqjgCeIU3z
fMy1oiGH9kRxMbzJkffG5s8=
=Y1Oo
-----END PGP SIGNATURE-----

--------------enigF2688528FC33A86F5BBF460C--
