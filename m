From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: IASL bug with big constants?
Date: Wed, 6 Oct 2004 10:47:53 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE0550237D8A8@orsmsx403.amr.corp.intel.com>
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
To: Greg Alexander <gre-VobwYXd2LmVM656bX5wj8A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Yes, it's a bug in the compiler.  I tested it, but did not run into the
problem until later.

I am having some trouble getting the new version of the compiler posted
to the web site, but I will send you a new version directly.

Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Greg Alexander
> Sent: Saturday, October 02, 2004 10:13 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] IASL bug with big constants?
>=20
> Hi -
>=20
> I hope this hasn't already been addressed.  I skimmed the logs and the
> buggy version appears to still be on Intel's site...
>=20
> I see the trouble in constants in OperationRegions generally getting
> cut to one-byte.  i.e.:
>=20
> ---
> DefinitionBlock ("DSDT.aml", "DSDT", 1, "VIA", "VIA_K7", 4096)
> {
>     ....
>     OperationRegion (M4D0, SystemMemory, 0x04D0, 0x0B)
>     Field (M4D0, ByteAcc, NoLock, Preserve)
>     {
>         ....
>     }
> }
> ---
>=20
> when I assembled then disassembled that with the 20040715 version of
> iasl, I got:
>=20
> ---
> DefinitionBlock ("DSDT.aml", "DSDT", 1, "VIA", "VIA_K7", 4096)
> {
>     ....
>     OperationRegion (M4D0, SystemMemory, 0xD0, 0x0B)	/* should be
0x04D0
> */
>     Field (M4D0, ByteAcc, NoLock, Preserve)
>     {
>         ....
>     }
> }
> ---
>=20
> Note the 0xD0 where 0x04D0 is expected!  My laptop manufacturer put
> NVRAM at 0x4D0.  They did not put it at 0xD0.
>=20
> I tracked it down to the following code in
> acpica/compiler/aslopcodes.c line 209 in OpcSetOptimalIntegerSize(),
> at the very beginning:
>=20
> ---
>     if (Op->Asl.Parent &&
>         Op->Asl.Parent->Asl.Parent &&
>         (Op->Asl.Parent->Asl.Parent->Asl.ParseOpcode =3D=3D
> PARSEOP_DEFINITIONBLOCK))
>     {
>         return 0;
>     }
> ---
>=20
> The parent is the OperationRegion, the parent's parent is the
> DefinitionBlock, so it doesn't generate a size for the opcode.
> So it gets the default from aslmap.c line 520:
>=20
>    /* INTEGER */ OP_TABLE_ENTRY (AML_BYTE_OP, 0, 0,
ACPI_BTYPE_INTEGER),
>=20
> It defaults to a byte!  I looked in the changelog and I suspect this
> corresponds to the following entry:
>=20
>    Eliminated optimization messages for "_T_x" objects and small
>    constants within the DefinitionBlock operator.
>=20
> Why don't you want to optimize small constants within the
> DefinitionBlock operator?  Why only when it's nested?  Why not test a
> change at least once before sending it to customers?  Since the
> change is both broken and meaningless to me, I simply removed the
> offending piece of code and now OpcSetOptimalIntegerSize() does its
> job appropriately and my DSDT works.  If we really don't want to
> optimize them, perhaps we should set a better default, like
> AML_DWORD_OP?
>=20
> This is a MOST frustrating bug to track down -- I had so little faith
> in my BIOS vendor that I thought they had enough non-standard crap
> jammed in there that recompiling my DSDT was expected to fail.
>=20
> Sure takes the joy out of bashing the Microsoft compiler.
>=20
> Nonetheless, thanks for the tools.  I never could have fixed my laptop
> without iasl.
>=20
>=20
> Cheers,
> - Greg
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on
ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give
us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out
> more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
