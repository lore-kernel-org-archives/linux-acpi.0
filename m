From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: ACPI interrupts..
Date: Wed, 25 Sep 2002 14:27:08 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B7BB@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'Linus Torvalds' <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The hardware is supposed to be implemented such that an SCI can only occur
if the enable bit and the status bit are both 1.

Interesting that it looks like the issue is within GPE block 1.

evevent-0704 [0000] [127] Ev_gpe_detect         : GPE block at
000000000000042E - Values: Enable 80 Status 40
 evevent-0704 [0000] [127] Ev_gpe_detect         : GPE block at
000000000000042F - Values: Enable 00 Status 21
 evevent-0704 [0000] [127] Ev_gpe_detect         : GPE block at
000000000000042A - Values: Enable 38 Status 00
 evevent-0704 [0000] [127] Ev_gpe_detect         : GPE block at
000000000000042B - Values: Enable 09 Status 00

-----Original Message-----
From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org] 
Sent: Wednesday, September 25, 2002 2:20 PM
To: 'Linus Torvalds'
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Subject: [ACPI] RE: ACPI interrupts..

> That also implies that it's not a completely spurious 
> interrupt: if it was
> spurious, the interrupt handler wouldn't know what to do with 
> it, and it 
> would scream constantly and the machine would make no 
> progress. Obviously 
> that isn't the case, since the machine works fine.

A properly functioning ACPI system should not generate 72000 interrupts per
second, needless to say. It may not be a lockup but it's still bad.

>From your trace, it sure looks like the software doesn't think it has any
fixed or general-purpose events outstanding, (like you say, enable and
status bits appear to be mutually exclusive) so it returns, assuming the
interrupt must be for someone else - but ACPI is the only one on irq 9
right?

I will whip up a patch to 1) disable all GPE enable bits and 2) clear all
GPE status bits and see if the problem goes away.

This kind of problem is pretty hard for me to fix without an actual instance
of the system to play with...sigh

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
