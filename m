From: BEAUGY Alexandre <beaugy.a@free.fr>
Subject: [DSDT PATCH] targa-laptop: traveller 826 - cpu freq fix
Date: Mon, 10 Aug 2009 21:52:31 +0200
Message-ID: <4A807A7F.7090508@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000709090602010604080202"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:50027 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbZHJTwj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Aug 2009 15:52:39 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id F40844B0158
	for <linux-acpi@vger.kernel.org>; Mon, 10 Aug 2009 21:52:34 +0200 (CEST)
Received: from [192.168.27.12] (laf31-3-82-227-128-88.fbx.proxad.net [82.227.128.88])
	by smtp2-g21.free.fr (Postfix) with ESMTP id D3BFC4B00BB
	for <linux-acpi@vger.kernel.org>; Mon, 10 Aug 2009 21:52:31 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000709090602010604080202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'm the owner of a nice Targa Traveller 826 (BIOS Vendor: American 
Megatrends Inc. - Version: A1029ATE V2.81. More info in attachment: 
"BIOS-targa_traveller_826.dmidecode"). For a long time I experienced 
kernel panic with my gentoo and after with my ubuntu.

First I thought it was a USB related bug in the kernel because, while 
the computer was  running on battery, each time my mouse was not 
connected to the laptop, I always experienced a kernel panic. Then not 
getting much better results with newer kernels, I tried another way. I 
read some documentations on power management, ACPI, etc. I also heard 
about computers's BIOS frequently buggy, especially concerning ACPI 
management. And then I bumped on an article on lesswatts.org, explaining 
how to debug and override a DSDT and therefore fix BIOS buggy ACPI 
management. I thought it was something to try... And tried and it worked 
very well.

After extracting, disassembling and rebuilding a first ime my DSDT, it 
appears that there was an error in the extracted/disassembled code. So I 
tried to fix the error as you can see in second attachment: 
"DSDT-targa_traveller_826.patch". Then I retried to build my DSDT and 
this time it worked. Finally, it seemed to be a CPU freq table 
erroneously declared, if I'm right, that was the cause of my kernel 
panics. A table with the 4 available CPU freq declared at the same 
"index ?" and a table uselessly filled with null entries. So I removed 
the indexes, "to force automatic indexing ?" and I removed the useless 
empty entries in the table.

