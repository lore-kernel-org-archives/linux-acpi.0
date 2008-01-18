From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: Re: dmidecode from hp pavilion dv9047ea Turion X2
Date: Fri, 18 Jan 2008 02:09:45 +0000
Message-ID: <20080118020945.3e41bb91.miknix@gmail.com>
References: <478C0D0E.1050402@versanet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:59860 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756756AbYARCFX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2008 21:05:23 -0500
Received: by ug-out-1314.google.com with SMTP id z38so420180ugc.16
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jan 2008 18:05:21 -0800 (PST)
In-Reply-To: <478C0D0E.1050402@versanet.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "HasiHeike@versanet.de" <HasiHeike@versanet.de>
Cc: linux-acpi@vger.kernel.org

On Tue, 15 Jan 2008 02:31:58 +0100
"HasiHeike@versanet.de" <HasiHeike@versanet.de> wrote:

> # dmidecode 2.9
> SMBIOS 2.4 present.
> 20 structures occupying 822 bytes.
> Table at 0x000F1C80.
> 
> Handle 0x0000, DMI type 0, 24 bytes
> BIOS Information
>         Vendor: Hewlett-Packard
>         Version: F.3B
>         Release Date: 10/02/2007
>         Address: 0xE6A30
>         Runtime Size: 103888 bytes
>         ROM Size: 1024 kB
>         Characteristics:
>                 ISA is supported
>                 PCI is supported
>                 PNP is supported
>                 BIOS is upgradeable
>                 BIOS shadowing is allowed
>                 ESCD support is available
>                 Boot from CD is supported
>                 Selectable boot is supported
>                 Print screen service is supported (int 5h)
>                 8042 keyboard services are supported (int 9h)
>                 Serial services are supported (int 14h)
>                 Printer services are supported (int 17h)
>                 ACPI is supported
>                 USB legacy is supported
>                 AGP is supported
>                 Smart battery is supported
>                 BIOS boot specification is supported
>                 Targeted content distribution is supported
> 
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: Hewlett-Packard
>         Product Name: HP Pavilion dv9000 (RE372EA#ABD)
>         Version: Rev 1
>         Serial Number: CNF6330ND6
>         UUID: 434E4636-3333-304E-4436-00163674AE3C
>         Wake-up Type: Power Switch
>         SKU Number: RE372EA#ABD
>         Family: 103C_5335KV
> 
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
>         Manufacturer: Quanta
>         Product Name: 30B9
>         Version: 65.29
>         Serial Number: None
> 
> Handle 0x0003, DMI type 3, 17 bytes
> Chassis Information
>         Manufacturer: Quanta
>         Type: Notebook
>         Lock: Not Present
>         Version: N/A
>         Serial Number: None
>         Asset Tag:
>         Boot-up State: Safe
>         Power Supply State: Safe
>         Thermal State: Safe
>         Security Status: Unknown
>         OEM Information: 0x00000000
> 
> Handle 0x0004, DMI type 4, 35 bytes
> Processor Information
>         Socket Designation: Socket S1
>         Type: Central Processor
>         Family: Opteron
>         Manufacturer: AMD
>         ID: 82 0F 04 00 FF FB 8B 17
>         Signature: Family 15, Model 72, Stepping 2
>         Flags:
>                 FPU (Floating-point unit on-chip)
>                 VME (Virtual mode extension)
>                 DE (Debugging extension)
>                 PSE (Page size extension)
>                 TSC (Time stamp counter)
>                 MSR (Model specific registers)
>                 PAE (Physical address extension)
>                 MCE (Machine check exception)
>                 CX8 (CMPXCHG8 instruction supported)
>                 APIC (On-chip APIC hardware supported)
>                 SEP (Fast system call)
>                 MTRR (Memory type range registers)
>                 PGE (Page global enable)
>                 MCA (Machine check architecture)
>                 CMOV (Conditional move instruction supported)
>                 PAT (Page attribute table)
>                 PSE-36 (36-bit page size extension)
>                 CLFSH (CLFLUSH instruction supported)
>                 MMX (MMX technology supported)
>                 FXSR (Fast floating-point save and restore)
>                 SSE (Streaming SIMD extensions)
>                 SSE2 (Streaming SIMD extensions 2)
>                 HTT (Hyper-threading technology)
>         Version: AMD Turion(tm) 64 X2 Mobile TL52
>         Voltage: 1.6 V
>         External Clock: 200 MHz
>         Max Speed: 1600 MHz
>         Current Speed: 1600 MHz
>         Status: Populated, Enabled
>         Upgrade: None
>         L1 Cache Handle: 0x0005
>         L2 Cache Handle: 0x0006
>         L3 Cache Handle: Not Provided
>         Serial Number: Not Specified
>         Asset Tag: Not Specified
>         Part Number: Not Specified
> 
> Handle 0x0005, DMI type 7, 19 bytes
> Cache Information
>         Socket Designation: L1 Cache
>         Configuration: Enabled, Not Socketed, Level 1
>         Operational Mode: Write Back
>         Location: Internal
>         Installed Size: 64 KB
>         Maximum Size: 64 KB
>         Supported SRAM Types:
>                 Burst
>                 Pipeline Burst
>                 Asynchronous
>         Installed SRAM Type: Asynchronous
>         Speed: Unknown
>         Error Correction Type: Unknown
>         System Type: Unknown
>         Associativity: Unknown
> 
> Handle 0x0006, DMI type 7, 19 bytes
> Cache Information
>         Socket Designation: L2 Cache
>         Configuration: Enabled, Not Socketed, Level 2
>         Operational Mode: Write Through
>         Location: Internal
>         Installed Size: 1024 KB
>         Maximum Size: 1024 KB
>         Supported SRAM Types:
>                 Burst
>                 Pipeline Burst
>                 Synchronous
>         Installed SRAM Type: Synchronous
>         Speed: Unknown
>         Error Correction Type: Unknown
>         System Type: Unified
>         Associativity: Unknown
> 
> Handle 0x0007, DMI type 9, 13 bytes
> System Slot Information
>         Designation: PCI Express Slot 1
>         Type: 64-bit PCI Express
>         Current Usage: Available
>         Length: Short
>         ID: 0
>         Characteristics:
>                 5.0 V is provided
>                 3.3 V is provided
> 
> Handle 0x0008, DMI type 9, 13 bytes
> System Slot Information
>         Designation: PCI Express Slot 2
>         Type: 64-bit PCI Express
>         Current Usage: Available
>         Length: Short
>         ID: 0
>         Characteristics:
>                 5.0 V is provided
>                 3.3 V is provided
>                 PME signal is supported
>                 Hot-plug devices are supported
> 
> Handle 0x0009, DMI type 10, 6 bytes
> On Board Device Information
>         Type: Video
>         Status: Enabled
>         Description:
> 
> Handle 0x000A, DMI type 11, 5 bytes
> OEM Strings
>         String 1: $HP$
>         String 2: LOC#
> 
> Handle 0x000B, DMI type 15, 29 bytes
> System Event Log
>         Area Length: 16 bytes
>         Header Start Offset: 0x0000
>         Header Length: 16 bytes
>         Data Start Offset: 0x0010
>         Access Method: General-purpose non-volatile data functions
>         Access Address: 0x0000
>         Status: Valid, Not Full
>         Change Token: 0x000000F6
>         Header Format: Type 1
>         Supported Log Type Descriptors: 3
>         Descriptor 1: POST error
>         Data Format 1: POST results bitmap
>         Descriptor 2: Single-bit ECC memory error
>         Data Format 2: Multiple-event
>         Descriptor 3: Multi-bit ECC memory error
>         Data Format 3: Multiple-event
> 
> Handle 0x000C, DMI type 16, 15 bytes
> Physical Memory Array
>         Location: System Board Or Motherboard
>         Use: System Memory
>         Error Correction Type: None
>         Maximum Capacity: 2 GB
>         Error Information Handle: Not Provided
>         Number Of Devices: 2
> 
> Handle 0x000D, DMI type 17, 27 bytes
> Memory Device
>         Array Handle: 0x000C
>         Error Information Handle: No Error
>         Total Width: 64 bits
>         Data Width: 64 bits
>         Size: 1024 MB
>         Form Factor: DIMM
>         Set: 1
>         Locator: DIMM 1
>         Bank Locator: Bank 0,1
>         Type: DDR2
>         Type Detail: Synchronous
>         Speed: 667 MHz (1.5 ns)
>         Manufacturer: F7F7460000000000
>         Serial Number: FFFFFFFF
>         Asset Tag: Not Specified
>         Part Number: MDT DDR2
> 
> Handle 0x000E, DMI type 17, 27 bytes
> Memory Device
>         Array Handle: 0x000C
>         Error Information Handle: No Error
>         Total Width: 64 bits
>         Data Width: 64 bits
>         Size: 1024 MB
>         Form Factor: DIMM
>         Set: 1
>         Locator: DIMM 2
>         Bank Locator: Bank 2,3
>         Type: DDR2
>         Type Detail: Unknown
>         Speed: 667 MHz (1.5 ns)
>         Manufacturer: F7F7460000000000
>         Serial Number: FFFFFFFF
>         Asset Tag: Not Specified
>         Part Number: MDT DDR2
> 
> Handle 0x000F, DMI type 19, 15 bytes
> Memory Array Mapped Address
>         Starting Address: 0x00000000000
>         Ending Address: 0x0007FFFFFFF
>         Range Size: 2 GB
>         Physical Array Handle: 0x000C
>         Partition Width: 0
> 
> Handle 0x0010, DMI type 20, 19 bytes
> Memory Device Mapped Address
>         Starting Address: 0x00000000000
>         Ending Address: 0x0003FFFFFFF
>         Range Size: 1 GB
>         Physical Device Handle: 0x000D
>         Memory Array Mapped Address Handle: 0x000F
>         Partition Row Position: 2
>         Interleave Position: 2
>         Interleaved Data Depth: 2
> 
> Handle 0x0011, DMI type 20, 19 bytes
> Memory Device Mapped Address
>         Starting Address: 0x00040000000
>         Ending Address: 0x0007FFFFFFF
>         Range Size: 1 GB
>         Physical Device Handle: 0x000E
>         Memory Array Mapped Address Handle: 0x000F
>         Partition Row Position: 2
>         Interleave Position: 2
>         Interleaved Data Depth: 2
> 
> Handle 0x0012, DMI type 32, 20 bytes
> System Boot Information
>         Status: <OUT OF SPEC>
> 
> Handle 0x0013, DMI type 127, 4 bytes
> End Of Table
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hello,

I'm developing a Linux driver for supporting Vista Hotstart(TM).
I think your laptop may support it. If you are interested in using that
functionality in Linux or simply interested in helping, please take a look at:

http://quickstart.sourceforge.net/

Thanks,
-- 
Angelo Arrifano AKA MiKNiX
CSE Student at UBI, Portugal
Gentoo Linux AMD64 Arch Tester
Linwizard Developer
miknix@gmail.com
http://miknix.homelinux.com
PGP Pubkey 0x3D92BB0B
