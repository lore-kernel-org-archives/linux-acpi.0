From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: preparing toshiba_acpi driver release
Date: Mon, 26 Jan 2004 12:44:36 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8A4B@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi John,
In general, it it is best to have smaller patches which are single
logical changes so that they can be reviewed as a unit, tested as a
unit, and applied or un-applied as a unit.  However, if the changes are
small, grouping several together is fine.

Also, if the patch applies both to 2.4 and 2.6, but the patch is
different, then I appresiate getting both patches rather than having to
port the patch myself.

Note that the strategy going forward is to create a generic acpi/video
extensions driver that works on all platforms.  When it is available, we
should remove the video functionality from toshiba_extras and
asus_extras.
http://bugzilla.kernel.org/show_bug.cgi?id=3D1944

If anybody is excited about doing this, I'd be happy to work with a
volunteer.

Thanks,
-Len


> -----Original Message-----
> From: John Belmonte [mailto:john-wanGne27zNesTnJN9+BGXg@public.gmane.org]=20
> Sent: Monday, January 26, 2004 11:33 AM
> To: Brown, Len
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: preparing toshiba_acpi driver release
>=20
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hello Len,
>=20
> I'm preparing a new release of the toshiba_acpi driver.  Below is the
> tentative changelog.  I haven't been following the check-in policy of
> the kernel or acpi subsystem lately, so I'm wondering if I=20
> can give this
> to you as a single patch or do you need it in several parts.
>=20
>=20
> ~  * Fix remote chance of invalid buffer access in write_video.
>=20
> ~  * Support alternate HCI method path (recent "Phoenix BIOS"=20
> Toshiba's).
>=20
> ~  * Report more proc-write errors.
>=20
> ~  * On proc-reads, report errors via printk instead of proc output.
>=20
> ~  * Add level to all printk's.
>=20
> ~  * Add missing __init and __exit function attributes.
>=20
>=20
> Regards,
> - -John Belmonte
>=20
>=20
> - --
> http:// if  ile.org/
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>=20
> iD8DBQFAFUE35Nfg6kxAQQoRAjQaAKCsdt8QoBH6w2TbtyPSzfpEy1ywMACguflq
> cc6Z79zaEhCmj4C9USs5TBE=3D
> =3Doq55
> -----END PGP SIGNATURE-----
>=20


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
