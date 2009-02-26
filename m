From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: boot hang when using kexec
Date: Thu, 26 Feb 2009 14:38:52 -0800
Message-ID: <49A719FC.3080604@oracle.com>
References: <49A6F3B0.2010805@oracle.com> <alpine.LFD.2.00.0902261534230.6492@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:47295 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbZBZWhv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Feb 2009 17:37:51 -0500
In-Reply-To: <alpine.LFD.2.00.0902261534230.6492@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>

Len Brown wrote:
> On Thu, 26 Feb 2009, Randy Dunlap wrote:
> 
>> For daily kernel testing, I (try to) use kexec to boot each new kernel.
>> This hasn't been working for several weeks now.
>> A "git bisect" only pointed me at one of Arjan's async boot (fastboot)
>> patches, but he and I think that's a git bisect anomaly.
>>
>> The test system is an HP BladeCenter 4-proc with 8 GB of RAM
>> (HP BladeCenter BL c-class: ProLiant BL685c G1).
>> It boots from an HP/Compaq CCISS drive (using an initramfs).
>>
>>
>> I capture the kernel log via netconsole, so sometimes the last few
>> lines of the kernel log are lost.  This is what the end of the
>> netconsole capture looks like:
>> (using acpi.debug_layer=0x03412f3b acpi.debug_level=0xffffffff)
>>
>> Execute Method: [\_SB_.PCI0.IP2P.ASMD._STA] (Node ffff88027f813ba0)
>>   nseval-0164 [FFFF88027F840000] [00] ns_evaluate           : Method at AML address ffffc2000000c68a Length 2
>>  utmutex-0249 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 attempting to acquire Mutex [ACPI_MTX_Interpreter]
>>      osl-0852 [FFFF88027F840000] [00] os_wait_semaphore     : Waiting for semaphore[ffff88027f806140|1|65535]
>>      osl-0871 [FFFF88027F840000] [00] os_wait_semaphore     : Acquired semaphore[ffff88027f806140|1|65535] utmutex-0257 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 acquired Mutex [ACPI_MTX_Interpreter]
>>  utmutex-0249 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 attempting to acquire Mutex [ACPI_MTX_Caches]
>>      osl-0852 [FFFF88027F840000] [00] os_wait_semaphore     : Waiting for semaphore[ffff88027f8061c0|1|65535]
>>      osl-0871 [FFFF88027F840000] [00] os_wait_semaphore     : Acquired semaphore[ffff88027f8061c0|1|65535] utmutex-0257 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 acquired Mutex [ACPI_MTX_Caches]
>>   utmisc-0228 [FFFF88027F840000] [00] ut_allocate_owner_id  : Allocated OwnerId: 9D
>>  utmutex-0292 [FFFF88027F840000] [00] ut_release_mutex      : Thread FFFF88027F840000 releasing Mutex [ACPI_MTX_Caches]
>>      osl-0891 [FFFF88027F840000] [00] os_signal_semaphore   : Signaling semaphore[ffff88027f8061c0|1]
>>  utmutex-0249 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 attempting to acquire Mutex [ACPI_MTX_Namespace]
>>      osl-0852 [FFFF88027F840000] [00] os_wait_semaphore     : Waiting for semaphore[ffff88027f806160|1|65535]
>>      osl-0871 [FFFF88027F840000] [00] os_wait_semaphore     : Acquired semaphore[ffff88027f806160|1|65535] utmutex-0257 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 acquired Mutex [ACPI_MTX_Namespace]
>>  utmutex-0292 [FFFF88027F840000] [00] ut_release_mutex      : Thread FFFF88027F840000 releasing Mutex [ACPI_MTX_Namespace]
>>
>>
>> [more of the kernel log including above is available at
>> http://oss.oracle.com/kerneltest/logs/netcon-5975.log, but it does not include
>> the beginning of the kernel boot for some reason -- it was truncated]
>>
>>
>>
>> and this is what is on the serial console output (which I don't know how
>> to capture in its entirety):
>>
>> nssearch-0110 [FFFF88027F840000] [00] ns_search_one_scope   : Searching \_SB_.PCI0.IP2P (ffff88027f806ee0) For [_S2D] (Untyped)
>> nssearch-0174 [FFFF88027F840000] [00] ns_search_one_scope   : Name [_S2D] (Untyped) not found in search in scope [IP2P] ffff88027f806ee0 first child ffff88027f806f00
>> nssearch-0386 [FFFF88027F840000] [00] ns_search_and_enter   : _S2D Not found in ffff88027f806ee0 [Not adding]
>> nsaccess-0575 [FFFF88027F840000] [00] ns_lookup             : Name [_S2D] not found in scope [IP2P] ffff88027f806ee0
>>  nsutils-0876 [FFFF88027F840000] [00] ns_get_node           : _S2D, AE_NOT_FOUND
>>  utmutex-0292 [FFFF88027F840000] [00] ut_release_mutex      : Thread FFFF88027F840000 releasing Mutex [ACPI_MTX_Namespace]
>>      osl-0891 [FFFF88027F840000] [00] os_signal_semaphore   : Signaling semaphore[ffff88027f806160|1]
>>   uteval-0227 [FFFF88027F840000] [00] ut_evaluate_object    : [IP2P._S2D] was not found
>>  nsutils-0461 [FFFF88027F840000] [00] ns_build_internal_name: Returning [ffff88027ed28be0] (rel) "_S3D"
>>  utmutex-0249 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 attempting to acquire Mutex [ACPI_MTX_Namespace]
>>      osl-0852 [FFFF88027F840000] [00] os_wait_semaphore     : Waiting for semaphore[ffff88027f806160|1|65535]
>>      osl-0871 [FFFF88027F840000] [00] os_wait_semaphore     : Acquired semaphore[ffff88027f806160|1|65535] utmutex-0257 [FFFF88027F840000] [00] ut_acquire_mutex      : Thread FFFF88027F840000 acquired Mutex [ACPI_MTX_Namespace]
>> nsaccess-0404 [FFFF88027F840000] [00] ns_lookup             : Searching relative to prefix scope [IP2P] (ffff88027f806ee0)
>> nsaccess-0514 [FFFF88027F840000] [00] ns_lookup             : Simple Pathname (1 segment, Flags=2)
>>   nsdump-0087 [FFFF88027F840000] [00] ns_print_pathname     : [_S3D]
>> nssearch-0110 [FFFF88027F840000] [00] ns_search_one_scope   : Searching \_SB_.PCI0.IP2P (ffff88027f806ee0) For [_S3D] (Untyped)
>> nssearch-0174 [FFFF88027F840000] [00] ns_search_one_scope   : Name [_S3D] (Untyped) not found in search in scope [IP2P] ffff88027f806ee0 first child ffff88027f806f00
>> nssearch-0386 [FFFF88027F840000] [00] ns_search_and_enter   : _S3D Not found in ffff88027f
> 
> mutexes being acquired and released,
> optional objects not being found.
> 
> Nothing jumps out at me as wrong above.
> 
> How does the boot fail, and why are you looking at ACPI --

  (see below for typical failures), & pulling at straws?

