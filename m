From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: ACPI black-list (was RE: Working around bugs in ACPI BIOS [was Re: DSDT in initrd])
Date: Tue, 27 May 2003 17:31:39 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10476C51A@cceexc19.americas.cpqcorp.net>
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>, mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

FYI - United Linux 1.0 contains a DMI-based blacklist system that you
might want to investigate.  Their dmi_scan.c controls the options
"acpi=3Doldboot" and "acpi=3Doff" (which can be overridden on the =
command
line with "acpi=3Dforce").  A number of systems are already included in
the blacklist.

Regards,
John

> -----Original Message-----
> From: Brown, Len [mailto:len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
> Sent: Tuesday, May 27, 2003 1:28 PM
> To: 'Ducrot Bruno'; Alan Cox
> Cc: Pavel Machek; Grover, Andrew; Randy.Dunlap;=20
> mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org; acpi-devel@sourceforge.net
> Subject: ACPI black-list (was RE: Working around bugs in ACPI=20
> BIOS [was Re: [ACPI] DSDT in initrd])
>=20
>=20
>=20
> > > A please upgrade signature table so that vendors who have
> > fixed bioses
> > > have a way to let customers find this out without bitching
> > at support
> >=20
> > Yeah.
>=20
> I like this too.  If somebody hasn't done it already I=20
> volunteer to take a swing at it.
>=20
> This sort of leads to examination of the ACPI black-list=20
> scheme -- which I think needs some work.
>=20
> It should have a cut-off date for each vendor, with a black=20
> list disabling ACPI on platforms newer than that date, plus a=20
> white list enabling ACPI for platforms older than the cutoff=20
> date.  If the OEM isn't on the list, there should be a=20
> default cut-off date.  If the date is about in the right=20
> place, then the black and white lists will be short.=20
>=20
> Also, the current black list has 3 possible outcomes:
> 1. pass black list and continue with everythything enabled.
> 2. fail black list, print a warning, but continue with acpi=20
> anyway ("non
> critical")
> 3. fail black list, and disable ACPI.
>=20
> Option 2 is worthless.  Probably better would be some flag=20
> bits that disable the part of ACPI that actually fails --=20
> leaving the rest intact.  (eg. Just because fan speed=20
> adjustment has a bug doesn't meen that power states have to=20
> be disabled).
>=20
> I think if we do this, then it will be easier to deploy and=20
> support ACPI-enabled systems, and less necessary for hackers=20
> to enhance their DSDT just to make their sytem function.
>=20
> Cheers,
> -Len


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
