From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: NO_RETURN_VALUE w/ 20040715
Date: Mon, 23 Aug 2004 13:22:17 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05501C71E7A@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

We are going to update the ACPI spec to something like this:

*	For the following operators, the data type of the first operand
dictates both the required type of the second operand and the type of
the result object.  (The second operator is converted, if necessary, to
match the type of the first operand.)
    Concatenate
    LEqual
    LGreater
    LGreaterEqual
    LLess
    LLessEqual
    LNotEqual





> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-VXdhtT5mjnY@public.gmane.org]
> Sent: Friday, August 20, 2004 4:18 PM
> To: Moore, Robert
> Cc: acpi-devel
> Subject: RE: [ACPI] NO_RETURN_VALUE w/ 20040715
>=20
> Bob,
>=20
>    Thanks once again for the quick and thorough analysis.  I'll feed
> this into our ACPI folks here and see if they have a strong opinion or
> can just avoid the problem.  Thanks,
>=20
> 	Alex
>=20
> On Fri, 2004-08-20 at 14:07 -0700, Moore, Robert wrote:
> > This is an error during the execution of this operator in SSTA:
> >
> > If (LEqual (Local0, 0x00))
> > {
> >
> > It turns out that Local0 contains a Buffer (BSTR), and the statement
is
> > trying to compare it to an Integer.  This causes an operand type
> > exception, which then results in a no-return-value exception.
> >
> > We have recently upgraded LEqual to handle buffers and strings; and
it
> > is implemented according to the rules below, which would appear to
> > require that both operands be of the same type.
> >
> > It is not clear to me whether the logical operators should support
> > "implicit type conversion".  This will require additional
investigation.
> >
> >
> >
> > From the ACPI spec:
> >
> > 17.5.60   LEqual (Logical Equal)
> > Syntax
> > LEqual (Source1, Source2) =3D> Boolean
> >
> > Arguments
> > Source1 and Source2 must evaluate to the same data type and both
must be
> > integers, strings, or buffers.
> >
> > Description
> > If the values are equal, True is returned; otherwise, False is
returned.
> > For integers, a numeric compare is performed. For strings and
buffers,
> > True is returned only if both lengths are the same and the result of
a
> > byte-wise compare indicates exact equality.
> >
> >
> >
> >   exdump-0520 [08] ExDumpOperands        : ************* Operand
Stack
> > Contents (Opcode [LEqual], 2 Operands)
> >   exdump-0192 [08] ExDumpOperand         : 004FE3B4 Integer
> > 0000000000000000
> >   exdump-0192 [08] ExDumpOperand         : 004FE414 Buffer len 1 @
> > 004FD354
> > Buffer Contents:  00
> >   exdump-0537 [08] ExDumpOperands        : ************* Stack dump
from
> > dswexec(510), after ExResolveOperands
> > exoparg2-0668 [09] ExOpcode_2A_0T_1R     : ----Entry LEqual
> > utobject-0160 [10] UtCreateInternalObject: ----Entry Integer
> > utobject-0343 [11] UtAllocateObjectDescDb: ----Entry
> >  utalloc-0231 [11] UtAcquireFromCache    : Object 004FFAA4 from
Operand
> > Object Cache
> > utobject-0360 [11] UtAllocateObjectDescDb: 004FFAA4 Size 28
> > utobject-0362 [11] UtAllocateObjectDescDb: ----Exit- 004FFAA4
> > utobject-0208 [10] UtCreateInternalObject: ----Exit- 004FFAA4
> > utdelete-0719 [10] UtRemoveReference     : ----Entry 004FFAA4
> > utdelete-0742 [10] UtRemoveReference     : Obj 004FFAA4 Refs=3D1
> > utdelete-0515 [11] UtUpdateObjectReferenc: ----Entry 004FFAA4
> >   utmisc-1212 [12] UtCreateUpdateState   : ----Entry 004FFAA4
> >  utalloc-0231 [12] UtAcquireFromCache    : Object 004FEA44 from
State
> > Object Cache
> >   utmisc-1229 [12] UtCreateUpdateState   : ----Exit- 004FEA44
> >   utmisc-1336 [12] UtDeleteGenericState  : ----Entry
> >   utmisc-1340 [12] UtDeleteGenericState  : ----Exit-
> > utdelete-0431 [11] UtUpdateRefCount      : Obj 004FFAA4 Refs=3D0,
> > [Decremented]
> > utdelete-0151 [12] UtDeleteInternalObj   : ----Entry 004FFAA4
> > utdelete-0324 [12] UtDeleteInternalObj   : Deleting Object 004FFAA4
> > [Integer]
> > utobject-0382 [13] UtDeleteObjectDesc    : ----Entry 004FFAA4
> > utobject-0397 [13] UtDeleteObjectDesc    : ----Exit-
> > utdelete-0327 [12] UtDeleteInternalObj   : ----Exit-
> >   utmisc-1096 [12] UtPopGenericState     : ----Entry
> >   utmisc-1109 [12] UtPopGenericState     : ----Exit- 00000000
> > utdelete-0655 [11] UtUpdateObjectReferenc: ----Exit- AE_OK
> > utdelete-0750 [10] UtRemoveReference     : ----Exit-
> > exoparg2-0756 [09] ExOpcode_2A_0T_1R     : ----Exit-
****Exception****:
> > AE_AML_OPERAND_TYPE
> >
> > > -----Original Message-----
> > > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> > > admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Alex Williamson
> > > Sent: Friday, August 20, 2004 1:12 PM
> > > To: acpi-devel
> > > Subject: [ACPI] NO_RETURN_VALUE w/ 20040715
> > >
> > >
> > >    I've got one more new error going on with the new ACPI.  On
bootup
> > of
> > > an hp rx8620 (sx1000 based ia64 system), I'm now getting a number
of
> > > these:
> > >
> > > dswstate-0273 [18] ds_result_pop_from_bot: No result objects!
> > > State=3De000072000095030
> > > dsutils-0526 [18] ds_create_operand     : Missing or null operand,
> > > AE_AML_NO_RETURN_VALUE
> > > psparse-1133: *** Error: Method execution failed
> > > [\_SB_.N000.S000.IOC0.L000.SSTA] (Node e0000703fef6d730),
> > > AE_AML_NO_RETURN_VALUE
> > > psparse-1133: *** Error: Method execution failed
> > > [\_SB_.N000.S000.IOC0.L000.SBF0._STA] (Node e0000703fef6f130),
> > > AE_AML_NO_RETURN_VALUE
> > >  uteval-0158: *** Error: Method execution failed
> > > [\_SB_.N000.S000.IOC0.L000.SBF0._STA] (Node e0000703fef6f130),
> > > AE_AML_NO_RETURN_VALUE
> > >
> > > This did not happen w/ the previous ACPI code so I'd like to get a
> > feel
> > > for whether this looks like an interpreter bug or an AML bug.
The
> > > disassembled DSDT for the _STA and SSTA methods is below.  Looks
to me
> > > like there's no way out of the SSTA method w/o a return, but then
I
> > > don't really know AML.  I can provide the entire DSDT if this
isn't
> > > sufficient.  Thanks,
> > >
> > > 	Alex
> > >
> > > Method (SSTA, 0, NotSerialized)
> > > {
> > >     Acquire (MCTX, 0xFFFF)
> > >     Store (0x0F, CSTS)
> > >     If (LNot (LEqual (PRES (), Ones)))
> > >     {
> > >         Store (0x00, CSTS)
> > >         Release (MCTX)
> > >         Return (ToInteger (CSTS, Local0))
> > >     }
> > >     If (LNot (LEqual (PCHK (), Ones)))
> > >     {
> > >          Store (0x00, GOOD)
> > >          Store (0x00, LIVE)
> > >          Store (0x00, SEEN)
> > >          Release (MCTX)
> > >          Return (ToInteger (CSTS, Local0))
> > >     }
> > >     If (LEqual (RC, 0x00))
> > >     {
> > >         Store (BSTR, Local0)
> > >     }
> > >     Else
> > >     {
> > >         Store (0x00, Local0)
> > >     }
> > >     If (LEqual (Local0, 0x00))
> > >     {
> > >         Store (0x01, GOOD)
> > >     }
> > >     Release (MCTX)
> > >     Return (ToInteger (CSTS, Local0))
> > > }
> > > ...
> > > Device (SBF0)
> > > {
> > >     ...
> > >     Method (_STA, 0, NotSerialized)
> > >     {
> > >         Return (^^SSTA ())
> > >     }
> > > }
> > >
> > > --
> > > Alex Williamson                             HP Linux & Open Source
Lab
> > >
> > >
> > >
> > > -------------------------------------------------------
> > > SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank
Media
> > > 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> > > Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> > > http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >
> --
> Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
