From: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: suspend-to-ram hangs on HP NX7010
Date: Wed, 09 Jun 2004 17:09:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40C72816.70908@drzeus.cx>
References: <3ACA40606221794F80A5670F0AF15F8404991407@pdsmsx403>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_athena.drzeus.cx-23390-1086793928-0001-2"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8404991407-4yWAQGcml66Amxt+E6XRvg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_athena.drzeus.cx-23390-1086793928-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Yu, Luming wrote:

>>I've been spending a few days trying to get suspend-to-ram to 
>>work on my 
>>new HP NX7010 laptop. Haven't had much success though so I thought I 
>>might get some help from the more experienced.
>>
>>    
>>
>
>Can you post the detailed HW info, as well as BIOS vendor/version?
>
>  
>
I've attached dmidecode, lspci -vv and lsusb -vv. That should include 
all the information you need.
The short summary is that it has a Pentium M 1.6GHz, intel 82801 
chipset, IPW2200BG wlan, CSR bluetooth, ati radeon mobility 9200 (M9), 
via firewire controller and rtl8139 network.
The bios seems to be HP's own. If it's made by someone else then they've 
hidden it properly. It's the latest version F.34 but the problem was 
identical with F.33, which the laptop was delivered with. The DSDT:s are 
also identical.

>>I'm running FC2 with linux 2.6.6. S3 has been tested using vanilla 
>>kernel and with the patch from acpi.sf.net. I've also included a patch 
>>    
>>
>>from the ACPI bugzilla to be able to control which devices can 
>  
>
>>wake the 
>>unit. The behaviour has been the same for all tests.
>>
>>    
>>
>
>What about S4?
>
>  
>
S4 works fine. But with X running it's too slow to be useful. A normal 
shutdown/startup is faster. S4bios is also available but I don't know 
what partition it wants so I haven't tried it.

>>I don't think the unit actually gets all the way into S3 though. If I 
>>turn on ACPI debug in the kernel I can see a debug message that says 
>>'Entering S3' but the laptop doesn't power down anything. After this 
>>point the only way to get control of the machine again is to hold down 
>>the power button for a couple of seconds, bypassing the OS. Also, for 
>>some strange reason I have to do this twice because the machine hangs 
>>during POST after the first reset (after a failed suspend-to-ram that 
>>is, works fine otherwise).
>>
>>    
>>
>
>This is unusual. Now, the most S3 failure focus on resuming from ram.
>Can you track down which driver might causes the problem?
>
>  
>
Don't really know how. I was hoping I could find where it stalls and 
using the DSDT to figure out which device was causing the problem. Since 
everything is integrated it's difficult to yank stuff out to eliminate 
sources of problem. If you have any ideas on how to isolate drivers I'll 
gladly try them out.

>>I've started looking in the ACPI spec. since I suspect the bug 
>>might be 
>>in the DSDT. I doesn't even compile cleanly with Intel's 
>>    
>>
>
>Did you find error message from ACPI?  
>
>You know, AML interpreter is capable of catching AML bug. Although,
>sometimes, we have to fix interpreter , rather than AML code. :)
>  
>
The error comes from when I try to compile with Intels compiler. The 
error is:

dsdt.2.dsl  2515:                     Field (C13B, AnyAcc, Lock, Preserve)
Error    1048 -                                 ^ Host Operation Region 
requires ByteAcc access

But I found a page stating that solving this problem (by replacing 
AnyAcc with ByteAcc) doesn't get suspend-to-ram working so I haven't 
bothered trying. The page in question is 
http://personal.eunet.fi/pp/joakim/nx7010.html.

As for getting output from the interpreter, I'm still trying to find a 
good balance for the acpi debug_level. I tried setting it to 0x7ffffff, 
which I figure gives me everything, wasn't very helpful since the screen 
filled up rather quickly. I did note however that some commands after 
"Entering state [S3]". These did not show when using a lower level 
(0xff). Since the machine hangs after this it is difficult to get a dump 
of the data.

Rgds
Pierre

--=_athena.drzeus.cx-23390-1086793928-0001-2
Content-Type: text/plain; name=dmidecode; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode"

