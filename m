From: Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] Linux 2.6-pre-mm2 Fix crash on boot on ASUS L3800C if enabing APIC => add this machine to DMI black list
Date: Mon, 21 Jul 2003 03:14:47 +0200 (MEST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200307210114.h6L1El7M018996@harpo.it.uu.se>
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: akpm-3NddpPZAyC0@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, eric.valette-GANU6spQydw@public.gmane.org, sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 20 Jul 2003 21:48:24 +0200, Eric Valette wrote:
>The following patch integrated in 2.5.74,
>
><http://lists.insecure.org/lists/linux-kernel/2003/Jun/5840.html>
>
>really enables the APIC even if BIOS disabled it. Unfortunately, 
>enabling APIC really does not seem to work on this ASUS laptop and ACPI 
>(which is mandatory) crash the kernel in ACPI code at boot time while 
>"Executing all Devices _STA and_INIT methods"
>
>Unless someones find a bug in ACPI code related to APIC management, It 
>is safer to add this machine in the DMI black list (along with DELL, 
>IBM, ...).
>
>So, as suggested by the author of the problematic change, I added and 
>entry in the DMI black list. But my guess is that most laptop will soon 
>be present in this list....

At least two P4 laptops are known to require the 2.5.74 patch, and
they do work with the local APIC.

While I don't dispute your machine has some problem, please
do the following first before we completely blacklist it:
- ensure you have the latest BIOS (ftp.asuscom.de has the ones for
  their desktop mainboards, presumably the laptop BIOSen are also there)
- in what way is ACPI mandatory? does it fail to boot, or does it
  just lose some specific feature? If you just want suspend support,
  try APM if the machine has it

A question for the ACPI people:
- Does the Linux kernel ACPI code ever transfer control to BIOS,
  explicitly or implicitly via SMIs triggered by the interpreter?
  If you do transfer control, do you disable interrupts and/or
  the interrupt controllers before transferring control?
  Entering BIOS with the local APIC live, in particular the timer,
  is a known hang-generator with APM.

/Mikael
(. again in "I hate BIOS writers" mode, grr .)
