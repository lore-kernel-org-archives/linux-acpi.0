From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: Working around bugs in ACPI BIOS [was Re: DSDT in initrd]
Date: Mon, 19 May 2003 13:09:42 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10440E51C@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Compaq was probably the first OEM to support ACPI with Windows 98.
The MS OS issue must have been fixed by the time other hardware
vendors implemented ACPI, so they didn't have to use the "*"
workaround.  (But that's just a guess, I don't know for sure.)

> -----Original Message-----
> From: Moore, Robert [mailto:robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
> Sent: Monday, May 19, 2003 12:46 PM
> To: Cagle, John (ISS-Houston); Kevin Fenzi;=20
> acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: Working around bugs in ACPI BIOS [was Re: [ACPI]=20
> DSDT in initrd]
>=20
>=20
>=20
> Why is it that only Compaq machines seem to use the asterisk? Bob
>=20
>=20
> > -----Original Message-----
> > From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org]
> > Sent: Monday, May 19, 2003 10:38 AM
> > To: Kevin Fenzi; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: RE: Working around bugs in ACPI BIOS [was Re:=20
> [ACPI] DSDT in=20
> > initrd]
> >=20
> > I recently discovered the origin of the infamous Compaq asterisk
> > problem:
> >=20
> > When doing the original ACPI BIOS code (for Win98, many years ago),=20
> > either Windows 98 or the Microsoft ASL compiler had a problem with=20
> > HIDs generated from EISA ID's.  To work around the problem,=20
> Microsoft=20
> > instructed us to use an asterisk as the first character of the _HID=20
> > value.  All MS OS's since have understood this as a valid character=20
> > for use in HIDs, yet it was never added to the ACPI spec. =20
> This wasn't=20
> > a problem until Linux came along using Intel's ACPI stack,=20
> which was=20
> > written to the original spec, which doesn't allow asterisks in the=20
> > HIDs...
> >=20
> > That said, it would be nice to relax that constraint in the=20
> Linux ACPI=20
> > implementation.  The BIOS developers are aware of the issue=20
> and they=20
> > are rolling that change into new implementations going forward, but=20
> > there's no way all existing laptops will get new versions=20
> of the BIOS.
> >=20
> > Regards,
> > John
> >=20
> > > -----Original Message-----
> > > From: Kevin Fenzi [mailto:kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org]
> > > Sent: Monday, May 19, 2003 12:08 PM
> > > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > Subject: Re: Working around bugs in ACPI BIOS [was Re:=20
> [ACPI] DSDT=20
> > > in initrd]
> > >
> > >
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > >>>>> "Pavel" =3D=3D Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:
> > >
> > > Pavel> Hi!
> > > >> I must admit I'm really torn. If there were 2-3 little AML
> > > problems
> > > >> that if we worked around them, a horde of machines would start=20
> > > >> working, then I think we would do that, but my sense is that
> there
> > > >> are many more ways a DSDT can be broken, and that implementing=20
> > > >> workarounds for all of them would cause other systems to
> > > fail. Maybe
> > > >> some of the people who have fixed their DSDTs can=20
> comment on the=20
> > > >> scope of bugs out there.
> > >
> > > Pavel> I believe policy should be "if it can't possibly break
> anyone".
> > >
> > > Pavel> AML functions not returning value can be safely=20
> replaced with=20
> > > Pavel> returning 0; uninitialized variables can also be
> > > initialized with
> > > Pavel> 0. Both should be safe, and we should printk()=20
> loudly in both=20
> > > Pavel> cases.
> > >
> > > The one I would like to see is when acpi is parsing and comes=20
> > > accross a variable with a * in it, it just removes the *=20
> and parses=20
> > > the variable after that. This would make tons of compaq laptops=20
> > > happy with acpi out of the box. I think pretty much all=20
> of them have=20
> > > this bug.
> > >
> > > The main reason I have to modify my dsdt is to remove all the *'s=20
> > > from it. ie,
> > >
> > > Name(_HID, "*PNP0C0B")
> > > ...
> > > Name(_HID, "*PNP0C01")
> > > ...
> > > Name(_HID, "*PNP0A03")
> > >
> > > Is there any way this could be added?
> > >
> > > Granted this might cause compaq to not update their bios, but on=20
> > > many of the older laptops I don't think thats going to happen=20
> > > anyhow.
> > >
> > > kevin
> > > -----BEGIN PGP SIGNATURE-----
> > > Version: GnuPG v1.2.1 (GNU/Linux)
> > > Comment: Processed by Mailcrypt 3.5.8=20
> > > <http://mailcrypt.sourceforge.net/>
> > >
> > >
> > > iD8DBQE+yQ9a3imCezTjY0ERAr3/AKCbuqoMQpYkRuMaBskTx1FPTiEDigCeMgN8
> > > rWg4Pf0x6RuabOMEtfjTVj8=3D
> > > =3DsStk
> > > -----END PGP SIGNATURE-----
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by: If flattening out C++ or=20
> Java code=20
> > to make your application fit in a relational database is painful,=20
> > don't do it! Check out ObjectStore. Now part of Progress Software.=20
> > http://www.objectstore.net/sourceforge
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: If flattening out C++ or=20
> Java code to make your application fit in a relational=20
> database is painful,=20
> don't do it! Check out ObjectStore. Now part of Progress=20
> Software. http://www.objectstore.net/sourceforge
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> https://lists.sourceforge.net/lists/listinfo/a> cpi-devel
>=20


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
