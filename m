From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Working around bugs in ACPI BIOS [was Re: DSDT in initrd]
Date: Mon, 19 May 2003 11:49:34 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96EA5@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C31E37.64000C6A"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>, Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C31E37.64000C6A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Against 2.4-acpi-latest.

Completely untested. Does this work?

-- Andy

> -----Original Message-----
> From: Grover, Andrew=20
> Sent: Monday, May 19, 2003 10:51 AM
> To: Cagle, John (ISS-Houston); Kevin Fenzi;=20
> acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: Working around bugs in ACPI BIOS [was Re: [ACPI]=20
> DSDT in initrd]
>=20
>=20
> OK, sounds reasonable. Anyone have a patch verified to work for this,
> sitting around? If not, I'll take a look at this for next release.
>=20
> Regards -- Andy
>=20
> > -----Original Message-----
> > From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org]=20
> > Sent: Monday, May 19, 2003 10:38 AM
> > To: Kevin Fenzi; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: RE: Working around bugs in ACPI BIOS [was Re: [ACPI]=20
> > DSDT in initrd]
> >=20
> >=20
> > I recently discovered the origin of the infamous Compaq asterisk
> > problem:
> >=20
> > When doing the original ACPI BIOS code (for Win98, many years ago),
> > either Windows 98 or the Microsoft ASL compiler had a problem with
> > HIDs generated from EISA ID's.  To work around the problem,=20
> Microsoft
> > instructed us to use an asterisk as the first character of the _HID
> > value.  All MS OS's since have understood this as a valid character
> > for use in HIDs, yet it was never added to the ACPI spec. =20
> This wasn't
> > a problem until Linux came along using Intel's ACPI stack, which was
> > written to the original spec, which doesn't allow asterisks in the
> > HIDs...
> >=20
> > That said, it would be nice to relax that constraint in the Linux
> > ACPI implementation.  The BIOS developers are aware of the issue and
> > they are rolling that change into new implementations going forward,
> > but there's no way all existing laptops will get new versions of the
> > BIOS.
> >=20
> > Regards,
> > John
> >=20
> > > -----Original Message-----
> > > From: Kevin Fenzi [mailto:kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org]=20
> > > Sent: Monday, May 19, 2003 12:08 PM
> > > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > Subject: Re: Working around bugs in ACPI BIOS [was Re: [ACPI]=20
> > > DSDT in initrd]
> > >=20
> > >=20
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >=20
> > > >>>>> "Pavel" =3D=3D Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:
> > >=20
> > > Pavel> Hi!
> > > >> I must admit I'm really torn. If there were 2-3 little AML=20
> > > problems=20
> > > >> that if we worked around them, a horde of machines would start=20
> > > >> working, then I think we would do that, but my sense is=20
> > that there=20
> > > >> are many more ways a DSDT can be broken, and that implementing=20
> > > >> workarounds for all of them would cause other systems to=20
> > > fail. Maybe=20
> > > >> some of the people who have fixed their DSDTs can=20
> comment on the=20
> > > >> scope of bugs out there.
> > >=20
> > > Pavel> I believe policy should be "if it can't possibly=20
> > break anyone".
> > >=20
> > > Pavel> AML functions not returning value can be safely=20
> > replaced with=20
> > > Pavel> returning 0; uninitialized variables can also be=20
> > > initialized with=20
> > > Pavel> 0. Both should be safe, and we should printk()=20
> > loudly in both=20
> > > Pavel> cases.
> > >=20
> > > The one I would like to see is when acpi is parsing and comes=20
> > > accross a variable with a * in it, it just removes the * and=20
> > > parses the variable after that. This would make tons of=20
> > > compaq laptops happy with acpi out of the box. I think pretty=20
> > > much all of them have this bug.=20
> > >=20
> > > The main reason I have to modify my dsdt is to remove all the=20
> > > *'s from it. ie,=20
> > >=20
> > > Name(_HID, "*PNP0C0B")
> > > ...
> > > Name(_HID, "*PNP0C01")
> > > ...
> > > Name(_HID, "*PNP0A03")
> > >=20
> > > Is there any way this could be added?
> > >=20
> > > Granted this might cause compaq to not update their bios, but=20
> > > on many of the older laptops I don't think thats going to=20
> > > happen anyhow.=20
> > >=20
> > > kevin
> > > -----BEGIN PGP SIGNATURE-----
> > > Version: GnuPG v1.2.1 (GNU/Linux)
> > > Comment: Processed by Mailcrypt 3.5.8=20
> > > <http://mailcrypt.sourceforge.net/>
> > >=20
> > >=20
> > > iD8DBQE+yQ9a3imCezTjY0ERAr3/AKCbuqoMQpYkRuMaBskTx1FPTiEDigCeMgN8
> > > rWg4Pf0x6RuabOMEtfjTVj8=3D
> > > =3DsStk
> > > -----END PGP SIGNATURE-----
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by: If flattening out C++ or Java
> > code to make your application fit in a relational database is=20
> > painful,=20
> > don't do it! Check out ObjectStore. Now part of Progress Software.
> > http://www.objectstore.net/sourceforge
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: If flattening out C++ or Java
> code to make your application fit in a relational database is=20
> painful,=20
> don't do it! Check out ObjectStore. Now part of Progress Software.
> http://www.objectstore.net/sourceforge
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20

------_=_NextPart_001_01C31E37.64000C6A
Content-Type: application/octet-stream;
	name="compaq.diff"
Content-Transfer-Encoding: base64
Content-Description: compaq.diff
Content-Disposition: attachment;
	filename="compaq.diff"

PT09PT0gZHJpdmVycy9hY3BpL2J1cy5jIDEuMTQgdnMgZWRpdGVkID09PT09Ci0tLSAxLjE0L2Ry
aXZlcnMvYWNwaS9idXMuYwlGcmkgTWF5IDE2IDEzOjM1OjA5IDIwMDMKKysrIGVkaXRlZC9kcml2
ZXJzL2FjcGkvYnVzLmMJTW9uIE1heSAxOSAxMTo0NjowOCAyMDAzCkBAIC0xNTA4LDYgKzE1MDgs
MTIgQEAKIAkJc3ByaW50ZihkZXZpY2UtPnBucC5kZXZpY2VfY2xhc3MsICIlcyIsIEFDUElfQlVT
X0NMQVNTKTsKIAl9CiAKKwkvKiBDb21wYXEgZXJyb25lb3VzbHkgcHV0cyAqIGluIGZyb250IG9m
IHRoZWlyIEhJRHMgb24gb2xkIEJJT1NlcyAqLworCWlmIChoaWQgJiYgKmhpZCA9PSAnKicpIHsK
KwkJcHJpbnRrKEtFUk5fREVCVUcgUFJFRklYICJJZ25vcmluZyAqIGluIF9ISUQuIElzIHRoaXMg
YSBDb21wYXE/XG4iKTsKKwkJaGlkKys7CisJfQorCiAJaWYgKGhpZCkgewogCQlzcHJpbnRmKGRl
dmljZS0+cG5wLmhhcmR3YXJlX2lkLCAiJXMiLCBoaWQpOwogCQlkZXZpY2UtPmZsYWdzLmhhcmR3
YXJlX2lkID0gMTsK

------_=_NextPart_001_01C31E37.64000C6A--


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
