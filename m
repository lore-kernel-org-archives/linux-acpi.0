From: Johannes Schanda <johannes.schanda-1R9WWMedIqeELgA04lAiVw@public.gmane.org>
Subject: Acer Extensa 3001 battery problem (smart battery)
Date: Mon, 13 Sep 2004 00:18:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409130018.02303.johannes.schanda@schanda.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi everyone,

I have a problem with my Acer Extensa 3001 laptop. The battery and ac adaptor 
are not detected, i.e. the /proc/acpi/battery and /proc/acpi/ac_adaptor 
directories are empty. I've already tried fixing my dsdt (it contained 3 
warnings), applying the ecdt fix from bugzilla.kernel.org and setting 
acpi_os_name boot paramter. 

After investigating my dsdt I'm pretty sure that I actually have a smart 
battery, I even tracked down the dsdt code for it:

Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                    })
                    Name (_GPE, 0x1D)
                    Name (OSEJ, 0x00)
                    Device (SMBC)
                    {
                        Name (_HID, "ACPI0001")
                        Name (_EC, 0x1820)
                        Device (SBS0)
                        {
                            Name (_HID, "ACPI0002")
                            Name (_SBS, 0x02)
                        }
                    }

This section looks nearly identical to the smart battery example from the acpi 
2.0 spec. Now my question is this: Is there anything left I can try, or does 
acpi4linux not support smart batteries yet? As far as I understand the spec, 
there should be a sbdt table as well to describe the smart battery, but my 
log makes no mention of it. Im going to attach dmesg | grep ACPI, my 
dmidecode output, and my acpidump output. Any help would be appreciated!

Johannes

dmesg | grep ACPI:
BIOS-e820: 000000001fee0000 - 000000001feec000 (ACPI data)
 BIOS-e820: 000000001feec000 - 000000001ff00000 (ACPI NVS)