# dmidecode 2.2
SMBIOS 2.3 present.
17 structures occupying 752 bytes.
Table at 0x000F17CC.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: Hewlett-Packard
		Version: 68BAL Ver. F.34
		Release Date: 04/09/2004
		Address: 0xE0000
		Runtime Size: 128 kB
		ROM Size: 512 kB
		Characteristics:
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			Boot from CD is supported
			Selectable boot is supported
			EDD is supported
			3.5"/720 KB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			LS-120 boot is supported
			Smart battery is supported
			BIOS boot specification is supported
			Function key-initiated network boot is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: Hewlett-Packard 
		Product Name: Compaq nx7010 (DU392T#AK8)      
		Version: F.34
		Serial Number: CND420068Q                      
		UUID: 08BB7CC4-23A4-D811-0680-669908246129
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: COMPAL
		Product Name: 0860
		Version: 8051 Version 24.52
		Serial Number:                 
Handle 0x0003
	DMI type 3, 13 bytes.
	Chassis Information
		Manufacturer: COMPAL
		Type: Notebook
		Lock: Not Present
		Version: NULL
		Serial Number: CND420068Q                      
		Asset Tag:                 
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: External Interface Enabled
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: U10
		Type: Central Processor
		Family: Itanium 2
		Manufacturer: Intel(R)
		ID: 95 06 00 00 BF F9 E9 A7
		Version: Intel(R) Pentium(R) M processor 1600MHz        
		Voltage: 1.8 V
		External Clock: 100 MHz
		Max Speed: 1600 MHz
		Current Speed: 1600 MHz
		Status: Populated, Enabled
		Upgrade: None
		L1 Cache Handle: 0x0005
		L2 Cache Handle: 0x0006
		L3 Cache Handle: Not Provided
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: Internal L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 64 KB
		Maximum Size: 64 KB
		Supported SRAM Types:
			Burst
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unified
		Associativity: 4-way Set-associative
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: Internal L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 1024 KB
		Maximum Size: 1024 KB
		Supported SRAM Types:
			Burst
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: None
		System Type: Unified
		Associativity: 4-way Set-associative
Handle 0x0007
	DMI type 10, 8 bytes.
	On Board Device Information
		Type: Video
		Status: Disabled
		Description: M7CL 
	On Board Device Information
		Type: Sound
		Status: Disabled
		Description: ADI981B
Handle 0x0008
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: Ownership Tag: 
Handle 0x0009
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 1 GB
		Error Information Handle: No Error
		Number Of Devices: 2
Handle 0x000A
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0009
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: SODIMM
		Set: None
		Locator: DIMM #1
		Bank Locator:         
		Type: DDR
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x000B
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0009
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: SODIMM
		Set: None
		Locator: DIMM #2
		Bank Locator:         
		Type: DDR
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number:                   
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x000C
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x0009
		Partition Width: 0
Handle 0x000D
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x000A
		Memory Array Mapped Address Handle: 0x000C
		Partition Row Position: 1
Handle 0x000E
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00010000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x000B
		Memory Array Mapped Address Handle: 0x000C
		Partition Row Position: 2
Handle 0x000F
	DMI type 32, 11 bytes.
	System Boot Information
		Status: No errors detected
Handle 0x0010
	DMI type 127, 4 bytes.
	End Of Table

--=_athena.drzeus.cx-23390-1086793928-0001-2
Content-Type: text/plain; name=lspci; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at b0000000 (32-bit, prefetchable)
	Capabilities: [e4] #09 [4104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: 90400000-904fffff
	Prefetchable memory behind bridge: 98000000-9fffffff
	Expansion ROM at 00003000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 48c0 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 48e0 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 5
	Region 4: I/O ports at 4c00 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 5
	Region 0: Memory at a0000000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 90000000-903fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 4c40 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 4c20 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 4000
	Region 1: I/O ports at 4880 [size=64]
	Region 2: Memory at a0200000 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at a0300000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 01) (prog-if 00 [Generic])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 4400
	Region 1: I/O ports at 4800 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 01) (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (2000ns min), Cache Line Size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 98000000 (32-bit, prefetchable)
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at 90400000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (8000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 90200000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 2400 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 20)
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (8000ns min, 16000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 2000
	Region 1: Memory at 90300000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.0 Network controller: Intel Corp. Intel(R) PRO/Wireless 2200BG (rev 05)
	Subsystem: Hewlett-Packard Company: Unknown device 12f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (750ns min, 6000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 90000000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

02:04.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 0860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 10
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 90100000 (32-bit, non-prefetchable)
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00005000-000050ff
	I/O window 1: 00005400-000054ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001


--=_athena.drzeus.cx-23390-1086793928-0001-2
Content-Type: text/plain; name=lsusb; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsusb"


Bus 004 Device 002: ID 049f:0086 Compaq Computer Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x049f Compaq Computer Corp.
  idProduct          0x0086 
  bcdDevice            8.02
  iManufacturer           1 ACTIONTEC
  iProduct                2 Bluetooth by hp
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          193
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower               90mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0010  bytes 16 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0040  bytes 64 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0040  bytes 64 once
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0000  bytes 0 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0000  bytes 0 once
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0009  bytes 9 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0009  bytes 9 once
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0011  bytes 17 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0011  bytes 17 once
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0019  bytes 25 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0019  bytes 25 once
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0021  bytes 33 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0021  bytes 33 once
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0031  bytes 49 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0031  bytes 49 once
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0 
      iInterface              0 
  unknown device class descriptor: 07 21 07 88 13 ff 03
  Language IDs: (length=4)
     0409 English(US)

Bus 004 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.6-mh3 uhci_hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:1d.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 once
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0xbf
  PortPwrCtrlMask    0xb8 
  Language IDs: (length=4)
     0409 English(US)

Bus 003 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.6-mh3 uhci_hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:1d.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 once
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xb8 
  Language IDs: (length=4)
     0409 English(US)

Bus 002 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.6-mh3 uhci_hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:1d.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 once
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xb8 
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.6-mh3 ehci_hcd
  iProduct                2 EHCI Host Controller
  iSerial                 1 0000:00:1d.7
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 once
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             6
  wHubCharacteristic 0x0008
    Ganged power switching
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xb8 
  Language IDs: (length=4)
     0409 English(US)

--=_athena.drzeus.cx-23390-1086793928-0001-2--


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
