From: Dimitri Van Landuyt <dimitri.vanlanduyt@gmail.com>
Subject: Re: MSI S420 (based on MS-141214 barebone)
Date: Sat, 21 Oct 2006 02:01:22 +0200
Message-ID: <45396352.6090907@gmail.com>
References: <eg5edj$m49$1@sea.gmane.org> <ehalud$p71$1@sea.gmane.org> <4538E702.3020707@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:13768 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161051AbWJUABc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 20:01:32 -0400
Received: by ug-out-1314.google.com with SMTP id z34so753280ugc
        for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2006 17:01:30 -0700 (PDT)
In-Reply-To: <4538E702.3020707@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

In this bugreport 
(http://www.mail-archive.com/acpi-bugzilla@lists.sourceforge.net/msg03861.html) 
about a different laptop the following is said about this laptop.

> ACPI: Looking for DSDT ... not found! 
 
This message is not in the kernel.org kernel source tree, either 
as of 2.6.15, or as of 2.6.18.  While your system seems to have 
plenty of other problems, ACPI did find the DSDT and it is running 
normally. 
 
I expect this message comes from the "initrd DSDT override patch" 
that some distributions, such as SuSE and Ubuntu tend to add to 
the kernel as their "value add" -- complain to them. 

I do have the impression that ACPI is partially enabled: events such as 
plugging out the adapter, closing the lid, ... are detected. Others 
again arent (temperature does not work, etc). Furthermore, I do have a 
non-empty /proc/acpi/dsdt.

Following this DSDT lead, I found the following page: 
http://forums.gentoo.org/viewtopic.php?t=122145 and did the following 
actions:

$ sudo cat /proc/acpi/dsdt > dsdt.dat
$ iasl -d dsdt.dat

Intel ACPI Component Architecture
AML Disassembler version 20060608 [Jun 29 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

Loading Acpi table from file dsdt.dat
Acpi table [DSDT] successfully installed and loaded
Pass 1 parse of [DSDT]
Pass 2 parse of [DSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
............................................................................................................................................................................................................................................................................................................................
Parsing completed
Disassembly completed, written to "dsdt.dsl"
$ iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060608 [Jun 29 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

dsdt.dsl  3665:             Acquire (MUTE, 0x03E8)
Warning  1103 -                                 ^ Possible operator 
timeout is ignored

dsdt.dsl  3679:             Acquire (MUTE, 0x03E8)
Warning  1103 -                                 ^ Possible operator 
timeout is ignored

dsdt.dsl  3694:             Acquire (MUTE, 0x03E8)
Warning  1103 -                                 ^ Possible operator 
timeout is ignored

dsdt.dsl  3709:             Acquire (MUTE, 0x0FFF)
Warning  1103 -                                 ^ Possible operator 
timeout is ignored

dsdt.dsl  3723:             Acquire (MUTE, 0x03E8)
Warning  1103 -                                 ^ Possible operator 
timeout is ignored

dsdt.dsl  3738:             Acquire (MUTE, 0x03E8)
Warning  1103 -                                 ^ Possible operator 
timeout is ignored

dsdt.dsl  3753:             Acquire (MUTE, 0x03E8)
Warning  1103 -                                 ^ Possible operator 
timeout is ignored

ASL Input:  dsdt.dsl - 4020 lines, 126317 bytes, 1562 keywords
AML Output: dsdt.aml - 14609 bytes 626 named objects 936 executable opcodes

Compilation complete. 0 Errors, 7 Warnings, 0 Remarks, 611 Optimizations

So apparently my DSDT contains no errors and a few warnings. Maybe they 
are causing the few functionalities not working?

Other leads I can pursue? How could this be related to the hpet=disable 
kernel param I need to give before booting?

Thanks for your help!
Dimitri





Alexey Starikovskiy wrote:
> This should be a starting point, without DSDT ACPI will be disabled on your machine:
> [17179573.608000] ACPI: Looking for DSDT ... not found!
>
> Before, DSDT was listed among other tables, so it probably exists, but has wrong checksum
> or it may be some huge problem with Ubuntu kernel...
>
> Regards,
> 	Alex.
>
> Dimitri Van Landuyt wrote:
>   
>> Dear ACPI list,
>>
>> further finding with my notebook:
>>
>> A lot works out of the box with Ubuntu edgy: suspend, wireless, card
>> reader, ..., BUT:
>> - There is still the hpet issue, which - I think - screws up my thermal
>> readings (is that possible).
>> - The reason I'm thinking this is that every ACPI related thing works
>> well enough, except for fan control and temperature reading. Since my
>> fan is on all the time, this reduces my battery life drastically.
>> - Since these issues were happening with similar models (MSI S271 also
>> has this Ati chipset), and BIOS fixes resolved these issues, I am
>> planning to ask MSI for a BIOS upgrade.
>> - What I would love is someone who wants to look into this, so I can
>> present a reasonable case at MSI and make them release a fix for my
>> problems.
>> - Or, when the problem is the ACPI linux stuff, I want to look into how
>> fixing this. Again, help is appreciated!
>>
>>
>>
>> dimitri@placeholder:~$ dmesg | grep ACPI
>> [17179569.184000]  BIOS-e820: 000000006ffd0000 - 000000006ffde000 (ACPI
>> data)
>> [17179569.184000]  BIOS-e820: 000000006ffde000 - 0000000070000000 (ACPI
>> NVS)
>> [17179569.184000] ACPI: RSDP (v000 MSI  ) @ 0x000f7ae0
>> [17179569.184000] ACPI: RSDT (v001 MSI    1024     0x07072006 MSFT
>> 0x00000097) @ 0x6ffd0000
>> [17179569.184000] ACPI: FADT (v002 MSI    1024     0x07072006 MSFT
>> 0x00000097) @ 0x6ffd0200
>> [17179569.184000] ACPI: MADT (v001 MSI    OEMAPIC  0x07072006 MSFT
>> 0x00000097) @ 0x6ffd0390
>> [17179569.184000] ACPI: MCFG (v001 MSI    OEMMCFG  0x07072006 MSFT
>> 0x00000097) @ 0x6ffd03f0
>> [17179569.184000] ACPI: OEMB (v001 MSI    MSI_OEM  0x07072006 MSFT
>> 0x00000097) @ 0x6ffde040
>> [17179569.184000] ACPI: HPET (v001 MSI    OEMHPET  0x07072006 MSFT
>> 0x00000097) @ 0x6ffd4230
>> [17179569.184000] ACPI: DSDT (v001    MSI    1412X 0x07072006 INTL
>> 0x02002026) @ 0x00000000
>> [17179569.184000] ACPI: PM-Timer IO Port: 0x808
>> [17179569.184000] ACPI: Local APIC address 0xfee00000
>> [17179569.184000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
>> [17179569.184000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
>> [17179569.184000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
>> [17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>> [17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low
>> level)
>> [17179569.184000] ACPI: IRQ0 used by override.
>> [17179569.184000] ACPI: IRQ2 used by override.
>> [17179569.184000] ACPI: HPET id: 0x0 base: 0xfed00000
>> [17179569.184000] Using ACPI (MADT) for SMP configuration information
>> [17179573.608000] ACPI: Core revision 20060707
>> [17179573.608000] ACPI: Looking for DSDT ... not found!
>> [17179574.140000] ACPI: bus type pci registered
>> [17179574.156000] ACPI: Interpreter enabled
>> [17179574.156000] ACPI: Using IOAPIC for interrupt routing
>> [17179574.156000] ACPI: PCI Root Bridge [PCI0] (0000:00)
>> [17179574.156000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>> [17179574.164000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
>> [17179574.164000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE6._PRT]
>> [17179574.164000] ACPI: Embedded Controller [EC] (gpe 6) interrupt mode.
>> [17179574.168000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
>> [17179574.168000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12
>> 14 15) *0, disabled.
>> [17179574.168000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12
>> 14 15) *0, disabled.
>> [17179574.168000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 11 12
>> 14 15) *0, disabled.
>> [17179574.168000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12
>> 14 15) *0, disabled.
>> [17179574.172000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12
>> 14 15) *0, disabled.
>> [17179574.172000] ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0, disabled.
>> [17179574.172000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12
>> 14 15) *0, disabled.
>> [17179574.172000] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12
>> 14 15) *0, disabled.
>> [17179574.172000] pnp: PnP ACPI init
>> [17179574.172000] pnp: PnP ACPI: found 11 devices
>> [17179574.172000] PnPBIOS: Disabled by ACPI PNP
>> [17179574.172000] PCI: Using ACPI for IRQ routing
>> [17179574.188000] ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17179574.636000] ACPI: (supports S0 S3 S4 S5)
>> [17179575.740000] ACPI: duty_cycle spans bit 4
>> [17179575.740000] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ AMI]
>> OemTableId [  CPU1PM] [20060707]
>> [17179575.740000] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ AMI]
>> OemTableId [  CPU2PM] [20060707]
>> [17179575.744000] ACPI: Thermal Zone [THRM] (75 C)
>> [17179576.024000] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level,
>> low) -> IRQ 201
>> [17179578.440000] ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17179578.568000] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17179578.756000] ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17179578.952000] ACPI: PCI Interrupt 0000:04:04.4[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17179589.696000] ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 18 (level,
>> low) -> IRQ 209
>> [17179589.812000] ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17179589.948000] ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level,
>> low) -> IRQ 201
>> [17179589.948000] ACPI: PCI Interrupt 0000:04:04.2[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17179590.976000] ACPI: PCI Interrupt 0000:04:09.0[A] -> GSI 16 (level,
>> low) -> IRQ 201
>> [17179596.956000] ACPI: AC Adapter [ADP1] (on-line)
>> [17179597.004000] ACPI: Battery Slot [BAT1] (battery present)
>> [17179597.020000] ACPI: Power Button (FF) [PWRF]
>> [17179597.020000] ACPI: Lid Switch [LID0]
>> [17179597.020000] ACPI: Sleep Button (CM) [SLPB]
>> [17179597.020000] ACPI: Power Button (CM) [PWRB]
>> [17179597.268000] ACPI: Video Device [VGA] (multi-head: yes  rom: no
>> post: no)
>> [17179600.968000] ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level,
>> low) -> IRQ 217
>> [17182085.196000] ACPI: PCI interrupt for device 0000:04:03.0 disabled
>> [17182085.276000] ACPI: PCI interrupt for device 0000:04:09.0 disabled
>> [17182089.604000] ACPI: PCI interrupt for device 0000:04:04.2 disabled
>> [17182089.620000] ACPI: PCI interrupt for device 0000:04:04.0 disabled
>> [17182090.088000] ACPI: PCI interrupt for device 0000:01:05.0 disabled
>> [17182090.104000] ACPI: PCI interrupt for device 0000:00:14.2 disabled
>> [17182090.104000] ACPI: PCI interrupt for device 0000:00:13.2 disabled
>> [17182090.120000] ACPI: PCI interrupt for device 0000:00:13.1 disabled
>> [17182090.120000] ACPI: PCI interrupt for device 0000:00:13.0 disabled
>> [17185894.120000] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17185894.120000] ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17185894.136000] ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17185894.136000] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level,
>> low) -> IRQ 201
>> [17185894.136000] ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level,
>> low) -> IRQ 201
>> [17185894.240000] ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level,
>> low) -> IRQ 217
>> [17185894.296000] ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17185894.312000] ACPI: PCI Interrupt 0000:04:04.2[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17185894.352000] ACPI: PCI Interrupt 0000:04:04.4[A] -> GSI 19 (level,
>> low) -> IRQ 177
>> [17185897.772000] ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 18 (level,
>> low) -> IRQ 209
>> [17185897.804000] ACPI: PCI Interrupt 0000:04:09.0[A] -> GSI 16 (level,
>> low) -> IRQ 201
>> [17185898.396000] ACPI: Power Button (FF) [PWRF]
>> [17185898.396000] ACPI: Lid Switch [LID0]
>> [17185898.396000] ACPI: Sleep Button (CM) [SLPB]
>> [17185898.396000] ACPI: Power Button (CM) [PWRB]
>> [17185898.444000] ACPI: Thermal Zone [THRM] (75 C)
>> [17185898.496000] ACPI: AC Adapter [ADP1] (on-line)
>> [17185898.528000] ACPI: Battery Slot [BAT1] (battery present)
>>
>> Thanks in advance!
>>
>>
>> Dimitri Van Landuyt wrote:
>>     
>>> Dear acpi list,
>>>
>>> I bought me a brand new laptop, MSI S420 based on the MS-141214
>>> barebone):
>>> http://www.msicomputer.com/NB/product_spec.asp?model=MS-141214.
>>>
>>> Of course, and too bad, not everything is supported in terms of acpi
>>> and  I am eager to look into this problem. I will enumerate on my
>>> issues and  observations here, hoping some willing ear would lend a
>>> helping hand.
>>>
>>> I am running ubuntu edgy beta now which runs the 2.6.17-10 kernel and
>>> I have seen the same issues in ubuntu dapper which has a 2.6.15 kernel.
>>>
>>> 1. When booting the machine in a default configuration, it hangs
>>> (kernel does not respond to any sysrq key combinations) after the
>>> following lines:
>>>
>>> using HPET for base-timer
>>> using HPET for gettimeofday
>>> Detected 2000.186 MHz processor
>>> Using hpet for high-res timesource.
>>>
>>> Playing with some kernel parameters, I notice the following behaviour:
>>> no effects with pci=noacpi, acpi=force,noapic, nohpet, ...
>>> What does work is: acpi=off but then I have no acpi at all, another
>>> option I discovered is hpet=disable, which enables some of the acpi
>>> functionalities.
>>>
>>> 2. with the hpet=disable parameter, I can see battery state, but
>>> remainng time is calculated incorrectly (always giving the same amount
>>> of minutes), plugging in and out the adapter is recognized however.
>>> Reading temperature does not work as he always gives the constant heat
>>> of 75 degrees. Cpu frequency scaling does not work.
>>>
>>> 3. output of dmesg | grep ACPI and dmesg are in attachment.
>>>
>>> 4. While booting the kernel, but apparently before putting things in
>>> the kernel log, some messages appear (three), among which something
>>> about a BIOS bug. They flash away too fast for me to write them down,
>>> so a way of capturing these is appreciated.
>>>
>>> 5. Would fixing the DSDT (of which I read some stuff here and there)
>>> be helpful in my case? Is it dangerous? Is there someone to walk me
>>> through it?
>>>
>>> 6. My BIOS is v1.01 and is definitely the current version as it is a
>>> very new laptop in general.
>>>
>>> Any help is greatly appreciated!
>>>
>>> Dimitri Van Landuyt
>>>
>>>
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>       
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>     
>
>   

