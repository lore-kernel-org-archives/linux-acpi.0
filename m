From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: _PTS call hangs system
Date: Mon, 20 Sep 2004 12:05:29 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6EDC9204B3704C4C8522539D5C1185E52449B7@mssmsx403.ccr.corp.intel.com>
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
To: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Could you post your whole DSDT and dmesg?
BTW, if you enable debug in ACPI and do "Store ("BLA-BLA-BLA", Debug)"
in any method of DSDT, ACPI will print it to console (even from _PTS and
_GTS).

Thanks,
	Alex.

>-----Original Message-----
>From: Andre Eisenbach [mailto:andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org]
>Sent: Saturday, September 18, 2004 1:59 AM
>To: Starikovskiy, Alexey Y
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] _PTS call hangs system
>
>Am Freitag 17 September 2004 04:08 schrieb Starikovskiy, Alexey Y:
>> >I may try to go throught the _PTS procedure next to figure out which
>> > call specifically hangs - if that is of any use?
>>
>> I think Sleep(2000) is a main suspect here. That architecture are you
>> using? Is it 64 bit one?
>
>It's a AMD XP (32-bit).
>
>I've tried it many times today and it crashes every time EXCEPT when I
>comment
>out ALL lines in that S5 branch. As in, this works:
>
>        If (LEqual (Arg0, 0x05))
>        {
>/*
>            Store (0x00, \_SB.PCI0.ISA.EC0.WORE)
>            If (\_SB.PCI0.ISA.WOLE)
>            {
>                Store (0x01, \_SB.PCI0.ISA.EC0.WOLE)
>            }
>            Else
>            {
>                Store (0x00, \_SB.PCI0.ISA.EC0.WOLE)
>            }
>
>            \_SB.PCI0.ISA.HPSS (0x02, 0x00)
>            Sleep (0x07D0)
>*/
>        }
>
>Every other combination (only the Sleep() enabled, only one other line
>enabled, whatever) causes the system to hang on shutdown. So only not
>calling
>that procedure or not doing anything inside seem to help at this point.
>
>Seems very odd.
>
>Cheers,
>    Andre


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
