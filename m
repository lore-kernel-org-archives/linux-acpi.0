From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] Linux 2.6-pre-mm2 Fix crash on boot on ASUS L3800C if enabing APIC => add this machine to DMI black list
Date: Fri, 25 Jul 2003 13:52:44 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E97080@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>, akpm-3NddpPZAyC0@public.gmane.org, eric.valette-GANU6spQydw@public.gmane.org, sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Mikael Pettersson [mailto:mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org] 
> On Sun, 20 Jul 2003 21:48:24 +0200, Eric Valette wrote:
> >The following patch integrated in 2.5.74,
> >
> ><http://lists.insecure.org/lists/linux-kernel/2003/Jun/5840.html>

> At least two P4 laptops are known to require the 2.5.74 patch, and
> they do work with the local APIC.
> 
> While I don't dispute your machine has some problem, please
> do the following first before we completely blacklist it:
> - ensure you have the latest BIOS (ftp.asuscom.de has the ones for
>   their desktop mainboards, presumably the laptop BIOSen are 
> also there)
> - in what way is ACPI mandatory? does it fail to boot, or does it
>   just lose some specific feature? If you just want suspend support,
>   try APM if the machine has it
> 
> A question for the ACPI people:
> - Does the Linux kernel ACPI code ever transfer control to BIOS,
>   explicitly or implicitly via SMIs triggered by the interpreter?
>   If you do transfer control, do you disable interrupts and/or
>   the interrupt controllers before transferring control?
>   Entering BIOS with the local APIC live, in particular the timer,
>   is a known hang-generator with APM.

Yes, some OEMs (IBM, for one. I'm sure there are more) enter SMM when
executing control methods. The interpreter is just blithely going along
and writing values to mem and io ports -- it doesn't know it just
invoked SMM. Nothing is disabled.

BTW I'm getting a bunch of other reports starting with 2.5.74 (see
"linux laptop keyboard problem since 2.5.74"). 

So let me get this straight -- because 2 machines require this patch,
you want all the OTHER machines to go on the blacklist? Shouldn't the 2
machines get special-cased?

All these machines work under Windows, so there has to be a solution
that enables everyone to work.

Regards -- Andy
