From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI interrupts..
Date: Wed, 25 Sep 2002 14:20:17 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEC3@orsmsx119.jf.intel.com>
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
To: 'Linus Torvalds' <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

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
