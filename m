From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: throttling is not changing
Date: Tue, 14 Sep 2004 08:56:12 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05501FB4F1F@orsmsx403.amr.corp.intel.com>
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
To: Andreas Leppert <wudmx-S0/GAf8tV78@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Executable code at the DefinitionBlock level is not allowed. =20

Put these kinds of statements in the \_SB_._INI method (which is
executed during init time.)



> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Andreas Leppert
> Sent: Sunday, September 12, 2004 7:21 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] throttling is not changing
>=20
> i disassembled my dsdt and tried to compile it again.
>=20
> bash-2.05b# ./iasl -tc dsdt.dsl
>=20
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20040715 [Sep 13
> 2004]
> Copyright (C) 2000 - 2004 Intel Corporation
> Supports ACPI Specification Revision 2.0c
>=20
> dsdt.dsl  3081:     If (SS1)
> Error    1037 -      ^ syntax error, unexpected PARSEOP_IF
>=20
> ASL Input:  dsdt.dsl - 3132 lines, 104097 bytes, 1533 keywords
> Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations
>=20
> sorry, really dont know wheres the problem. can you help me?
>=20
> dsdt.dsl is attached!
>=20
> thanks
> Andreas Leppert


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
