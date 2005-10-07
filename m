From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI errors on ECS G220 laptop
Date: Fri, 7 Oct 2005 14:55:16 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E02FCA019@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, bulk-wOwPqRMbTBJeoWH0uzbU5w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Newer versions of iASL actually allow this, since it is valid ACPI 1.0
syntax.

However, the ACPICA interpreter does not "fully" execute code like this
(if statements outside of control methods, etc.) at this time, although
we are working on providing this support.

Also, putting this code into a control method such as _SB_._INI often
won't accomplish the goal of the code which is to insert objects into
the namespace -- because such objects are automatically deleted upon
method exit. In these cases, it is probably best to just remove the if()
statements and leave the code within the If(). Operators that insert
objects into the namespace are executed during the loading of the table.
The overall goal of the code seems to be to selectively disable various
S states based upon BIOS options.

Bob


Here's the compiler change:

26 May 2005.  Summary of changes for version 20050526:

iASL Compiler/Disassembler:

Implemented support to allow Type 1 and Type 2 ASL operators to appear
at the module level (not within a control method.) These operators will
be executed once at the time the table is loaded. This type of code was
legal up until the release of ACPI 2.0B (2002) and is now supported by
the iASL compiler in order to provide backwards compatibility with
earlier BIOS ASL code.


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Thomas Renninger
> Sent: Thursday, October 06, 2005 9:45 AM
> To: bulk-wOwPqRMbTBJeoWH0uzbU5w@public.gmane.org
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] ACPI errors on ECS G220 laptop
>=20
> Junk Mail Recipient wrote:
> > I recently purchased an ECS G220 laptop with the hopes of running
Suse
> > 9.3 on it.  I am pretty well outta luck as far as acpi goes though.
The
> > battery monitor doesn't work at all.  It perpetually shows a 1%
charge.
> > It also doesn't seem to be getting any thermal information.  CPU
scaling
> > can be done manually, but is not happening automatically.
> >
> > I followed the how-to on broken dsdt and from iasl I get 1 error and
no
> > warnings.  Unfortunately this seems to be a pretty generic syntax
error
> > and I am at a loss on how to track it down or where to go from here.
> >
> > Intel ACPI Component Architecture
> > ASL Optimizing Compiler / AML Disassembler version 20050309 [Mar 19
> > 2005]
> > Copyright (C) 2000 - 2005 Intel Corporation
> > Supports ACPI Specification Revision 3.0
> >
> > dsdt.dsl  1901:     If (SS1)
> > Error    1037 -      ^ syntax error, unexpected PARSEOP_IF
>=20
> Create an _INI function in \_SB scope (if there is not already one)
and
> place
> the If(SSX){...} code there.
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads,
discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
