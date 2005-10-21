From: marek czardybon <max-MEOeS5c08o1g9hUCZPvPmw@public.gmane.org>
Subject: Re: acer travelmate 2313 battery problem.
Date: Fri, 21 Oct 2005 14:56:16 +0200
Message-ID: <4358E570.6000302@inbox.eu.org>
References: <20051020173040.51826.qmail@web81602.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051020173040.51826.qmail-AjlHvM9Xp4mA/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dnia 2005-10-20 19:30, foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org napisa=B3:
> That's a little bit weird but similar to the problem I had with my
> Acer. You will need to build the IASL DSDT compiler and fix your DSDT,
> because there is not a fixed one in the ACPI4Linux database yet. But
> first, before you try that, try upgrading your BIOS and seeing if that
> solves the problem.
>=20
> Please look here http://forums.gentoo.org/viewtopic.php?t=3D122145 for
> ideas. They apply to more than just Gentoo machines.
>=20
[cut]

I've downloaded tools from this link and here is my output:

maxik:/usr/src/battery/iasl-linux-20030918# ./iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt.dsl  1577:                     Method (_CRS, 0, Serialized)
Warning  2019 -                                ^ Not all control paths re=
turn a=20
value (_CRS)

dsdt.dsl  1577:                     Method (_CRS, 0, Serialized)
Warning  2026 -                                ^ Reserved method must ret=
urn a=20
value (_CRS)

dsdt.dsl  2673:                 Z004,
Error    1022 -                    ^ Object does not exist (Z004)

dsdt.dsl  2674:                 Z004,
Error    1022 -                    ^ Object does not exist (Z004)

dsdt.dsl  3049:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                ^ Reserved method must return a value (_WA=
K)

ASL Input:  dsdt.dsl - 3169 lines, 107438 bytes, 1506 keywords
Compilation complete. 2 Errors, 3 Warnings, 0 Remarks, 510 Optimizations


I've corected this 2 error after read this=20
http://acpi.sourceforge.net/dsdt/view.php?id=3D405

and one warning using=20
http://users.pandora.be/PrittyFlemishPages/linux/aspire1800_3.html


and now i've somethink like this:

maxik:/usr/src/battery/iasl-linux-20030918# ./iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt.dsl  1577:                     Method (_CRS, 0, Serialized)
Warning  2019 -                                ^ Not all control paths re=
turn a=20
value (_CRS)

dsdt.dsl  1577:                     Method (_CRS, 0, Serialized)
Warning  2026 -                                ^ Reserved method must ret=
urn a=20
value (_CRS)

ASL Input:  dsdt.dsl - 3171 lines, 107474 bytes, 1507 keywords
AML Output: DSDT.aml - 12898 bytes 371 named objects 1136 executable opco=
des

Compilation complete. 0 Errors, 2 Warnings, 0 Remarks, 512 Optimizations

Now i've to compile DSDT into my kernel and test it.
after weekend i'll send report from tests.

--=20
marek czardybon / maxilee   +48 0697 724 404       http://inbox.eu.org
GG:3299479 JAB:maxilee-veJsmC5npURmR6Xm/wNWPw@public.gmane.org                  http://outbox.eu.org
ARP: 00:90:CC:43:D8:0D         GCC d? s:- a- C+++ UL++ P++ L++ E--- W+
N+ o K w--- O M- V- PS+ PE+ Y PGP t 5 X+R+ !tv b+ DI- D++ G e h r++ y?


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
