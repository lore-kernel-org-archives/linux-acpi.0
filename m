From: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] Linux 2.6-pre-mm2 Fix crash on boot on ASUS
 L3800C if enabing APIC => add this machine to DMI black list
Date: Mon, 21 Jul 2003 17:59:42 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3F1C0DEE.8040509@free.fr>
References: <200307210114.h6L1El7M018996@harpo.it.uu.se> <3F1B9F37.509@free.fr>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3F1B9F37.509-GANU6spQydw@public.gmane.org>
To: eric.valette-GANU6spQydw@public.gmane.org
Cc: Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>, akpm-3NddpPZAyC0@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>>The following patch integrated in 2.5.74,
>>
>><http://lists.insecure.org/lists/linux-kernel/2003/Jun/5840.html>
>>
>>really enables the APIC even if BIOS disabled it. Unfortunately,
>>enabling APIC really does not seem to work on this ASUS laptop and ACPI
>>(which is mandatory) crash the kernel in ACPI code at boot time while
>>"Executing all Devices _STA and_INIT methods"
>>
>>Unless someones find a bug in ACPI code related to APIC management, It
>>is safer to add this machine in the DMI black list (along with DELL,
>>IBM, ...).
>>
>>So, as suggested by the author of the problematic change, I added and
>>entry in the DMI black list. But my guess is that most laptop will soon
>>be present in this list....
> 
> At least two P4 laptops are known to require the 2.5.74 patch, and
> they do work with the local APIC.

After a second though I think this kind of justification is not 
appropriate :
	- If we play this game of counting the machines that works with your 
patch and the machines that breaks, we may end up removing this patch as 
I have seen other with other laptop model also failing while executing 
the _STA and _INI initialization...
	- Anyway, there are already 3 machines in the black list includings two 
very popular old dells...

> - in what way is ACPI mandatory? does it fail to boot, or does it
>   just lose some specific feature? If you just want suspend support,
>   try APM if the machine has it

Come on, APM is a thing from the past and any recent laptop does not 
even care of supporting it now that Windows XP is  bundled... And in any 
case it is not supported by this particular machine...

> A question for the ACPI people:
> - Does the Linux kernel ACPI code ever transfer control to BIOS,
>   explicitly or implicitly via SMIs triggered by the interpreter?
>   If you do transfer control, do you disable interrupts and/or
>   the interrupt controllers before transferring control?

While I tried to read the ACPI specs for the fisrt time this morning 
searching for the meaning of _STA and _INI (and found the section 
related to INI rather unclear) I suspect the _INI is just dedicated to 
that purpose for escaping from legacy mode. But frankly, I got lost in 
the code trying to see when and how the function is really called... I 
would really like to have some help from ACPI development team on this 
one...

But if a BIOS function is called and the BIOS expects the APIC disabled, 
I would not blame BIOS writer if calling the function fails... So either 
the APIC should be disabled again or the ACPI initialisation should be 
done before turning the APIC on. But I have no idea about feasability...


>   Entering BIOS with the local APIC live, in particular the timer,
>   is a known hang-generator with APM.

My experienec 6 years ago writing a floppy network boot loader (in 32 
bit mode with a BIOS trampoline) is that this is not sufficient : before 
calling the BIOS, you should also restore the interrupt controller 
status in the legacy mode you got when entering (e.g 8259 programmation 
and especially PIC masks or any other legacy emultation). While this is 
not required on many machines, on some machines others, the bootloader 
just do not work without...



-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette-GANU6spQydw@public.gmane.org