> is this the last thing seen on the console?

Yes.

> What is the last thing printed when acpi_debug is not enabled?

Usual failures are like these:

ACPI: bus type pci registered
PCI: MCFG configuration 0: base 80000000 segment 0 buses 0 - 255
PCI: Not using MMCONFIG.
PCI: Using configuration type 1 for base access
PCI: HP ProLiant BL685c G1 detected, enabling pci=bfsort.
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: SSDT 7FE58000, 04F0 (r2 HP     PNOWSSDT        2 HP          1)
ACPI: Interpreter enabled

or

ACPI: bus type pci registered
PCI: Using configuration type 1 for base access
PCI: HP ProLiant BL685c G1 detected, enabling pci=bfsort.
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: SSDT 7FE58000, 04F0 (r2 HP     PNOWSSDT        2 HP          1)
ACPI: Interpreter enabled
ACPI: (supports S0 S4 S5)
ACPI: Using IOAPIC for interrupt routing

or

ACPI: bus type pci registered
PCI: MCFG configuration 0: base 80000000 segment 0 buses 0 - 255
PCI: Not using MMCONFIG.
PCI: Using configuration type 1 for base access
PCI: HP ProLiant BL685c G1 detected, enabling pci=bfsort.
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: SSDT 7FE58000, 04F0 (r2 HP     PNOWSSDT        2 HP          1)
ACPI: Interpreter enabled
ACPI: (supports S0 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: MCFG configuration 0: base 80000000 segment 0 buses 0 - 255
PCI: MCFG area at 80000000 reserved in ACPI motherboard resources
PCI: Using MMCONFIG at 80000000 - 8fffffff
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:02.0: reg 10 32bit mmio: [0xf7de0000-0xf7de0fff]
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:02.0: PME# disabled
pci 0000:00:02.1: reg 10 32bit mmio: [0xf7dd0000-0xf7dd00ff]
pci 0000:00:02.1: supports D1 D2
pci 0000:00:02.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:02.1: PME# disabled
pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:0b.0: PME# disabled
pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:0c.0: PME# disabled
pci 0000:00:0d.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:0d.0: PME# disabled
pci 0000:00:0e.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:0e.0: PME# disabled
pci 0000:01:03.0: reg 10 32bit mmio: [0xe8000000-0xefffffff]
pci 0000:01:03.0: reg 14 io port: [0x1000-0x10ff]
pci 0000:01:03.0: reg 18 32bit mmio: [0xf7ff0000-0xf7ffffff]
pci 0000:01:03.0: reg 30 32bit mmio: [0x000000-0x01ffff]
pci 0000:01:03.0: supports D1 D2
pci 0000:01:04.0: reg 10 io port: [0x2800-0x28ff]
pci 0000:01:04.0: reg 14 32bit mmio: [0xf7fe0000-0xf7fe01ff]
pci 0000:01:04.0: PME# supported from D0 D3hot D3cold
pci 0000:01:04.0: PME# disabled
pci 0000:01:04.2: reg 10 io port: [0x1400-0x14ff]
pci 0000:01:04.2: reg 14 32bit mmio: [0xf7fd0000-0xf7fd07ff]
pci 0000:01:04.2: reg 18 32bit mmio: [0xf7fc0000-0xf7fc1fff]


while a working boot is like this:

calling  cciss_init+0x0/0x2e [cciss] @ 733
HP CISS Driver (v 3.6.20)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 54
cciss 0000:42:08.0: PCI INT A -> Link[LNKA] -> GSI 54 (level, high) -> IRQ 54
cciss 0000:42:08.0: irq 70 for MSI/MSI-X
IRQ 70/cciss0: IRQF_DISABLED is not guaranteed on shared IRQs
cciss0: <0x3238> at PCI 0000:42:08.0 IRQ 70 using DAC
usb 1-1: new full speed USB device using uhci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
input: HP Virtual Keyboard as /class/input/input2
generic-usb 0003:03F0:1027.0001: input: USB HID v1.01 Keyboard [HP Virtual Keyboard] on usb-0000:01:04.4-1/input0
input: HP Virtual Keyboard as /class/input/input3
generic-usb 0003:03F0:1027.0002: input: USB HID v1.01 Mouse [HP Virtual Keyboard] on usb-0000:01:04.4-1/input1
usb 1-2: new full speed USB device using uhci_hcd and address 3
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 7 ports detected


This leads me (now) to suspect the cciss driver more than anything else.


> not having any idea what is wrong here, try irqpoll,

irqpoll didn't help.

> in case some interrupts are screwed up.
> you might also enable the watchdog.

I already have nmi_watchdog=2.  Is that OK?


Thanks.
-- 
~Randy
