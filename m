From: Patrick Ohler <patrick.ohler-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org>
Subject: ACPI problem with Samsung NV5750
Date: Wed, 05 Jan 2005 18:09:01 +0100
Message-ID: <41DC1F2D.1030801@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi @all,

i'm a student from Germany and i need my notebook with linux for
university, because i hate W*ndo*s and had much problems with it. But
after installing a new kernel for my Debian-Linux on my notebook, i
can't see my battery status. This is a big Problem for me and therefore
i can't use it in university (cause i cant't see, when the power ends).

I searched in the Internet and founded, that the Problem is the DSDT of
my Samsung, but i can't find a fixed version. So I tried to fix it by
myself but i failed... :-(

Can you please give me some hints?

I have a:
Samsung NV5750 (it's the "grandpa" of the Q10) with 192 MB RAM

Thanx a lot!

Patrick


p.s.: when i disassemble the dsdt with the iasl the .dsl-file is 127K
big, so i don't want to attach it... when i try to compile it, i get
these errors and warnings:

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

original.dsl  1052:                     Method (_GLK, 1, NotSerialized)
Warning  2024 -                                    ^ Reserved method has
too many arguments ( _GLK requires 0)

original.dsl  1058:                     Field (RAM, DWordAcc, Lock,
Preserve)
Error    1048 -                                  ^ Host Operation Region
requires ByteAcc access

original.dsl  1456:                     PWST,   8,
Error    1051 -                            ^ Access width of Field Unit
extends beyond region limit

original.dsl  1458:                     PMES,   1
Error    1051 -                            ^ Access width of Field Unit
extends beyond region limit

original.dsl  1674:                     ICF0,   2,
Error    1051 -                            ^ Access width of Field Unit
extends beyond region limit

original.dsl  1675:                     ICF1,   2,
Error    1051 -                            ^ Access width of Field Unit
extends beyond region limit

original.dsl  1677:                     WPPE,   1,
Error    1051 -                            ^ Access width of Field Unit
extends beyond region limit

original.dsl  2272:                                 Store (SBUF (), Local0)
Warning  2030 -   Called method may not always return a value ^

original.dsl  2292:                     Method (SBUF, 0, NotSerialized)
Warning  2019 -                                    ^ Not all control
paths return a value (SBUF)

original.dsl  2566:                     Method (SGTF, 0, NotSerialized)
Warning  2019 -                                    ^ Not all control
paths return a value (SGTF)

original.dsl  2630:                             Store (SBUF (), Local0)
Warning  2030 -                                           ^ Called
method may not always return a value

original.dsl  2680:                         Method (_GTF, 0, NotSerialized)
Warning  2019 -   Not all control paths return a value ^  (_GTF)

original.dsl  2680:                         Method (_GTF, 0, NotSerialized)
Warning  2026 -    Reserved method must return a value ^  (_GTF)

original.dsl  2754:                         Method (_GTF, 0, NotSerialized)
Warning  2019 -   Not all control paths return a value ^  (_GTF)

original.dsl  2754:                         Method (_GTF, 0, NotSerialized)
Warning  2026 -    Reserved method must return a value ^  (_GTF)

original.dsl  2770:                                 Store (SGTF (), Local0)
Warning  2030 -   Called method may not always return a value ^

ASL Input:  original.dsl - 3620 lines, 129894 bytes, 2079 keywords
Compilation complete. 6 Errors, 10 Warnings, 0 Remarks, 592 Optimizations




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