ACPI: RSDP (v000 ACER                                      ) @ 0x000f62c0
ACPI: RSDT (v001 ACER   Kestrel  0x20020707  LTP 0x00000000) @ 0x1fee6235
ACPI: FADT (v001 ACER   Kestrel  0x20020707 PTL  0x00000050) @ 0x1feebf2c
ACPI: HPET (v001 ACER   Kestrel  0x20020707 PTL  0x00000000) @ 0x1feebfa0
ACPI: BOOT (v001 ACER   Kestrel  0x20020707  LTP 0x00000001) @ 0x1feebfd8
ACPI: DSDT (v001 ACER   Kestrel  0x20020707 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: HPET id: 0x8086a201 base: 0x0
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *6)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *6)
ACPI: PCI Interrupt Link [LNKD] (IRQs *6)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 6) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:06.2[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:06.3[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (56 C)
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:02:06.2[A] -> GSI 10 (level, low) -> IRQ 10
cpufreq: CPU0 - ACPI performance management activated.
ACPI: (supports S0 S3 S4 S5)
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10

dmidecode:
SMBIOS 2.31 present.
27 structures occupying 1207 bytes.
Table at 0x000DF810.
Handle 0x0000
 DMI type 0, 20 bytes.
 BIOS Information
  Vendor: ACER   
  Version: 3A03
  Release Date: 07/07/2004
  Address: 0xE5510
  Runtime Size: 109296 bytes
  ROM Size: 512 kB
  Characteristics:
   ISA is supported
   PCI is supported
   PC Card (PCMCIA) is supported
   PNP is supported
   APM is supported
   BIOS is upgradeable
   BIOS shadowing is allowed
   ESCD support is available
   Boot from CD is supported
   3.5"/720 KB floppy services are supported (int 13h)
   Print screen service is supported (int 5h)
   8042 keyboard services are supported (int 9h)
   Serial services are supported (int 14h)
   Printer services are supported (int 17h)
   ACPI is supported
   USB legacy is supported
   AGP is supported
   Smart battery is supported
   BIOS boot specification is supported
Handle 0x0001
 DMI type 1, 25 bytes.
 System Information
  Manufacturer: Acer
  Product Name: Extensa 3000  
  Version: Rev 1                   
  Serial Number: LXE080500243201989EM01
  UUID: E0112D1F-244C-D711-8042-00C09F46C455
  Wake-up Type: Power Switch
Handle 0x0002
 DMI type 2, 8 bytes.
 Base Board Information
  Manufacturer: Acer
  Product Name: Extensa 3000  
  Version: Rev 1.0                 
  Serial Number: LXE080500243201989EM01
Handle 0x0003
 DMI type 3, 17 bytes.
 Chassis Information
  Manufacturer: Acer
  Type: Notebook
  Lock: Not Present
  Version: Rev.1                   
  Serial Number: LXE080500243201989EM01
  Asset Tag:                                      
  Boot-up State: Safe
  Power Supply State: Safe
  Thermal State: Safe
  Security Status: None
  OEM Information: 0x00001234
Handle 0x0004
 DMI type 4, 35 bytes.
 Processor Information
  Socket Designation: uFCPGA2
  Type: Central Processor
  Family: Unknown
  Manufacturer: Intel
  ID: D6 06 00 00 BF F9 E9 AF
  Version: Intel(R) Pentium(R) M processor
  Voltage: 1.2 V
  External Clock: 400 MHz
  Max Speed: 1500 MHz
  Current Speed: 1500 MHz
  Status: Populated, Enabled
  Upgrade: ZIF Socket
  L1 Cache Handle: 0x0008
  L2 Cache Handle: 0x0009
  L3 Cache Handle: Not Provided
  Serial Number: Not Specified
  Asset Tag: Not Specified
  Part Number: Not Specified
Handle 0x0005
 DMI type 5, 20 bytes.
 Memory Controller Information
  Error Detecting Method: None
  Error Correcting Capabilities:
   None
  Supported Interleave: One-way Interleave
  Current Interleave: One-way Interleave
  Maximum Memory Module Size: 1024 MB
  Maximum Total Memory Size: 2048 MB
  Supported Speeds:
   60 ns
  Supported Memory Types:
   DIMM
  Memory Module Voltage: 3.3 V
  Associated Memory Slots: 2
   0x0006
   0x0007
  Enabled Error Correcting Capabilities:
   None
Handle 0x0006
 DMI type 6, 12 bytes.
 Memory Module Information
  Socket Designation: DIMM 1
  Bank Connections: 0 1
  Current Speed: 75 ns
  Type: DIMM SDRAM
  Installed Size: 256 MB (Double-bank Connection)
  Enabled Size: 256 MB (Double-bank Connection)
  Error Status: OK
Handle 0x0007
 DMI type 6, 12 bytes.
 Memory Module Information
  Socket Designation: DIMM 2
  Bank Connections: 2 3
  Current Speed: 75 ns
  Type: DIMM SDRAM
  Installed Size: 256 MB (Double-bank Connection)
  Enabled Size: 256 MB (Double-bank Connection)
  Error Status: OK
Handle 0x0008
 DMI type 7, 19 bytes.
 Cache Information
  Socket Designation: L1 Cache
  Configuration: Enabled, Not Socketed, Level 1
  Operational Mode: Write Back
  Location: Internal
  Installed Size: 32 KB
  Maximum Size: 32 KB
  Supported SRAM Types:
   Burst
   Pipeline Burst
   Asynchronous
  Installed SRAM Type: Asynchronous
  Speed: Unknown
  Error Correction Type: Unknown
  System Type: Unknown
  Associativity: Unknown
Handle 0x0009
 DMI type 7, 19 bytes.
 Cache Information
  Socket Designation: L2 Cache
  Configuration: Enabled, Not Socketed, Level 2
  Operational Mode: Write Back
  Location: External
  Installed Size: 2048 KB
  Maximum Size: 2048 KB
  Supported SRAM Types:
   Burst
   Pipeline Burst
   Asynchronous
  Installed SRAM Type: Burst
  Speed: Unknown
  Error Correction Type: Unknown
  System Type: Unknown
  Associativity: Unknown
Handle 0x000A
 DMI type 8, 9 bytes.
 Port Connector Information
  Internal Reference Designator: LPT 1
  Internal Connector Type: None
  External Reference Designator: Parallel
  External Connector Type: DB-25 female
  Port Type: Parallel Port ECP/EPP
Handle 0x000B
 DMI type 8, 9 bytes.
 Port Connector Information
  Internal Reference Designator: U28
  Internal Connector Type: None
  External Reference Designator: PS/2 Mouse
  External Connector Type: Circular DIN-8 male
  Port Type: Keyboard Port
Handle 0x000C
 DMI type 9, 13 bytes.
 System Slot Information
  Designation: PCMCIA socket 0
  Type: 32-bit PC Card (PCMCIA)
  Current Usage: Unknown
  Length: Long
  ID: Adapter 0, Socket 0
  Characteristics:
   5.0 V is provided
   3.3 V is provided
   PC Card-16 is supported
   Cardbus is supported
   Modem ring resume is supported
   PME signal is supported
			Hot-plug devices are supported
Handle 0x000D
	DMI type 10, 10 bytes.
	On Board Device 1 Information
		Type: Video
		Status: Disabled
		Description: ATI M11
	On Board Device 2 Information
		Type: Sound
  Status: Disabled
  Description: AC97 Audio
 On Board Device 3 Information
  Type: Other
  Status: Disabled
  Description: TI TSB43AB21 IEEE-1394 Controller
Handle 0x000E
 DMI type 11, 5 bytes.
 OEM Strings
  String 1: SMBIOS 2.3
  String 2: Customer Reference Platform
Handle 0x000F
 DMI type 12, 5 bytes.
 System Configuration Options
  Option 1: No Jumper On This Platform.
Handle 0x0010
 DMI type 15, 29 bytes.
 System Event Log
  Area Length: 0 bytes
  Header Start Offset: 0x0000
  Header Length: 16 bytes
  Data Start Offset: 0x0010
  Access Method: Memory-mapped physical 32-bit address
  Access Address: 0x00000000
  Status: Invalid, No Header
  Change Token: 0x00000000
  Header Format: Type 1
  Supported Log Type Descriptors: 3
  Descriptor 1: POST error
  Data Format 1: POST results bitmap
  Descriptor 2: Single-bit ECC memory error
  Data Format 2: Multiple-event
  Descriptor 3: Multi-bit ECC memory error
  Data Format 3: Multiple-event
Handle 0x0011
 DMI type 16, 15 bytes.
 Physical Memory Array
  Location: System Board Or Motherboard
  Use: System Memory
  Error Correction Type: None
  Maximum Capacity: 3 GB
  Error Information Handle: Not Provided
  Number Of Devices: 2
Handle 0x0012
 DMI type 17, 27 bytes.
 Memory Device
  Array Handle: 0x0011
  Error Information Handle: No Error
  Total Width: 64 bits
  Data Width: 64 bits
  Size: 256 MB
  Form Factor: DIMM
  Set: 1
  Locator: DIMM 0
  Bank Locator: Bank 0, 1
  Type: SRAM
  Type Detail: Synchronous
  Speed: 333 MHz (3.0 ns)
  Manufacturer: Not Specified
  Serial Number: Not Specified
  Asset Tag: Not Specified
  Part Number: Not Specified
Handle 0x0013
 DMI type 17, 27 bytes.
 Memory Device
  Array Handle: 0x0011
  Error Information Handle: No Error
  Total Width: 64 bits
  Data Width: 64 bits
  Size: 256 MB
  Form Factor: DIMM
  Set: 1
  Locator: DIMM 1
  Bank Locator: Bank 2, 3
  Type: SRAM
  Type Detail: Synchronous
  Speed: 333 MHz (3.0 ns)
  Manufacturer: Not Specified
  Serial Number: Not Specified
  Asset Tag: Not Specified
  Part Number: Not Specified
Handle 0x0014
 DMI type 19, 15 bytes.
 Memory Array Mapped Address
  Starting Address: 0x00000000000
  Ending Address: 0x0001FFFFFFF
  Range Size: 512 MB
  Physical Array Handle: 0x0011
  Partition Width: 0
Handle 0x0015
 DMI type 20, 19 bytes.
 Memory Device Mapped Address
  Starting Address: 0x00000000000
  Ending Address: 0x0000FFFFFFF
  Range Size: 256 MB
  Physical Device Handle: 0x0012
  Memory Array Mapped Address Handle: 0x0014
  Partition Row Position: 1
  Interleave Position: 1
Handle 0x0016
 DMI type 20, 19 bytes.
 Memory Device Mapped Address
  Starting Address: 0x00010000000
  Ending Address: 0x0001FFFFFFF
  Range Size: 256 MB
  Physical Device Handle: 0x0013
  Memory Array Mapped Address Handle: 0x0014
  Partition Row Position: 1
  Interleave Position: 1
Handle 0x0017
 DMI type 21, 7 bytes.
 Built-in Pointing Device
  Type: Mouse
  Interface: PS/2
  Buttons: 2
Handle 0x0018
 DMI type 22, 26 bytes.
 Portable Battery
  Location: Right Side
  Manufacturer: Sanyo
  Name: Sanyo
  Chemistry: Lithium Ion
  Design Capacity: 4400 mWh
  Design Voltage: 14800 mV
  SBDS Version: Bat123
  Maximum Error: 6%
  SBDS Serial Number: 04D2
  SBDS Manufacture Date: 1985-08-25
  OEM-specific Information: 0x00000000
Handle 0x0019
 DMI type 32, 20 bytes.
 System Boot Information
  Status: <OUT OF SPEC>
Handle 0x001A
 DMI type 127, 4 bytes.
 End Of Table

acpidump:
RSDP "ACER" @ 0x000f62c0
  0000: 52 53 44 20 50 54 52 20 e2 41 43 45 52 20 20 00  RSD PTR .ACER  .
  0010: 35 62 ee 1f                                      5b..

RSDT @ 0x1fee6235
  0000: 52 53 44 54 30 00 00 00 01 f5 41 43 45 52 20 20  RSDT0.....ACER  
  0010: 4b 65 73 74 72 65 6c 20 07 07 02 20 20 4c 54 50  Kestrel ...  LTP
  0020: 00 00 00 00 2c bf ee 1f a0 bf ee 1f d8 bf ee 1f  ....,...........

FACP @ 0x1feebf2c
  0000: 46 41 43 50 74 00 00 00 01 13 41 43 45 52 20 20  FACPt.....ACER  
  0010: 4b 65 73 74 72 65 6c 20 07 07 02 20 50 54 4c 20  Kestrel ... PTL 
  0020: 50 00 00 00 c0 cf ef 1f 65 62 ee 1f 00 00 09 00  P.......eb......
  0030: b2 00 00 00 f0 f1 f2 80 00 10 00 00 00 00 00 00  ................
  0040: 04 10 00 00 00 00 00 00 20 10 00 00 08 10 00 00  ........ .......
  0050: 28 10 00 00 00 00 00 00 04 02 01 04 08 00 00 85  (...............
  0060: 01 00 55 00 00 00 00 00 01 03 0d 00 32 00 00 00  ..U.........2...
  0070: 25 00 00 00                                      %...

DSDT @ 0x1fee6265
  0000: 44 53 44 54 c7 5c 00 00 01 80 41 43 45 52 20 20  DSDT.\....ACER  
  0010: 4b 65 73 74 72 65 6c 20 07 07 02 20 4d 53 46 54  Kestrel ... MSFT
  0020: 0e 00 00 01 5b 80 50 4f 52 54 01 0a 80 0a 02 5b  ....[.PORT.....[
  0030: 81 10 50 4f 52 54 01 50 38 30 48 08 50 38 31 48  ..PORT.P80H.P81H
  0040: 08 5b 80 49 4f 5f 54 01 0b 00 08 0a 10 5b 81 0b  .[.IO_T......[..
  0050: 49 4f 5f 54 01 54 52 50 30 08 5b 80 4d 4e 56 53  IO_T.TRP0.[.MNVS
  0060: 00 0c 59 ce ee 1f 0a 60 5b 81 4c 0d 4d 4e 56 53  ..Y....`[.L.MNVS
  0070: 10 4f 53 59 53 10 53 4d 49 46 08 53 43 49 46 08  .OSYS.SMIF.SCIF.
  0080: 50 41 52 31 08 50 41 52 32 08 41 43 50 53 08 44  PAR1.PAR2.ACPS.D
  0090: 42 47 53 08 44 43 4b 53 04 43 44 43 4b 04 49 47  BGS.DCKS.CDCK.IG
  00a0: 44 53 08 53 4c 49 44 08 42 52 54 43 08 42 52 54  DS.SLID.BRTC.BRT
  00b0: 53 08 57 52 4b 46 08 53 57 32 4c 01 50 4e 43 53  S.WRKF.SW2L.PNCS
  00c0: 01 00 06 50 52 49 44 08 43 4d 41 50 08 43 4d 42  ...PRID.CMAP.CMB
  00d0: 50 08 4c 50 54 50 08 46 44 43 50 08 00 08 50 53  P.LPTP.FDCP...PS
  00e0: 32 46 08 00 10 41 43 54 54 08 50 53 56 54 08 54  2F...ACTT.PSVT.T
  00f0: 43 31 56 08 54 43 32 56 08 54 53 50 56 08 43 52  C1V.TC2V.TSPV.CR
  0100: 54 54 08 00 10 42 56 41 4c 20 44 4f 46 46 08 54  TT...BVAL DOFF.T
  0110: 4d 50 31 08 54 4d 50 32 08 53 56 43 52 08 54 4d  MP1.TMP2.SVCR.TM
  0120: 50 34 20 54 4d 50 35 20 43 53 54 45 10 4e 53 54  P4 TMP5 CSTE.NST
  0130: 45 10 53 53 54 45 10 43 41 44 4c 10 50 41 44 4c  E.SSTE.CADL.PADL
  0140: 10 42 43 41 50 08 10 4e 0a 5f 50 52 5f 5b 83 46  .BCAP..N._PR_[.F
  0150: 0a 43 50 55 30 00 10 10 00 00 06 08 5f 50 43 54  .CPU0......._PCT
  0160: 12 2c 02 11 14 0a 11 82 0c 00 01 08 00 00 b2 00  .,..............
  0170: 00 00 00 00 00 00 79 00 11 14 0a 11 82 0c 00 01  ......y.........
  0180: 08 00 00 b3 00 00 00 00 00 00 00 79 00 08 5f 50  ...........y.._P
  0190: 53 53 12 48 05 05 12 10 06 0b dc 05 0b c0 5d 0a  SS.H..........].
  01a0: 0a 0a 0a 0a 89 0a 00 12 10 06 0b b0 04 0b 20 4e  .............. N
  01b0: 0a 0a 0a 0a 0a 8a 0a 01 12 10 06 0b e8 03 0b 50  ...............P
  01c0: 46 0a 0a 0a 0a 0a 8b 0a 02 12 10 06 0b 20 03 0b  F............ ..
  01d0: 80 3e 0a 0a 0a 0a 0a 8c 0a 03 12 10 06 0b 58 02  .>............X.
  01e0: 0b e0 2e 0a 0a 0a 0a 0a 8d 0a 04 14 09 5f 50 50  ............._PP
  01f0: 43 00 a4 0a 00 08 5c 44 53 45 4e 0a 01 10 3b 5f  C.....\DSEN...;_
  0200: 53 49 5f 14 35 5f 4d 53 47 01 a0 17 68 70 01 5c  SI_.5_MSG...hp.\
  0210: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 4c  /._SB_PCI0LPC0BL
  0220: 32 37 a1 16 70 00 5c 2f 04 5f 53 42 5f 50 43 49  27..p.\/._SB_PCI
  0230: 30 4c 50 43 30 42 4c 32 37 08 5c 5f 53 30 5f 12  0LPC0BL27.\_S0_.
  0240: 06 02 0a 00 0a 00 08 5c 5f 53 33 5f 12 06 02 0a  .......\_S3_....
  0250: 05 0a 05 08 5c 5f 53 34 5f 12 06 02 0a 06 0a 06  ....\_S4_.......
  0260: 08 5c 5f 53 35 5f 12 06 02 0a 07 0a 07 14 44 19  .\_S5_........D.
  0270: 5f 50 54 53 01 70 68 5c 2e 5f 53 42 5f 53 54 41  _PTS.ph\._SB_STA
  0280: 54 70 0d 3e 3e 3e 3e 20 5f 50 54 53 20 2d 2d 2d  Tp.>>>> _PTS ---
  0290: 2d 2d 2d 2d 2d 2d 2d 2d 2d 00 5b 31 70 68 5b 31  ---------.[1ph[1
  02a0: 70 68 5c 2e 5f 53 42 5f 53 4c 45 45 70 0a 84 5c  ph\._SB_SLEEp..\
  02b0: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 43  /._SB_PCI0LPC0BC
  02c0: 4d 44 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30  MDp..\/._SB_PCI0
  02d0: 4c 50 43 30 53 4d 49 43 a0 25 7d 93 68 0a 03 93  LPC0SMIC.%}.h...
  02e0: 68 0a 04 00 70 0a 01 5c 2f 05 5f 53 42 5f 50 43  h...p..\/._SB_PC
  02f0: 49 30 4c 50 43 30 45 43 30 5f 41 50 57 52 a0 4a  I0LPC0EC0_APWR.J
  0300: 05 93 68 0a 03 70 0a e6 50 38 30 48 70 0a 80 5c  ..h..p..P80Hp..\
  0310: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 43  /._SB_PCI0LPC0BC
  0320: 4d 44 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30  MDp..\/._SB_PCI0
  0330: 4c 50 43 30 53 4d 49 43 70 0a 01 5c 2f 04 5f 53  LPC0SMICp..\/._S
  0340: 42 5f 50 43 49 30 4c 50 43 30 4c 56 33 37 5b 22  B_PCI0LPC0LV37["
  0350: 0a c8 70 0a e7 50 38 30 48 a0 41 07 93 68 0a 04  ..p..P80H.A..h..
  0360: 70 0a 01 5c 2e 5f 53 42 5f 53 34 57 50 70 0a 82  p..\._SB_S4WPp..
  0370: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 42  \/._SB_PCI0LPC0B
  0380: 43 4d 44 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49  CMDp..\/._SB_PCI
  0390: 30 4c 50 43 30 53 4d 49 43 70 01 5c 2f 05 5f 53  0LPC0SMICp.\/._S
  03a0: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 50 46  B_PCI0LPC0EC0_PF
  03b0: 4c 47 70 01 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  LGp.\/._SB_PCI0L
  03c0: 50 43 30 45 43 30 5f 53 34 4c 44 a0 0a 93 87 5c  PC0EC0_S4LD....\
  03d0: 5f 4f 53 5f 0a 27 a0 2b 93 68 0a 05 70 01 5c 2f  _OS_.'.+.h..p.\/
  03e0: 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30  ._SB_PCI0LPC0EC0
  03f0: 5f 53 35 4c 57 70 0a 00 5c 2e 5f 53 42 5f 45 43  _S5LWp..\._SB_EC
  0400: 4f 4b 14 4e 1e 5f 57 41 4b 01 70 68 5c 2e 5f 53  OK.N._WAK.ph\._S
  0410: 42 5f 53 54 41 54 a0 45 08 7d 93 5c 2f 03 5f 53  B_STAT.E.}.\/._S
  0420: 42 5f 50 43 49 30 4d 59 4f 53 0a 03 93 5c 2f 03  B_PCI0MYOS...\/.
  0430: 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a 01 00 70  _SB_PCI0MYOS...p
  0440: 5c 2e 5f 53 42 5f 57 4c 45 53 5c 2f 05 5f 53 42  \._SB_WLES\/._SB
  0450: 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 57 45 53  _PCI0LPC0EC0_WES
  0460: 54 70 5c 2e 5f 53 42 5f 42 54 45 53 5c 2f 05 5f  Tp\._SB_BTES\/._
  0470: 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 42  SB_PCI0LPC0EC0_B
  0480: 45 53 54 70 01 5c 2f 05 5f 53 42 5f 50 43 49 30  ESTp.\/._SB_PCI0
  0490: 4c 50 43 30 45 43 30 5f 57 42 49 4e a0 1f 93 68  LPC0EC0_WBIN...h
  04a0: 0a 04 70 0a 01 5c 2e 5f 53 42 5f 4f 4b 45 43 86  ..p..\._SB_OKEC.
  04b0: 5c 2e 5f 53 42 5f 53 4c 50 42 0a 02 a0 42 0e 93  \._SB_SLPB...B..
  04c0: 87 5c 5f 4f 53 5f 0a 14 70 0a e4 50 38 30 48 70  .\_OS_..p..P80Hp
  04d0: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 52  \/._SB_PCI0LPC0R
  04e0: 42 49 44 60 70 5c 2f 04 5f 53 42 5f 50 43 49 30  BID`p\/._SB_PCI0
  04f0: 49 44 45 30 42 41 59 52 61 70 60 5c 2f 04 5f 53  IDE0BAYRap`\/._S
  0500: 42 5f 50 43 49 30 49 44 45 30 42 41 59 52 a0 43  B_PCI0IDE0BAYR.C
  0510: 06 92 93 60 61 a0 4c 05 7d 93 61 0a 01 93 61 0a  ...`a.L.}.a...a.
  0520: 02 00 a0 33 7b 93 5c 2f 03 5f 53 42 5f 50 43 49  ...3{.\/._SB_PCI
  0530: 30 4d 59 4f 53 0a 03 93 60 0a 03 00 86 5c 2f 05  0MYOS...`....\/.
  0540: 5f 53 42 5f 50 43 49 30 49 44 45 30 53 45 43 4e  _SB_PCI0IDE0SECN
  0550: 42 41 59 31 0a 03 a1 1b 86 5c 2f 05 5f 53 42 5f  BAY1.....\/._SB_
  0560: 50 43 49 30 49 44 45 30 53 45 43 4e 42 41 59 31  PCI0IDE0SECNBAY1
  0570: 0a 01 a0 25 7d 93 60 0a 01 93 60 0a 02 00 86 5c  ...%}.`...`....\
  0580: 2f 05 5f 53 42 5f 50 43 49 30 49 44 45 30 53 45  /._SB_PCI0IDE0SE
  0590: 43 4e 42 41 59 31 0a 00 70 0a e5 50 38 30 48 a0  CNBAY1..p..P80H.
  05a0: 0a 93 87 5c 5f 4f 53 5f 0a 27 70 5c 2f 05 5f 53  ...\_OS_.'p\/._S
  05b0: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 41 43  B_PCI0LPC0EC0_AC
  05c0: 44 46 5c 2e 5f 53 42 5f 41 43 53 54 a0 17 93 87  DF\._SB_ACST....
  05d0: 5c 5f 4f 53 5f 0a 11 86 5c 2e 5f 53 42 5f 53 4c  \_OS_...\._SB_SL
  05e0: 50 42 0a 02 70 0a 00 5c 2e 5f 53 42 5f 53 4c 45  PB..p..\._SB_SLE
  05f0: 45 10 44 0c 5f 47 50 45 14 18 5f 4c 30 35 00 86  E.D._GPE.._L05..
  0600: 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 44 4d 30 0a  \/._SB_PCI0MDM0.
  0610: 02 14 4e 04 5f 4c 30 42 00 86 5c 2f 03 5f 53 42  ..N._L0B..\/._SB
  0620: 5f 50 43 49 30 50 43 49 42 0a 00 a0 34 7d 93 5c  _PCI0PCIB...4}.\
  0630: 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a 01  /._SB_PCI0MYOS..
  0640: 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53  .\/._SB_PCI0MYOS
  0650: 0a 03 00 86 5c 2e 5f 53 42 5f 53 4c 50 42 0a 02  ....\._SB_SLPB..
  0660: 14 18 5f 4c 30 33 00 86 5c 2f 03 5f 53 42 5f 50  .._L03..\/._SB_P
  0670: 43 49 30 55 53 42 31 0a 02 14 18 5f 4c 30 34 00  CI0USB1...._L04.
  0680: 86 5c 2f 03 5f 53 42 5f 50 43 49 30 55 53 42 32  .\/._SB_PCI0USB2
  0690: 0a 02 14 18 5f 4c 30 43 00 86 5c 2f 03 5f 53 42  ...._L0C..\/._SB
  06a0: 5f 50 43 49 30 55 53 42 33 0a 02 14 0a 5f 45 31  _PCI0USB3...._E1
  06b0: 38 00 5b 22 0a 01 10 80 61 05 5f 53 42 5f 08 53  8.["....a._SB_.S
  06c0: 54 41 54 0a 00 08 44 31 53 54 0a 00 08 44 31 53  TAT...D1ST...D1S
  06d0: 4a 0a 01 08 4f 4b 45 43 0a 00 5b 82 85 e6 04 50  J...OKEC..[....P
  06e0: 43 49 30 08 4d 59 4f 53 0a 02 14 40 0d 5f 49 4e  CI0.MYOS...@._IN
  06f0: 49 00 70 0a 01 5c 2e 5f 53 42 5f 44 31 53 4a 70  I.p..\._SB_D1SJp
  0700: 0a 02 4d 59 4f 53 a0 41 06 93 87 5c 5f 4f 53 5f  ..MYOS.A...\_OS_
  0710: 0a 14 70 0a 01 4d 59 4f 53 70 0b d0 07 4f 53 59  ..p..MYOSp...OSY
  0720: 53 70 0a 01 5c 2e 5f 53 42 5f 57 32 4b 46 a0 39  Sp..\._SB_W2KF.9
  0730: 5b 12 5f 4f 53 49 60 a0 30 5c 5f 4f 53 49 0d 57  [._OSI`.0\_OSI.W
  0740: 69 6e 64 6f 77 73 20 32 30 30 31 00 70 0a 03 4d  indows 2001.p..M
  0750: 59 4f 53 70 0b d1 07 4f 53 59 53 70 0a 03 5c 2e  YOSp...OSYSp..\.
  0760: 5f 53 42 5f 57 32 4b 46 a1 42 05 a0 26 93 87 5c  _SB_W2KF.B..&..\
  0770: 5f 4f 53 5f 0a 11 70 0a 00 4d 59 4f 53 70 0b ce  _OS_..p..MYOSp..
  0780: 07 4f 53 59 53 70 0a 00 5c 2e 5f 53 42 5f 57 32  .OSYSp..\._SB_W2
  0790: 4b 46 a1 28 a0 26 93 87 5c 5f 4f 53 5f 0a 27 70  KF.(.&..\_OS_.'p
  07a0: 0a 02 4d 59 4f 53 70 0b cf 07 4f 53 59 53 70 0a  ..MYOSp...OSYSp.
  07b0: 02 5c 2e 5f 53 42 5f 57 32 4b 46 08 5f 48 49 44  .\._SB_W2KF._HID
  07c0: 0c 41 d0 0a 03 08 5f 41 44 52 0a 00 08 5f 42 42  .A...._ADR..._BB
  07d0: 4e 0a 00 5b 80 48 42 55 53 02 0a 40 0a c0 5b 81  N..[.HBUS..@..[.
  07e0: 4e 06 48 42 55 53 03 00 40 0c 00 07 48 45 4e 41  N.HBUS..@...HENA
  07f0: 01 00 04 50 4d 30 48 02 00 02 50 4d 31 4c 02 00  ...PM0H...PM1L..
  0800: 02 50 4d 31 48 02 00 02 50 4d 32 4c 02 00 02 50  .PM1H...PM2L...P
  0810: 4d 32 48 02 00 02 50 4d 33 4c 02 00 02 50 4d 33  M2H...PM3L...PM3
  0820: 48 02 00 02 50 4d 34 4c 02 00 02 50 4d 34 48 02  H...PM4L...PM4H.
  0830: 00 02 50 4d 35 4c 02 00 02 50 4d 35 48 02 00 02  ..PM5L...PM5H...
  0840: 50 4d 36 4c 02 00 02 50 4d 36 48 02 00 02 08 42  PM6L...PM6H....B
  0850: 55 46 30 11 46 20 0b 01 02 88 0e 00 02 0c 00 00  UF0.F ..........
  0860: 00 00 00 ff 00 00 00 00 01 00 87 18 00 01 0c 03  ................
  0870: 00 00 00 00 00 00 00 00 f7 0c 00 00 00 00 00 00  ................
  0880: f8 0c 00 00 00 47 01 f8 0c f8 0c 01 08 87 18 00  .....G..........
  0890: 01 0c 03 00 00 00 00 00 0d 00 00 ff ff 00 00 00  ................
  08a0: 00 00 00 00 f3 00 00 00 87 18 00 00 0c 03 00 00  ................
  08b0: 00 00 00 00 0a 00 ff ff 0b 00 00 00 00 00 00 00  ................
  08c0: 02 00 00 87 18 00 00 0c 03 00 00 00 00 00 00 0c  ................
  08d0: 00 ff 3f 0c 00 00 00 00 00 00 40 00 00 00 87 18  ..?.......@.....
  08e0: 00 00 0c 03 00 00 00 00 00 40 0c 00 ff 7f 0c 00  .........@......
  08f0: 00 00 00 00 00 40 00 00 00 87 18 00 00 0c 03 00  .....@..........
  0900: 00 00 00 00 80 0c 00 ff bf 0c 00 00 00 00 00 00  ................
  0910: 40 00 00 00 87 18 00 00 0c 03 00 00 00 00 00 c0  @...............
  0920: 0c 00 ff ff 0c 00 00 00 00 00 00 40 00 00 00 87  ...........@....
  0930: 18 00 00 0c 03 00 00 00 00 00 00 0d 00 ff 3f 0d  ..............?.
  0940: 00 00 00 00 00 00 40 00 00 00 87 18 00 00 0c 03  ......@.........
  0950: 00 00 00 00 00 40 0d 00 ff 7f 0d 00 00 00 00 00  .....@..........
  0960: 00 40 00 00 00 87 18 00 00 0c 03 00 00 00 00 00  .@..............
  0970: 80 0d 00 ff bf 0d 00 00 00 00 00 00 40 00 00 00  ............@...
  0980: 87 18 00 00 0c 03 00 00 00 00 00 c0 0d 00 ff ff  ................
  0990: 0d 00 00 00 00 00 00 40 00 00 00 87 18 00 00 0c  .......@........
  09a0: 03 00 00 00 00 00 00 0e 00 ff 3f 0e 00 00 00 00  ..........?.....
  09b0: 00 00 40 00 00 00 87 18 00 00 0c 03 00 00 00 00  ..@.............
  09c0: 00 40 0e 00 ff 7f 0e 00 00 00 00 00 00 40 00 00  .@...........@..
  09d0: 00 87 18 00 00 0c 03 00 00 00 00 00 80 0e 00 ff  ................
  09e0: bf 0e 00 00 00 00 00 00 40 00 00 00 87 18 00 00  ........@.......
  09f0: 0c 03 00 00 00 00 00 c0 0e 00 ff ff 0e 00 00 00  ................
  0a00: 00 00 00 40 00 00 00 87 18 00 00 0c 03 00 00 00  ...@............
  0a10: 00 00 00 0f 00 ff ff 0f 00 00 00 00 00 00 00 01  ................
  0a20: 00 00 87 18 00 00 0c 03 00 00 00 00 00 00 00 00  ................
  0a30: ff ff bf fe 00 00 00 00 00 00 00 00 00 87 18 00  ................
  0a40: 00 0c 03 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0a50: 00 00 00 00 00 00 00 00 79 00 14 42 3a 5f 43 52  ........y..B:_CR
  0a60: 53 08 a0 16 50 4d 31 4c 8a 42 55 46 30 0a 80 43  S...PM1L.BUF0..C
  0a70: 30 4c 4e 70 00 43 30 4c 4e a0 1a 93 50 4d 31 4c  0LNp.C0LN...PM1L
  0a80: 0a 01 8d 42 55 46 30 0b 78 03 43 30 52 57 70 00  ...BUF0.x.C0RWp.
  0a90: 43 30 52 57 a0 16 50 4d 31 48 8a 42 55 46 30 0a  C0RW..PM1H.BUF0.
  0aa0: 9b 43 34 4c 4e 70 00 43 34 4c 4e a0 1a 93 50 4d  .C4LNp.C4LN...PM
  0ab0: 31 48 0a 01 8d 42 55 46 30 0b 50 04 43 34 52 57  1H...BUF0.P.C4RW
  0ac0: 70 00 43 34 52 57 a0 16 50 4d 32 4c 8a 42 55 46  p.C4RW..PM2L.BUF
  0ad0: 30 0a b6 43 38 4c 4e 70 00 43 38 4c 4e a0 1a 93  0..C8LNp.C8LN...
  0ae0: 50 4d 32 4c 0a 01 8d 42 55 46 30 0b 28 05 43 38  PM2L...BUF0.(.C8
  0af0: 52 57 70 00 43 38 52 57 a0 16 50 4d 32 48 8a 42  RWp.C8RW..PM2H.B
  0b00: 55 46 30 0a d1 43 43 4c 4e 70 00 43 43 4c 4e a0  UF0..CCLNp.CCLN.
  0b10: 1a 93 50 4d 32 48 0a 01 8d 42 55 46 30 0b 00 06  ..PM2H...BUF0...
  0b20: 43 43 52 57 70 00 43 43 52 57 a0 16 50 4d 33 4c  CCRWp.CCRW..PM3L
  0b30: 8a 42 55 46 30 0a ec 44 30 4c 4e 70 00 44 30 4c  .BUF0..D0LNp.D0L
  0b40: 4e a0 1a 93 50 4d 33 4c 0a 01 8d 42 55 46 30 0b  N...PM3L...BUF0.
  0b50: d8 06 44 30 52 57 70 00 44 30 52 57 a0 17 50 4d  ..D0RWp.D0RW..PM
  0b60: 33 48 8a 42 55 46 30 0b 07 01 44 34 4c 4e 70 00  3H.BUF0...D4LNp.
  0b70: 44 34 4c 4e a0 1a 93 50 4d 33 48 0a 01 8d 42 55  D4LN...PM3H...BU
  0b80: 46 30 0b b0 07 44 34 52 57 70 00 44 34 52 57 a0  F0...D4RWp.D4RW.
  0b90: 17 50 4d 34 4c 8a 42 55 46 30 0b 22 01 44 38 4c  .PM4L.BUF0.".D8L
  0ba0: 4e 70 00 44 38 4c 4e a0 1a 93 50 4d 34 4c 0a 01  Np.D8LN...PM4L..
  0bb0: 8d 42 55 46 30 0b 88 08 44 38 52 57 70 00 44 38  .BUF0...D8RWp.D8
  0bc0: 52 57 a0 17 50 4d 34 48 8a 42 55 46 30 0b 3d 01  RW..PM4H.BUF0.=.
  0bd0: 44 43 4c 4e 70 00 44 43 4c 4e a0 1a 93 50 4d 34  DCLNp.DCLN...PM4
  0be0: 48 0a 01 8d 42 55 46 30 0b 60 09 44 43 52 57 70  H...BUF0.`.DCRWp
  0bf0: 00 44 43 52 57 a0 17 50 4d 35 4c 8a 42 55 46 30  .DCRW..PM5L.BUF0
  0c00: 0b 58 01 45 30 4c 4e 70 00 45 30 4c 4e a0 1a 93  .X.E0LNp.E0LN...
  0c10: 50 4d 35 4c 0a 01 8d 42 55 46 30 0b 38 0a 45 30  PM5L...BUF0.8.E0
  0c20: 52 57 70 00 45 30 52 57 a0 17 50 4d 35 48 8a 42  RWp.E0RW..PM5H.B
  0c30: 55 46 30 0b 73 01 45 34 4c 4e 70 00 45 34 4c 4e  UF0.s.E4LNp.E4LN
  0c40: a0 1a 93 50 4d 35 48 0a 01 8d 42 55 46 30 0b 10  ...PM5H...BUF0..
  0c50: 0b 45 34 52 57 70 00 45 34 52 57 a0 17 50 4d 36  .E4RWp.E4RW..PM6
  0c60: 4c 8a 42 55 46 30 0b 8e 01 45 38 4c 4e 70 00 45  L.BUF0...E8LNp.E
  0c70: 38 4c 4e a0 1a 93 50 4d 36 4c 0a 01 8d 42 55 46  8LN...PM6L...BUF
  0c80: 30 0b e8 0b 45 38 52 57 70 00 45 38 52 57 a0 17  0...E8RWp.E8RW..
  0c90: 50 4d 36 48 8a 42 55 46 30 0b a9 01 45 43 4c 4e  PM6H.BUF0...ECLN
  0ca0: 70 00 45 43 4c 4e a0 1a 93 50 4d 36 48 0a 01 8d  p.ECLN...PM6H...
  0cb0: 42 55 46 30 0b c0 0c 45 43 52 57 70 00 45 43 52  BUF0...ECRWp.ECR
  0cc0: 57 a0 17 50 4d 30 48 8a 42 55 46 30 0b c4 01 46  W..PM0H.BUF0...F
  0cd0: 30 4c 4e 70 00 46 30 4c 4e a0 1a 93 50 4d 30 48  0LNp.F0LN...PM0H
  0ce0: 0a 01 8d 42 55 46 30 0b 98 0d 46 30 52 57 70 00  ...BUF0...F0RWp.
  0cf0: 46 30 52 57 8a 42 55 46 30 0b d3 01 4d 31 4d 4e  F0RW.BUF0...M1MN
  0d00: 8a 42 55 46 30 0b d7 01 4d 31 4d 58 8a 42 55 46  .BUF0...M1MX.BUF
  0d10: 30 0b df 01 4d 31 4c 4e 77 0c 00 00 00 02 5c 2f  0...M1LNw.....\/
  0d20: 04 5f 53 42 5f 50 43 49 30 4d 42 55 53 44 52 42  ._SB_PCI0MBUSDRB
  0d30: 33 4d 31 4d 4e 72 74 4d 31 4d 58 4d 31 4d 4e 00  3M1MNrtM1MXM1MN.
  0d40: 0a 01 4d 31 4c 4e 7a 7b 5c 2f 04 5f 53 42 5f 50  ..M1LNz{\/._SB_P
  0d50: 43 49 30 4c 50 43 30 4d 54 53 45 0b 80 03 00 0a  CI0LPC0MTSE.....
  0d60: 07 60 a0 45 09 7b 60 0a 04 00 8a 42 55 46 30 0b  .`.E.{`....BUF0.
  0d70: ee 01 4d 32 4d 4e 8a 42 55 46 30 0b f2 01 4d 32  ..M2MN.BUF0...M2
  0d80: 4d 58 8a 42 55 46 30 0b fa 01 4d 32 4c 4e 70 0c  MX.BUF0...M2LNp.
  0d90: 00 00 d0 fe 4d 32 4d 4e 70 0c ff 03 d0 fe 4d 32  ....M2MNp.....M2
  0da0: 4d 58 70 0b 00 04 4d 32 4c 4e a0 19 93 60 0a 05  MXp...M2LN...`..
  0db0: 70 0c 00 10 d0 fe 4d 32 4d 4e 70 0c ff 13 d0 fe  p.....M2MNp.....
  0dc0: 4d 32 4d 58 a0 19 93 60 0a 06 70 0c 00 20 d0 fe  M2MX...`..p.. ..
  0dd0: 4d 32 4d 4e 70 0c ff 23 d0 fe 4d 32 4d 58 a0 19  M2MNp..#..M2MX..
  0de0: 93 60 0a 07 70 0c 00 30 d0 fe 4d 32 4d 4e 70 0c  .`..p..0..M2MNp.
  0df0: ff 33 d0 fe 4d 32 4d 58 a4 42 55 46 30 14 45 0e  .3..M2MX.BUF0.E.
  0e00: 5f 50 52 54 00 a4 12 4c 0d 07 12 1e 04 0c ff ff  _PRT...L........
  0e10: 01 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  0e20: 50 43 30 4c 4e 4b 41 0a 00 12 1e 04 0c ff ff 1d  PC0LNKA.........
  0e30: 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  ...\/._SB_PCI0LP
  0e40: 43 30 4c 4e 4b 41 0a 00 12 1e 04 0c ff ff 1d 00  C0LNKA..........
  0e50: 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  0e60: 30 4c 4e 4b 44 0a 00 12 1e 04 0c ff ff 1d 00 0a  0LNKD...........
  0e70: 02 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  0e80: 4c 4e 4b 43 0a 00 12 1e 04 0c ff ff 1d 00 0a 03  LNKC............
  0e90: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c  \/._SB_PCI0LPC0L
  0ea0: 4e 4b 48 0a 00 12 1e 04 0c ff ff 1f 00 0a 00 5c  NKH............\
  0eb0: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e  /._SB_PCI0LPC0LN
  0ec0: 4b 43 0a 00 12 1e 04 0c ff ff 1f 00 0a 01 5c 2f  KC............\/
  0ed0: 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b  ._SB_PCI0LPC0LNK
  0ee0: 42 0a 00 5b 82 33 4d 42 55 53 08 5f 41 44 52 0a  B..[.3MBUS._ADR.
  0ef0: 01 5b 80 4d 42 55 53 02 0a 40 0a c0 5b 81 1a 4d  .[.MBUS..@..[..M
  0f00: 42 55 53 03 44 52 42 30 08 44 52 42 31 08 44 52  BUS.DRB0.DRB1.DR
  0f10: 42 32 08 44 52 42 33 08 5b 82 4c 9b 41 47 50 5f  B2.DRB3.[.L.AGP_
  0f20: 08 5f 41 44 52 0c 00 00 01 00 08 5f 50 52 54 12  ._ADR......_PRT.
  0f30: 1f 01 12 1c 04 0b ff ff 0a 00 5c 2f 04 5f 53 42  ..........\/._SB
  0f40: 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 41 0a 00 5b  _PCI0LPC0LNKA..[
  0f50: 82 45 98 56 47 41 5f 08 5f 41 44 52 0a 00 08 53  .E.VGA_._ADR...S
  0f60: 57 49 54 0a 01 08 43 52 54 41 0a 00 08 4c 43 44  WIT...CRTA...LCD
  0f70: 41 0a 01 08 54 56 30 41 0a 00 08 44 56 49 41 0a  A...TV0A...DVIA.
  0f80: 00 08 54 4f 47 46 0a 00 08 4c 53 54 46 0a 00 08  ..TOGF...LSTF...
  0f90: 57 44 41 53 0a 01 14 09 5f 53 54 41 00 a4 0a 0f  WDAS...._STA....
  0fa0: 08 5f 50 53 43 0a 00 08 55 53 42 46 0a 00 14 0d  ._PSC...USBF....
  0fb0: 5f 50 53 30 00 70 0a 00 5f 50 53 43 14 0d 5f 50  _PS0.p.._PSC.._P
  0fc0: 53 33 00 70 0a 03 5f 50 53 43 14 10 5f 44 4f 53  S3.p.._PSC.._DOS
  0fd0: 01 70 7b 68 0a 03 00 53 57 49 54 14 1e 5f 44 4f  .p{h...SWIT.._DO
  0fe0: 44 00 a4 12 16 04 0c 00 01 01 00 0c 10 01 01 00  D...............
  0ff0: 0c 00 02 01 00 0c 10 02 01 00 5b 82 4e 04 43 52  ..........[.N.CR
  1000: 54 5f 08 5f 41 44 52 0b 00 01 14 14 5f 44 43 53  T_._ADR....._DCS
  1010: 00 a0 08 43 52 54 41 a4 0a 1f a1 04 a4 0a 1d 14  ...CRTA.........
  1020: 14 5f 44 47 53 00 a0 08 43 52 54 41 a4 0a 01 a1  ._DGS...CRTA....
  1030: 04 a4 0a 00 14 15 5f 44 53 53 01 70 0d 43 52 54  ......_DSS.p.CRT
  1040: 20 2d 2d 5f 44 53 53 00 5b 31 5b 82 4e 04 44 56   --_DSS.[1[.N.DV
  1050: 49 5f 08 5f 41 44 52 0b 10 02 14 14 5f 44 43 53  I_._ADR....._DCS
  1060: 00 a0 08 44 56 49 41 a4 0a 1f a1 04 a4 0a 1d 14  ...DVIA.........
  1070: 14 5f 44 47 53 00 a0 08 44 56 49 41 a4 0a 01 a1  ._DGS...DVIA....
  1080: 04 a4 0a 00 14 15 5f 44 53 53 01 70 0d 44 56 49  ......_DSS.p.DVI
  1090: 20 2d 2d 5f 44 53 53 00 5b 31 5b 82 4d 04 54 56   --_DSS.[1[.M.TV
  10a0: 30 5f 08 5f 41 44 52 0b 00 02 14 14 5f 44 43 53  0_._ADR....._DCS
  10b0: 00 a0 08 54 56 30 41 a4 0a 1f a1 04 a4 0a 1d 14  ...TV0A.........
  10c0: 14 5f 44 47 53 00 a0 08 54 56 30 41 a4 0a 01 a1  ._DGS...TV0A....
  10d0: 04 a4 0a 00 14 14 5f 44 53 53 01 70 0d 54 56 20  ......_DSS.p.TV 
  10e0: 2d 2d 5f 44 53 53 00 5b 31 5b 82 44 05 4c 43 44  --_DSS.[1[.D.LCD
  10f0: 5f 08 5f 41 44 52 0b 10 01 14 14 5f 44 43 53 00  _._ADR....._DCS.
  1100: a0 08 4c 43 44 41 a4 0a 1f a1 04 a4 0a 1d 14 1a  ..LCDA..........
  1110: 5f 44 47 53 00 70 4c 43 44 41 60 a0 08 4c 43 44  _DGS.pLCDA`..LCD
  1120: 41 a4 0a 01 a1 04 a4 0a 00 14 15 5f 44 53 53 01  A.........._DSS.
  1130: 70 0d 4c 43 44 20 2d 2d 5f 44 53 53 00 5b 31 14  p.LCD --_DSS.[1.
  1140: 40 54 53 57 49 48 00 70 0a 97 5c 2f 04 5f 53 42  @TSWIH.p..\/._SB
  1150: 5f 50 43 49 30 4c 50 43 30 42 43 4d 44 70 0a 00  _PCI0LPC0BCMDp..
  1160: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 53  \/._SB_PCI0LPC0S
  1170: 4d 49 43 70 5c 2e 5f 53 42 5f 44 41 54 53 57 44  MICp\._SB_DATSWD
  1180: 41 53 70 57 44 41 53 50 38 30 48 47 45 54 44 a0  ASpWDASP80HGETD.
  1190: 43 12 93 57 44 41 53 0a 0f 75 54 4f 47 46 a0 0f  C..WDAS..uTOGF..
  11a0: 94 54 4f 47 46 0a 07 70 0a 01 54 4f 47 46 70 54  .TOGF..p..TOGFpT
  11b0: 4f 47 46 61 a0 21 93 61 0a 01 70 0a 01 4c 43 44  OGFa.!.a..p..LCD
  11c0: 41 70 0a 00 43 52 54 41 70 0a 00 54 56 30 41 70  Ap..CRTAp..TV0Ap
  11d0: 0a 00 44 56 49 41 a1 4c 0d a0 21 93 61 0a 02 70  ..DVIA.L..!.a..p
  11e0: 0a 01 4c 43 44 41 70 0a 01 43 52 54 41 70 0a 00  ..LCDAp..CRTAp..
  11f0: 54 56 30 41 70 0a 00 44 56 49 41 a1 47 0b a0 21  TV0Ap..DVIA.G..!
  1200: 93 61 0a 03 70 0a 01 4c 43 44 41 70 0a 00 43 52  .a..p..LCDAp..CR
  1210: 54 41 70 0a 00 54 56 30 41 70 0a 01 44 56 49 41  TAp..TV0Ap..DVIA
  1220: a1 42 09 a0 21 93 61 0a 04 70 0a 01 4c 43 44 41  .B..!.a..p..LCDA
  1230: 70 0a 00 43 52 54 41 70 0a 01 54 56 30 41 70 0a  p..CRTAp..TV0Ap.
  1240: 00 44 56 49 41 a1 4d 06 a0 21 93 61 0a 05 70 0a  .DVIA.M..!.a..p.
  1250: 00 4c 43 44 41 70 0a 01 43 52 54 41 70 0a 00 54  .LCDAp..CRTAp..T
  1260: 56 30 41 70 0a 00 44 56 49 41 a1 48 04 a0 21 93  V0Ap..DVIA.H..!.
  1270: 61 0a 06 70 0a 00 4c 43 44 41 70 0a 00 43 52 54  a..p..LCDAp..CRT
  1280: 41 70 0a 00 54 56 30 41 70 0a 01 44 56 49 41 a1  Ap..TV0Ap..DVIA.
  1290: 23 a0 21 93 61 0a 07 70 0a 00 4c 43 44 41 70 0a  #.!.a..p..LCDAp.
  12a0: 00 43 52 54 41 70 0a 01 54 56 30 41 70 0a 00 44  .CRTAp..TV0Ap..D
  12b0: 56 49 41 a0 49 0d 93 57 44 41 53 0a 0d 75 54 4f  VIA.I..WDAS..uTO
  12c0: 47 46 a0 0f 94 54 4f 47 46 0a 05 70 0a 01 54 4f  GF...TOGF..p..TO
  12d0: 47 46 70 54 4f 47 46 61 a0 21 93 61 0a 01 70 0a  GFpTOGFa.!.a..p.
  12e0: 01 4c 43 44 41 70 0a 00 43 52 54 41 70 0a 00 54  .LCDAp..CRTAp..T
  12f0: 56 30 41 70 0a 00 44 56 49 41 a1 42 09 a0 21 93  V0Ap..DVIA.B..!.
  1300: 61 0a 02 70 0a 01 4c 43 44 41 70 0a 00 43 52 54  a..p..LCDAp..CRT
  1310: 41 70 0a 00 54 56 30 41 70 0a 01 44 56 49 41 a1  Ap..TV0Ap..DVIA.
  1320: 4d 06 a0 21 93 61 0a 03 70 0a 01 4c 43 44 41 70  M..!.a..p..LCDAp
  1330: 0a 00 43 52 54 41 70 0a 01 54 56 30 41 70 0a 00  ..CRTAp..TV0Ap..
  1340: 44 56 49 41 a1 48 04 a0 21 93 61 0a 04 70 0a 00  DVIA.H..!.a..p..
  1350: 4c 43 44 41 70 0a 00 43 52 54 41 70 0a 00 54 56  LCDAp..CRTAp..TV
  1360: 30 41 70 0a 01 44 56 49 41 a1 23 a0 21 93 61 0a  0Ap..DVIA.#.!.a.
  1370: 05 70 0a 00 4c 43 44 41 70 0a 00 43 52 54 41 70  .p..LCDAp..CRTAp
  1380: 0a 01 54 56 30 41 70 0a 00 44 56 49 41 a0 49 0d  ..TV0Ap..DVIA.I.
  1390: 93 57 44 41 53 0a 0b 75 54 4f 47 46 a0 0f 94 54  .WDAS..uTOGF...T
  13a0: 4f 47 46 0a 05 70 0a 01 54 4f 47 46 70 54 4f 47  OGF..p..TOGFpTOG
  13b0: 46 61 a0 21 93 61 0a 01 70 0a 01 4c 43 44 41 70  Fa.!.a..p..LCDAp
  13c0: 0a 00 43 52 54 41 70 0a 00 54 56 30 41 70 0a 00  ..CRTAp..TV0Ap..
  13d0: 44 56 49 41 a1 42 09 a0 21 93 61 0a 02 70 0a 01  DVIA.B..!.a..p..
  13e0: 4c 43 44 41 70 0a 01 43 52 54 41 70 0a 00 54 56  LCDAp..CRTAp..TV
  13f0: 30 41 70 0a 00 44 56 49 41 a1 4d 06 a0 21 93 61  0Ap..DVIA.M..!.a
  1400: 0a 03 70 0a 01 4c 43 44 41 70 0a 00 43 52 54 41  ..p..LCDAp..CRTA
  1410: 70 0a 00 54 56 30 41 70 0a 01 44 56 49 41 a1 48  p..TV0Ap..DVIA.H
  1420: 04 a0 21 93 61 0a 04 70 0a 00 4c 43 44 41 70 0a  ..!.a..p..LCDAp.
  1430: 01 43 52 54 41 70 0a 00 54 56 30 41 70 0a 00 44  .CRTAp..TV0Ap..D
  1440: 56 49 41 a1 23 a0 21 93 61 0a 05 70 0a 00 4c 43  VIA.#.!.a..p..LC
  1450: 44 41 70 0a 00 43 52 54 41 70 0a 00 54 56 30 41  DAp..CRTAp..TV0A
  1460: 70 0a 01 44 56 49 41 a0 4f 08 93 57 44 41 53 0a  p..DVIA.O..WDAS.
  1470: 09 75 54 4f 47 46 a0 0f 94 54 4f 47 46 0a 03 70  .uTOGF...TOGF..p
  1480: 0a 01 54 4f 47 46 70 54 4f 47 46 61 a0 21 93 61  ..TOGFpTOGFa.!.a
  1490: 0a 01 70 0a 01 4c 43 44 41 70 0a 00 43 52 54 41  ..p..LCDAp..CRTA
  14a0: 70 0a 00 54 56 30 41 70 0a 00 44 56 49 41 a1 48  p..TV0Ap..DVIA.H
  14b0: 04 a0 21 93 61 0a 02 70 0a 01 4c 43 44 41 70 0a  ..!.a..p..LCDAp.
  14c0: 00 43 52 54 41 70 0a 00 54 56 30 41 70 0a 01 44  .CRTAp..TV0Ap..D
  14d0: 56 49 41 a1 23 a0 21 93 61 0a 03 70 0a 00 4c 43  VIA.#.!.a..p..LC
  14e0: 44 41 70 0a 00 43 52 54 41 70 0a 00 54 56 30 41  DAp..CRTAp..TV0A
  14f0: 70 0a 01 44 56 49 41 a0 41 0e 91 93 57 44 41 53  p..DVIA.A...WDAS
  1500: 0a 05 93 57 44 41 53 0a 07 75 54 4f 47 46 a0 0f  ...WDAS..uTOGF..
  1510: 94 54 4f 47 46 0a 05 70 0a 01 54 4f 47 46 70 54  .TOGF..p..TOGFpT
  1520: 4f 47 46 61 a0 21 93 61 0a 01 70 0a 01 4c 43 44  OGFa.!.a..p..LCD
  1530: 41 70 0a 00 43 52 54 41 70 0a 00 54 56 30 41 70  Ap..CRTAp..TV0Ap
  1540: 0a 00 44 56 49 41 a1 42 09 a0 21 93 61 0a 02 70  ..DVIA.B..!.a..p
  1550: 0a 01 4c 43 44 41 70 0a 01 43 52 54 41 70 0a 00  ..LCDAp..CRTAp..
  1560: 54 56 30 41 70 0a 00 44 56 49 41 a1 4d 06 a0 21  TV0Ap..DVIA.M..!
  1570: 93 61 0a 03 70 0a 01 4c 43 44 41 70 0a 00 43 52  .a..p..LCDAp..CR
  1580: 54 41 70 0a 01 54 56 30 41 70 0a 00 44 56 49 41  TAp..TV0Ap..DVIA
  1590: a1 48 04 a0 21 93 61 0a 04 70 0a 00 4c 43 44 41  .H..!.a..p..LCDA
  15a0: 70 0a 01 43 52 54 41 70 0a 00 54 56 30 41 70 0a  p..CRTAp..TV0Ap.
  15b0: 00 44 56 49 41 a1 23 a0 21 93 61 0a 05 70 0a 00  .DVIA.#.!.a..p..
  15c0: 4c 43 44 41 70 0a 00 43 52 54 41 70 0a 01 54 56  LCDAp..CRTAp..TV
  15d0: 30 41 70 0a 00 44 56 49 41 a0 40 09 92 94 57 44  0Ap..DVIA.@...WD
  15e0: 41 53 0a 03 75 54 4f 47 46 a0 0f 94 54 4f 47 46  AS..uTOGF...TOGF
  15f0: 0a 03 70 0a 01 54 4f 47 46 70 54 4f 47 46 61 a0  ..p..TOGFpTOGFa.
  1600: 21 93 61 0a 01 70 0a 01 4c 43 44 41 70 0a 00 43  !.a..p..LCDAp..C
  1610: 52 54 41 70 0a 00 54 56 30 41 70 0a 00 44 56 49  RTAp..TV0Ap..DVI
  1620: 41 a1 48 04 a0 21 93 61 0a 02 70 0a 01 4c 43 44  A.H..!.a..p..LCD
  1630: 41 70 0a 01 43 52 54 41 70 0a 00 54 56 30 41 70  Ap..CRTAp..TV0Ap
  1640: 0a 00 44 56 49 41 a1 23 a0 21 93 61 0a 03 70 0a  ..DVIA.#.!.a..p.
  1650: 00 4c 43 44 41 70 0a 01 43 52 54 41 70 0a 00 54  .LCDAp..CRTAp..T
  1660: 56 30 41 70 0a 00 44 56 49 41 86 5c 2f 04 5f 53  V0Ap..DVIA.\/._S
  1670: 42 5f 50 43 49 30 41 47 50 5f 56 47 41 5f 0a 80  B_PCI0AGP_VGA_..
  1680: 14 45 25 47 45 54 44 00 70 0a 98 5c 2f 04 5f 53  .E%GETD.p..\/._S
  1690: 42 5f 50 43 49 30 4c 50 43 30 42 43 4d 44 70 0a  B_PCI0LPC0BCMDp.
  16a0: 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  16b0: 53 4d 49 43 70 5c 2e 5f 53 42 5f 44 49 53 44 60  SMICp\._SB_DISD`
  16c0: a0 41 07 93 57 44 41 53 0a 0f a0 0c 93 60 0a 07  .A..WDAS.....`..
  16d0: 70 0a 07 54 4f 47 46 a0 0c 93 60 0a 06 70 0a 06  p..TOGF...`..p..
  16e0: 54 4f 47 46 a0 0c 93 60 0a 05 70 0a 05 54 4f 47  TOGF...`..p..TOG
  16f0: 46 a0 0c 93 60 0a 04 70 0a 04 54 4f 47 46 a0 0c  F...`..p..TOGF..
  1700: 93 60 0a 03 70 0a 03 54 4f 47 46 a0 0c 93 60 0a  .`..p..TOGF...`.
  1710: 02 70 0a 02 54 4f 47 46 a0 0c 93 60 0a 01 70 0a  .p..TOGF...`..p.
  1720: 01 54 4f 47 46 a0 0c 93 60 0a 00 70 0a 00 54 4f  .TOGF...`..p..TO
  1730: 47 46 a0 47 05 93 57 44 41 53 0a 0d a0 0c 93 60  GF.G..WDAS.....`
  1740: 0a 07 70 0a 05 54 4f 47 46 a0 0c 93 60 0a 06 70  ..p..TOGF...`..p
  1750: 0a 04 54 4f 47 46 a0 0c 93 60 0a 04 70 0a 03 54  ..TOGF...`..p..T
  1760: 4f 47 46 a0 0c 93 60 0a 03 70 0a 02 54 4f 47 46  OGF...`..p..TOGF
  1770: a0 0c 93 60 0a 01 70 0a 01 54 4f 47 46 a0 0c 93  ...`..p..TOGF...
  1780: 60 0a 00 70 0a 00 54 4f 47 46 a0 47 05 93 57 44  `..p..TOGF.G..WD
  1790: 41 53 0a 0b a0 0c 93 60 0a 06 70 0a 05 54 4f 47  AS.....`..p..TOG
  17a0: 46 a0 0c 93 60 0a 05 70 0a 04 54 4f 47 46 a0 0c  F...`..p..TOGF..
  17b0: 93 60 0a 03 70 0a 03 54 4f 47 46 a0 0c 93 60 0a  .`..p..TOGF...`.
  17c0: 02 70 0a 02 54 4f 47 46 a0 0c 93 60 0a 01 70 0a  .p..TOGF...`..p.
  17d0: 01 54 4f 47 46 a0 0c 93 60 0a 00 70 0a 00 54 4f  .TOGF...`..p..TO
  17e0: 47 46 a0 3c 93 57 44 41 53 0a 09 a0 0c 93 60 0a  GF.<.WDAS.....`.
  17f0: 06 70 0a 03 54 4f 47 46 a0 0c 93 60 0a 03 70 0a  .p..TOGF...`..p.
  1800: 02 54 4f 47 46 a0 0c 93 60 0a 01 70 0a 01 54 4f  .TOGF...`..p..TO
  1810: 47 46 a0 0c 93 60 0a 00 70 0a 00 54 4f 47 46 a0  GF...`..p..TOGF.
  1820: 48 07 91 93 57 44 41 53 0a 05 93 57 44 41 53 0a  H...WDAS...WDAS.
  1830: 07 a0 0c 93 60 0a 07 70 0a 05 54 4f 47 46 a0 0c  ....`..p..TOGF..
  1840: 93 60 0a 05 70 0a 04 54 4f 47 46 a0 0c 93 60 0a  .`..p..TOGF...`.
  1850: 04 70 0a 03 54 4f 47 46 a0 0c 93 60 0a 02 70 0a  .p..TOGF...`..p.
  1860: 02 54 4f 47 46 a0 0c 93 60 0a 01 70 0a 01 54 4f  .TOGF...`..p..TO
  1870: 47 46 a0 0c 93 60 0a 00 70 0a 00 54 4f 47 46 a0  GF...`..p..TOGF.
  1880: 0f 93 54 4f 47 46 4c 53 54 46 75 54 4f 47 46 70  ..TOGFLSTFuTOGFp
  1890: 54 4f 47 46 4c 53 54 46 a0 3d 92 94 57 44 41 53  TOGFLSTF.=..WDAS
  18a0: 0a 03 a0 0c 93 60 0a 05 70 0a 03 54 4f 47 46 a0  .....`..p..TOGF.
  18b0: 0c 93 60 0a 02 70 0a 02 54 4f 47 46 a0 0c 93 60  ..`..p..TOGF...`
  18c0: 0a 01 70 0a 01 54 4f 47 46 a0 0c 93 60 0a 00 70  ..p..TOGF...`..p
  18d0: 0a 00 54 4f 47 46 5b 82 4e 12 50 43 49 42 08 5f  ..TOGF[.N.PCIB._
  18e0: 41 44 52 0c 00 00 1e 00 5b 82 1b 47 4c 41 4e 08  ADR.....[..GLAN.
  18f0: 5f 41 44 52 0c 00 00 02 00 08 5f 50 52 57 12 06  _ADR......_PRW..
  1900: 02 0a 0b 0a 05 5b 82 1b 4d 50 43 49 08 5f 41 44  .....[..MPCI._AD
  1910: 52 0c 00 00 04 00 08 5f 50 52 57 12 06 02 0a 0b  R......_PRW.....
  1920: 0a 04 5b 82 1b 54 33 39 34 08 5f 41 44 52 0c 02  ..[..T394._ADR..
  1930: 00 06 00 08 5f 50 52 57 12 06 02 0a 0b 0a 04 14  ...._PRW........
  1940: 46 0c 5f 50 52 54 00 a4 12 4d 0b 06 12 1e 04 0c  F._PRT...M......
  1950: ff ff 02 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49  ......\/._SB_PCI
  1960: 30 4c 50 43 30 4c 4e 4b 44 0a 00 12 1e 04 0c ff  0LPC0LNKD.......
  1970: ff 04 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30  .....\/._SB_PCI0
  1980: 4c 50 43 30 4c 4e 4b 42 0a 00 12 1e 04 0c ff ff  LPC0LNKB........
  1990: 04 00 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  19a0: 50 43 30 4c 4e 4b 43 0a 00 12 1e 04 0c ff ff 06  PC0LNKC.........
  19b0: 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  ...\/._SB_PCI0LP
  19c0: 43 30 4c 4e 4b 45 0a 00 12 1e 04 0c ff ff 06 00  C0LNKE..........
  19d0: 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  19e0: 30 4c 4e 4b 46 0a 00 12 1e 04 0c ff ff 06 00 0a  0LNKF...........
  19f0: 02 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  1a00: 4c 4e 4b 47 0a 00 5b 82 8b 86 02 4c 50 43 30 08  LNKG..[....LPC0.
  1a10: 5f 41 44 52 0c 00 00 1f 00 14 0a 44 45 43 44 04  _ADR.......DECD.
  1a20: 70 68 5b 31 5b 80 52 45 47 53 02 0a 40 0a c0 5b  ph[1[.REGS..@..[
  1a30: 81 48 05 52 45 47 53 03 50 4d 42 41 10 00 40 0b  .H.REGS.PMBA..@.
  1a40: 47 50 42 41 10 00 40 3b 50 4f 53 44 01 00 07 4d  GPBA..@;POSD...M
  1a50: 54 53 45 10 00 08 00 40 06 43 4d 41 44 03 00 01  TSE....@.CMAD...
  1a60: 43 4d 42 44 03 00 01 4c 50 54 44 02 00 02 46 44  CMBD...LPTD...FD
  1a70: 44 44 01 00 23 45 43 4f 31 01 45 43 4f 32 01 45  DD..#ECO1.ECO2.E
  1a80: 4c 50 54 01 45 46 44 44 01 5b 80 50 49 52 58 02  LPT.EFDD.[.PIRX.
  1a90: 0a 60 0a 0c 5b 81 33 50 49 52 58 03 01 01 00 50  .`..[.3PIRX....P
  1aa0: 49 52 41 08 50 49 52 42 08 50 49 52 43 08 50 49  IRA.PIRB.PIRC.PI
  1ab0: 52 44 08 00 20 50 49 52 45 08 50 49 52 46 08 50  RD.. PIRE.PIRF.P
  1ac0: 49 52 47 08 50 49 52 48 08 5b 82 45 06 54 49 4d  IRG.PIRH.[.E.TIM
  1ad0: 52 08 5f 48 49 44 0c 41 d0 01 00 08 42 55 46 30  R._HID.A....BUF0
  1ae0: 11 15 0a 12 47 01 40 00 40 00 01 04 47 01 50 00  ....G.@.@...G.P.
  1af0: 50 00 10 04 79 00 08 42 55 46 31 11 18 0a 15 47  P...y..BUF1....G
  1b00: 01 40 00 40 00 01 04 47 01 50 00 50 00 10 04 22  .@.@...G.P.P..."
  1b10: 01 00 79 00 14 1b 5f 43 52 53 08 a0 0f 7b 4d 54  ..y..._CRS...{MT
  1b20: 53 45 0b 00 02 00 a4 42 55 46 30 a4 42 55 46 31  SE.....BUF0.BUF1
  1b30: 5b 82 45 0a 49 50 49 43 08 5f 48 49 44 0b 41 d0  [.E.IPIC._HID.A.
  1b40: 08 5f 43 52 53 11 41 09 0a 8d 47 01 20 00 20 00  ._CRS.A...G. . .
  1b50: 01 02 47 01 24 00 24 00 01 02 47 01 28 00 28 00  ..G.$.$...G.(.(.
  1b60: 01 02 47 01 2c 00 2c 00 01 02 47 01 30 00 30 00  ..G.,.,...G.0.0.
  1b70: 01 02 47 01 34 00 34 00 01 02 47 01 38 00 38 00  ..G.4.4...G.8.8.
  1b80: 01 02 47 01 3c 00 3c 00 01 02 47 01 a0 00 a0 00  ..G.<.<...G.....
  1b90: 01 02 47 01 a4 00 a4 00 01 02 47 01 a8 00 a8 00  ..G.......G.....
  1ba0: 01 02 47 01 ac 00 ac 00 01 02 47 01 b0 00 b0 00  ..G.......G.....
  1bb0: 01 02 47 01 b4 00 b4 00 01 02 47 01 b8 00 b8 00  ..G.......G.....
  1bc0: 01 02 47 01 bc 00 bc 00 01 02 47 01 d0 04 d0 04  ..G.......G.....
  1bd0: 01 02 22 04 00 79 00 5b 82 45 05 52 54 43 5f 08  .."..y.[.E.RTC_.
  1be0: 5f 48 49 44 0c 41 d0 0b 00 08 42 55 46 30 11 0d  _HID.A....BUF0..
  1bf0: 0a 0a 47 01 70 00 70 00 01 08 79 00 08 42 55 46  ..G.p.p...y..BUF
  1c00: 31 11 10 0a 0d 47 01 70 00 70 00 01 08 22 00 01  1....G.p.p..."..
  1c10: 79 00 14 1b 5f 43 52 53 08 a0 0f 7b 4d 54 53 45  y..._CRS...{MTSE
  1c20: 0b 00 02 00 a4 42 55 46 30 a4 42 55 46 31 5b 82  .....BUF0.BUF1[.
  1c30: 25 4d 41 54 48 08 5f 48 49 44 0c 41 d0 0c 04 08  %MATH._HID.A....
  1c40: 5f 43 52 53 11 10 0a 0d 47 01 f0 00 f0 00 01 01  _CRS....G.......
  1c50: 22 00 20 79 00 5b 82 46 04 44 4d 41 43 08 5f 48  ". y.[.F.DMAC._H
  1c60: 49 44 0c 41 d0 02 00 08 5f 43 52 53 11 30 0a 2d  ID.A...._CRS.0.-
  1c70: 47 01 00 00 00 00 01 20 47 01 81 00 81 00 01 0f  G...... G.......
  1c80: 47 01 90 00 90 00 01 02 47 01 93 00 93 00 01 0d  G.......G.......
  1c90: 47 01 c0 00 c0 00 01 20 2a 10 01 79 00 5b 82 40  G...... *..y.[.@
  1ca0: 1b 4d 42 52 44 08 5f 48 49 44 0c 41 d0 0c 02 08  .MBRD._HID.A....
  1cb0: 5f 55 49 44 0a 1f 08 5f 43 52 53 11 43 19 0b 8e  _UID..._CRS.C...
  1cc0: 01 47 01 10 00 10 00 01 10 47 01 24 00 24 00 01  .G.......G.$.$..
  1cd0: 02 47 01 28 00 28 00 01 02 47 01 2c 00 2c 00 01  .G.(.(...G.,.,..
  1ce0: 02 47 01 4e 16 4e 16 01 02 47 01 30 00 30 00 01  .G.N.N...G.0.0..
  1cf0: 02 47 01 34 00 34 00 01 02 47 01 38 00 38 00 01  .G.4.4...G.8.8..
  1d00: 02 47 01 3c 00 3c 00 01 02 47 01 50 00 50 00 01  .G.<.<...G.P.P..
  1d10: 04 47 01 61 00 61 00 01 01 47 01 63 00 63 00 01  .G.a.a...G.c.c..
  1d20: 01 47 01 65 00 65 00 01 01 47 01 67 00 67 00 01  .G.e.e...G.g.g..
  1d30: 01 47 01 72 00 72 00 01 06 47 01 80 00 80 00 01  .G.r.r...G......
  1d40: 01 47 01 90 00 90 00 01 10 47 01 92 00 92 00 01  .G.......G......
  1d50: 01 47 01 a4 00 a4 00 01 02 47 01 a8 00 a8 00 01  .G.......G......
  1d60: 02 47 01 ac 00 ac 00 01 02 47 01 b0 00 b0 00 01  .G.......G......
  1d70: 06 47 01 b2 00 b2 00 01 02 47 01 b8 00 b8 00 01  .G.......G......
  1d80: 02 47 01 bc 00 bc 00 01 02 47 01 00 06 00 06 01  .G.......G......
  1d90: 10 47 01 00 07 00 07 01 10 47 01 00 08 00 08 01  .G.......G......
  1da0: 10 47 01 00 10 00 10 01 80 47 01 80 11 80 11 01  .G.......G......
  1db0: 40 47 01 c0 01 c0 01 01 10 47 01 2e 00 2e 00 01  @G.......G......
  1dc0: 02 47 01 68 00 68 00 01 01 47 01 6c 00 6c 00 01  .G.h.h...G.l.l..
  1dd0: 01 47 01 00 fe 00 fe 00 01 47 01 d0 04 d0 04 01  .G.......G......
  1de0: 02 47 01 10 06 10 06 01 10 47 01 68 00 68 00 01  .G.......G.h.h..
  1df0: 01 47 01 6c 00 6c 00 01 01 86 09 00 01 00 00 c1  .G.l.l..........
  1e00: fe 00 00 01 00 86 09 00 00 00 00 80 ff 00 00 40  ...............@
  1e10: 00 86 09 00 00 00 00 f0 ff 00 00 10 00 86 09 00  ................
  1e20: 01 00 00 00 00 00 00 0a 00 86 09 00 00 00 00 0e  ................
  1e30: 00 00 00 02 00 86 09 00 00 00 f8 0d 00 00 08 00  ................
  1e40: 00 86 09 00 01 00 00 10 00 00 00 00 00 79 00 5b  .............y.[
  1e50: 82 26 46 57 48 44 08 5f 48 49 44 0c 25 d4 08 00  .&FWHD._HID.%...
  1e60: 08 5f 43 52 53 11 11 0a 0e 86 09 00 00 00 00 80  ._CRS...........
  1e70: ff 00 00 80 00 79 00 5b 82 41 0c 48 50 45 54 08  .....y.[.A.HPET.
  1e80: 5f 48 49 44 0c 41 d0 01 03 08 42 55 46 30 11 17  _HID.A....BUF0..
  1e90: 0a 14 22 01 00 22 00 01 86 09 00 00 00 00 d0 fe  ..".."..........
  1ea0: 00 04 00 00 79 00 14 36 5f 53 54 41 00 7a 7b 4d  ....y..6_STA.z{M
  1eb0: 54 53 45 0b 80 03 00 0a 07 60 a0 13 93 4f 53 59  TSE......`...OSY
  1ec0: 53 0b d1 07 a0 09 7b 60 0a 04 00 a4 0a 0f a1 0b  S.....{`........
  1ed0: a0 09 7b 60 0a 04 00 a4 0a 0b a4 0a 00 14 4c 05  ..{`..........L.
  1ee0: 5f 43 52 53 08 7a 7b 4d 54 53 45 0b 80 03 00 0a  _CRS.z{MTSE.....
  1ef0: 07 60 a0 42 04 7b 60 0a 04 00 8a 42 55 46 30 0a  .`.B.{`....BUF0.
  1f00: 0a 48 50 54 30 a0 0f 93 60 0a 05 70 0c 00 10 d0  .HPT0...`..p....
  1f10: fe 48 50 54 30 a0 0f 93 60 0a 06 70 0c 00 20 d0  .HPT0...`..p.. .
  1f20: fe 48 50 54 30 a0 0f 93 60 0a 07 70 0c 00 30 d0  .HPT0...`..p..0.
  1f30: fe 48 50 54 30 a4 42 55 46 30 5b 82 45 0a 4c 4e  .HPT0.BUF0[.E.LN
  1f40: 4b 41 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49  KA._HID.A...._UI
  1f50: 44 0a 01 14 0d 5f 44 49 53 08 70 0a 80 50 49 52  D...._DIS.p..PIR
  1f60: 41 08 5f 50 52 53 11 09 0a 06 23 40 00 18 79 00  A._PRS....#@..y.
  1f70: 14 3a 5f 43 52 53 08 08 52 54 4c 41 11 09 0a 06  .:_CRS..RTLA....
  1f80: 23 00 00 18 79 00 8b 52 54 4c 41 0a 01 49 52 51  #...y..RTLA..IRQ
  1f90: 30 70 00 49 52 51 30 79 0a 01 7b 50 49 52 41 0a  0p.IRQ0y..{PIRA.
  1fa0: 0f 00 49 52 51 30 a4 52 54 4c 41 14 1c 5f 53 52  ..IRQ0.RTLA.._SR
  1fb0: 53 09 8b 68 0a 01 49 52 51 30 82 49 52 51 30 60  S..h..IRQ0.IRQ0`
  1fc0: 76 60 70 60 50 49 52 41 14 18 5f 53 54 41 08 a0  v`p`PIRA.._STA..
  1fd0: 0c 7b 50 49 52 41 0a 80 00 a4 0a 09 a1 04 a4 0a  .{PIRA..........
  1fe0: 0b 5b 82 45 0a 4c 4e 4b 42 08 5f 48 49 44 0c 41  .[.E.LNKB._HID.A
  1ff0: d0 0c 0f 08 5f 55 49 44 0a 02 14 0d 5f 44 49 53  ...._UID...._DIS
  2000: 08 70 0a 80 50 49 52 42 08 5f 50 52 53 11 09 0a  .p..PIRB._PRS...
  2010: 06 23 00 04 18 79 00 14 3a 5f 43 52 53 08 08 52  .#...y..:_CRS..R
  2020: 54 4c 42 11 09 0a 06 23 00 00 18 79 00 8b 52 54  TLB....#...y..RT
  2030: 4c 42 0a 01 49 52 51 30 70 00 49 52 51 30 79 0a  LB..IRQ0p.IRQ0y.
  2040: 01 7b 50 49 52 42 0a 0f 00 49 52 51 30 a4 52 54  .{PIRB...IRQ0.RT
  2050: 4c 42 14 1c 5f 53 52 53 09 8b 68 0a 01 49 52 51  LB.._SRS..h..IRQ
  2060: 30 82 49 52 51 30 60 76 60 70 60 50 49 52 42 14  0.IRQ0`v`p`PIRB.
  2070: 18 5f 53 54 41 08 a0 0c 7b 50 49 52 42 0a 80 00  ._STA...{PIRB...
  2080: a4 0a 09 a1 04 a4 0a 0b 5b 82 45 0a 4c 4e 4b 43  ........[.E.LNKC
  2090: 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a  ._HID.A...._UID.
  20a0: 03 14 0d 5f 44 49 53 08 70 0a 80 50 49 52 43 08  ..._DIS.p..PIRC.
  20b0: 5f 50 52 53 11 09 0a 06 23 40 00 18 79 00 14 3a  _PRS....#@..y..:
  20c0: 5f 43 52 53 08 08 52 54 4c 43 11 09 0a 06 23 00  _CRS..RTLC....#.
  20d0: 00 18 79 00 8b 52 54 4c 43 0a 01 49 52 51 30 70  ..y..RTLC..IRQ0p
  20e0: 00 49 52 51 30 79 0a 01 7b 50 49 52 43 0a 0f 00  .IRQ0y..{PIRC...
  20f0: 49 52 51 30 a4 52 54 4c 43 14 1c 5f 53 52 53 09  IRQ0.RTLC.._SRS.
  2100: 8b 68 0a 01 49 52 51 30 82 49 52 51 30 60 76 60  .h..IRQ0.IRQ0`v`
  2110: 70 60 50 49 52 43 14 18 5f 53 54 41 08 a0 0c 7b  p`PIRC.._STA...{
  2120: 50 49 52 43 0a 80 00 a4 0a 09 a1 04 a4 0a 0b 5b  PIRC...........[
  2130: 82 45 0a 4c 4e 4b 44 08 5f 48 49 44 0c 41 d0 0c  .E.LNKD._HID.A..
  2140: 0f 08 5f 55 49 44 0a 04 14 0d 5f 44 49 53 08 70  .._UID...._DIS.p
  2150: 0a 80 50 49 52 44 08 5f 50 52 53 11 09 0a 06 23  ..PIRD._PRS....#
  2160: 40 00 18 79 00 14 3a 5f 43 52 53 08 08 52 54 4c  @..y..:_CRS..RTL
  2170: 44 11 09 0a 06 23 00 00 18 79 00 8b 52 54 4c 44  D....#...y..RTLD
  2180: 0a 01 49 52 51 30 70 00 49 52 51 30 79 0a 01 7b  ..IRQ0p.IRQ0y..{
  2190: 50 49 52 44 0a 0f 00 49 52 51 30 a4 52 54 4c 44  PIRD...IRQ0.RTLD
  21a0: 14 1c 5f 53 52 53 09 8b 68 0a 01 49 52 51 30 82  .._SRS..h..IRQ0.
  21b0: 49 52 51 30 60 76 60 70 60 50 49 52 44 14 18 5f  IRQ0`v`p`PIRD.._
  21c0: 53 54 41 08 a0 0c 7b 50 49 52 44 0a 80 00 a4 0a  STA...{PIRD.....
  21d0: 09 a1 04 a4 0a 0b 5b 82 45 0a 4c 4e 4b 45 08 5f  ......[.E.LNKE._
  21e0: 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 05 14  HID.A...._UID...
  21f0: 0d 5f 44 49 53 08 70 0a 80 50 49 52 45 08 5f 50  ._DIS.p..PIRE._P
  2200: 52 53 11 09 0a 06 23 00 04 18 79 00 14 3a 5f 43  RS....#...y..:_C
  2210: 52 53 08 08 52 54 4c 45 11 09 0a 06 23 00 00 18  RS..RTLE....#...
  2220: 79 00 8b 52 54 4c 45 0a 01 49 52 51 30 70 00 49  y..RTLE..IRQ0p.I
  2230: 52 51 30 79 0a 01 7b 50 49 52 45 0a 0f 00 49 52  RQ0y..{PIRE...IR
  2240: 51 30 a4 52 54 4c 45 14 1c 5f 53 52 53 09 8b 68  Q0.RTLE.._SRS..h
  2250: 0a 01 49 52 51 30 82 49 52 51 30 60 76 60 70 60  ..IRQ0.IRQ0`v`p`
  2260: 50 49 52 45 14 18 5f 53 54 41 08 a0 0c 7b 50 49  PIRE.._STA...{PI
  2270: 52 45 0a 80 00 a4 0a 09 a1 04 a4 0a 0b 5b 82 45  RE...........[.E
  2280: 0a 4c 4e 4b 46 08 5f 48 49 44 0c 41 d0 0c 0f 08  .LNKF._HID.A....
  2290: 5f 55 49 44 0a 06 14 0d 5f 44 49 53 08 70 0a 80  _UID...._DIS.p..
  22a0: 50 49 52 46 08 5f 50 52 53 11 09 0a 06 23 00 04  PIRF._PRS....#..
  22b0: 18 79 00 14 3a 5f 43 52 53 08 08 52 54 4c 46 11  .y..:_CRS..RTLF.
  22c0: 09 0a 06 23 00 00 18 79 00 8b 52 54 4c 46 0a 01  ...#...y..RTLF..
  22d0: 49 52 51 30 70 00 49 52 51 30 79 0a 01 7b 50 49  IRQ0p.IRQ0y..{PI
  22e0: 52 46 0a 0f 00 49 52 51 30 a4 52 54 4c 46 14 1c  RF...IRQ0.RTLF..
  22f0: 5f 53 52 53 09 8b 68 0a 01 49 52 51 30 82 49 52  _SRS..h..IRQ0.IR
  2300: 51 30 60 76 60 70 60 50 49 52 46 14 18 5f 53 54  Q0`v`p`PIRF.._ST
  2310: 41 08 a0 0c 7b 50 49 52 46 0a 80 00 a4 0a 09 a1  A...{PIRF.......
  2320: 04 a4 0a 0b 5b 82 45 0a 4c 4e 4b 47 08 5f 48 49  ....[.E.LNKG._HI
  2330: 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 07 14 0d 5f  D.A...._UID...._
  2340: 44 49 53 08 70 0a 80 50 49 52 47 08 5f 50 52 53  DIS.p..PIRG._PRS
  2350: 11 09 0a 06 23 40 00 18 79 00 14 3a 5f 43 52 53  ....#@..y..:_CRS
  2360: 08 08 52 54 4c 47 11 09 0a 06 23 00 00 18 79 00  ..RTLG....#...y.
  2370: 8b 52 54 4c 47 0a 01 49 52 51 30 70 00 49 52 51  .RTLG..IRQ0p.IRQ
  2380: 30 79 0a 01 7b 50 49 52 47 0a 0f 00 49 52 51 30  0y..{PIRG...IRQ0
  2390: a4 52 54 4c 47 14 1c 5f 53 52 53 09 8b 68 0a 01  .RTLG.._SRS..h..
  23a0: 49 52 51 30 82 49 52 51 30 60 76 60 70 60 50 49  IRQ0.IRQ0`v`p`PI
  23b0: 52 47 14 18 5f 53 54 41 08 a0 0c 7b 50 49 52 47  RG.._STA...{PIRG
  23c0: 0a 80 00 a4 0a 09 a1 04 a4 0a 0b 5b 82 45 0a 4c  ...........[.E.L
  23d0: 4e 4b 48 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55  NKH._HID.A...._U
  23e0: 49 44 0a 08 14 0d 5f 44 49 53 08 70 0a 80 50 49  ID...._DIS.p..PI
  23f0: 52 48 08 5f 50 52 53 11 09 0a 06 23 00 04 18 79  RH._PRS....#...y
  2400: 00 14 3a 5f 43 52 53 08 08 52 54 4c 48 11 09 0a  ..:_CRS..RTLH...
  2410: 06 23 00 00 18 79 00 8b 52 54 4c 48 0a 01 49 52  .#...y..RTLH..IR
  2420: 51 30 70 00 49 52 51 30 79 0a 01 7b 50 49 52 48  Q0p.IRQ0y..{PIRH
  2430: 0a 0f 00 49 52 51 30 a4 52 54 4c 48 14 1c 5f 53  ...IRQ0.RTLH.._S
  2440: 52 53 09 8b 68 0a 01 49 52 51 30 82 49 52 51 30  RS..h..IRQ0.IRQ0
  2450: 60 76 60 70 60 50 49 52 48 14 18 5f 53 54 41 08  `v`p`PIRH.._STA.
  2460: a0 0c 7b 50 49 52 48 0a 80 00 a4 0a 09 a1 04 a4  ..{PIRH.........
  2470: 0a 0b 5b 80 47 50 4f 58 01 0b 80 11 0a 40 5b 81  ..[.GPOX.....@[.
  2480: 40 06 47 50 4f 58 13 00 38 00 01 49 4f 32 35 01  @.GPOX..8..IO25.
  2490: 00 01 49 4f 32 37 01 00 34 4c 56 31 36 01 4c 56  ..IO27..4LV16.LV
  24a0: 31 37 01 00 06 00 01 4c 56 32 35 01 00 01 4c 56  17.....LV25...LV
  24b0: 32 37 01 00 4c 05 00 01 42 4c 32 35 01 00 01 42  27..L...BL25...B
  24c0: 4c 32 37 01 00 44 0e 52 42 49 44 02 4d 42 54 50  L27..D.RBID.MBTP
  24d0: 03 4c 56 33 37 01 4c 56 33 38 01 4c 56 33 39 01  .LV37.LV38.LV39.
  24e0: 5b 80 50 4d 49 4f 01 0b 00 10 0a 51 5b 81 46 07  [.PMIO.....Q[.F.
  24f0: 50 4d 49 4f 12 01 03 00 00 48 14 00 03 50 4d 45  PMIO.....H...PME
  2500: 53 01 00 0c 00 03 50 4d 45 45 01 00 04 47 50 49  S.....PMEE...GPI
  2510: 30 01 47 50 49 31 01 47 50 49 32 01 47 50 49 33  0.GPI1.GPI2.GPI3
  2520: 01 47 50 49 34 01 47 50 49 35 01 47 50 49 36 01  .GPI4.GPI5.GPI6.
  2530: 47 50 49 37 01 47 50 49 38 01 47 50 49 39 01 47  GPI7.GPI8.GPI9.G
  2540: 50 49 41 01 47 50 49 42 01 47 50 49 43 01 47 50  PIA.GPIB.GPIC.GP
  2550: 49 44 01 47 50 49 45 01 47 50 49 46 01 00 06 47  ID.GPIE.GPIF...G
  2560: 50 45 45 01 5b 82 37 4b 42 43 5f 08 5f 48 49 44  PEE.[.7KBC_._HID
  2570: 0c 41 d0 03 03 08 5f 43 52 53 11 18 0a 15 47 01  .A...._CRS....G.
  2580: 60 00 60 00 01 01 47 01 64 00 64 00 01 01 22 02  `.`...G.d.d...".
  2590: 00 79 00 14 09 5f 53 54 41 00 a4 0a 0f 5b 82 4d  .y..._STA....[.M
  25a0: 04 4d 4f 55 45 08 5f 48 49 44 0c 24 4d 37 80 08  .MOUE._HID.$M7..
  25b0: 5f 43 49 44 0c 4f 2e 10 03 08 5f 43 52 53 11 08  _CID.O...._CRS..
  25c0: 0a 05 22 00 10 79 00 14 24 5f 53 54 41 00 a0 0d  .."..y..$_STA...
  25d0: 93 87 5c 5f 4f 53 5f 0a 14 a4 0a 00 a1 0f a0 08  ..\_OS_.........
  25e0: 50 53 32 46 a4 0a 0f a1 04 a4 0a 00 5b 82 4c 06  PS2F........[.L.
  25f0: 4d 4f 55 32 08 5f 48 49 44 0c 4f 2e 10 03 08 5f  MOU2._HID.O...._
  2600: 43 49 44 12 11 03 0c 4f 2e 10 02 0c 4f 2e 10 00  CID....O....O...
  2610: 0c 41 d0 0f 13 08 5f 43 52 53 11 08 0a 05 22 00  .A...._CRS....".
  2620: 10 79 00 14 36 5f 53 54 41 00 a0 24 93 87 5c 5f  .y..6_STA..$..\_
  2630: 4f 53 5f 0a 14 a0 0e 50 53 32 46 70 50 53 32 46  OS_....PS2FpPS2F
  2640: 60 a4 0a 0f a1 0a 70 50 53 32 46 60 a4 0a 00 a1  `.....pPS2F`....
  2650: 0a 70 50 53 32 46 60 a4 0a 00 5b 82 84 13 01 53  .pPS2F`...[....S
  2660: 49 4f 5f 08 5f 48 49 44 0c 41 d0 0a 05 5b 80 53  IO_._HID.A...[.S
  2670: 49 49 4f 01 0b 4e 16 0a 02 5b 81 10 53 49 49 4f  IIO..N...[..SIIO
  2680: 01 49 4e 44 58 08 44 41 54 41 08 5b 01 4e 33 39  .INDX.DATA.[.N39
  2690: 33 00 14 13 53 45 54 44 09 70 0a 07 49 4e 44 58  3...SETD.p..INDX
  26a0: 70 68 44 41 54 41 14 14 52 45 41 44 09 70 68 49  phDATA..READ.phI
  26b0: 4e 44 58 70 44 41 54 41 60 a4 60 14 12 57 52 49  NDXpDATA`.`..WRI
  26c0: 54 0a 70 68 49 4e 44 58 70 69 44 41 54 41 14 2d  T.phINDXpiDATA.-
  26d0: 4c 44 52 53 03 5b 23 4e 33 39 33 ff ff 70 0a 07  LDRS.[#N393..p..
  26e0: 49 4e 44 58 70 68 44 41 54 41 70 69 49 4e 44 58  INDXphDATApiINDX
  26f0: 70 6a 44 41 54 41 5b 27 4e 33 39 33 14 2f 4c 44  pjDATA['N393./LD
  2700: 52 47 02 5b 23 4e 33 39 33 ff ff 70 0a 07 49 4e  RG.[#N393..p..IN
  2710: 44 58 70 68 44 41 54 41 70 69 49 4e 44 58 70 44  DXphDATApiINDXpD
  2720: 41 54 41 60 5b 27 4e 33 39 33 a4 60 14 2a 52 43  ATA`['N393.`.*RC
  2730: 46 36 01 5b 23 4e 33 39 33 ff ff 70 0a 26 49 4e  F6.[#N393..p.&IN
  2740: 44 58 70 44 41 54 41 60 7b 60 68 60 5b 27 4e 33  DXpDATA`{`h`['N3
  2750: 39 33 a4 7f 60 68 00 14 4f 13 50 44 52 53 02 a0  93..`h..O.PDRS..
  2760: 42 13 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  B.\/._SB_PCI0LPC
  2770: 30 50 4f 53 44 a0 32 93 68 0a 00 a0 0a 93 69 0b  0POSD.2.h.....i.
  2780: f0 03 70 0a 00 60 a1 0c a0 0a 93 69 0b 70 03 70  ..p..`.....i.p.p
  2790: 0a 01 60 70 60 5c 2f 04 5f 53 42 5f 50 43 49 30  ..`p`\/._SB_PCI0
  27a0: 4c 50 43 30 46 44 44 44 a1 46 0e a0 3f 93 68 0a  LPC0FDDD.F..?.h.
  27b0: 01 a0 0a 93 69 0b 78 03 70 0a 00 60 a1 19 a0 0a  ....i.x.p..`....
  27c0: 93 69 0b 78 02 70 0a 01 60 a1 0c a0 0a 93 69 0b  .i.x.p..`.....i.
  27d0: bc 03 70 0a 02 60 70 60 5c 2f 04 5f 53 42 5f 50  ..p..`p`\/._SB_P
  27e0: 43 49 30 4c 50 43 30 4c 50 54 44 a1 43 0a a0 0a  CI0LPC0LPTD.C...
  27f0: 93 69 0b f8 03 70 0a 00 60 a1 4d 05 a0 0a 93 69  .i...p..`.M....i
  2800: 0b f8 02 70 0a 01 60 a1 4f 04 a0 0a 93 69 0b 20  ...p..`.O....i. 
  2810: 02 70 0a 02 60 a1 41 04 a0 0a 93 69 0b 28 02 70  .p..`.A....i.(.p
  2820: 0a 03 60 a1 33 a0 0a 93 69 0b 38 02 70 0a 04 60  ..`.3...i.8.p..`
  2830: a1 26 a0 0a 93 69 0b e8 02 70 0a 05 60 a1 19 a0  .&...i...p..`...
  2840: 0a 93 69 0b 38 03 70 0a 06 60 a1 0c a0 0a 93 69  ..i.8.p..`.....i
  2850: 0b e8 03 70 0a 07 60 a0 1a 93 68 0a 02 70 60 5c  ...p..`...h..p`\
  2860: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 43 4d  /._SB_PCI0LPC0CM
  2870: 42 44 a1 1c a0 1a 93 68 0a 03 70 60 5c 2f 04 5f  BD.....h..p`\/._
  2880: 53 42 5f 50 43 49 30 4c 50 43 30 43 4d 41 44 a4  SB_PCI0LPC0CMAD.
  2890: 0a 01 a1 04 a4 0a 00 5b 82 4c 2b 45 43 50 5f 08  .......[.L+ECP_.
  28a0: 5f 48 49 44 0c 41 d0 04 01 08 5f 55 49 44 0a 03  _HID.A...._UID..
  28b0: 14 4b 05 5f 53 54 41 00 70 4c 44 52 47 0a 01 0a  .K._STA.pLDRG...
  28c0: f0 60 7a 60 0a 05 60 a0 1a 94 5c 2f 04 5f 53 42  .`z`..`...\/._SB
  28d0: 5f 50 43 49 30 4c 50 43 30 4d 42 54 50 0a 01 a4  _PCI0LPC0MBTP...
  28e0: 0a 00 a0 24 90 52 43 46 36 0a 02 91 93 60 0a 04  ...$.RCF6....`..
  28f0: 93 60 0a 07 79 4c 44 52 47 0a 01 0a 30 0a 01 61  .`..yLDRG...0..a
  2900: 72 0a 0d 61 61 a4 61 a1 04 a4 0a 00 14 10 5f 50  r..aa.a......._P
  2910: 53 30 00 4c 44 52 53 0a 01 0a 30 0a 01 14 10 5f  S0.LDRS...0...._
  2920: 50 53 33 00 4c 44 52 53 0a 01 0a 30 0a 00 14 48  PS3.LDRS...0...H
  2930: 0c 5f 50 52 53 00 a4 11 4f 0b 0a bb 30 47 01 78  ._PRS...O...0G.x
  2940: 03 78 03 08 08 47 01 78 07 78 07 08 08 22 80 00  .x...G.x.x..."..
  2950: 2a 08 00 30 47 01 78 02 78 02 08 08 47 01 78 06  *..0G.x.x...G.x.
  2960: 78 06 08 08 22 20 00 2a 08 00 30 47 01 78 03 78  x..." .*..0G.x.x
  2970: 03 08 08 47 01 78 07 78 07 08 08 22 20 00 2a 08  ...G.x.x..." .*.
  2980: 00 30 47 01 78 02 78 02 08 08 47 01 78 06 78 06  .0G.x.x...G.x.x.
  2990: 08 08 22 80 00 2a 08 00 30 47 01 78 03 78 03 08  .."..*..0G.x.x..
  29a0: 08 47 01 78 07 78 07 08 08 22 80 00 2a 02 00 30  .G.x.x..."..*..0
  29b0: 47 01 78 02 78 02 08 08 47 01 78 06 78 06 08 08  G.x.x...G.x.x...
  29c0: 22 20 00 2a 02 00 30 47 01 78 03 78 03 08 08 47  " .*..0G.x.x...G
  29d0: 01 78 07 78 07 08 08 22 20 00 2a 02 00 30 47 01  .x.x..." .*..0G.
  29e0: 78 02 78 02 08 08 47 01 78 06 78 06 08 08 22 80  x.x...G.x.x...".
  29f0: 00 2a 02 00 38 79 00 14 10 5f 44 49 53 00 4c 44  .*..8y..._DIS.LD
  2a00: 52 53 0a 01 0a 30 0a 00 14 40 0e 5f 43 52 53 00  RS...0...@._CRS.
  2a10: 08 44 43 52 53 11 1b 0a 18 47 01 78 03 78 03 08  .DCRS....G.x.x..
  2a20: 08 47 01 78 07 78 07 08 08 22 80 00 2a 08 00 79  .G.x.x..."..*..y
  2a30: 00 70 4c 44 52 47 0a 01 0a 60 61 70 4c 44 52 47  .pLDRG...`apLDRG
  2a40: 0a 01 0a 61 60 70 60 88 44 43 52 53 0a 02 00 70  ...a`p`.DCRS...p
  2a50: 60 88 44 43 52 53 0a 0a 00 70 60 88 44 43 52 53  `.DCRS...p`.DCRS
  2a60: 0a 04 00 70 60 88 44 43 52 53 0a 0c 00 70 61 88  ...p`.DCRS...pa.
  2a70: 44 43 52 53 0a 03 00 70 61 88 44 43 52 53 0a 05  DCRS...pa.DCRS..
  2a80: 00 72 61 0a 04 61 70 61 88 44 43 52 53 0a 0b 00  .ra..apa.DCRS...
  2a90: 70 61 88 44 43 52 53 0a 0d 00 79 0a 01 4c 44 52  pa.DCRS...y..LDR
  2aa0: 47 0a 01 0a 70 60 70 60 88 44 43 52 53 0a 11 00  G...p`p`.DCRS...
  2ab0: 7a 60 0a 08 61 70 61 88 44 43 52 53 0a 12 00 79  z`..apa.DCRS...y
  2ac0: 0a 01 4c 44 52 47 0a 01 0a 74 60 70 60 88 44 43  ..LDRG...t`p`.DC
  2ad0: 52 53 0a 14 00 7a 60 0a 08 61 70 61 88 44 43 52  RS...z`..apa.DCR
  2ae0: 53 0a 15 00 a4 44 43 52 53 14 4b 06 5f 53 52 53  S....DCRS.K._SRS
  2af0: 01 8c 68 0a 02 41 44 52 4c 8c 68 0a 03 41 44 52  ..h..ADRL.h..ADR
  2b00: 4d 8b 68 0a 11 49 52 51 4d 8b 68 0a 14 44 4d 41  M.h..IRQM.h..DMA
  2b10: 4d 82 49 52 51 4d 60 76 60 82 44 4d 41 4d 61 76  M.IRQM`v`.DMAMav
  2b20: 61 4c 44 52 53 0a 01 0a 70 60 4c 44 52 53 0a 01  aLDRS...p`LDRS..
  2b30: 0a 74 61 4c 44 52 53 0a 01 0a 60 41 44 52 4d 4c  .taLDRS...`ADRML
  2b40: 44 52 53 0a 01 0a 61 41 44 52 4c 4c 44 52 53 0a  DRS...aADRLLDRS.
  2b50: 01 0a 30 0a 01 5b 82 4b 23 45 50 50 5f 08 5f 48  ..0..[.K#EPP_._H
  2b60: 49 44 0c 41 d0 04 00 08 5f 55 49 44 0a 02 14 4b  ID.A...._UID...K
  2b70: 05 5f 53 54 41 00 70 4c 44 52 47 0a 01 0a f0 60  ._STA.pLDRG....`
  2b80: 7a 60 0a 05 60 a0 1a 94 5c 2f 04 5f 53 42 5f 50  z`..`...\/._SB_P
  2b90: 43 49 30 4c 50 43 30 4d 42 54 50 0a 01 a4 0a 00  CI0LPC0MBTP.....
  2ba0: a0 24 90 52 43 46 36 0a 02 91 93 60 0a 02 93 60  .$.RCF6....`...`
  2bb0: 0a 03 79 4c 44 52 47 0a 01 0a 30 0a 01 61 72 0a  ..yLDRG...0..ar.
  2bc0: 0d 61 61 a4 61 a1 04 a4 0a 00 14 10 5f 50 53 30  .aa.a......._PS0
  2bd0: 00 4c 44 52 53 0a 01 0a 30 0a 01 14 10 5f 50 53  .LDRS...0...._PS
  2be0: 33 00 4c 44 52 53 0a 01 0a 30 0a 00 14 48 08 5f  3.LDRS...0...H._
  2bf0: 50 52 53 00 a4 11 4f 07 0a 7b 30 47 01 78 03 78  PRS...O..{0G.x.x
  2c00: 03 08 08 47 01 78 07 78 07 08 08 22 80 00 30 47  ...G.x.x..."..0G
  2c10: 01 78 02 78 02 08 08 47 01 78 06 78 06 08 08 22  .x.x...G.x.x..."
  2c20: 20 00 30 47 01 78 03 78 03 08 08 47 01 78 07 78   .0G.x.x...G.x.x
  2c30: 07 08 08 22 20 00 30 47 01 78 02 78 02 08 08 47  ..." .0G.x.x...G
  2c40: 01 78 06 78 06 08 08 22 80 00 30 47 01 78 01 78  .x.x..."..0G.x.x
  2c50: 01 08 08 47 01 78 05 78 05 08 08 22 80 00 30 47  ...G.x.x..."..0G
  2c60: 01 78 01 78 01 08 08 47 01 78 05 78 05 08 08 22  .x.x...G.x.x..."
  2c70: 20 00 38 79 00 14 10 5f 44 49 53 00 4c 44 52 53   .8y..._DIS.LDRS
  2c80: 0a 01 0a 30 0a 00 14 48 0b 5f 43 52 53 00 08 44  ...0...H._CRS..D
  2c90: 43 52 53 11 18 0a 15 47 01 78 03 78 03 08 08 47  CRS....G.x.x...G
  2ca0: 01 78 07 78 07 08 08 22 80 00 79 00 70 4c 44 52  .x.x..."..y.pLDR
  2cb0: 47 0a 01 0a 60 61 70 4c 44 52 47 0a 01 0a 61 60  G...`apLDRG...a`
  2cc0: 70 60 88 44 43 52 53 0a 02 00 70 60 88 44 43 52  p`.DCRS...p`.DCR
  2cd0: 53 0a 0a 00 70 60 88 44 43 52 53 0a 04 00 70 60  S...p`.DCRS...p`
  2ce0: 88 44 43 52 53 0a 0c 00 70 61 88 44 43 52 53 0a  .DCRS...pa.DCRS.
  2cf0: 03 00 70 61 88 44 43 52 53 0a 05 00 72 61 0a 04  ..pa.DCRS...ra..
  2d00: 61 70 61 88 44 43 52 53 0a 0b 00 70 61 88 44 43  apa.DCRS...pa.DC
  2d10: 52 53 0a 0d 00 79 0a 01 4c 44 52 47 0a 01 0a 70  RS...y..LDRG...p
  2d20: 60 70 60 88 44 43 52 53 0a 11 00 7a 60 0a 08 61  `p`.DCRS...z`..a
  2d30: 70 61 88 44 43 52 53 0a 12 00 a4 44 43 52 53 14  pa.DCRS....DCRS.
  2d40: 42 05 5f 53 52 53 01 8c 68 0a 02 41 44 52 4c 8c  B._SRS..h..ADRL.
  2d50: 68 0a 03 41 44 52 4d 8b 68 0a 11 49 52 51 4d 82  h..ADRM.h..IRQM.
  2d60: 49 52 51 4d 60 76 60 4c 44 52 53 0a 01 0a 70 60  IRQM`v`LDRS...p`
  2d70: 4c 44 52 53 0a 01 0a 60 41 44 52 4d 4c 44 52 53  LDRS...`ADRMLDRS
  2d80: 0a 01 0a 61 41 44 52 4c 4c 44 52 53 0a 01 0a 30  ...aADRLLDRS...0
  2d90: 0a 01 5b 82 4f 26 4c 50 54 42 08 5f 48 49 44 0c  ..[.O&LPTB._HID.
  2da0: 41 d0 04 00 08 5f 55 49 44 0a 01 14 46 05 5f 53  A...._UID...F._S
  2db0: 54 41 00 70 4c 44 52 47 0a 01 0a f0 60 7a 60 0a  TA.pLDRG....`z`.
  2dc0: 05 60 a0 1a 94 5c 2f 04 5f 53 42 5f 50 43 49 30  .`...\/._SB_PCI0
  2dd0: 4c 50 43 30 4d 42 54 50 0a 01 a4 0a 00 a0 1f 90  LPC0MBTP........
  2de0: 52 43 46 36 0a 02 93 60 0a 01 79 4c 44 52 47 0a  RCF6...`..yLDRG.
  2df0: 01 0a 30 0a 01 61 72 0a 0d 61 61 a4 61 a1 04 a4  ..0..ar..aa.a...
  2e00: 0a 00 14 10 5f 50 53 30 00 4c 44 52 53 0a 01 0a  ...._PS0.LDRS...
  2e10: 30 0a 01 14 10 5f 50 53 33 00 4c 44 52 53 0a 01  0...._PS3.LDRS..
  2e20: 0a 30 0a 00 14 48 08 5f 50 52 53 00 a4 11 4f 07  .0...H._PRS...O.
  2e30: 0a 7b 30 47 01 78 03 78 03 08 08 47 01 78 07 78  .{0G.x.x...G.x.x
  2e40: 07 08 08 22 80 00 30 47 01 78 02 78 02 08 08 47  ..."..0G.x.x...G
  2e50: 01 78 06 78 06 08 08 22 20 00 30 47 01 78 03 78  .x.x..." .0G.x.x
  2e60: 03 08 08 47 01 78 07 78 07 08 08 22 20 00 30 47  ...G.x.x..." .0G
  2e70: 01 78 02 78 02 08 08 47 01 78 06 78 06 08 08 22  .x.x...G.x.x..."
  2e80: 80 00 30 47 01 bc 03 bc 03 04 04 47 01 bc 07 bc  ..0G.......G....
  2e90: 07 04 04 22 80 00 30 47 01 bc 03 bc 03 04 04 47  ..."..0G.......G
  2ea0: 01 bc 07 bc 07 04 04 22 20 00 38 79 00 14 10 5f  ......." .8y..._
  2eb0: 44 49 53 00 4c 44 52 53 0a 01 0a 30 0a 00 14 41  DIS.LDRS...0...A
  2ec0: 0f 5f 43 52 53 00 08 44 43 52 53 11 18 0a 15 47  ._CRS..DCRS....G
  2ed0: 01 78 03 78 03 08 08 47 01 78 07 78 07 08 08 22  .x.x...G.x.x..."
  2ee0: 80 00 79 00 70 4c 44 52 47 0a 01 0a 60 61 70 4c  ..y.pLDRG...`apL
  2ef0: 44 52 47 0a 01 0a 61 60 70 60 88 44 43 52 53 0a  DRG...a`p`.DCRS.
  2f00: 02 00 70 60 88 44 43 52 53 0a 0a 00 70 60 88 44  ..p`.DCRS...p`.D
  2f10: 43 52 53 0a 04 00 70 60 88 44 43 52 53 0a 0c 00  CRS...p`.DCRS...
  2f20: 70 61 88 44 43 52 53 0a 03 00 70 61 88 44 43 52  pa.DCRS...pa.DCR
  2f30: 53 0a 05 00 72 61 0a 04 61 70 61 88 44 43 52 53  S...ra..apa.DCRS
  2f40: 0a 0b 00 70 61 88 44 43 52 53 0a 0d 00 a0 0a 7b  ...pa.DCRS.....{
  2f50: 60 0a 04 00 70 0a 04 60 a1 05 70 0a 08 60 70 60  `...p..`..p..`p`
  2f60: 88 44 43 52 53 0a 06 00 70 60 88 44 43 52 53 0a  .DCRS...p`.DCRS.
  2f70: 07 00 70 60 88 44 43 52 53 0a 0e 00 70 60 88 44  ..p`.DCRS...p`.D
  2f80: 43 52 53 0a 0f 00 79 0a 01 4c 44 52 47 0a 01 0a  CRS...y..LDRG...
  2f90: 70 60 70 60 88 44 43 52 53 0a 11 00 7a 60 0a 08  p`p`.DCRS...z`..
  2fa0: 61 70 61 88 44 43 52 53 0a 12 00 a4 44 43 52 53  apa.DCRS....DCRS
  2fb0: 14 42 05 5f 53 52 53 01 8c 68 0a 02 41 44 52 4c  .B._SRS..h..ADRL
  2fc0: 8c 68 0a 03 41 44 52 4d 8b 68 0a 11 49 52 51 4d  .h..ADRM.h..IRQM
  2fd0: 82 49 52 51 4d 60 76 60 4c 44 52 53 0a 01 0a 70  .IRQM`v`LDRS...p
  2fe0: 60 4c 44 52 53 0a 01 0a 60 41 44 52 4d 4c 44 52  `LDRS...`ADRMLDR
  2ff0: 53 0a 01 0a 61 41 44 52 4c 4c 44 52 53 0a 01 0a  S...aADRLLDRS...
  3000: 30 0a 01 5b 82 4f 26 4c 50 54 5f 08 5f 48 49 44  0..[.O&LPT_._HID
  3010: 0c 41 d0 04 00 08 5f 55 49 44 0a 00 14 46 05 5f  .A...._UID...F._
  3020: 53 54 41 00 70 4c 44 52 47 0a 01 0a f0 60 7a 60  STA.pLDRG....`z`
  3030: 0a 05 60 a0 1a 94 5c 2f 04 5f 53 42 5f 50 43 49  ..`...\/._SB_PCI
  3040: 30 4c 50 43 30 4d 42 54 50 0a 01 a4 0a 00 a0 1f  0LPC0MBTP.......
  3050: 90 52 43 46 36 0a 02 93 60 0a 00 79 4c 44 52 47  .RCF6...`..yLDRG
  3060: 0a 01 0a 30 0a 01 61 72 0a 0d 61 61 a4 61 a1 04  ...0..ar..aa.a..
  3070: a4 0a 00 14 10 5f 50 53 30 00 4c 44 52 53 0a 01  ....._PS0.LDRS..
  3080: 0a 30 0a 01 14 10 5f 50 53 33 00 4c 44 52 53 0a  .0...._PS3.LDRS.
  3090: 01 0a 30 0a 00 14 48 08 5f 50 52 53 00 a4 11 4f  ..0...H._PRS...O
  30a0: 07 0a 7b 30 47 01 78 03 78 03 08 08 47 01 78 07  ..{0G.x.x...G.x.
  30b0: 78 07 08 08 22 80 00 30 47 01 78 02 78 02 08 08  x..."..0G.x.x...
  30c0: 47 01 78 06 78 06 08 08 22 20 00 30 47 01 78 03  G.x.x..." .0G.x.
  30d0: 78 03 08 08 47 01 78 07 78 07 08 08 22 20 00 30  x...G.x.x..." .0
  30e0: 47 01 78 02 78 02 08 08 47 01 78 06 78 06 08 08  G.x.x...G.x.x...
  30f0: 22 80 00 30 47 01 bc 03 bc 03 04 04 47 01 bc 07  "..0G.......G...
  3100: bc 07 04 04 22 80 00 30 47 01 bc 03 bc 03 04 04  ...."..0G.......
  3110: 47 01 bc 07 bc 07 04 04 22 20 00 38 79 00 14 10  G......." .8y...
  3120: 5f 44 49 53 00 4c 44 52 53 0a 01 0a 30 0a 00 14  _DIS.LDRS...0...
  3130: 41 0f 5f 43 52 53 00 08 44 43 52 53 11 18 0a 15  A._CRS..DCRS....
  3140: 47 01 78 03 78 03 08 08 47 01 78 07 78 07 08 08  G.x.x...G.x.x...
  3150: 22 80 00 79 00 70 4c 44 52 47 0a 01 0a 60 61 70  "..y.pLDRG...`ap
  3160: 4c 44 52 47 0a 01 0a 61 60 70 60 88 44 43 52 53  LDRG...a`p`.DCRS
  3170: 0a 02 00 70 60 88 44 43 52 53 0a 0a 00 70 60 88  ...p`.DCRS...p`.
  3180: 44 43 52 53 0a 04 00 70 60 88 44 43 52 53 0a 0c  DCRS...p`.DCRS..
  3190: 00 70 61 88 44 43 52 53 0a 03 00 70 61 88 44 43  .pa.DCRS...pa.DC
  31a0: 52 53 0a 05 00 72 61 0a 04 61 70 61 88 44 43 52  RS...ra..apa.DCR
  31b0: 53 0a 0b 00 70 61 88 44 43 52 53 0a 0d 00 a0 0a  S...pa.DCRS.....
  31c0: 7b 60 0a 04 00 70 0a 04 60 a1 05 70 0a 08 60 70  {`...p..`..p..`p
  31d0: 60 88 44 43 52 53 0a 06 00 70 60 88 44 43 52 53  `.DCRS...p`.DCRS
  31e0: 0a 07 00 70 60 88 44 43 52 53 0a 0e 00 70 60 88  ...p`.DCRS...p`.
  31f0: 44 43 52 53 0a 0f 00 79 0a 01 4c 44 52 47 0a 01  DCRS...y..LDRG..
  3200: 0a 70 60 70 60 88 44 43 52 53 0a 11 00 7a 60 0a  .p`p`.DCRS...z`.
  3210: 08 61 70 61 88 44 43 52 53 0a 12 00 a4 44 43 52  .apa.DCRS....DCR
  3220: 53 14 42 05 5f 53 52 53 01 8c 68 0a 02 41 44 52  S.B._SRS..h..ADR
  3230: 4c 8c 68 0a 03 41 44 52 4d 8b 68 0a 11 49 52 51  L.h..ADRM.h..IRQ
  3240: 4d 82 49 52 51 4d 60 76 60 4c 44 52 53 0a 01 0a  M.IRQM`v`LDRS...
  3250: 70 60 4c 44 52 53 0a 01 0a 60 41 44 52 4d 4c 44  p`LDRS...`ADRMLD
  3260: 52 53 0a 01 0a 61 41 44 52 4c 4c 44 52 53 0a 01  RS...aADRLLDRS..
  3270: 0a 30 0a 01 5b 82 45 1d 43 4f 4d 41 08 5f 48 49  .0..[.E.COMA._HI
  3280: 44 0c 41 d0 05 01 08 5f 55 49 44 0a 00 14 42 04  D.A...._UID...B.
  3290: 5f 53 54 41 00 a0 1a 94 5c 2f 04 5f 53 42 5f 50  _STA....\/._SB_P
  32a0: 43 49 30 4c 50 43 30 4d 42 54 50 0a 01 a4 0a 00  CI0LPC0MBTP.....
  32b0: a0 1a 52 43 46 36 0a 08 79 4c 44 52 47 0a 03 0a  ..RCF6..yLDRG...
  32c0: 30 0a 01 61 72 0a 0d 61 61 a4 61 a1 04 a4 0a 00  0..ar..aa.a.....
  32d0: 14 10 5f 50 53 30 00 4c 44 52 53 0a 03 0a 30 0a  .._PS0.LDRS...0.
  32e0: 01 14 10 5f 50 53 33 00 4c 44 52 53 0a 03 0a 30  ..._PS3.LDRS...0
  32f0: 0a 00 14 40 07 5f 50 52 53 00 a4 11 47 06 0a 63  ...@._PRS...G..c
  3300: 30 47 01 f8 03 f8 03 08 08 22 10 00 30 47 01 f8  0G......."..0G..
  3310: 02 f8 02 08 08 22 08 00 30 47 01 e8 03 e8 03 08  ....."..0G......
  3320: 08 22 10 00 30 47 01 e8 02 e8 02 08 08 22 08 00  ."..0G......."..
  3330: 30 47 01 f8 03 f8 03 08 08 22 08 00 30 47 01 f8  0G......."..0G..
  3340: 02 f8 02 08 08 22 10 00 30 47 01 e8 03 e8 03 08  ....."..0G......
  3350: 08 22 08 00 30 47 01 e8 02 e8 02 08 08 22 10 00  ."..0G......."..
  3360: 38 79 00 14 10 5f 44 49 53 00 4c 44 52 53 0a 03  8y..._DIS.LDRS..
  3370: 0a 30 0a 00 14 43 08 5f 43 52 53 00 08 44 43 52  .0...C._CRS..DCR
  3380: 53 11 10 0a 0d 47 01 f8 03 f8 03 08 08 22 10 00  S....G......."..
  3390: 79 00 70 4c 44 52 47 0a 03 0a 60 61 70 4c 44 52  y.pLDRG...`apLDR
  33a0: 47 0a 03 0a 61 60 70 60 88 44 43 52 53 0a 02 00  G...a`p`.DCRS...
  33b0: 70 60 88 44 43 52 53 0a 04 00 70 61 88 44 43 52  p`.DCRS...pa.DCR
  33c0: 53 0a 03 00 70 61 88 44 43 52 53 0a 05 00 79 0a  S...pa.DCRS...y.
  33d0: 01 4c 44 52 47 0a 03 0a 70 60 70 60 88 44 43 52  .LDRG...p`p`.DCR
  33e0: 53 0a 09 00 7a 60 0a 08 61 70 61 88 44 43 52 53  S...z`..apa.DCRS
  33f0: 0a 0a 00 a4 44 43 52 53 14 42 05 5f 53 52 53 01  ....DCRS.B._SRS.
  3400: 8c 68 0a 02 41 44 52 4c 8c 68 0a 03 41 44 52 4d  .h..ADRL.h..ADRM
  3410: 8b 68 0a 09 49 52 51 4d 82 49 52 51 4d 60 76 60  .h..IRQM.IRQM`v`
  3420: 4c 44 52 53 0a 03 0a 70 60 4c 44 52 53 0a 03 0a  LDRS...p`LDRS...
  3430: 60 41 44 52 4d 4c 44 52 53 0a 03 0a 61 41 44 52  `ADRMLDRS...aADR
  3440: 4c 4c 44 52 53 0a 03 0a 30 0a 01 5b 82 43 34 46  LLDRS...0..[.C4F
  3450: 49 52 5f 14 25 5f 48 49 44 00 a0 16 91 93 4d 59  IR_.%_HID.....MY
  3460: 4f 53 0a 01 93 4d 59 4f 53 0a 03 a4 0c 3a 63 60  OS...MYOS....:c`
  3470: 01 a1 07 a4 0c 3a 63 60 01 08 5f 55 49 44 0a 00  .....:c`.._UID..
  3480: 14 36 5f 53 54 41 00 70 4c 44 52 47 0a 02 0a 74  .6_STA.pLDRG...t
  3490: 60 a0 20 90 52 43 46 36 0a 04 92 93 60 0a 04 79  `. .RCF6....`..y
  34a0: 4c 44 52 47 0a 02 0a 30 0a 01 61 72 0a 0d 61 61  LDRG...0..ar..aa
  34b0: a4 61 a1 04 a4 0a 00 14 10 5f 50 53 30 00 4c 44  .a......._PS0.LD
  34c0: 52 53 0a 02 0a 30 0a 01 14 10 5f 50 53 33 00 4c  RS...0...._PS3.L
  34d0: 44 52 53 0a 02 0a 30 0a 00 14 49 17 5f 50 52 53  DRS...0...I._PRS
  34e0: 00 a4 11 40 17 0b 6b 01 30 47 01 f8 03 f8 03 08  ...@..k.0G......
  34f0: 08 22 10 00 2a 01 00 30 47 01 f8 02 f8 02 08 08  ."..*..0G.......
  3500: 22 08 00 2a 01 00 30 47 01 e8 03 e8 03 08 08 22  "..*..0G......."
  3510: 10 00 2a 01 00 30 47 01 e8 02 e8 02 08 08 22 08  ..*..0G.......".
  3520: 00 2a 01 00 30 47 01 f8 03 f8 03 08 08 22 08 00  .*..0G......."..
  3530: 2a 01 00 30 47 01 f8 02 f8 02 08 08 22 10 00 2a  *..0G......."..*
  3540: 01 00 30 47 01 e8 03 e8 03 08 08 22 08 00 2a 01  ..0G......."..*.
  3550: 00 30 47 01 e8 02 e8 02 08 08 22 10 00 2a 01 00  .0G......."..*..
  3560: 30 47 01 f8 03 f8 03 08 08 22 10 00 2a 02 00 30  0G......."..*..0
  3570: 47 01 f8 02 f8 02 08 08 22 08 00 2a 02 00 30 47  G......."..*..0G
  3580: 01 e8 03 e8 03 08 08 22 10 00 2a 02 00 30 47 01  ......."..*..0G.
  3590: e8 02 e8 02 08 08 22 08 00 2a 02 00 30 47 01 f8  ......"..*..0G..
  35a0: 03 f8 03 08 08 22 08 00 2a 02 00 30 47 01 f8 02  ....."..*..0G...
  35b0: f8 02 08 08 22 10 00 2a 02 00 30 47 01 e8 03 e8  ...."..*..0G....
  35c0: 03 08 08 22 08 00 2a 02 00 30 47 01 e8 02 e8 02  ..."..*..0G.....
  35d0: 08 08 22 10 00 2a 02 00 30 47 01 f8 03 f8 03 08  .."..*..0G......
  35e0: 08 22 10 00 2a 08 00 30 47 01 f8 02 f8 02 08 08  ."..*..0G.......
  35f0: 22 08 00 2a 08 00 30 47 01 e8 03 e8 03 08 08 22  "..*..0G......."
  3600: 10 00 2a 08 00 30 47 01 e8 02 e8 02 08 08 22 08  ..*..0G.......".
  3610: 00 2a 08 00 30 47 01 f8 03 f8 03 08 08 22 08 00  .*..0G......."..
  3620: 2a 08 00 30 47 01 f8 02 f8 02 08 08 22 10 00 2a  *..0G......."..*
  3630: 08 00 30 47 01 e8 03 e8 03 08 08 22 08 00 2a 08  ..0G......."..*.
  3640: 00 30 47 01 e8 02 e8 02 08 08 22 10 00 2a 08 00  .0G......."..*..
  3650: 38 79 00 14 10 5f 44 49 53 00 4c 44 52 53 0a 02  8y..._DIS.LDRS..
  3660: 0a 30 0a 00 14 4b 0a 5f 43 52 53 00 08 44 43 52  .0...K._CRS..DCR
  3670: 53 11 13 0a 10 47 01 f8 02 f8 02 08 08 22 08 00  S....G......."..
  3680: 2a 01 00 79 00 70 4c 44 52 47 0a 02 0a 60 61 70  *..y.pLDRG...`ap
  3690: 4c 44 52 47 0a 02 0a 61 60 70 60 88 44 43 52 53  LDRG...a`p`.DCRS
  36a0: 0a 02 00 70 60 88 44 43 52 53 0a 04 00 70 61 88  ...p`.DCRS...pa.
  36b0: 44 43 52 53 0a 03 00 70 61 88 44 43 52 53 0a 05  DCRS...pa.DCRS..
  36c0: 00 79 0a 01 4c 44 52 47 0a 02 0a 70 60 70 60 88  .y..LDRG...p`p`.
  36d0: 44 43 52 53 0a 09 00 7a 60 0a 08 61 70 61 88 44  DCRS...z`..apa.D
  36e0: 43 52 53 0a 0a 00 79 0a 01 4c 44 52 47 0a 02 0a  CRS...y..LDRG...
  36f0: 74 60 70 60 88 44 43 52 53 0a 0c 00 7a 60 0a 08  t`p`.DCRS...z`..
  3700: 61 70 61 88 44 43 52 53 0a 0d 00 a4 44 43 52 53  apa.DCRS....DCRS
  3710: 14 4f 07 5f 53 52 53 01 8c 68 0a 02 41 44 52 4c  .O._SRS..h..ADRL
  3720: 8c 68 0a 03 41 44 52 4d 8b 68 0a 09 49 52 51 4d  .h..ADRM.h..IRQM
  3730: 8b 68 0a 0c 44 4d 41 4d 82 49 52 51 4d 60 76 60  .h..DMAM.IRQM`v`
  3740: 82 44 4d 41 4d 61 76 61 4c 44 52 53 0a 02 0a 70  .DMAMavaLDRS...p
  3750: 60 4c 44 52 53 0a 02 0a 74 61 4c 44 52 53 0a 02  `LDRS...taLDRS..
  3760: 0a 60 41 44 52 4d 4c 44 52 53 0a 02 0a 61 41 44  .`ADRMLDRS...aAD
  3770: 52 4c 50 44 52 53 0a 02 72 79 41 44 52 4d 0a 08  RLPDRS..ryADRM..
  3780: 00 41 44 52 4c 00 4c 44 52 53 0a 02 0a 30 0a 01  .ADRL.LDRS...0..
  3790: 5b 82 48 a8 45 43 30 5f 08 5f 48 49 44 0c 41 d0  [.H.EC0_._HID.A.
  37a0: 0c 09 08 5f 43 52 53 11 15 0a 12 47 01 62 00 62  ..._CRS....G.b.b
  37b0: 00 01 01 47 01 66 00 66 00 01 01 79 00 08 5f 47  ...G.f.f...y.._G
  37c0: 50 45 0a 1d 08 4f 53 45 4a 0a 00 5b 82 39 53 4d  PE...OSEJ..[.9SM
  37d0: 42 43 08 5f 48 49 44 0d 41 43 50 49 30 30 30 31  BC._HID.ACPI0001
  37e0: 00 08 5f 45 43 5f 0b 20 18 5b 82 1b 53 42 53 30  .._EC_. .[..SBS0
  37f0: 08 5f 48 49 44 0d 41 43 50 49 30 30 30 32 00 08  ._HID.ACPI0002..
  3800: 5f 53 42 53 0a 02 14 45 0e 5f 52 45 47 02 a0 4d  _SBS...E._REG..M
  3810: 0d 93 68 0a 03 70 69 5c 2e 5f 53 42 5f 4f 4b 45  ..h..pi\._SB_OKE
  3820: 43 70 69 5c 2e 5f 53 42 5f 45 43 4f 4b a0 4e 0b  Cpi\._SB_ECOK.N.
  3830: 7d 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f  }.\/._SB_PCI0MYO
  3840: 53 0a 03 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d  S...\/._SB_PCI0M
  3850: 59 4f 53 0a 01 00 a0 1c 69 70 0a 01 5c 2f 05 5f  YOS.....ip..\/._
  3860: 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 52  SB_PCI0LPC0EC0_R
  3870: 47 35 37 70 5c 2e 5f 53 42 5f 57 4c 45 53 5c 2f  G57p\._SB_WLES\/
  3880: 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30  ._SB_PCI0LPC0EC0
  3890: 5f 57 45 53 54 70 5c 2e 5f 53 42 5f 42 54 45 53  _WESTp\._SB_BTES
  38a0: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45  \/._SB_PCI0LPC0E
  38b0: 43 30 5f 42 45 53 54 70 01 5c 2f 05 5f 53 42 5f  C0_BESTp.\/._SB_
  38c0: 50 43 49 30 4c 50 43 30 45 43 30 5f 57 42 49 4e  PCI0LPC0EC0_WBIN
  38d0: 70 44 4f 46 46 5c 2f 05 5f 53 42 5f 50 43 49 30  pDOFF\/._SB_PCI0
  38e0: 4c 50 43 30 45 43 30 5f 54 4d 4f 46 5b 80 45 52  LPC0EC0_TMOF[.ER
  38f0: 41 4d 03 0a 00 0a ff 5b 81 4f 2a 45 52 41 4d 01  AM.....[.O*ERAM.
  3900: 00 20 43 4d 43 4d 08 43 4d 44 31 08 43 4d 44 32  . CMCM.CMD1.CMD2
  3910: 08 43 4d 44 33 08 00 40 08 53 4d 50 52 08 53 4d  .CMD3..@.SMPR.SM
  3920: 53 54 08 53 4d 41 44 08 53 4d 43 4d 08 53 4d 44  ST.SMAD.SMCM.SMD
  3930: 30 40 10 42 43 4e 54 08 53 4d 41 41 08 42 41 54  0@.BCNT.SMAA.BAT
  3940: 44 10 41 43 44 46 01 00 07 00 04 46 50 52 31 01  D.ACDF.....FPR1.
  3950: 53 34 4c 44 01 53 35 4c 57 01 50 46 4c 47 01 00  S4LD.S5LW.PFLG..
  3960: 08 54 4d 53 53 02 00 02 42 41 4e 4b 04 00 08 56  .TMSS...BANK...V
  3970: 46 41 4e 01 00 07 52 4c 30 31 01 52 44 30 31 01  FAN...RL01.RD01.
  3980: 52 46 30 31 01 52 50 30 31 01 52 42 30 31 01 52  RF01.RP01.RB01.R
  3990: 43 30 31 01 00 01 52 37 30 31 01 52 38 30 31 01  C01...R701.R801.
  39a0: 52 4d 30 31 01 52 49 30 31 01 00 01 00 01 00 01  RM01.RI01.......
  39b0: 52 41 30 31 01 52 52 30 31 01 52 4c 31 30 01 52  RA01.RR01.RL10.R
  39c0: 44 31 30 01 52 46 31 30 01 52 50 31 30 01 52 42  D10.RF10.RP10.RB
  39d0: 31 30 01 52 43 31 30 01 00 01 52 37 31 30 01 52  10.RC10...R710.R
  39e0: 38 31 30 01 52 4d 31 30 01 52 49 31 30 01 00 01  810.RM10.RI10...
  39f0: 00 01 00 01 52 41 31 30 01 52 52 31 30 01 4c 49  ....RA10.RR10.LI
  3a00: 44 45 01 44 42 32 45 01 52 50 54 45 01 57 50 30  DE.DB2E.RPTE.WP0
  3a10: 31 01 57 42 30 31 01 57 43 30 31 01 00 01 57 37  1.WB01.WC01...W7
  3a20: 30 31 01 57 38 30 31 01 57 4d 30 31 01 57 49 30  01.W801.WM01.WI0
  3a30: 31 01 00 01 00 01 00 01 57 41 30 31 01 57 52 30  1.......WA01.WR0
  3a40: 31 01 4c 49 44 53 01 44 42 32 53 01 52 50 54 53  1.LIDS.DB2S.RPTS
  3a50: 01 57 50 31 30 01 57 42 31 30 01 57 43 31 30 01  .WP10.WB10.WC10.
  3a60: 00 01 57 37 31 30 01 57 38 31 30 01 57 4d 31 30  ..W710.W810.WM10
  3a70: 01 57 49 31 30 01 00 01 00 01 00 01 57 41 31 30  .WI10.......WA10
  3a80: 01 57 52 31 30 01 00 01 42 41 59 45 01 45 46 44  .WR10...BAYE.EFD
  3a90: 45 01 50 52 44 45 01 42 52 42 45 01 41 44 49 4d  E.PRDE.BRBE.ADIM
  3aa0: 01 00 01 57 37 42 45 01 57 38 42 45 01 50 4d 45  ...W7BE.W8BE.PME
  3ab0: 45 01 49 4e 54 45 01 00 01 00 01 00 01 00 01 44  E.INTE.........D
  3ac0: 42 33 45 01 00 10 00 01 42 41 59 53 01 45 46 44  B3E.....BAYS.EFD
  3ad0: 53 01 50 52 44 53 01 42 52 42 53 01 43 52 54 53  S.PRDS.BRBS.CRTS
  3ae0: 01 00 01 57 37 42 53 01 54 4d 4f 46 08 00 18 52  ...W7BS.TMOF...R
  3af0: 47 35 37 08 43 54 4d 50 08 52 47 35 39 08 52 47  G57.CTMP.RG59.RG
  3b00: 35 41 08 52 47 35 42 08 46 53 50 44 10 00 08 57  5A.RG5B.FSPD...W
  3b10: 45 53 54 01 42 45 53 54 01 57 42 49 4e 01 00 05  EST.BEST.WBIN...
  3b20: 00 01 46 41 4e 43 01 00 4e 07 4d 42 49 44 08 4d  ..FANC..N.MBID.M
  3b30: 42 54 53 01 4d 42 54 46 01 00 06 4d 42 54 43 01  BTS.MBTF...MBTC.
  3b40: 00 27 42 41 31 43 08 4d 42 56 47 10 4d 43 55 52  .'BA1C.MBVG.MCUR
  3b50: 10 00 20 53 42 49 44 08 53 42 54 53 01 53 42 54  .. SBID.SBTS.SBT
  3b60: 46 01 00 06 53 42 54 43 01 00 27 42 41 32 43 08  F...SBTC..'BA2C.
  3b70: 41 42 56 47 10 41 43 55 52 10 00 48 1b 4d 42 52  ABVG.ACUR..H.MBR
  3b80: 4d 10 00 28 41 42 52 4d 10 00 20 45 42 50 4c 01  M..(ABRM.. EBPL.
  3b90: 00 0f 00 06 41 50 57 52 01 00 19 44 42 50 4c 08  ....APWR...DBPL.
  3ba0: 00 40 08 47 51 4b 53 07 5b 81 0e 45 52 41 4d 01  .@.GQKS.[..ERAM.
  3bb0: 00 40 0e 53 4d 57 30 10 5b 81 0e 45 52 41 4d 01  .@.SMW0.[..ERAM.
  3bc0: 00 40 0e 53 4d 42 30 08 5b 81 0f 45 52 41 4d 01  .@.SMB0.[..ERAM.
  3bd0: 00 40 0e 46 4c 44 30 40 04 5b 81 0f 45 52 41 4d  .@.FLD0@.[..ERAM
  3be0: 01 00 40 0e 46 4c 44 31 40 08 5b 81 0f 45 52 41  ..@.FLD1@.[..ERA
  3bf0: 4d 01 00 40 0e 46 4c 44 32 40 0c 5b 81 0f 45 52  M..@.FLD2@.[..ER
  3c00: 41 4d 01 00 40 0e 46 4c 44 33 40 10 14 13 42 50  AM..@.FLD3@...BP
  3c10: 4f 4c 01 70 68 44 42 50 4c 70 0a 01 45 42 50 4c  OL.phDBPLp..EBPL
  3c20: 08 45 43 55 53 0a 00 08 42 41 54 4f 0a 00 08 42  .ECUS...BATO...B
  3c30: 41 54 4e 0a 00 08 42 41 54 46 0a c0 14 22 5f 51  ATN...BATF..."_Q
  3c40: 30 39 00 a0 0a 93 87 5c 5f 4f 53 5f 0a 14 a0 10  09.....\_OS_....
  3c50: 93 87 5c 5f 4f 53 5f 0a 14 42 50 4f 4c 0a 3c 14  ..\_OS_..BPOL.<.
  3c60: 27 5f 51 32 30 00 a0 20 7b 53 4d 53 54 0a 40 00  '_Q20.. {SMST.@.
  3c70: 70 53 4d 41 41 60 a0 10 93 60 0a 14 7b 53 4d 53  pSMAA`...`..{SMS
  3c80: 54 0a bf 53 4d 53 54 14 48 11 53 45 4c 45 00 70  T..SMST.H.SELE.p
  3c90: 42 41 54 44 42 41 54 4e 70 0a 00 42 41 54 46 a0  BATDBATNp..BATF.
  3ca0: 14 7b 0a c0 42 41 54 4e 00 7d 42 41 54 46 0a 01  .{..BATN.}BATF..
  3cb0: 42 41 54 46 a0 15 7b 0b 00 03 42 41 54 4e 00 7d  BATF..{...BATN.}
  3cc0: 42 41 54 46 0a 04 42 41 54 46 7b 42 41 54 4e 0a  BATF..BATF{BATN.
  3cd0: 01 60 7b 42 41 54 4f 0a 01 61 a0 0e 60 7d 42 41  .`{BATO..a..`}BA
  3ce0: 54 46 0b 00 01 42 41 54 46 a1 0d 7b 42 41 54 46  TF...BATF..{BATF
  3cf0: 0b ff fe 42 41 54 46 a0 11 80 93 60 61 00 7d 42  ...BATF....`a.}B
  3d00: 41 54 46 0a 40 42 41 54 46 7b 42 41 54 4e 0a 02  ATF.@BATF{BATN..
  3d10: 60 7b 42 41 54 4f 0a 02 61 a0 0e 60 7d 42 41 54  `{BATO..a..`}BAT
  3d20: 46 0b 00 02 42 41 54 46 a1 0d 7b 42 41 54 46 0b  F...BATF..{BATF.
  3d30: ff fd 42 41 54 46 a0 11 80 93 60 61 00 7d 42 41  ..BATF....`a.}BA
  3d40: 54 46 0a 80 42 41 54 46 7b 42 41 54 4e 0a c0 60  TF..BATF{BATN..`
  3d50: 7b 42 41 54 4f 0a c0 61 a0 11 80 93 60 61 00 7d  {BATO..a....`a.}
  3d60: 42 41 54 46 0a 02 42 41 54 46 a0 35 7b 0a 01 42  BATF..BATF.5{..B
  3d70: 41 54 46 00 a0 2b 7b 0a 04 42 41 54 46 00 a0 14  ATF..+{..BATF...
  3d80: 7b 42 41 54 4e 0a 20 00 7d 42 41 54 46 0a 10 42  {BATN. .}BATF..B
  3d90: 41 54 46 a1 0c 7d 42 41 54 46 0a 20 42 41 54 46  ATF..}BATF. BATF
  3da0: 14 31 5f 51 30 44 00 70 0d 53 6c 65 65 70 20 42  .1_Q0D.p.Sleep B
  3db0: 75 74 74 6f 6e 20 51 75 65 72 79 3a 20 46 6e 2b  utton Query: Fn+
  3dc0: 46 34 00 5b 31 86 5c 2e 5f 53 42 5f 53 4c 50 42  F4.[1.\._SB_SLPB
  3dd0: 0a 80 14 1d 5f 51 30 45 00 5c 2f 05 5f 53 42 5f  ...._Q0E.\/._SB_
  3de0: 50 43 49 30 41 47 50 5f 56 47 41 5f 53 57 49 48  PCI0AGP_VGA_SWIH
  3df0: 14 4c 04 5f 51 31 33 00 70 0d 42 72 69 67 68 74  .L._Q13.p.Bright
  3e00: 6e 65 73 73 20 55 70 3a 20 46 6e 2b 2d 3e 00 5b  ness Up: Fn+->.[
  3e10: 31 70 0a 8c 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  1p..\/._SB_PCI0L
  3e20: 50 43 30 42 43 4d 44 70 0a 00 5c 2f 04 5f 53 42  PC0BCMDp..\/._SB
  3e30: 5f 50 43 49 30 4c 50 43 30 53 4d 49 43 14 4e 04  _PCI0LPC0SMIC.N.
  3e40: 5f 51 31 32 00 70 0d 42 72 69 67 68 74 6e 65 73  _Q12.p.Brightnes
  3e50: 73 20 44 6f 77 6e 3a 20 46 6e 2b 3c 2d 00 5b 31  s Down: Fn+<-.[1
  3e60: 70 0a 8d 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  3e70: 43 30 42 43 4d 44 70 0a 00 5c 2f 04 5f 53 42 5f  C0BCMDp..\/._SB_
  3e80: 50 43 49 30 4c 50 43 30 53 4d 49 43 14 34 5f 51  PCI0LPC0SMIC.4_Q
  3e90: 38 30 00 70 0d 54 65 6d 70 65 72 61 74 75 72 65  80.p.Temperature
  3ea0: 20 69 6e 63 72 65 61 73 69 6e 67 3a 20 5f 51 38   increasing: _Q8
  3eb0: 30 00 5b 31 86 5c 2e 5f 54 5a 5f 54 48 52 4d 0a  0.[1.\._TZ_THRM.
  3ec0: 80 14 34 5f 51 38 31 00 70 0d 54 65 6d 70 65 72  ..4_Q81.p.Temper
  3ed0: 61 74 75 72 65 20 64 65 63 72 65 61 73 69 6e 67  ature decreasing
  3ee0: 3a 20 5f 51 38 31 00 5b 31 86 5c 2e 5f 54 5a 5f  : _Q81.[1.\._TZ_
  3ef0: 54 48 52 4d 0a 80 5b 02 45 4a 54 31 14 4d 31 5f  THRM..[.EJT1.M1_
  3f00: 51 38 41 00 5b 01 4d 55 54 30 00 5b 01 4d 55 54  Q8A.[.MUT0.[.MUT
  3f10: 31 00 70 0d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d  1.p.------------
  3f20: 2d 2d 2d 2d 2d 2d 5f 51 30 78 38 41 20 2d 2d 2d  ------_Q0x8A ---
  3f30: 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d  ----------------
  3f40: 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d  ----------------
  3f50: 2d 2d 2d 00 5b 31 a0 19 4c 49 44 45 70 0a 01 4c  ---.[1..LIDEp..L
  3f60: 49 44 45 86 5c 2e 5f 53 42 5f 4c 49 44 5f 0a 80  IDE.\._SB_LID_..
  3f70: a0 49 2a 44 42 32 45 70 0d 2d 2d 2d 2d 2d 2d 2d  .I*DB2Ep.-------
  3f80: 2d 20 44 65 76 69 63 65 20 52 2d 42 61 79 20 45  - Device R-Bay E
  3f90: 76 65 6e 74 20 2d 2d 2d 2d 2d 2d 00 5b 31 70 0a  vent ------.[1p.
  3fa0: 01 44 42 32 45 70 0a b1 50 38 30 48 a0 4d 26 7d  .DB2Ep..P80H.M&}
  3fb0: 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53  .\/._SB_PCI0MYOS
  3fc0: 0a 01 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59  ...\/._SB_PCI0MY
  3fd0: 4f 53 0a 03 00 a0 44 1b 44 42 32 53 70 0a b2 50  OS....D.DB2Sp..P
  3fe0: 38 30 48 70 0d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d  80Hp.-----------
  3ff0: 20 44 65 76 69 63 65 20 42 61 79 20 43 68 61 6e   Device Bay Chan
  4000: 67 65 20 53 74 61 74 75 73 20 2d 2d 2d 2d 2d 2d  ge Status ------
  4010: 2d 2d 2d 2d 20 49 4e 20 00 5b 31 70 5c 2f 04 5f  ---- IN .[1p\/._
  4020: 53 42 5f 50 43 49 30 4c 50 43 30 52 42 49 44 60  SB_PCI0LPC0RBID`
  4030: 70 60 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44 45  p`\/._SB_PCI0IDE
  4040: 30 42 41 59 52 a0 26 93 60 0a 00 70 0a b4 50 38  0BAYR.&.`..p..P8
  4050: 30 48 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30  0Hp..\/._SB_PCI0
  4060: 4c 50 43 30 4c 56 33 37 5b 22 0a c8 a1 4d 11 70  LPC0LV37["...M.p
  4070: 0a b5 50 38 30 48 70 0a 00 5c 2f 04 5f 53 42 5f  ..P80Hp..\/._SB_
  4080: 50 43 49 30 4c 50 43 30 4c 56 33 37 5b 22 0a 64  PCI0LPC0LV37[".d
  4090: 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  40a0: 43 30 4c 56 33 39 5b 22 0a c8 70 0a 01 5c 2f 04  C0LV39["..p..\/.
  40b0: 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 56 33 39  _SB_PCI0LPC0LV39
  40c0: 5b 22 0b c4 09 5b 22 0a c8 5b 22 0a c8 5b 22 0a  ["...["..["..[".
  40d0: 64 70 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30 49  dp..\/._SB_PCI0I
  40e0: 44 45 30 53 53 49 47 70 0a 01 5c 2f 04 5f 53 42  DE0SSIGp..\/._SB
  40f0: 5f 50 43 49 30 49 44 45 30 55 44 43 31 70 0a 02  _PCI0IDE0UDC1p..
  4100: 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44 45 30 55  \/._SB_PCI0IDE0U
  4110: 44 54 31 7d 5c 2f 04 5f 53 42 5f 50 43 49 30 49  DT1}\/._SB_PCI0I
  4120: 44 45 30 46 53 43 42 0a 04 5c 2f 04 5f 53 42 5f  DE0FSCB..\/._SB_
  4130: 50 43 49 30 49 44 45 30 46 53 43 42 70 0b 03 e3  PCI0IDE0FSCBp...
  4140: 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44 45 30 49  \/._SB_PCI0IDE0I
  4150: 54 4d 31 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49  TM1p..\/._SB_PCI
  4160: 30 49 44 45 30 53 53 49 47 86 5c 2f 05 5f 53 42  0IDE0SSIG.\/._SB
  4170: 5f 50 43 49 30 49 44 45 30 53 45 43 4e 42 41 59  _PCI0IDE0SECNBAY
  4180: 31 0a 00 70 0a b6 50 38 30 48 a1 4f 08 70 0a b7  1..p..P80H.O.p..
  4190: 50 38 30 48 70 0d 2d 2d 2d 2d 2d 2d 2d 2d 20 44  P80Hp.-------- D
  41a0: 65 76 69 63 65 20 42 61 79 20 45 76 65 6e 74 20  evice Bay Event 
  41b0: 2d 2d 2d 2d 2d 2d 20 4f 55 54 20 00 5b 31 70 5c  ------ OUT .[1p\
  41c0: 2f 04 5f 53 42 5f 50 43 49 30 49 44 45 30 42 41  /._SB_PCI0IDE0BA
  41d0: 59 52 60 70 0a 01 5c 2f 04 5f 53 42 5f 50 43 49  YR`p..\/._SB_PCI
  41e0: 30 4c 50 43 30 4c 56 33 37 5b 22 0a c8 a0 2c 7d  0LPC0LV37["...,}
  41f0: 93 60 0a 01 93 60 0a 02 00 86 5c 2f 05 5f 53 42  .`...`....\/._SB
  4200: 5f 50 43 49 30 49 44 45 30 53 45 43 4e 42 41 59  _PCI0IDE0SECNBAY
  4210: 31 0a 01 70 0a b8 50 38 30 48 5b 80 53 4d 49 30  1..p..P80H[.SMI0
  4220: 01 0c 00 fe 00 00 0c 02 00 00 00 5b 81 0b 53 4d  ...........[..SM
  4230: 49 30 00 53 4d 49 43 08 5b 80 53 4d 49 31 00 0c  I0.SMIC.[.SMI1..
  4240: bd ce ef 1f 0c 90 00 00 00 5b 81 16 53 4d 49 31  .........[..SMI1
  4250: 00 42 43 4d 44 08 44 49 44 5f 20 49 4e 46 4f 40  .BCMD.DID_ INFO@
  4260: 40 5b 81 10 53 4d 49 31 00 01 01 00 00 28 49 4e  @[..SMI1.....(IN
  4270: 46 5f 08 5b 82 1b 4d 44 4d 30 08 5f 41 44 52 0c  F_.[..MDM0._ADR.
  4280: 06 00 1f 00 08 5f 50 52 57 12 06 02 0a 05 0a 03  ....._PRW.......
  4290: 5b 82 85 16 01 49 44 45 30 08 5f 41 44 52 0c 01  [....IDE0._ADR..
  42a0: 00 1f 00 5b 80 50 43 49 5f 02 0a 00 0a 58 5b 81  ...[.PCI_....X[.
  42b0: 44 04 50 43 49 5f 03 00 18 00 07 53 49 44 45 01  D.PCI_.....SIDE.
  42c0: 00 40 1f 00 01 45 49 4f 52 01 00 0d 45 53 49 44  .@...EIOR...ESID
  42d0: 01 00 20 55 4d 41 30 01 55 4d 41 31 01 55 4d 41  .. UMA0.UMA1.UMA
  42e0: 32 01 55 4d 41 33 01 00 4c 06 50 53 49 47 02 53  2.UMA3..L.PSIG.S
  42f0: 53 49 47 02 5b 81 45 06 50 43 49 5f 03 00 40 20  SIG.[.E.PCI_..@ 
  4300: 49 54 4d 30 10 49 54 4d 31 10 53 49 54 30 04 53  ITM0.ITM1.SIT0.S
  4310: 49 54 31 04 00 18 55 44 43 30 02 55 44 43 31 02  IT1...UDC0.UDC1.
  4320: 00 0c 55 44 54 30 08 55 44 54 31 08 00 40 04 49  ..UDT0.UDT1..@.I
  4330: 43 46 30 02 49 43 46 31 02 43 42 38 30 04 00 02  CF0.ICF1.CB80...
  4340: 57 50 50 45 01 00 01 46 53 43 42 04 54 52 49 50  WPPE...FSCB.TRIP
  4350: 02 54 52 49 53 02 46 41 54 53 04 08 54 49 4d 30  .TRIS.FATS..TIM0
  4360: 12 11 01 12 0e 05 0a 78 0a b4 0a f0 0b 86 01 0b  .......x........
  4370: 58 02 08 54 49 4d 31 12 0c 01 12 09 03 0a 78 0a  X..TIM1.......x.
  4380: 96 0b fe 01 08 54 49 4d 32 12 11 01 12 0e 06 0a  .....TIM2.......
  4390: 18 0a 1e 0a 2d 0a 3c 0a 5a 0a 78 08 41 54 30 31  ....-.<.Z.x.AT01
  43a0: 11 0a 0a 07 03 00 00 00 00 00 ef 08 41 54 30 32  ............AT02
  43b0: 11 0a 0a 07 00 00 00 00 00 00 90 08 41 54 30 33  ............AT03
  43c0: 11 0a 0a 07 00 00 00 00 00 00 c6 08 41 54 30 34  ............AT04
  43d0: 11 0a 0a 07 00 00 00 00 00 00 91 08 41 54 41 30  ............ATA0
  43e0: 11 03 0a 1d 08 41 54 41 31 11 03 0a 1d 08 41 54  .....ATA1.....AT
  43f0: 41 32 11 03 0a 1d 08 41 54 41 33 11 03 0a 1d 08  A2.....ATA3.....
  4400: 41 54 41 42 11 03 0a 0e 08 43 4d 44 43 0a 00 08  ATAB.....CMDC...
  4410: 42 41 59 52 0a 00 14 1e 5f 49 4e 49 00 70 5c 2f  BAYR...._INI.p\/
  4420: 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 52 42 49  ._SB_PCI0LPC0RBI
  4430: 44 42 41 59 52 14 47 05 47 54 46 42 0b 77 43 4d  DBAYR.G.GTFB.wCM
  4440: 44 43 0a 38 60 5b 13 41 54 41 42 60 0a 38 43 4d  DC.8`[.ATAB`.8CM
  4450: 44 58 77 43 4d 44 43 0a 07 60 8c 41 54 41 42 72  DXwCMDC..`.ATABr
  4460: 60 0a 01 00 41 30 30 31 8c 41 54 41 42 72 60 0a  `...A001.ATABr`.
  4470: 05 00 41 30 30 35 70 68 43 4d 44 58 70 69 41 30  ..A005phCMDXpiA0
  4480: 30 31 70 6a 41 30 30 35 75 43 4d 44 43 5b 01 47  01pjA005uCMDC[.G
  4490: 54 46 4d 00 14 4e 20 47 54 46 5f 0b 5b 23 47 54  TFM..N GTF_.[#GT
  44a0: 46 4d ff ff 8a 6a 0a 00 50 49 4f 30 8a 6a 0a 04  FM...j..PIO0.j..
  44b0: 44 4d 41 30 8a 6a 0a 08 50 49 4f 31 8a 6a 0a 0c  DMA0.j..PIO1.j..
  44c0: 44 4d 41 31 8a 6a 0a 10 43 48 4e 46 70 0a 00 43  DMA1.j..CHNFp..C
  44d0: 4d 44 43 08 49 44 30 30 0a 80 08 49 44 34 39 0b  MDC.ID00...ID49.
  44e0: 00 0c 08 49 44 35 39 0a 00 08 49 44 35 33 0a 04  ...ID59...ID53..
  44f0: 08 49 44 36 33 0b 00 0f 08 49 44 38 38 0b 00 0f  .ID63....ID88...
  4500: 08 49 52 44 59 0a 01 08 50 49 4f 54 0a 00 08 44  .IRDY...PIOT...D
  4510: 4d 41 54 0a 00 a0 4e 06 93 87 69 0b 00 02 8c 69  MAT...N...i....i
  4520: 0a 00 49 42 30 30 70 49 42 30 30 49 44 30 30 8b  ..IB00pIB00ID00.
  4530: 69 0a 62 49 57 34 39 70 49 57 34 39 49 44 34 39  i.bIW49pIW49ID49
  4540: 8b 69 0a 6a 49 57 35 33 70 49 57 35 33 49 44 35  .i.jIW53pIW53ID5
  4550: 33 8b 69 0a 7e 49 57 36 33 70 49 57 36 33 49 44  3.i.~IW63pIW63ID
  4560: 36 33 8b 69 0a 76 49 57 35 39 70 49 57 35 39 49  63.i.vIW59pIW59I
  4570: 44 35 39 8b 69 0a b0 49 57 38 38 70 49 57 38 38  D59.i..IW88pIW88
  4580: 49 44 38 38 a1 06 a4 41 54 41 42 70 0a a0 67 a0  ID88...ATABp..g.
  4590: 48 05 68 70 0a b0 67 7b 43 48 4e 46 0a 08 49 52  H.hp..g{CHNF..IR
  45a0: 44 59 a0 12 7b 43 48 4e 46 0a 10 00 70 50 49 4f  DY..{CHNF...pPIO
  45b0: 31 50 49 4f 54 a1 0a 70 50 49 4f 30 50 49 4f 54  1PIOT..pPIO0PIOT
  45c0: a0 27 7b 43 48 4e 46 0a 04 00 a0 12 7b 43 48 4e  .'{CHNF.....{CHN
  45d0: 46 0a 10 00 70 44 4d 41 31 44 4d 41 54 a1 0a 70  F...pDMA1DMAT..p
  45e0: 44 4d 41 30 44 4d 41 54 a1 28 7b 43 48 4e 46 0a  DMA0DMAT.({CHNF.
  45f0: 02 49 52 44 59 70 50 49 4f 30 50 49 4f 54 a0 12  .IRDYpPIO0PIOT..
  4600: 7b 43 48 4e 46 0a 01 00 70 44 4d 41 30 44 4d 41  {CHNF...pDMA0DMA
  4610: 54 a0 36 90 7b 49 44 35 33 0a 04 00 7b 49 44 38  T.6.{ID53...{ID8
  4620: 38 0a ff 00 70 0a 00 61 7b 49 44 38 38 0a ff 62  8...p..a{ID88..b
  4630: a2 07 7a 62 61 00 75 61 76 61 47 54 46 42 41 54  ..zba.uavaGTFBAT
  4640: 30 31 7d 0a 40 61 00 67 a0 37 49 52 44 59 70 89  01}.@a.g.7IRDYp.
  4650: 83 88 54 49 4d 30 0a 00 00 04 50 49 4f 54 00 0a  ..TIM0....PIOT..
  4660: 00 0a 00 61 a0 08 93 61 ff 70 0a 04 61 74 0a 04  ...a...a.p..at..
  4670: 61 61 47 54 46 42 41 54 30 31 7d 0a 08 61 00 67  aaGTFBAT01}..a.g
  4680: a1 17 a0 15 7b 49 44 34 39 0b 00 04 00 47 54 46  ....{ID49....GTF
  4690: 42 41 54 30 31 0a 01 67 5b 27 47 54 46 4d a4 41  BAT01..g['GTFM.A
  46a0: 54 41 42 14 25 52 41 54 41 01 8c 68 0a 00 43 4d  TAB.%RATA..h..CM
  46b0: 44 4e 77 43 4d 44 4e 0a 38 60 5b 13 68 0a 08 60  DNwCMDN.8`[.h..`
  46c0: 52 45 54 42 a4 52 45 54 42 08 52 45 47 46 0a 01  RETB.RETB.REGF..
  46d0: 14 12 5f 52 45 47 02 a0 0b 93 68 0a 02 70 69 52  .._REG....h..piR
  46e0: 45 47 46 08 42 41 59 44 0a 00 14 09 5f 53 54 41  EGF.BAYD...._STA
  46f0: 00 a4 0a 0f 14 48 1b 47 54 4d 5f 06 70 11 03 0a  .....H.GTM_.p...
  4700: 14 60 8a 60 0a 00 50 49 4f 30 8a 60 0a 04 44 4d  .`.`..PIO0.`..DM
  4710: 41 30 8a 60 0a 08 50 49 4f 31 8a 60 0a 0c 44 4d  A0.`..PIO1.`..DM
  4720: 41 31 8a 60 0a 10 46 4c 41 47 a0 15 91 7b 68 0a  A1.`..FLAG...{h.
  4730: 08 00 92 7b 68 0a 01 00 70 0b 84 03 50 49 4f 30  ...{h...p...PIO0
  4740: a1 23 72 7a 7b 68 0b 00 03 00 0a 08 00 7a 7b 68  .#rz{h.......z{h
  4750: 0b 00 30 00 0a 0c 00 61 77 74 0a 09 61 00 0a 1e  ..0....awt..a...
  4760: 50 49 4f 30 a0 3b 7b 68 0b 00 40 00 a0 15 91 7b  PIO0.;{h..@....{
  4770: 68 0a 80 00 92 7b 68 0a 10 00 70 0b 84 03 50 49  h....{h...p...PI
  4780: 4f 31 a1 1d 72 7b 69 0a 03 00 7a 7b 69 0a 0c 00  O1..r{i...z{i...
  4790: 0a 02 00 61 77 74 0a 09 61 00 0a 1e 50 49 4f 31  ...awt..a...PIO1
  47a0: a1 0a 70 50 49 4f 30 50 49 4f 31 a0 38 7b 6a 0a  ..pPIO0PIO1.8{j.
  47b0: 01 00 a0 0d 7b 6d 0a 01 00 70 0a 08 44 4d 41 30  ....{m...p..DMA0
  47c0: a1 23 74 0a 04 7b 6b 0a 03 00 61 a0 0e 7b 6c 0a  .#t..{k...a..{l.
  47d0: 01 00 77 61 0a 0f 44 4d 41 30 a1 09 77 61 0a 1e  ..wa..DMA0..wa..
  47e0: 44 4d 41 30 a1 0a 70 50 49 4f 30 44 4d 41 30 a0  DMA0..pPIO0DMA0.
  47f0: 40 05 7b 68 0b 00 40 00 a0 3c 7b 6a 0a 02 00 a0  @.{h..@..<{j....
  4800: 0d 7b 6d 0a 02 00 70 0a 08 44 4d 41 31 a1 27 74  .{m...p..DMA1.'t
  4810: 0a 04 7a 7b 6b 0a 30 00 0a 04 00 61 a0 0e 7b 6c  ..z{k.0....a..{l
  4820: 0a 02 00 77 61 0a 0f 44 4d 41 31 a1 09 77 61 0a  ...wa..DMA1..wa.
  4830: 1e 44 4d 41 31 a1 0a 70 50 49 4f 31 44 4d 41 31  .DMA1..pPIO1DMA1
  4840: a1 0a 70 44 4d 41 30 44 4d 41 31 70 00 46 4c 41  ..pDMA0DMA1p.FLA
  4850: 47 a0 11 7b 68 0a 01 00 7d 46 4c 41 47 0a 10 46  G..{h...}FLAG..F
  4860: 4c 41 47 a0 11 7b 6a 0a 01 00 7d 46 4c 41 47 0a  LAG..{j...}FLAG.
  4870: 01 46 4c 41 47 a0 11 7b 68 0a 02 00 7d 46 4c 41  .FLAG..{h...}FLA
  4880: 47 0a 02 46 4c 41 47 a0 11 7b 6a 0a 02 00 7d 46  G..FLAG..{j...}F
  4890: 4c 41 47 0a 04 46 4c 41 47 a0 11 7b 68 0a 20 00  LAG..FLAG..{h. .
  48a0: 7d 46 4c 41 47 0a 08 46 4c 41 47 a4 60 14 41 52  }FLAG..FLAG.`.AR
  48b0: 53 54 4d 53 03 70 11 03 0a 18 67 8a 67 0a 00 49  STMS.p....g.g..I
  48c0: 54 4d 5f 8a 67 0a 04 53 49 54 5f 8a 67 0a 08 55  TM_.g..SIT_.g..U
  48d0: 44 43 5f 8a 67 0a 0c 55 44 54 5f 8a 67 0a 10 49  DC_.g..UDT_.g..I
  48e0: 43 46 5f 8a 67 0a 14 41 31 30 30 70 0a 01 57 50  CF_.g..A100p..WP
  48f0: 50 45 8a 68 0a 00 50 49 4f 30 8a 68 0a 04 44 4d  PE.h..PIO0.h..DM
  4900: 41 30 8a 68 0a 08 50 49 4f 31 8a 68 0a 0c 44 4d  A0.h..PIO1.h..DM
  4910: 41 31 8a 68 0a 10 46 4c 41 47 70 46 4c 41 47 64  A1.h..FLAGpFLAGd
  4920: 70 0b 00 40 60 08 57 34 39 4d 0a 00 08 57 35 33  p..@`.W49M...W53
  4930: 4d 0a 00 08 57 36 32 4d 0a 00 08 57 36 34 4d 0a  M...W62M...W64M.
  4940: 00 08 57 38 38 4d 0a 00 a0 41 08 93 87 69 0b 00  ..W88M...A...i..
  4950: 02 8a 69 0a 00 57 30 30 41 8a 69 0a 62 57 34 39  ..i..W00A.i.bW49
  4960: 41 8a 69 0a 6a 57 35 33 41 8a 69 0a 7c 57 36 32  A.i.jW53A.i.|W62
  4970: 41 8a 69 0a 80 57 36 34 41 8a 69 0a b0 57 38 38  A.i..W64A.i..W88
  4980: 41 70 57 34 39 41 57 34 39 4d 70 57 35 33 41 57  ApW49AW49MpW53AW
  4990: 35 33 4d 70 57 36 32 41 57 36 32 4d 70 57 36 34  53MpW62AW62MpW64
  49a0: 41 57 36 34 4d 70 57 38 38 41 57 38 38 4d a0 0b  AW64MpW88AW88M..
  49b0: 57 30 30 41 7d 60 0b 00 80 60 a0 0f 92 7b 57 30  W00A}`...`...{W0
  49c0: 30 41 0a 80 00 7d 60 0a 04 60 a1 24 70 0a 00 57  0A...}`..`.$p..W
  49d0: 34 39 4d 70 0a 00 57 35 33 4d 70 0a 00 57 36 32  49Mp..W53Mp..W62
  49e0: 4d 70 0a 00 57 36 34 4d 70 0a 00 57 38 38 4d 08  Mp..W64Mp..W88M.
  49f0: 57 34 39 53 0a 00 08 57 35 33 53 0a 00 08 57 36  W49S...W53S...W6
  4a00: 32 53 0a 00 08 57 36 34 53 0a 00 08 57 38 38 53  2S...W64S...W88S
  4a10: 0a 00 a0 41 08 93 87 6a 0b 00 02 8a 6a 0a 00 57  ...A...j....j..W
  4a20: 30 30 42 8a 6a 0a 62 57 34 39 42 8a 6a 0a 6a 57  00B.j.bW49B.j.jW
  4a30: 35 33 42 8a 6a 0a 7c 57 36 32 42 8a 6a 0a 80 57  53B.j.|W62B.j..W
  4a40: 36 34 42 8a 6a 0a b0 57 38 38 42 70 57 34 39 42  64B.j..W88BpW49B
  4a50: 57 34 39 53 70 57 35 33 42 57 35 33 53 70 57 36  W49SpW53BW53SpW6
  4a60: 32 42 57 36 32 53 70 57 36 34 42 57 36 34 53 70  2BW62SpW64BW64Sp
  4a70: 57 38 38 42 57 38 38 53 a0 0b 57 30 30 42 7d 60  W88BW88S..W00B}`
  4a80: 0b 00 80 60 a0 0f 92 7b 57 30 30 42 0a 80 00 7d  ...`...{W00B...}
  4a90: 60 0a 40 60 a1 24 70 0a 00 57 34 39 53 70 0a 00  `.@`.$p..W49Sp..
  4aa0: 57 35 33 53 70 0a 00 57 36 32 53 70 0a 00 57 36  W53Sp..W62Sp..W6
  4ab0: 34 53 70 0a 00 57 38 38 53 70 0a 00 41 31 30 30  4Sp..W88Sp..A100
  4ac0: a0 40 05 7b 0a 38 57 38 38 4d 00 a0 1e 7b 0a 20  .@.{.8W88M...{. 
  4ad0: 57 38 38 4d 00 70 0a 08 44 4d 41 30 7d 41 31 30  W88M.p..DMA0}A10
  4ae0: 30 0c 10 00 10 00 41 31 30 30 a1 26 a0 1b 7b 0a  0.....A100.&..{.
  4af0: 10 57 38 38 4d 00 70 0a 1e 44 4d 41 30 7d 41 31  .W88M.p..DMA0}A1
  4b00: 30 30 0a 10 41 31 30 30 a1 08 70 0a 2d 44 4d 41  00..A100..p.-DMA
  4b10: 30 a1 46 04 a0 43 04 7b 0a 07 57 38 38 4d 00 7d  0.F..C.{..W88M.}
  4b20: 0b 00 01 41 31 30 30 41 31 30 30 a0 10 7b 0a 04  ...A100A100..{..
  4b30: 57 38 38 4d 00 70 0a 3c 44 4d 41 30 a1 1b a0 10  W88M.p.<DMA0....
  4b40: 7b 0a 02 57 38 38 4d 00 70 0a 5a 44 4d 41 30 a1  {..W88M.p.ZDMA0.
  4b50: 08 70 0a 78 44 4d 41 30 a0 40 05 7b 0a 3f 57 38  .p.xDMA0.@.{.?W8
  4b60: 38 53 00 a0 1e 7b 0a 20 57 38 38 53 00 70 0a 08  8S...{. W88S.p..
  4b70: 44 4d 41 31 7d 41 31 30 30 0c 20 00 20 00 41 31  DMA1}A100. . .A1
  4b80: 30 30 a1 26 a0 1b 7b 0a 10 57 38 38 53 00 70 0a  00.&..{..W88S.p.
  4b90: 1e 44 4d 41 31 7d 41 31 30 30 0a 20 41 31 30 30  .DMA1}A100. A100
  4ba0: a1 08 70 0a 2d 44 4d 41 31 a0 15 90 7b 57 34 39  ..p.-DMA1...{W49
  4bb0: 4d 0b 00 08 00 7b 64 0a 02 00 7d 60 0a 02 60 a0  M....{d...}`..`.
  4bc0: 0e 95 50 49 4f 30 0b 84 03 7d 60 0a 01 60 a0 15  ..PIO0...}`..`..
  4bd0: 90 7b 57 34 39 53 0b 00 08 00 7b 64 0a 08 00 7d  .{W49S....{d...}
  4be0: 60 0a 20 60 a0 0e 95 50 49 4f 31 0b 84 03 7d 60  `. `...PIO1...}`
  4bf0: 0a 10 60 a0 0c 7b 64 0a 01 00 70 50 49 4f 30 61  ..`..{d...pPIO0a
  4c00: a1 07 70 44 4d 41 30 61 a0 0b 92 95 61 0a f0 7d  ..pDMA0a....a..}
  4c10: 60 0a 08 60 a1 42 04 a0 37 7b 57 35 33 4d 0a 02  `..`.B..7{W53M..
  4c20: 00 a0 15 90 7b 57 36 34 4d 0a 02 00 92 94 61 0a  ....{W64M.....a.
  4c30: 78 7d 60 0b 01 23 60 a1 17 a0 15 90 7b 57 36 34  x}`..#`.....{W64
  4c40: 4d 0a 01 00 92 94 61 0a b4 7d 60 0b 01 21 60 a1  M.....a..}`..!`.
  4c50: 07 7d 60 0b 01 10 60 70 60 49 54 4d 5f 70 00 60  .}`...`p`ITM_p.`
  4c60: a0 0c 7b 64 0a 04 00 70 50 49 4f 31 61 a1 07 70  ..{d...pPIO1a..p
  4c70: 44 4d 41 31 61 a0 41 06 7b 64 0a 10 00 a0 11 92  DMA1a.A.{d......
  4c80: 95 61 0a f0 7d 0a 80 49 54 4d 5f 49 54 4d 5f a1  .a..}..ITM_ITM_.
  4c90: 47 04 7d 0a 10 49 54 4d 5f 49 54 4d 5f a0 33 7b  G.}..ITM_ITM_.3{
  4ca0: 57 35 33 53 0a 02 00 a0 13 90 7b 57 36 34 53 0a  W53S......{W64S.
  4cb0: 02 00 92 94 61 0a 78 70 0a 0b 60 a1 15 a0 13 90  ....a.xp..`.....
  4cc0: 7b 57 36 34 53 0a 01 00 92 94 61 0a b4 70 0a 09  {W64S.....a..p..
  4cd0: 60 a1 05 70 0a 04 60 70 60 53 49 54 5f 70 0a 00  `..p..`p`SIT_p..
  4ce0: 60 a0 14 90 7b 0a 3f 57 38 38 4d 00 7b 64 0a 01  `...{.?W88M.{d..
  4cf0: 00 7d 60 0a 01 60 a0 0b 7b 64 0a 04 00 7d 60 0a  .}`..`..{d...}`.
  4d00: 02 60 70 60 55 44 43 5f 70 0a 00 60 a0 45 04 7b  .`p`UDC_p..`.E.{
  4d10: 64 0a 01 00 a0 19 95 44 4d 41 30 0a 1e 7d 41 31  d......DMA0..}A1
  4d20: 30 30 0b 00 10 41 31 30 30 7d 60 0a 01 60 a1 23  00...A100}`..`.#
  4d30: a0 11 95 44 4d 41 30 0a 3c 78 44 4d 41 30 0a 0f  ...DMA0.<xDMA0..
  4d40: 00 61 a1 0a 78 44 4d 41 30 0a 1e 00 61 74 0a 04  .a..xDMA0...at..
  4d50: 61 60 a0 4e 04 7b 64 0a 04 00 a0 19 95 44 4d 41  a`.N.{d......DMA
  4d60: 31 0a 1e 7d 41 31 30 30 0b 00 20 41 31 30 30 7d  1..}A100.. A100}
  4d70: 60 0a 10 60 a1 2c a0 11 95 44 4d 41 31 0a 3c 78  `..`.,...DMA1.<x
  4d80: 44 4d 41 31 0a 0f 00 61 a1 0a 78 44 4d 41 31 0a  DMA1...a..xDMA1.
  4d90: 1e 00 61 74 0a 04 61 61 79 61 0a 04 61 7d 60 61  ..at..aaya..a}`a
  4da0: 60 70 60 55 44 54 5f 70 0a 00 60 a0 0d 95 44 4d  `p`UDT_p..`...DM
  4db0: 41 30 0a 3c 7d 60 0a 01 60 a0 0d 95 44 4d 41 31  A0.<}`..`...DMA1
  4dc0: 0a 3c 7d 60 0a 02 60 70 60 49 43 46 5f a4 67 14  .<}`..`p`ICF_.g.
  4dd0: 49 0f 47 54 46 30 07 70 11 0a 0a 07 03 00 00 00  I.GTF0.p........
  4de0: 00 a0 ef 67 8c 67 0a 01 4d 4f 44 45 a0 2f 7b 6a  ...g.g..MODE./{j
  4df0: 0a 01 00 a0 0d 7b 6e 0a 01 00 70 0a 45 4d 4f 44  .....{n...p.EMOD
  4e00: 45 a1 1a 7b 6b 0a 03 60 a0 0b 7b 6c 0a 01 00 72  E..{k..`..{l...r
  4e10: 60 0a 02 60 7d 60 0a 40 4d 4f 44 45 a1 3e 72 7a  `..`}`.@MODE.>rz
  4e20: 7b 68 0b 00 03 00 0a 08 00 7a 7b 68 0b 00 30 00  {h.......z{h..0.
  4e30: 0a 0c 00 60 a0 0d 92 95 60 0a 05 70 0a 22 4d 4f  ...`....`..p."MO
  4e40: 44 45 a1 18 a0 0d 92 95 60 0a 03 70 0a 21 4d 4f  DE......`..p.!MO
  4e50: 44 45 a1 08 70 0a 20 4d 4f 44 45 73 67 67 66 a0  DE..p. MODEsggf.
  4e60: 24 91 7b 68 0a 08 00 92 7b 68 0a 01 00 a0 0d 7b  $.{h....{h.....{
  4e70: 68 0a 02 00 70 0a 00 4d 4f 44 45 a1 08 70 0a 08  h...p..MODE..p..
  4e80: 4d 4f 44 45 a1 3e 72 7a 7b 68 0b 00 03 00 0a 08  MODE.>rz{h......
  4e90: 00 7a 7b 68 0b 00 30 00 0a 0c 00 60 a0 0d 92 95  .z{h..0....`....
  4ea0: 60 0a 05 70 0a 0c 4d 4f 44 45 a1 18 a0 0d 92 95  `..p..MODE......
  4eb0: 60 0a 03 70 0a 0b 4d 4f 44 45 a1 08 70 0a 0a 4d  `..p..MODE..p..M
  4ec0: 4f 44 45 73 66 67 65 a4 65 08 42 30 34 5f 11 03  ODEsfge.e.B04_..
  4ed0: 0a 04 08 42 32 30 5f 11 03 0a 04 08 42 34 30 5f  ...B20_.....B40_
  4ee0: 11 03 0a 04 5b 82 4f 17 50 52 49 4d 08 5f 41 44  ....[.O.PRIM._AD
  4ef0: 52 0a 00 08 5f 50 53 43 0a 00 14 0d 5f 50 53 30  R..._PSC...._PS0
  4f00: 00 70 0a 00 5f 50 53 43 14 0d 5f 50 53 33 00 70  .p.._PSC.._PS3.p
  4f10: 0a 03 5f 50 53 43 14 3b 5f 47 54 4d 00 70 11 04  .._PSC.;_GTM.p..
  4f20: 0a 14 00 60 70 5e 5e 47 54 4d 5f 5e 5e 49 54 4d  ...`p^^GTM_^^ITM
  4f30: 30 5e 5e 53 49 54 30 5e 5e 55 44 43 30 5e 5e 55  0^^SIT0^^UDC0^^U
  4f40: 44 54 30 5e 5e 49 43 46 30 5e 5e 46 53 43 42 60  DT0^^ICF0^^FSCB`
  4f50: a4 60 14 4e 0e 5f 53 54 4d 03 70 47 54 46 5f 0a  .`.N._STM.pGTF_.
  4f60: 00 69 68 41 54 41 30 70 47 54 46 5f 0a 01 6a 68  .ihATA0pGTF_..jh
  4f70: 41 54 41 31 70 5e 5e 53 54 4d 53 68 69 6a 60 8a  ATA1p^^STMShij`.
  4f80: 60 0a 00 49 54 4d 5f 8a 60 0a 04 53 49 54 5f 8a  `..ITM_.`..SIT_.
  4f90: 60 0a 08 55 44 43 5f 8a 60 0a 0c 55 44 54 5f 8a  `..UDC_.`..UDT_.
  4fa0: 60 0a 10 49 43 46 5f 70 49 54 4d 5f 5e 5e 49 54  `..ICF_pITM_^^IT
  4fb0: 4d 30 70 53 49 54 5f 5e 5e 53 49 54 30 70 55 44  M0pSIT_^^SIT0pUD
  4fc0: 43 5f 5e 5e 55 44 43 30 70 55 44 54 5f 5e 5e 55  C_^^UDC0pUDT_^^U
  4fd0: 44 54 30 8a 60 0a 14 41 31 30 30 7d 7b 5e 5e 43  DT0.`..A100}{^^C
  4fe0: 42 38 30 0a 0c 00 7a 7b 0a 30 41 31 30 30 00 0a  B80...z{.0A100..
  4ff0: 04 00 5e 5e 43 42 38 30 7d 7b 5e 5e 46 53 43 42  ..^^CB80}{^^FSCB
  5000: 0a 0c 00 7a 7b 0b 00 30 41 31 30 30 00 0a 0c 00  ...z{..0A100....
  5010: 5e 5e 46 53 43 42 7d 7b 5e 5e 46 41 54 53 0a 0c  ^^FSCB}{^^FATS..
  5020: 00 7a 7b 0c 00 00 30 00 41 31 30 30 00 0a 14 00  .z{...0.A100....
  5030: 5e 5e 46 41 54 53 70 49 43 46 5f 5e 5e 49 43 46  ^^FATSpICF_^^ICF
  5040: 30 5b 82 22 4d 41 53 54 08 5f 41 44 52 0a 00 08  0[."MAST._ADR...
  5050: 48 31 35 46 00 14 0f 5f 47 54 46 00 a4 52 41 54  H15F..._GTF..RAT
  5060: 41 41 54 41 30 5b 82 49 31 53 45 43 4e 08 5f 41  AATA0[.I1SECN._A
  5070: 44 52 0a 01 08 46 41 53 54 0a 63 14 14 5f 53 54  DR...FAST.c.._ST
  5080: 41 00 a0 08 45 53 49 44 a4 0a 0f a1 04 a4 0a 08  A...ESID........
  5090: 08 5f 50 53 43 0a 00 14 0d 5f 50 53 30 00 70 0a  ._PSC...._PS0.p.
  50a0: 00 5f 50 53 43 14 0d 5f 50 53 33 00 70 0a 03 5f  ._PSC.._PS3.p.._
  50b0: 50 53 43 14 44 04 5f 47 54 4d 00 70 11 04 0a 14  PSC.D._GTM.p....
  50c0: 00 60 70 5e 5e 46 53 43 42 61 7a 61 0a 02 61 70  .`p^^FSCBaza..ap
  50d0: 5e 5e 47 54 4d 5f 5e 5e 49 54 4d 31 5e 5e 53 49  ^^GTM_^^ITM1^^SI
  50e0: 54 31 5e 5e 55 44 43 31 5e 5e 55 44 54 31 5e 5e  T1^^UDC1^^UDT1^^
  50f0: 49 43 46 31 61 60 a4 60 14 4e 0e 5f 53 54 4d 03  ICF1a`.`.N._STM.
  5100: 70 47 54 46 5f 0a 00 69 68 41 54 41 32 70 47 54  pGTF_..ihATA2pGT
  5110: 46 5f 0a 01 6a 68 41 54 41 33 70 5e 5e 53 54 4d  F_..jhATA3p^^STM
  5120: 53 68 69 6a 60 8a 60 0a 00 49 54 4d 5f 8a 60 0a  Shij`.`..ITM_.`.
  5130: 04 53 49 54 5f 8a 60 0a 08 55 44 43 5f 8a 60 0a  .SIT_.`..UDC_.`.
  5140: 0c 55 44 54 5f 8a 60 0a 10 49 43 46 5f 70 49 54  .UDT_.`..ICF_pIT
  5150: 4d 5f 5e 5e 49 54 4d 31 70 53 49 54 5f 5e 5e 53  M_^^ITM1pSIT_^^S
  5160: 49 54 31 70 55 44 43 5f 5e 5e 55 44 43 31 70 55  IT1pUDC_^^UDC1pU
  5170: 44 54 5f 5e 5e 55 44 54 31 8a 60 0a 14 41 31 30  DT_^^UDT1.`..A10
  5180: 30 7d 7b 5e 5e 43 42 38 30 0a 03 00 7a 7b 0a 30  0}{^^CB80...z{.0
  5190: 41 31 30 30 00 0a 02 00 5e 5e 43 42 38 30 7d 7b  A100....^^CB80}{
  51a0: 5e 5e 46 53 43 42 0a 03 00 7a 7b 0b 00 30 41 31  ^^FSCB...z{..0A1
  51b0: 30 30 00 0a 0a 00 5e 5e 46 53 43 42 7d 7b 5e 5e  00....^^FSCB}{^^
  51c0: 46 41 54 53 0a 03 00 7a 7b 0c 00 00 30 00 41 31  FATS...z{...0.A1
  51d0: 30 30 00 0a 12 00 5e 5e 46 41 54 53 70 49 43 46  00....^^FATSpICF
  51e0: 5f 5e 5e 49 43 46 31 5b 82 42 14 42 41 59 31 08  _^^ICF1[.B.BAY1.
  51f0: 5f 41 44 52 0a 00 08 48 31 35 46 00 08 45 4a 30  _ADR...H15F..EJ0
  5200: 46 0a 00 14 0f 5f 47 54 46 00 a4 52 41 54 41 41  F...._GTF..RATAA
  5210: 54 41 32 14 4f 09 5f 53 54 41 00 a0 42 09 5c 2f  TA2.O._STA..B.\/
  5220: 04 5f 53 42 5f 50 43 49 30 49 44 45 30 45 53 49  ._SB_PCI0IDE0ESI
  5230: 44 5c 2f 05 5f 53 42 5f 50 43 49 30 49 44 45 30  D\/._SB_PCI0IDE0
  5240: 53 45 43 4e 43 42 41 59 70 5e 5e 42 46 4c 47 60  SECNCBAYp^^BFLG`
  5250: a0 2e 93 5e 5e 42 4e 55 4d 0a 01 a0 23 7b 60 0a  ...^^BNUM...#{`.
  5260: 01 00 a0 17 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  5270: 50 43 30 4c 56 33 37 a4 0a 08 a1 04 a4 0a 0f a1  PC0LV37.........
  5280: 2e a0 27 93 5e 5e 42 4e 55 4d 0a 02 a0 17 5c 2f  ..'.^^BNUM....\/
  5290: 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 56 33  ._SB_PCI0LPC0LV3
  52a0: 37 a4 0a 08 a1 04 a4 0a 0f a1 04 a4 0a 08 a1 04  7...............
  52b0: a4 0a 08 14 47 07 5f 45 4a 30 01 a0 4f 06 68 a0  ....G._EJ0..O.h.
  52c0: 1b 94 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  52d0: 30 4d 42 54 50 0a 01 5b 22 0a 32 a1 4f 04 70 0a  0MBTP..[".2.O.p.
  52e0: 01 5e 5e 5e 53 53 49 47 5b 22 0a 32 70 0b 00 c0  .^^^SSIG[".2p...
  52f0: 5e 5e 5e 49 54 4d 31 70 0a 01 5c 2f 04 5f 53 42  ^^^ITM1p..\/._SB
  5300: 5f 50 43 49 30 4c 50 43 30 4c 56 33 37 5b 22 0a  _PCI0LPC0LV37[".
  5310: c8 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  .p..\/._SB_PCI0L
  5320: 50 43 30 4c 56 33 39 5b 22 0a c8 08 42 4e 55 4d  PC0LV39["...BNUM
  5330: 0a 00 08 42 46 4c 47 0a 00 14 46 04 43 42 41 59  ...BFLG...F.CBAY
  5340: 00 70 0a 00 42 4e 55 4d 70 0a 00 42 46 4c 47 70  .p..BNUMp..BFLGp
  5350: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 52  \/._SB_PCI0LPC0R
  5360: 42 49 44 60 a0 1b 7d 93 60 0a 01 93 60 0a 02 00  BID`..}.`...`...
  5370: 75 42 4e 55 4d 7d 42 46 4c 47 0a 01 42 46 4c 47  uBNUM}BFLG..BFLG
  5380: 14 4a 05 5f 50 53 30 00 a0 4b 04 7b 93 5f 50 53  .J._PS0..K.{._PS
  5390: 43 0a 03 93 5c 2e 5f 53 42 5f 53 54 41 54 0a 03  C...\._SB_STAT..
  53a0: 00 70 0a 89 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  .p..\/._SB_PCI0L
  53b0: 50 43 30 42 43 4d 44 70 0a 00 5c 2f 04 5f 53 42  PC0BCMDp..\/._SB
  53c0: 5f 50 43 49 30 4c 50 43 30 53 4d 49 43 70 0a b0  _PCI0LPC0SMICp..
  53d0: 50 38 30 48 70 0a 00 5f 50 53 43 14 14 5f 50 53  P80Hp.._PSC.._PS
  53e0: 33 00 70 0a 03 5f 50 53 43 70 0a b3 50 38 30 48  3.p.._PSCp..P80H
  53f0: 08 5f 50 53 43 0a 00 5b 82 4c 06 55 53 42 31 08  ._PSC..[.L.USB1.
  5400: 5f 41 44 52 0c 00 00 1d 00 5b 80 55 53 42 4f 02  _ADR.....[.USBO.
  5410: 0a c4 0a 04 5b 81 0b 55 53 42 4f 01 52 53 45 4e  ....[..USBO.RSEN
  5420: 02 08 5f 50 52 57 12 06 02 0a 03 0a 03 14 37 5f  .._PRW........7_
  5430: 50 53 57 01 a0 18 68 70 0a 03 5c 2f 04 5f 53 42  PSW...hp..\/._SB
  5440: 5f 50 43 49 30 55 53 42 31 52 53 45 4e a1 17 70  _PCI0USB1RSEN..p
  5450: 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 55 53 42  ..\/._SB_PCI0USB
  5460: 31 52 53 45 4e 5b 82 4c 06 55 53 42 32 08 5f 41  1RSEN[.L.USB2._A
  5470: 44 52 0c 01 00 1d 00 5b 80 55 53 42 4f 02 0a c4  DR.....[.USBO...
  5480: 0a 04 5b 81 0b 55 53 42 4f 01 52 53 45 4e 02 08  ..[..USBO.RSEN..
  5490: 5f 50 52 57 12 06 02 0a 04 0a 03 14 37 5f 50 53  _PRW........7_PS
  54a0: 57 01 a0 18 68 70 0a 03 5c 2f 04 5f 53 42 5f 50  W...hp..\/._SB_P
  54b0: 43 49 30 55 53 42 32 52 53 45 4e a1 17 70 0a 00  CI0USB2RSEN..p..
  54c0: 5c 2f 04 5f 53 42 5f 50 43 49 30 55 53 42 32 52  \/._SB_PCI0USB2R
  54d0: 53 45 4e 5b 82 4c 06 55 53 42 33 08 5f 41 44 52  SEN[.L.USB3._ADR
  54e0: 0c 02 00 1d 00 5b 80 55 53 42 4f 02 0a c4 0a 04  .....[.USBO.....
  54f0: 5b 81 0b 55 53 42 4f 01 52 53 45 4e 02 08 5f 50  [..USBO.RSEN.._P
  5500: 52 57 12 06 02 0a 0c 0a 03 14 37 5f 50 53 57 01  RW........7_PSW.
  5510: a0 18 68 70 0a 03 5c 2f 04 5f 53 42 5f 50 43 49  ..hp..\/._SB_PCI
  5520: 30 55 53 42 33 52 53 45 4e a1 17 70 0a 00 5c 2f  0USB3RSEN..p..\/
  5530: 04 5f 53 42 5f 50 43 49 30 55 53 42 33 52 53 45  ._SB_PCI0USB3RSE
  5540: 4e 5b 82 4f 05 4c 49 44 5f 08 5f 48 49 44 0c 41  N[.O.LID_._HID.A
  5550: d0 0c 0d 08 4c 53 54 53 0a 00 14 47 04 5f 4c 49  ....LSTS...G._LI
  5560: 44 00 a0 32 5c 2e 5f 53 42 5f 4f 4b 45 43 a0 1e  D..2\._SB_OKEC..
  5570: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45  \/._SB_PCI0LPC0E
  5580: 43 30 5f 4c 49 44 53 70 00 4c 53 54 53 a1 07 70  C0_LIDSp.LSTS..p
  5590: 01 4c 53 54 53 a1 07 70 00 4c 53 54 53 a4 4c 53  .LSTS..p.LSTS.LS
  55a0: 54 53 10 4a 66 5c 5f 54 5a 5f 08 54 50 4c 5f 0b  TS.Jf\_TZ_.TPL_.
  55b0: a0 0c 08 54 41 43 31 0b 0e 0d 08 54 41 43 30 0b  ...TAC1....TAC0.
  55c0: 54 0d 08 54 50 41 53 0b 44 0e 08 54 50 43 5f 0b  T..TPAS.D..TPC_.
  55d0: 94 0e 08 54 50 54 4d 0b 3c 0c 08 54 42 53 45 0b  ...TPTM.<..TBSE.
  55e0: ac 0a 08 4c 54 4d 50 0b a0 0c 08 54 56 41 52 11  ...LTMP....TVAR.
  55f0: 08 0a 05 00 20 1f 0c 1f 8c 54 56 41 52 0a 00 50  .... ....TVAR..P
  5600: 4c 43 59 8b 54 56 41 52 0a 01 43 54 4f 53 8b 54  LCY.TVAR..CTOS.T
  5610: 56 41 52 0a 03 43 54 48 59 5b 82 43 06 46 41 4e  VAR..CTHY[.C.FAN
  5620: 30 08 5f 48 49 44 0c 41 d0 0c 0b 08 5f 55 49 44  0._HID.A...._UID
  5630: 0a 01 08 5f 50 52 30 12 06 01 50 46 4e 30 14 1f  ..._PR0...PFN0..
  5640: 5f 50 53 30 00 70 0d 4c 6f 77 20 53 70 65 65 64  _PS0.p.Low Speed
  5650: 20 46 41 4e 20 2d 20 5f 50 53 30 00 5b 31 14 1f   FAN - _PS0.[1..
  5660: 5f 50 53 33 00 70 0d 4c 6f 77 20 53 70 65 65 64  _PS3.p.Low Speed
  5670: 20 46 41 4e 20 2d 20 5f 50 53 33 00 5b 31 5b 84   FAN - _PS3.[1[.
  5680: 45 1f 50 46 4e 30 00 00 00 08 46 4e 53 31 0a 00  E.PFN0....FNS1..
  5690: 08 46 46 53 54 0a 01 14 0e 5f 53 54 41 00 70 46  .FFST...._STA.pF
  56a0: 4e 53 31 61 a4 61 14 43 0c 5f 4f 4e 5f 00 70 0a  NS1a.a.C._ON_.p.
  56b0: 01 46 4e 53 31 a0 38 5c 2f 03 5f 54 5a 5f 50 46  .FNS1.8\/._TZ_PF
  56c0: 4e 31 46 4e 53 32 70 0d 46 41 4e 20 31 20 28 48  N1FNS2p.FAN 1 (H
  56d0: 69 67 68 20 73 70 65 65 64 20 61 6c 72 65 61 64  igh speed alread
  56e0: 79 20 74 75 72 6e 20 6f 6e 29 20 00 5b 31 a1 42  y turn on) .[1.B
  56f0: 04 a0 3f 5c 2e 5f 53 42 5f 4f 4b 45 43 70 0a b4  ..?\._SB_OKECp..
  5700: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45  \/._SB_PCI0LPC0E
  5710: 43 30 5f 46 53 50 44 70 0a 01 5c 2f 05 5f 53 42  C0_FSPDp..\/._SB
  5720: 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 46 50 52  _PCI0LPC0EC0_FPR
  5730: 31 a0 38 7d 93 5c 2f 03 5f 53 42 5f 50 43 49 30  1.8}.\/._SB_PCI0
  5740: 4d 59 4f 53 0a 01 93 5c 2f 03 5f 53 42 5f 50 43  MYOS...\/._SB_PC
  5750: 49 30 4d 59 4f 53 0a 03 00 5c 2f 03 5f 54 5a 5f  I0MYOS...\/._TZ_
  5760: 54 48 52 4d 5f 53 43 50 0a 01 14 4a 10 5f 4f 46  THRM_SCP...J._OF
  5770: 46 00 70 0a 00 46 4e 53 31 a0 4d 05 93 87 5c 5f  F.p..FNS1.M...\_
  5780: 4f 53 5f 0a 14 a0 41 05 5c 2e 5f 53 42 5f 4f 4b  OS_...A.\._SB_OK
  5790: 45 43 a0 29 5c 2f 03 5f 54 5a 5f 50 46 4e 31 46  EC.)\/._TZ_PFN1F
  57a0: 4e 53 32 70 01 5c 2f 05 5f 53 42 5f 50 43 49 30  NS2p.\/._SB_PCI0
  57b0: 4c 50 43 30 45 43 30 5f 46 50 52 31 a1 1a 70 00  LPC0EC0_FPR1..p.
  57c0: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45  \/._SB_PCI0LPC0E
  57d0: 43 30 5f 46 50 52 31 a1 44 06 a0 39 95 46 46 53  C0_FPR1.D..9.FFS
  57e0: 54 0a 02 70 0a 86 5c 2f 04 5f 53 42 5f 50 43 49  T..p..\/._SB_PCI
  57f0: 30 4c 50 43 30 42 43 4d 44 70 0a 00 5c 2f 04 5f  0LPC0BCMDp..\/._
  5800: 53 42 5f 50 43 49 30 4c 50 43 30 53 4d 49 43 75  SB_PCI0LPC0SMICu
  5810: 46 46 53 54 a1 27 a0 25 5c 2e 5f 53 42 5f 4f 4b  FFST.'.%\._SB_OK
  5820: 45 43 70 0a 00 5c 2f 05 5f 53 42 5f 50 43 49 30  ECp..\/._SB_PCI0
  5830: 4c 50 43 30 45 43 30 5f 46 50 52 31 a0 38 7d 93  LPC0EC0_FPR1.8}.
  5840: 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a  \/._SB_PCI0MYOS.
  5850: 01 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f  ..\/._SB_PCI0MYO
  5860: 53 0a 03 00 5c 2f 03 5f 54 5a 5f 54 48 52 4d 5f  S...\/._TZ_THRM_
  5870: 53 43 50 0a 01 5b 82 49 06 46 41 4e 31 08 5f 48  SCP..[.I.FAN1._H
  5880: 49 44 0c 41 d0 0c 0b 08 5f 55 49 44 0a 02 08 5f  ID.A...._UID..._
  5890: 50 52 30 12 0a 02 50 46 4e 30 50 46 4e 31 14 20  PR0...PFN0PFN1. 
  58a0: 5f 50 53 30 00 70 0d 48 69 67 68 20 53 70 65 65  _PS0.p.High Spee
  58b0: 64 20 46 41 4e 20 2d 20 5f 50 53 30 00 5b 31 14  d FAN - _PS0.[1.
  58c0: 20 5f 50 53 33 00 70 0d 48 69 67 68 20 53 70 65   _PS3.p.High Spe
  58d0: 65 64 20 46 41 4e 20 2d 20 5f 50 53 33 00 5b 31  ed FAN - _PS3.[1
  58e0: 5b 84 4c 16 50 46 4e 31 00 00 00 08 46 4e 53 32  [.L.PFN1....FNS2
  58f0: 0a 00 14 0b 5f 53 54 41 00 a4 46 4e 53 32 14 47  ...._STA..FNS2.G
  5900: 08 5f 4f 4e 5f 00 70 0a 01 46 4e 53 32 a0 3f 5c  ._ON_.p..FNS2.?\
  5910: 2e 5f 53 42 5f 4f 4b 45 43 70 0a ff 5c 2f 05 5f  ._SB_OKECp..\/._
  5920: 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 46  SB_PCI0LPC0EC0_F
  5930: 53 50 44 70 0a 01 5c 2f 05 5f 53 42 5f 50 43 49  SPDp..\/._SB_PCI
  5940: 30 4c 50 43 30 45 43 30 5f 46 50 52 31 a0 38 7d  0LPC0EC0_FPR1.8}
  5950: 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53  .\/._SB_PCI0MYOS
  5960: 0a 01 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59  ...\/._SB_PCI0MY
  5970: 4f 53 0a 03 00 5c 2f 03 5f 54 5a 5f 54 48 52 4d  OS...\/._TZ_THRM
  5980: 5f 53 43 50 0a 01 14 47 0c 5f 4f 46 46 00 70 00  _SCP...G._OFF.p.
  5990: 46 4e 53 32 70 0a 00 46 4e 53 32 a0 41 05 5c 2f  FNS2p..FNS2.A.\/
  59a0: 03 5f 54 5a 5f 50 46 4e 30 46 4e 53 31 a0 3f 5c  ._TZ_PFN0FNS1.?\
  59b0: 2e 5f 53 42 5f 4f 4b 45 43 70 0a b4 5c 2f 05 5f  ._SB_OKECp..\/._
  59c0: 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 46  SB_PCI0LPC0EC0_F
  59d0: 53 50 44 70 0a 01 5c 2f 05 5f 53 42 5f 50 43 49  SPDp..\/._SB_PCI
  59e0: 30 4c 50 43 30 45 43 30 5f 46 50 52 31 a1 27 a0  0LPC0EC0_FPR1.'.
  59f0: 25 5c 2e 5f 53 42 5f 4f 4b 45 43 70 0a 00 5c 2f  %\._SB_OKECp..\/
  5a00: 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30  ._SB_PCI0LPC0EC0
  5a10: 5f 46 50 52 31 a0 38 7d 93 5c 2f 03 5f 53 42 5f  _FPR1.8}.\/._SB_
  5a20: 50 43 49 30 4d 59 4f 53 0a 01 93 5c 2f 03 5f 53  PCI0MYOS...\/._S
  5a30: 42 5f 50 43 49 30 4d 59 4f 53 0a 03 00 5c 2f 03  B_PCI0MYOS...\/.
  5a40: 5f 54 5a 5f 54 48 52 4d 5f 53 43 50 0a 01 5b 85  _TZ_THRM_SCP..[.
  5a50: 4d 1b 54 48 52 4d 08 5f 41 4c 30 12 06 01 46 41  M.THRM._AL0...FA
  5a60: 4e 31 14 0b 5f 41 43 30 00 a4 54 41 43 30 08 5f  N1.._AC0..TAC0._
  5a70: 41 4c 31 12 06 01 46 41 4e 30 14 0b 5f 41 43 31  AL1...FAN0.._AC1
  5a80: 00 a4 54 41 43 31 14 0b 5f 43 52 54 00 a4 54 50  ..TAC1.._CRT..TP
  5a90: 43 5f 14 0b 5f 50 53 56 00 a4 54 50 41 53 08 5f  C_.._PSV..TPAS._
  5aa0: 54 53 50 0a 64 14 47 0a 5f 54 4d 50 00 a0 45 09  TSP.d.G._TMP..E.
  5ab0: 5c 2e 5f 53 42 5f 4f 4b 45 43 70 5c 2f 05 5f 53  \._SB_OKECp\/._S
  5ac0: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 43 54  B_PCI0LPC0EC0_CT
  5ad0: 4d 50 61 70 0d 44 6f 74 68 61 6e 20 42 31 20 43  MPap.Dothan B1 C
  5ae0: 50 55 20 74 65 6d 70 65 72 61 74 75 72 65 20 6f  PU temperature o
  5af0: 66 66 73 65 74 20 76 61 6c 75 65 20 3d 20 00 5b  ffset value = .[
  5b00: 31 70 44 4f 46 46 5b 31 70 61 5b 31 70 0d 43 75  1pDOFF[1pa[1p.Cu
  5b10: 72 72 65 6e 74 20 54 65 6d 70 65 72 61 74 75 72  rrent Temperatur
  5b20: 65 20 69 73 20 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d  e is -----------
  5b30: 20 00 5b 31 70 61 5b 31 72 77 61 0a 0a 00 54 42   .[1pa[1rwa...TB
  5b40: 53 45 61 a1 07 70 4c 54 4d 50 61 a4 61 08 5f 50  SEa..pLTMPa.a._P
  5b50: 53 4c 12 0c 01 5c 2e 5f 50 52 5f 43 50 55 30 08  SL...\._PR_CPU0.
  5b60: 5f 54 43 31 0a 02 08 5f 54 43 32 0a 03 14 4f 09  _TC1..._TC2...O.
  5b70: 5f 53 43 50 01 70 00 50 4c 43 59 a0 47 04 5c 2f  _SCP.p.PLCY.G.\/
  5b80: 03 5f 54 5a 5f 50 46 4e 30 46 4e 53 31 a0 23 93  ._TZ_PFN0FNS1.#.
  5b90: 5c 2f 03 5f 54 5a 5f 50 46 4e 31 46 4e 53 32 0a  \/._TZ_PFN1FNS2.
  5ba0: 00 70 0b 22 0d 54 41 43 31 70 0b 86 0d 54 41 43  .p.".TAC1p...TAC
  5bb0: 30 a1 11 70 0b 22 0d 54 41 43 31 70 0b 40 0d 54  0..p.".TAC1p.@.T
  5bc0: 41 43 30 a1 34 a0 20 5c 2f 03 5f 54 5a 5f 50 46  AC0.4. \/._TZ_PF
  5bd0: 4e 31 46 4e 53 32 70 0b 22 0d 54 41 43 31 70 0b  N1FNS2p.".TAC1p.
  5be0: 40 0d 54 41 43 30 a1 11 70 0b 40 0d 54 41 43 31  @.TAC0..p.@.TAC1
  5bf0: 70 0b 86 0d 54 41 43 30 70 0b 44 0e 54 50 41 53  p...TAC0p.D.TPAS
  5c00: 86 5c 2e 5f 54 5a 5f 54 48 52 4d 0a 81 5b 82 0f  .\._TZ_THRM..[..
  5c10: 53 4c 50 42 08 5f 48 49 44 0c 41 d0 0c 0e 5b 80  SLPB._HID.A...[.
  5c20: 45 58 43 4f 01 0a 72 0a 02 5b 81 10 45 58 43 4f  EXCO..r..[..EXCO
  5c30: 01 49 4e 44 58 08 44 41 54 41 08 5b 86 4a 08 49  .INDX.DATA.[.J.I
  5c40: 4e 44 58 44 41 54 41 01 00 40 10 41 43 53 54 01  NDXDATA..@.ACST.
  5c50: 45 43 4f 4b 01 57 4c 45 53 01 42 54 45 53 01 57  ECOK.WLES.BTES.W
  5c60: 32 4b 46 02 53 34 57 50 01 46 4c 41 37 01 4c 53  2KF.S4WP.FLA7.LS
  5c70: 46 47 01 4c 44 31 30 01 50 53 32 4d 01 44 49 53  FG.LD10.PS2M.DIS
  5c80: 44 03 4f 56 52 4c 01 00 01 53 4c 45 45 08 42 50  D.OVRL...SLEE.BP
  5c90: 46 47 08 50 57 53 54 08 44 41 54 53 08 43 4d 32  FG.PWST.DATS.CM2
  5ca0: 36 08 43 4d 32 37 08 43 4d 32 38 10 43 4d 32 41  6.CM27.CM28.CM2A
  5cb0: 10 46 34 46 47 01 00 1f 43 4d 33 30 08 43 4d 33  .F4FG...CM30.CM3
  5cc0: 31 08 43 4d 33 32 08                             1.CM32.

FACS @ 0x1fefcfc0
  0000: 46 41 43 53 40 00 00 00 da 12 00 00 00 00 00 00  FACS@...........
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

HPET @ 0x1feebfa0
  0000: 48 50 45 54 38 00 00 00 01 0a 41 43 45 52 20 20  HPET8.....ACER  
  0010: 4b 65 73 74 72 65 6c 20 07 07 02 20 50 54 4c 20  Kestrel ... PTL 
  0020: 00 00 00 00 01 a2 86 80 00 00 00 00 00 00 00 00  ................
  0030: 00 00 d0 fe 00 80 00 00                          ........

BOOT @ 0x1feebfd8
  0000: 42 4f 4f 54 28 00 00 00 01 d6 41 43 45 52 20 20  BOOT(.....ACER  
  0010: 4b 65 73 74 72 65 6c 20 07 07 02 20 20 4c 54 50  Kestrel ...  LTP
  0020: 01 00 00 00 37 00 00 00                          ....7...



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
