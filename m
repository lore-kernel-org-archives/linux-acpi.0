From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: DSDT in initrd
Date: Fri, 16 May 2003 15:50:40 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2A7@orsmsx401.jf.intel.com>
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
To: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Michael Frank [mailto:mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org]=20
> On Friday 16 May 2003 09:41, Brown, Len wrote:
> > > IMHO this patch is very useful because it provides the
> > > equivalent of a "DSDT module" and avoids building a kernel
> > > for each DSDT.
> >
> > This is the 1st reason I've seen for not simply using an
> > ACPI_DSDT_OVERRIDE config option to pull a DSDT into the kernel
> > from a well-known file name.
>=20
> DSDT problems will be around for a long time as this=20
> technology makes it into the main stream, while still maturing.
>=20
> For example: I found DSDT of a recent P4 mainboard has 16=20
> compile errors.=20
>=20
> Realistically, one can't go really into production with it=20
> without being able to override.

It should be obvious that using DSDT override (however easy we make it)
is NOT an option for distributions or any sort of non-developer
solution. You mention that distributions could install DSDTs on
installation but I don't buy it. This is part of the reason that I
haven't been very receptive towards making DSDT override very easy.

We need to look for solutions that make using an ACPI-enabled kernel
possible on the widest number of machines possible, *without* involving
DSDT override. If there are bugs in the interpreter, we need to fix
them. If there are bugs in the DSDT, we need to get on OEMs to fix them.
Or, we need to have a blacklist that, either via specific system
signatures or just BIOS date, safely reverts to non-ACPI on machines on
which it has problems.

I really think it's kind of funny that so many people on this mailing
list have gotten so good at fixing their systems' DSDT (maybe they
should apply for BIOS engineer jobs!) but this skill is the equivalent
of requiring someone to know how an engine works in order to drive a
car.

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