--- DSDT.dsl~    2009-01-27 22:00:17.000000000 +0100
+++ DSDT.dsl    2009-01-27 22:01:51.000000000 +0100
@@ -1242,7 +1242,7 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1,
                         })
                         Name (_PSS, Package (0x04)
                         {
-                            Package (0x06)
+                            Package ()
                             {
                                 0x000007D0,
                                 0x000088B8,
@@ -1252,7 +1252,7 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1,
                                 0x0000010C
                             },
 
-                            Package (0x06)
+                            Package ()
                             {
                                 0x00000708,
                                 0x00006590,
@@ -1262,7 +1262,7 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1,
                                 0x0000020A
                             },
 
-                            Package (0x06)
+                            Package ()
                             {
                                 0x00000640,
                                 0x00005208,
@@ -1272,7 +1272,7 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1,
                                 0x00000288
                             },
 
-                            Package (0x06)
+                            Package ()
                             {
                                 0x00000320,
                                 0x00002328,
@@ -1281,139 +1281,6 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1,
                                 0xE0202CC0,
                                 0x000004C0
                             },
-
-                            Zero,
-                            Zero,
[...]

For now 6 months, I'm running my ubuntu with my own fixed DSDT, as the 
following kernel logs can attest:

Aug 10 20:01:40 * kernel: [    0.120805] ACPI: Core revision 20080926
Aug 10 20:01:40 * kernel: [    0.121973] ACPI: Checking initramfs for 
custom DSDT
Aug 10 20:01:40 * kernel: [    0.407812] ACPI: Found DSDT in DSDT.aml.
Aug 10 20:01:40 * kernel: [    0.407816] ACPI: Override [DSDT-    1029], 
this is unsafe: tainting kernel
Aug 10 20:01:40 * kernel: [    0.407821] ACPI: Table DSDT replaced by 
host OS
Aug 10 20:01:40 * kernel: [    0.407825] ACPI: DSDT 00000000, 2BAD 
(r1    MSI     1029  4192006 INTL 20061109)
Aug 10 20:01:40 * kernel: [    0.407829] ACPI: DSDT override uses 
original SSDTs unless "acpi_no_auto_ssdt"

And since I'm using my own fixed DSDT, I never experienced anymore 
kernel panic on my laptop, in any configuration (on or not on battery, 
with or without mouse, usb audio, usb disk, etc.).

So I consider that my little DSDT patch is working as expected. I think 
that now it is time for more people to test it, if possible. And then 
try to consider implementing a workaround, of this AMI buggy BIOS, into 
the GNU/Linux kernel. But for this, I'm totally lost and don't have much 
time to explore this way much. That's why I give everybody, the results 
of my peregrinations, and first of all, the solution I found and tested.

I hope this will help people use ACPI again on targa traveller 826 
(especially with ubuntu, where it is automatically disabled for this 
laptop) and allow people to use safely CPU freq with this laptop. I also 
hope that this solution will be taken into account in the next versions 
of the GNU/Linux kernel. For that last expectation, if can help in any 
way, please let me now. Also if anybody can help me create a ACPI patch 
from my DSDT.dsl patch, I'm OK to try, do it and propose an ACPI kernel 
patch.

Kind Regards.

-- 
Alexandre Beaugy


--------------000709090602010604080202
Content-Type: text/plain;
 name="BIOS-targa_traveller_826.dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BIOS-targa_traveller_826.dmidecode"

# dmidecode 2.9
SMBIOS 2.3 present.
15 structures occupying 789 bytes.
Table at 0x000FAB60.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: A1029ATE V2.81
	Release Date: 04/19/2006
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 512 kB
	Characteristics:
		ISA is supported
		EISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		Smart battery is supported
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer: MICRO-STAR INT'L CO.,LTD
	Product Name: MS-1029
	Version: 0291
	Serial Number: FFFFFFFF
	UUID: 00020003-0004-0005-0006-000700080009
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: MICRO-STAR INT'L CO.,LTD
	Type: Notebook
	Lock: Not Present
	Version: To Be Filled By O.E.M.
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x000004D2

Handle 0x0003, DMI type 4, 35 bytes
Processor Information
	Socket Designation: CPU 1
	Type: Central Processor
	Family: Athlon 64
	Manufacturer: AMD              
	ID: C0 0F 01 00 FF FB 8B 07
	Signature: Family 15, Model 28, Stepping 0
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
	Version: Mobile AMD Athlon(tm) 64 Processor 3000+            
	Voltage: 3.3 V 2.9 V
	External Clock: 200 MHz
	Max Speed: 2000 MHz
	Current Speed: 2000 MHz
	Status: Populated, Enabled
	Upgrade: Socket 754
	L1 Cache Handle: 0x0004
	L2 Cache Handle: 0x0005
	L3 Cache Handle: Not Provided
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Part Number: To Be Filled By O.E.M.

Handle 0x0004, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1-Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 64 KB
	Maximum Size: 64 KB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 4-way Set-associative

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2-Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 512 KB
	Maximum Size: 512 KB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 4-way Set-associative

Handle 0x0006, DMI type 9, 13 bytes
System Slot Information
	Designation: RC593
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Available
	Length: Short
	ID: Adapter 0, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported

Handle 0x0007, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 8 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0008, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0005FFFFFFF
	Range Size: 1536 MB
	Physical Array Handle: 0x0007
	Partition Width: 0

Handle 0x0009, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0007
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 72 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK0
	Type: DDR
	Type Detail: Synchronous
	Speed: 266 MHz (3.8 ns)
	Manufacturer: Manufacturer0
	Serial Number: SerNum0
	Asset Tag: AssetTagNum0
	Part Number: PartNum0

Handle 0x000A, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0009
	Memory Array Mapped Address Handle: 0x0008
	Partition Row Position: 1

Handle 0x000B, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0007
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 72 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK1
	Type: DDR
	Type Detail: Synchronous
	Speed: 266 MHz (3.8 ns)
	Manufacturer: Manufacturer1
	Serial Number: SerNum1
	Asset Tag: AssetTagNum1
	Part Number: PartNum1

Handle 0x000C, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0005FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000B
	Memory Array Mapped Address Handle: 0x0008
	Partition Row Position: 1

Handle 0x000D, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x000E, DMI type 127, 4 bytes
End Of Table


--------------000709090602010604080202
Content-Type: text/x-patch;
 name="DSDT-targa_traveller_826.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DSDT-targa_traveller_826.patch"

--- DSDT.dsl~	2009-01-27 22:00:17.000000000 +0100
+++ DSDT.dsl	2009-01-27 22:01:51.000000000 +0100
@@ -1242,7 +1242,7 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                         })
                         Name (_PSS, Package (0x04)
                         {
-                            Package (0x06)
+                            Package ()
                             {
                                 0x000007D0, 
                                 0x000088B8, 
@@ -1252,7 +1252,7 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                                 0x0000010C
                             }, 
 
-                            Package (0x06)
+                            Package ()
                             {
                                 0x00000708, 
                                 0x00006590, 
@@ -1262,7 +1262,7 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                                 0x0000020A
                             }, 
 
-                            Package (0x06)
+                            Package ()
                             {
                                 0x00000640, 
                                 0x00005208, 
@@ -1272,7 +1272,7 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                                 0x00000288
                             }, 
 
-                            Package (0x06)
+                            Package ()
                             {
                                 0x00000320, 
                                 0x00002328, 
@@ -1281,139 +1281,6 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                                 0xE0202CC0, 
                                 0x000004C0
                             }, 
-
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero, 
-                            Zero
                         })
                         Method (_PPC, 0, NotSerialized)
                         {

--------------000709090602010604080202--
