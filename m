From: Ramkumar R <andyetitmoves-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: DSDT problem with Acer Aspire 3002NLC
Date: Mon, 6 Jun 2005 07:40:23 -0700
Message-ID: <9a9bfc170506060740547d2bd6@mail.gmail.com>
Reply-To: Ramkumar R <andyetitmoves-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi!

I have a Acer Aspire 3002NLC and the battery was not getting reported.
The syslog too was flooded. I checked up the DSDT database and found a
fixed table for Aspire 3000 (It reportedly fixed this error, see
http://acpi.sourceforge.net/dsdt/view.php?id=3D377). I merged the
changes with the decompiled file I had. I had decompiled with iasl,
and on recompilation with the patch 6 errors remained. (Originally 37
errors were present). I am using iasl version 20050513.

The compilation cmdline: iasl -oi -of -on -tc dcust.dsl 2>&1 > /tmp/error.l=
og

Error log:

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050513 [Jun  4 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dcust.dsl  2506:                             If (LNot (LEqual
(\_PR.CPU0._PPC, 0x00)))
Error    1022 -                                       Object does not
exist ^  (\_PR.CPU0._PPC)

dcust.dsl  2508:                                 Store (0x00, \_PR.CPU0._PP=
C)
Error    1022 -                                      Object does not
exist ^  (\_PR.CPU0._PPC)

dcust.dsl  2516:                             If (LLess (\_PR.CPU0._PPC, Loc=
al1))
Error    1022 -                                Object does not exist ^
 (\_PR.CPU0._PPC)

dcust.dsl  2518:                                 Store (Local1, \_PR.CPU0._=
PPC)
Error    1022 -                                        Object does not
exist ^  (\_PR.CPU0._PPC)

dcust.dsl  2528:                         If (LNot (LEqual
(\_PR.CPU0._PPC, 0x00)))
Error    1022 -                                   Object does not
exist ^  (\_PR.CPU0._PPC)

dcust.dsl  2530:                             Store (0x00, \_PR.CPU0._PPC)
Error    1022 -                                  Object does not exist
^  (\_PR.CPU0._PPC)

ASL Input:  dcust.dsl - 3466 lines, 120769 bytes, 1560 keywords
Compilation complete. 6 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

Thanx,
Ramkumar.

PS: I am new to the list. Tried attaching the dsdt, but the mailist
list server complained. So, I have mailed without the dsdt (I think
it's the same as in the url above). If the older mail eventually gets
approved and comes to this list, sorry for the repetition :)

--=20
The day Microsoft makes something that doesn't suck
is probably the day they start making vacuum cleaners.
                                               -Ernst Jan Plugge


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
