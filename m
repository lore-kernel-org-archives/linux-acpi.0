From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org>
Subject: RE: Working around bugs in ACPI BIOS [was Re: DSDT in initrd]
Date: 21 May 2003 13:07:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1053518837.1421.22.camel@darkstar.portugal>
References: <C50AB9511EE59B49B2A503CB7AE1ABD10440E51B@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C50AB9511EE59B49B2A503CB7AE1ABD10440E51B-Iar2LzuD2f6P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Cagle, John   (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-05-19 at 18:38, Cagle, John (ISS-Houston) wrote:
> I recently discovered the origin of the infamous Compaq asterisk
> problem:
>=20
> When doing the original ACPI BIOS code (for Win98, many years ago),
> either Windows 98 or the Microsoft ASL compiler had a problem with
> HIDs generated from EISA ID's.  To work around the problem, Microsoft
> instructed us to use an asterisk as the first character of the _HID
> value.  All MS OS's since have understood this as a valid character
> for use in HIDs, yet it was never added to the ACPI spec.  This wasn't
> a problem until Linux came along using Intel's ACPI stack, which was
> written to the original spec, which doesn't allow asterisks in the
> HIDs...
>=20
> That said, it would be nice to relax that constraint in the Linux
> ACPI implementation.  The BIOS developers are aware of the issue and
> they are rolling that change into new implementations going forward,
> but there's no way all existing laptops will get new versions of the
> BIOS.
Can you give me one tip, idea (paint one draw) about whose Compaq have
this asterisk,=20
or where do you think Compaq begins correct this undocumented  thing,=20
this question is more for laptops area.
My compaq presario 706EA doesn't have =20
--=20
S=E9rgio Basto
Technology Project Manager
onevision design studios
TECMAIA - Parque de Ci=EAncia e Tecnologia da Maia
Rua Frederico Ulrich, 2650
4470-605 MOREIRA DA MAIA
tel. + 351 22 091 5410
fax. + 351 22 091 5419
email: sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org
web: http://www.onevision-design.com



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
