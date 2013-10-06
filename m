From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [050/121] ACPI / battery: Fix parsing _BIX return value
Date: Sun, 06 Oct 2013 23:21:07 +0100
Message-ID: <1381098067.2788.37.camel@deadeye.wl.decadent.org.uk>
References: <18659783.iZRLPaKV6J@aoki>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-QYcG7JiRLbUdHX3XyR9X"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51466 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754664Ab3JFWVT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Oct 2013 18:21:19 -0400
In-Reply-To: <18659783.iZRLPaKV6J@aoki>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Francisco Castro <fcr@adinet.com.uy>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org


--=-QYcG7JiRLbUdHX3XyR9X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2013-10-01 at 01:01 -0300, Francisco Castro wrote:
> From: Ben Hutchings <ben@decadent.org.uk>
> > 3.2.51-rc1 review patch.  If anyone has any objections, please let me k=
now.
> >=20
> > ------------------
> > From: Lan Tianyu <tianyu.lan@intel.com>
> >=20
> > commit 016d5baad04269e8559332df05f89bd95b52d6ad upstream.
> >=20
> > The _BIX method returns extended battery info as a package.
> > According the ACPI spec (ACPI 5, Section 10.2.2.2), the first member
> > of that package should be "Revision".  However, the current ACPI
> > battery driver treats the first member as "Power Unit" which should
> > be the second member.  This causes the result of _BIX return data
> > parsing to be incorrect.
> >=20
> > Fix this by adding a new member called 'revision' to struct
> > acpi_battery and adding the offsetof() information on it to
> > extended_info_offsets[] as the first row.
[...]
> Hello,
>=20
> Before anything, sorry for my broken english, and thank you all for readi=
ng my=20
> mail.
>=20
> I noticed this patch, since it happened to be added recently to the stand=
ard=20
> ubuntu kernel 3.8.0.31; and these two lines makes the battery module fail=
 with=20
> laptop (a NEC LZ750/LS) which previously worked. After removing these two=
=20
> lines and recompiling, it worked again.
>=20
> The lines that dmesg is now showing, are:
>=20
> [    2.272970] ACPI Warning: For \_SB_.PCI0.LPCB.EC__.BAT1._BIX: Return=
=20
> Package is too small - found 19 elements, expected 20 (20121018/nspredef-=
679)
> [    2.272985] battery: probe of PNP0C0A:00 failed with error -14
>=20
> I believe a new (working) patch is needed, since this breaks compatibilit=
y=20
> with hardware that's somewhat new, and still on sale. I hope this mail is=
 not=20
> too late, and this can be fixed.

You should report this to the Ubuntu kernel maintainers via Launchpad so
they can make a decision whether to revert this change in their packaged
kernel.

Hopefully Lan Tianyu and other ACPI developers will work out how to fix
this completely and then that fix can go into later stable updates.

I only look after the stable 3.2.y branch, so there's little I can do to
help you beyond this.

Ben.

--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, reading IRC for the first time

--=-QYcG7JiRLbUdHX3XyR9X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIVAwUAUlHiU+e/yOyVhhEJAQoDZA//V8XBn1uG5oJSCy1WjYInFhPActqG9YJ9
S5NuipuFq19jNSChme8zb02wuzqPtAOew5ZvclcFbtMOGKrobWYM3IIV9J2ACfsz
mnUZcy9a+WbcY47t7JKT28qIX6yybMrvpR1UU921MigDCVKlx1xOiBhpx/UvZRnr
v88+voOMnAdkdIlXtGPPbxKle9zSuUldAZAMsY8VQZXxLOi4kVlI6QC8isKfR4ZS
OvXIhcVyn1unAZ/zG25Pa43c0FbRO7RMjTebr5gHLnOcGzPVEmO3uL19N3pKljnJ
J8KrL0TNplCD33aKPr1a3Yh0tzvcGc/o3GMoLLsARdQ0SyQWJGCVYDOVyJNgbSC/
HDgaWFj9cvInXYYMwqU7TxlRP/0X7qMi/mZS8X6t2uhTZV7IWGyJrbC3OF7T8Xyc
9ZKmvTyMMJXdANPtb6ba4g/GWuY0DHPxpZTpD8cR9mKLpwX/MjfGOyKdgUYbCZX7
6l8CaZfQy4sbiOBu31ashLotBfwdyAwoVczgbDNTjnXtnPb7PvS7PpCydHkelj+G
IQ1rTeKygOA8NVtG2uDYMe3eO11mDQSq3ON0hQIWzNq/dFJBBQ0aD9W0ScJzngMV
3uhcZ0lhISs+rY2fL0Uc7mmr8Oj7uc1k5T3y7rnt/x8KP26SkHm0qvDq0rx3raQQ
A6xQpeFNGD8=
=/SvY
-----END PGP SIGNATURE-----

--=-QYcG7JiRLbUdHX3XyR9X--
