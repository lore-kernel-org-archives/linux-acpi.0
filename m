From: Bernd Pfrommer <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: ACPI source release updated (20021002)
Date: Thu, 03 Oct 2002 17:59:14 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D9CBDB2.5040206@optonline.net>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DF00@orsmsx119.jf.intel.com>
Reply-To: berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I should have looked at the messages more carefully: things do markedly 
change, but it still doesn't get the interrupts right.
Interestingly, the links LN02-06 and LN10-15 which are first reported as 
disabled seem to get enabled later. Does that look kosher?

Thanks,
Bernd

Table [DSDT] - 769 Objects with 47 Devices 187 Methods 17 Regions
ACPI Namespace successfully loaded at root c03c79fc
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode 
successful
Executing all Device _STA and_INI 
methods:...............................................
47 Devices found containing: 47 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package 
initialization:......................................................................
Initialized 11/17 Regions 2/2 Fields 40/40 Buffers 17/17 Packages (769 
nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [NRTH] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 *5 7 9 11 12 14 15)
ACPI: PCI Interrupt Link [LN01] (IRQs 3 4 5 7 9 11 12 14 15, enabled at 
IRQ 10)
ACPI: PCI Interrupt Link [LN02] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN03] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN04] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN05] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN06] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN07] (IRQs 3 4 5 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [LN08] (IRQs *3 4 5 7 9 11 12 14 15)
ACPI: PCI Interrupt Link [LN09] (IRQs 3 4 5 7 *9 11 12 14 15)
ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNUS] (IRQs *10)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LN02] enabled at IRQ 11
ACPI: PCI Interrupt Link [LN03] enabled at IRQ 9
ACPI: PCI Interrupt Link [LN04] enabled at IRQ 5
ACPI: PCI Interrupt Link [LN05] enabled at IRQ 11
ACPI: PCI Interrupt Link [LN06] enabled at IRQ 9
ACPI: PCI Interrupt Link [LN10] enabled at IRQ 5
ACPI: PCI Interrupt Link [LN11] enabled at IRQ 11
ACPI: PCI Interrupt Link [LN12] enabled at IRQ 9
ACPI: PCI Interrupt Link [LN13] enabled at IRQ 5
ACPI: PCI Interrupt Link [LN14] enabled at IRQ 11
ACPI: PCI Interrupt Link [LN15] enabled at IRQ 9
PCI: Using ACPI for IRQ routing



Grover, Andrew wrote:

>>From: Bernd Pfrommer [mailto:berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org] 
>>    - it seems that there are a lot of these link devices, not just 
>>LNUS, no? Or do you think LNUS is the only one causing 
>>trouble? Maybe I 
>>can somehow get rid of it then?
>>
>
>You want them there if you are in a mode (usually PIC) that uses them. I
>think we may want to eliminate the dmesg output concerning them unless
>ACPI_DEBUG_OUTPUT, since in your case they're not even used (except for
>LNUS).
>
>>    - is there a way to disable the link devices altogether 
>>by modifying 
>>the DSDT?
>>
>
>They really are just a logical representation of the chipset routing control
>registers, so they should be harmless.
>
>>    - any suggestions as to why pci=noacpi does not fix the problem?
>>    - any other things I could try?
>>
>
>No, I'm kind of mystified why fixing GETI didn't fix things.
>
>Regards -- Andy
>




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
