From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Subject: Re: 2.6.24-rc1-g74521c28: oops during boot [<ffffffff881c03e4>]
 :power_supply:power_supply_show_property+0x94/0x150
Date: Sun, 11 Nov 2007 12:57:16 +0100
Message-ID: <4736EE1C.3010500@archlinux.org>
References: <472C5C2D.9010700@archlinux.org> <200711031926.01665.rjw@sisk.pl>
 <472CC005.4070609@archlinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary=------------enig9AB15FC5CEB74FBE31037014
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755562AbXKKL5b@vger.kernel.org>
In-reply-to: <472CC005.4070609@archlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9AB15FC5CEB74FBE31037014
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Thomas B=E4chler schrieb:
> Rafael J. Wysocki schrieb:
>> On Saturday, 3 November 2007 12:31, Thomas B=E4chler wrote:
>>> I am trying to boot 2.6.24-rc1-g74521c28 from the linux-2.6 git tree.=

>>> During boot, I get a kernel oops when udevtrigger is running, thus mo=
st
>>> devices are not created and the boot stalls.
>>>
>>> Fortunately, the services are still started (though I don't see anyth=
ing
>>> due to missing ttys) and syslog caught the oops. The logfile and conf=
ig
>>> are attached.
>> Can you please attach these files to the bugzilla entry at:
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D9299
>=20
> Done.

I just tested again (with 2.6.24-rc2-gecd744ee). If I only load the 'ac'
kernel module and not the 'battery' kernel module, then the system boots
fine. However, if I load the 'battery' module during boot or later, I
still get the oops.

I am running 2.6.24-rc2-gecd744ee right now, but without the battery
module. I am forwarding this to the ACPI list as well.


--------------enig9AB15FC5CEB74FBE31037014
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHNu4cEda5KzHP/VARCGxEAJ9A9vYN5f1Lyhw0NAjcZrIGm/+WDACfZP7e
NEUArz1OFSJAPXsummeJOyk=
=tA6m
-----END PGP SIGNATURE-----

--------------enig9AB15FC5CEB74FBE31037014--
