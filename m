From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI stops working after memory upgrade vpr Matrix 175b4
Date: Wed, 11 Feb 2004 16:19:26 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB699@PDSMSX403.ccr.corp.intel.com>
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
To: dave-eQMij45H2SHXYFsarriMmxagbA6BzR3y@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Sure! I got it 99% working, but I am getting an=20
> AML_UNINITIALIZED_LOCAL
> error message, which is pretty annoying because I can't see why its
> throwing that error.

I'm interested in the AML code that cause AML_UNINITIALIZED_LOCAL,
Can you show me. Maybe we can come up with some generic solution.

>=20
> Trying with an unmodified DSDT doesn't really show much because it has
> several bugs that cause the ACPI features to not work at all. I can
> capture the two different streams of error messages.
>=20

Great!

> > > > methods:....exregion-0164 [25] ex_system_memory_space:=20
> > > Could not map=20
> > > > memory at 000000000FF7FDBD, size 190
> > >=20
> > > Maybe the root of this error is that __ioremap don't=20
> allow anybody to
> > > remap
> > > normal RAM. Could you verify it by checking it in=20
> > > arch/i386/mm/ioremap.c

Did you check memory at 000000000FF7FDBD, size 190 has
been reservered.=20

--Luming


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
