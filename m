From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: PROBLEM: ACPI freezes 2.6.1 (acpi-20031203-2.6.1 patched) on boot
Date: Wed, 21 Jan 2004 13:10:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3oesx5wok.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="====-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--====-=-=
Content-Type: multipart/mixed; boundary="===-=-="

--===-=-=

Hi all,

FYI: below is my problem report about ACPI freezing my ASUS M2N on
boot with plain vanilla Linux 2.6.1.

As a possible way of solving the problem I've tried the patch
acpi-20031203-2.6.1.diff.bz2 with date 09-Jan-2004 (have to admit the
version numbering isn't clear to me) I get a different error message

 ACPI: IRQ9 SCI: Edge set to Level Trigger.

However, this still appears to be the same problem.

The outputs of dmidecode, acpidmp, lspci and cat /proc/interrupts is
attached at the end. If you need more info, let me know.

Ideas anyone? 

Regards,
Georg



--===-=-=
Content-Type: message/rfc822
Content-Disposition: inline

X-From-Line: nobody Wed Jan 21 12:12:06 2004
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Martin Loschwitz <madkiss-R0iKqZn4BxJAfugRpC6u6w@public.gmane.org>
Subject: PROBLEM: ACPI freezes 2.6.1 on boot
X-Draft-From: ("nnml:misc.misc" "")
From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Sender: "Georg C. F. Greve" <greve-1r/uNngapc3YtjvyW6yDsg@public.gmane.org>
Organisation: Free Software Foundation Europe - GNU Project
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Wed, 21 Jan 2004 12:12:05 +0100
Message-ID: <m3isj5a73u.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Lines: 55
Xref: reason.gnu-hamburg mail.2004-01:167
X-Gnus-Article-Number: 167   Wed Jan 21 12:12:06 2004

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=

Hi all,

I've seen the mail by Martin Loschwitz of January 1st 2004, in which
he reported:

 > I'm writing this mail as I'm discovering ACPI related problems on
 > my Acer TravelMate 800LCi notebook with Linux 2.6.1-rc1-mm1.

 > While the system boots up fine with Linux 2.6.1-rc1, with
 > 2.6.1-rc1-mm1 it hangs while booting. The last message printed to
 > screen is "ACPI: IRQ 9 was Edge Triggered, setting to Level
 > Triggerd". This is fully reproducable with a Linux 2.6.0 kernel
 > which has the ACPI20031203 patch applied.

I'm now seeing the _exact same problem_ on an ASUS M2400N [*] with a
Linux 2.6.1 (unpatched) kernel. The kernel freezes after printing 

 "ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd" 

(yes, the typo is in the kernel, it seems)

I've seen no reply to his mail. Has the problem been solved or is it
still a known bug(tm)?

Martin? Were you successful in resolving that problem?

Regards,
Georg


[*] Pentium 4 M Centrino, 1.6, 512MB, Intel 855GM chipset

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFADl6GbvivwoZXSsoRAgbzAJ9vRXwpjbLaE+aCdjZ/QRIRAbmOPACfQeFS
wvDcWrP8gstW4gYvJtvQvHw=
=Z0H3
-----END PGP MESSAGE-----
--==-=-=--

--===-=-=
Content-Disposition: inline; filename=dmidecode

# dmidecode 1.8
PCI Interrupt Routing 1.0 present.
	Table Size: 128 bytes
	Router ID: 00:1f.0
	Exclusive IRQs: None
	Compatible Router: 8086:24cc
PNP 1.0 present.
	Event Notification: Not Supported
	Real Mode Code Address: F000:39C2
	Real Mode Data Address: F000:0000
	Protected Mode Code Address: 0x000F39EA
	Protected Mode Data Address: 0x000F0000
ACPI 1.0 present.
	OEM ID: ACPIAM
RSD table at 0x1F740000.
SMBIOS 2.3 present.
DMI 2.3 present.
37 structures occupying 1383 bytes.
DMI table at 0x000F5620.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information Block
		Vendor: American Megatrends Inc.
		Version: 0206    
		Release: 06/10/2003
		BIOS base: 0xF0000
		ROM size: 512K
		Capabilities:
			Flags: 0x000000007FCBDF90
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information Block
		Vendor: ASUSTeK Computer Inc.        
		Product: M2N       
		Version: 1.0       
		Serial Number: SSN12345678901234567
Handle 0x0002
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor: ASUSTeK Computer Inc.        
		Product: M2N       
		Version: 1.0       
		Serial Number: BSN12345678901234567
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information Block
		Vendor: ASUSTeK Computer Inc.        
		Chassis Type: Notebook
		Version: 1.0       
		Serial Number: CSN12345678901234567
		Asset Tag: ATN12345678901234567
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor
		Socket Designation: X1
		Processor Type: Central Processor
		Processor Family: Unknown
		Processor Manufacturer: Intel            
		Processor Version: Mobile Genuine Intel(R) processor       1600MHz     
		Serial Number: PSN12345678901234567
		Asset Tag: PATN1234567890123456
		Vendor Part Number: PPN12345678901234567
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache
		Socket: L1-Cache
		L1 Internal Cache: 
		L1 Cache Size: 32K
		L1 Cache Maximum: 32K
		L1 Cache Type: Pipeline burst 
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache
		Socket: L2-cache
		L2 Internal Cache: 
		L2 Cache Size: 1024K
		L2 Cache Maximum: 1024K
		L2 Cache Type: Pipeline burst 
Handle 0x0007
	DMI type 5, 20 bytes.
	Memory Controller
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM1
		Banks: 0 1
		Speed: 10nS
		Type: STANDARD 
		Installed Size: 256Mbyte
		Enabled Size: 256Mbyte
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM2
		Banks: 2 3
		Speed: 10nS
		Type: STANDARD 
		Installed Size: 256Mbyte (Double sided)
		Enabled Size: 256Mbyte (Double sided)
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J1A1
		Internal Connector Type: None
		External Designator: USB1
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J1A1
		Internal Connector Type: None
		External Designator: USB2
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J3A1
		Internal Connector Type: None
		External Designator: 1394
		External Connector Type: 1394
		Port Type: FireWire (IEEE P1394)
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J4A1
		Internal Connector Type: None
		External Designator: MODEM
		External Connector Type: RJ-11
		Port Type: Modem Port
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J5A1
		Internal Connector Type: None
		External Designator: LAN
		External Connector Type: RJ-45
		Port Type: Network Port
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J6A1
		Internal Connector Type: None
		External Designator: Audio Mic In
		External Connector Type: Mini-jack (headphones)
		Port Type: Audio Port
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J6A1
		Internal Connector Type: None
		External Designator: Audio Line In
		External Connector Type: Mini-jack (headphones)
		Port Type: Audio Port
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J6A1
		Internal Connector Type: None
		External Designator: Audio Line Out
		External Connector Type: Mini-jack (headphones)
		Port Type: Audio Port
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J9A1
		Internal Connector Type: None
		External Designator: Video
		External Connector Type: DB-15 pin female
		Port Type: Video Port
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J10A1
		Internal Connector Type: None
		External Designator: Port Replicator
		External Connector Type: Proprietary
		Port Type: Other
Handle 0x0014
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J11A1
		Internal Connector Type: None
		External Designator: AIBOX
		External Connector Type: Proprietary
		Port Type: Other
Handle 0x0015
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: J12A1
		Internal Connector Type: None
		External Designator: USB3
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0016
	DMI type 9, 13 bytes.
	Card Slot
		Slot: MiniPCI
		Type: 32bit Long PCI 
		Status: Available.
		Slot Features: 3.3v Shared 
Handle 0x0017
	DMI type 10, 6 bytes.
	On Board Devices Information
		Description: AGP VGA controller : Enabled
		Type: Video
Handle 0x0018
	DMI type 10, 6 bytes.
	On Board Devices Information
		Description: Ethernet controller : Enabled
		Type: Ethernet
Handle 0x0019
	DMI type 10, 6 bytes.
	On Board Devices Information
		Description: Audio controller : Enabled
		Type: Sound
Handle 0x001A
	DMI type 10, 6 bytes.
	On Board Devices Information
		Description: Modem controller : Enabled
		Type: Other
Handle 0x001B
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 1
			enUS
		Currently Installed Language: enUS
Handle 0x001C
	DMI type 15, 33 bytes.
	Event Log
		Log Area: 1008 bytes.
		Log Header At: 4112.
		Log Data At: 4128.
		Log Type: 4.
Handle 0x001D
	DMI type 18, 23 bytes.
	32-bit Memory Error Information
Handle 0x001E
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System board or motherboard
		Use: System memory
		Error Correction Type: None
		Maximum Capacity: 3145728 kB
		Error Information Handle: 0x001D
		Number of Devices: 2
Handle 0x001F
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
Handle 0x0020
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x001E
		Error Information Handle: 0x001D
		Total Width: 72 bits
		Data Width: 64 bits
		Size: 256 Mbyte
		Form Factor: DIMM
		Locator: DIMM1
		Bank Locator: BANK0
		Type: SDRAM
		Type Detail: Synchronous 
		Speed: Unknown
		Manufacturer: Manufacturer1
		Serial Number: SerNum1
		Asset Tag: AssetTagNum1
		Part Number: PartNum1
Handle 0x0021
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x0022
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x001E
		Error Information Handle: 0x001D
		Total Width: 72 bits
		Data Width: 64 bits
		Size: 256 Mbyte
		Form Factor: DIMM
		Locator: DIMM2
		Bank Locator: BANK1
		Type: SDRAM
		Type Detail: Synchronous 
		Speed: Unknown
		Manufacturer: Manufacturer2
		Serial Number: SerNum2
		Asset Tag: AssetTagNum2
		Part Number: PartNum2
Handle 0x0023
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
Handle 0x0024
	DMI type 127, 4 bytes.
	End-of-Table

--===-=-=
Content-Disposition: inline; filename=acpidmp

RSDP "ACPIAM" @ 0x000f4b60
  0000: 52 53 44 20 50 54 52 20 a3 41 43 50 49 41 4d 00  RSD PTR .ACPIAM.
  0010: 00 00 74 1f                                      ..t.

RSDT @ 0x1f740000
  0000: 52 53 44 54 2c 00 00 00 01 ce 41 20 4d 20 49 20  RSDT,.....A M I 
  0010: 4f 45 4d 52 53 44 54 20 10 03 00 06 4d 53 46 54  OEMRSDT ....MSFT
  0020: 97 00 00 00 00 02 74 1f 40 00 75 1f              ......t.-LGTn94yZUJM@public.gmane.org

FACP @ 0x1f740200
  0000: 46 41 43 50 81 00 00 00 02 5c 41 20 4d 20 49 20  FACP.....\A M I 
  0010: 4f 45 4d 46 41 43 50 20 10 03 00 06 4d 53 46 54  OEMFACP ....MSFT
  0020: 97 00 00 00 00 00 75 1f 00 03 74 1f 00 00 09 00  ......u...t.....
  0030: b2 00 00 00 e1 1e 00 e2 00 e4 00 00 00 00 00 00  ................
  0040: 04 e4 00 00 00 00 00 00 20 e4 00 00 08 e4 00 00  ........ .......
  0050: 28 e4 00 00 00 00 00 00 04 02 01 04 08 00 00 e3  (...............
  0060: 01 00 65 00 00 04 10 00 01 03 0d 00 00 03 00 00  ..e.............
  0070: a5 00 00 00 01 08 00 00 f9 0c 00 00 00 00 00 00  ................
  0080: 06                                               .

DSDT @ 0x1f740300
  0000: 44 53 44 54 29 6d 00 00 01 d4 30 41 42 42 44 00  DSDT)m....0ABBD.
  0010: 30 41 42 42 44 30 30 31 01 00 00 00 4d 53 46 54  0ABBD001....MSFT
  0020: 0d 00 00 01 5b 80 42 49 4f 53 00 0c 64 00 75 1f  ....[.BIOS..d.u.
  0030: 0a ff 5b 81 3f 42 49 4f 53 01 53 53 31 5f 01 53  ..[.?BIOS.SS1_.S
  0040: 53 32 5f 01 53 53 33 5f 01 53 53 34 5f 01 00 04  S2_.SS3_.SS4_...
  0050: 49 4f 53 54 10 54 4f 50 4d 20 52 4f 4d 53 20 4d  IOST.TOPM ROMS M
  0060: 47 31 42 20 4d 47 31 4c 20 4d 47 32 42 20 4d 47  G1B MG1L MG2B MG
  0070: 32 4c 20 08 49 4f 31 42 0b 80 04 08 49 4f 31 4c  2L .IO1B....IO1L
  0080: 0a 10 08 49 4f 58 42 0b c0 04 08 49 4f 58 4c 0a  ...IOXB....IOXL.
  0090: 10 08 53 50 49 4f 0a 2e 08 41 50 43 42 0a 00 08  ..SPIO...APCB...
  00a0: 41 50 43 4c 0a 00 08 50 4d 42 53 0b 00 e4 08 50  APCL...PMBS....P
  00b0: 4d 4c 4e 0a 80 08 57 46 41 54 0a 90 08 57 4e 56  MLN...WFAT...WNV
  00c0: 52 0a 91 08 52 4e 56 52 0a 92 08 53 57 46 52 0a  R...RNVR...SWFR.
  00d0: 93 08 53 54 44 44 0a 94 08 47 54 44 44 0a 95 08  ..STDD...GTDD...
  00e0: 41 44 42 52 0a 96 08 43 47 50 53 0a 97 08 43 47  ADBR...CGPS...CG
  00f0: 57 4b 0a 98 08 49 53 57 50 0a 99 08 49 53 54 42  WK...ISWP...ISTB
  0100: 0a 9a 08 47 50 42 53 0b 00 ec 08 47 50 4c 4e 0a  ...GPBS....GPLN.
  0110: 40 08 53 4d 42 53 0b 00 e8 08 53 4d 42 4c 0a 10  @.SMBS....SMBL..
  0120: 08 46 4e 43 30 0a 00 08 46 4e 43 31 0a 19 08 46  .FNC0...FNC1...F
  0130: 4e 43 32 0a 28 08 46 4e 43 33 0a 2d 08 46 4e 43  NC2.(.FNC3.-.FNC
  0140: 34 0a 34 14 0f 52 52 49 4f 04 70 0d 52 52 49 4f  4.4..RRIO.p.RRIO
  0150: 00 5b 31 14 0f 52 44 4d 41 03 70 0d 72 44 4d 41  .[1..RDMA.p.rDMA
  0160: 00 5b 31 08 50 49 43 4d 0a 00 14 1f 5f 50 49 43  .[1.PICM...._PIC
  0170: 01 a0 09 68 70 0a aa 44 42 47 38 a1 08 70 0a 55  ...hp..DBG8..p.U
  0180: 44 42 47 38 70 68 50 49 43 4d 14 31 4f 53 46 4c  DBG8phPICM.1OSFL
  0190: 00 70 0a 01 60 a0 24 4d 43 54 48 5c 5f 4f 53 5f  .p..`.$MCTH\_OS_
  01a0: 0d 4d 69 63 72 6f 73 6f 66 74 20 57 69 6e 64 6f  .Microsoft Windo
  01b0: 77 73 20 4e 54 00 70 0a 00 60 a4 60 14 4f 04 4d  ws NT.p..`.`.O.M
  01c0: 43 54 48 02 a0 08 95 87 68 87 69 a4 00 72 87 68  CTH.....h.i..r.h
  01d0: 0a 01 60 08 42 55 46 30 11 02 60 08 42 55 46 31  ..`.BUF0..`.BUF1
  01e0: 11 02 60 70 68 42 55 46 30 70 69 42 55 46 31 a2  ..`phBUF0piBUF1.
  01f0: 1a 60 76 60 a0 15 92 93 83 88 42 55 46 30 60 00  .`v`......BUF0`.
  0200: 83 88 42 55 46 31 60 00 a4 00 a4 01 14 44 09 47  ..BUF1`......D.G
  0210: 50 52 57 02 08 50 52 57 50 12 06 02 0a 00 0a 00  PRW..PRWP.......
  0220: 70 68 88 50 52 57 50 0a 00 00 70 69 88 50 52 57  ph.PRWP...pi.PRW
  0230: 50 0a 01 00 70 0a 00 60 7d 60 79 53 53 31 5f 0a  P...p..`}`ySS1_.
  0240: 01 00 60 7d 60 79 53 53 32 5f 0a 02 00 60 7d 60  ..`}`ySS2_...`}`
  0250: 79 53 53 33 5f 0a 03 00 60 7d 60 79 53 53 34 5f  ySS3_...`}`ySS4_
  0260: 0a 04 00 60 a0 09 7b 79 0a 01 69 00 60 00 a1 2d  ...`..{y..i.`..-
  0270: 7a 60 0a 01 60 70 4f 53 46 4c 61 a0 14 91 93 61  z`..`pOSFLa....a
  0280: 0a 01 93 61 0a 02 81 60 88 50 52 57 50 0a 01 00  ...a...`.PRWP...
  0290: a1 0b 82 60 88 50 52 57 50 0a 01 00 a4 50 52 57  ...`.PRWP....PRW
  02a0: 50 08 57 41 4b 50 12 06 02 0a 00 0a 00 5b 80 44  P.WAKP.......[.D
  02b0: 45 42 30 01 0a 80 0a 01 5b 81 0b 44 45 42 30 01  EB0.....[..DEB0.
  02c0: 44 42 47 38 08 5b 80 44 45 42 31 01 0a 90 0a 02  DBG8.[.DEB1.....
  02d0: 5b 81 0b 44 45 42 31 02 44 42 47 39 10 10 13 5c  [..DEB1.DBG9...\
  02e0: 5f 50 52 5f 5b 83 0b 43 50 55 31 01 10 e4 00 00  _PR_[..CPU1.....
  02f0: 06 10 89 fe 05 5c 5f 53 42 5f 08 50 52 30 31 12  .....\_SB_.PR01.
  0300: 43 06 06 12 0f 04 0c ff ff 04 00 0a 00 4c 4e 4b  C............LNK
  0310: 41 0a 00 12 0f 04 0c ff ff 03 00 0a 00 4c 4e 4b  A............LNK
  0320: 42 0a 00 12 0f 04 0c ff ff 03 00 0a 01 4c 4e 4b  B............LNK
  0330: 43 0a 00 12 0f 04 0c ff ff 03 00 0a 02 4c 4e 4b  C............LNK
  0340: 41 0a 00 12 0f 04 0c ff ff 05 00 0a 00 4c 4e 4b  A............LNK
  0350: 43 0a 00 12 0f 04 0c ff ff 05 00 0a 01 4c 4e 4b  C............LNK
  0360: 44 0a 00 08 41 52 30 31 12 47 05 06 12 0d 04 0c  D...AR01.G......
  0370: ff ff 04 00 0a 00 0a 00 0a 10 12 0d 04 0c ff ff  ................
  0380: 03 00 0a 00 0a 00 0a 11 12 0d 04 0c ff ff 03 00  ................
  0390: 0a 01 0a 00 0a 12 12 0d 04 0c ff ff 03 00 0a 02  ................
  03a0: 0a 00 0a 10 12 0d 04 0c ff ff 05 00 0a 00 0a 00  ................
  03b0: 0a 12 12 0d 04 0c ff ff 05 00 0a 01 0a 00 0a 13  ................
  03c0: 08 50 52 30 30 12 43 07 07 12 0f 04 0c ff ff 02  .PR00.C.........
  03d0: 00 0a 00 4c 4e 4b 41 0a 00 12 0f 04 0c ff ff 1f  ...LNKA.........
  03e0: 00 0a 00 4c 4e 4b 43 0a 00 12 0f 04 0c ff ff 1f  ...LNKC.........
  03f0: 00 0a 01 4c 4e 4b 42 0a 00 12 0f 04 0c ff ff 1d  ...LNKB.........
  0400: 00 0a 00 4c 4e 4b 41 0a 00 12 0f 04 0c ff ff 1d  ...LNKA.........
  0410: 00 0a 01 4c 4e 4b 44 0a 00 12 0f 04 0c ff ff 1d  ...LNKD.........
  0420: 00 0a 02 4c 4e 4b 43 0a 00 12 0f 04 0c ff ff 1d  ...LNKC.........
  0430: 00 0a 03 4c 4e 4b 48 0a 00 08 41 52 30 30 12 45  ...LNKH...AR00.E
  0440: 06 07 12 0d 04 0c ff ff 02 00 0a 00 0a 00 0a 10  ................
  0450: 12 0d 04 0c ff ff 1f 00 0a 00 0a 00 0a 12 12 0d  ................
  0460: 04 0c ff ff 1f 00 0a 01 0a 00 0a 11 12 0d 04 0c  ................
  0470: ff ff 1d 00 0a 00 0a 00 0a 10 12 0d 04 0c ff ff  ................
  0480: 1d 00 0a 01 0a 00 0a 13 12 0d 04 0c ff ff 1d 00  ................
  0490: 0a 02 0a 00 0a 12 12 0d 04 0c ff ff 1d 00 0a 03  ................
  04a0: 0a 00 0a 17 08 50 52 53 41 11 09 0a 06 23 f8 18  .....PRSA....#..
  04b0: 18 79 00 08 50 52 53 42 11 09 0a 06 23 f8 10 18  .y..PRSB....#...
  04c0: 79 00 06 50 52 53 42 50 52 53 43 06 50 52 53 42  y..PRSBPRSC.PRSB
  04d0: 50 52 53 44 06 50 52 53 42 50 52 53 45 06 50 52  PRSD.PRSBPRSE.PR
  04e0: 53 42 50 52 53 46 06 50 52 53 42 50 52 53 47 06  SBPRSF.PRSBPRSG.
  04f0: 50 52 53 42 50 52 53 48 5b 82 81 de 05 50 43 49  PRSBPRSH[....PCI
  0500: 30 08 5f 48 49 44 0c 41 d0 0a 03 08 5f 41 44 52  0._HID.A...._ADR
  0510: 0a 00 08 5f 42 42 4e 0a 00 08 5f 55 49 44 0a 00  ..._BBN..._UID..
  0520: 14 16 5f 50 52 54 00 a0 0a 50 49 43 4d a4 41 52  .._PRT...PICM.AR
  0530: 30 30 a4 50 52 30 30 5b 82 48 24 50 30 50 31 08  00.PR00[.H$P0P1.
  0540: 5f 41 44 52 0c 00 00 1e 00 14 0f 5f 50 52 57 00  _ADR......._PRW.
  0550: a4 47 50 52 57 0a 0b 0a 04 14 16 5f 50 52 54 00  .GPRW......_PRT.
  0560: a0 0a 50 49 43 4d a4 41 52 30 31 a4 50 52 30 31  ..PICM.AR01.PR01
  0570: 5b 82 1f 4c 41 4e 30 08 5f 41 44 52 0c 00 00 04  [..LAN0._ADR....
  0580: 00 14 0f 5f 50 52 57 00 a4 47 50 52 57 0a 0b 0a  ..._PRW..GPRW...
  0590: 04 5b 82 40 0b 43 42 53 30 08 5f 41 44 52 0c 00  .[.-niIhIQQzEBw63ADYO7DcFQ@public.gmane.org
  05a0: 00 03 00 5b 80 43 42 53 50 02 0a 00 0a f0 5b 81  ...[.CBSP.....[.
  05b0: 38 43 42 53 50 03 00 20 43 42 30 34 08 00 48 07  8CBSP.. CB04..H.
  05c0: 43 42 31 34 08 00 48 13 43 42 33 43 08 00 08 43  CB14..H.CB3C...C
  05d0: 42 33 45 08 00 28 43 42 34 34 20 00 40 4c 50 4d  B3E..(CB44 .-mhBEk/xDt6Y@public.gmane.org
  05e0: 45 30 08 50 4d 45 31 08 14 0c 5f 49 4e 49 00 70  E0.PME1..._INI.p
  05f0: 00 43 42 34 34 14 12 43 42 53 57 01 a0 0b 93 68  .CB44..CBSW....h
  0600: 0a 03 70 00 43 42 34 34 14 2a 43 42 53 52 00 7b  ..p.CB44.*CBSR.{
  0610: 50 4d 45 31 0a 80 61 a0 19 61 7b 50 4d 45 30 0a  PME1..a..a{PME0.
  0620: fc 50 4d 45 30 70 50 4d 45 31 62 70 62 50 4d 45  .PME0pPME1bpbPME
  0630: 31 a4 61 14 0f 5f 50 52 57 00 a4 47 50 52 57 0a  1.a.._PRW..GPRW.
  0640: 0b 0a 03 5b 82 40 0b 43 42 53 31 08 5f 41 44 52  ...[.-h5Ge+ELprUN8FCDQoD0XbQ@public.gmane.org
  0650: 0c 01 00 03 00 5b 80 43 42 53 50 02 0a 00 0a f0  .....[.CBSP.....
  0660: 5b 81 38 43 42 53 50 03 00 20 43 42 30 34 08 00  [.8CBSP.. CB04..
  0670: 48 07 43 42 31 34 08 00 48 13 43 42 33 43 08 00  H.CB14..H.CB3C..
  0680: 08 43 42 33 45 08 00 28 43 42 34 34 20 00 40 4c  .CB3E..(CB44 .-GyM4K8BPxY0@public.gmane.org
  0690: 50 4d 45 30 08 50 4d 45 31 08 14 0c 5f 49 4e 49  PME0.PME1..._INI
  06a0: 00 70 00 43 42 34 34 14 12 43 42 53 57 01 a0 0b  .p.CB44..CBSW...
  06b0: 93 68 0a 03 70 00 43 42 34 34 14 2a 43 42 53 52  .h..p.CB44.*CBSR
  06c0: 00 7b 50 4d 45 31 0a 80 61 a0 19 61 7b 50 4d 45  .{PME1..a..a{PME
  06d0: 30 0a fc 50 4d 45 30 70 50 4d 45 31 62 70 62 50  0..PME0pPME1bpbP
  06e0: 4d 45 31 a4 61 14 0f 5f 50 52 57 00 a4 47 50 52  ME1.a.._PRW..GPR
  06f0: 57 0a 0b 0a 03 5b 82 1f 50 33 39 34 08 5f 41 44  W....[..P394._AD
  0700: 52 0c 02 00 03 00 14 0f 5f 50 52 57 00 a4 47 50  R......._PRW..GP
  0710: 52 57 0a 0b 0a 03 5b 82 49 06 4d 50 43 49 08 5f  RW....[.I.MPCI._
  0720: 41 44 52 0c 00 00 05 00 5b 80 4d 49 4e 50 02 0a  ADR.....[.MINP..
  0730: 00 0a 68 5b 81 15 4d 49 4e 50 01 56 4e 55 4d 20  ..h[..MINP.VNUM 
  0740: 00 40 14 53 4e 55 4d 20 00 20 14 36 4d 50 44 50  .-olPo5nJYOWA@public.gmane.org . .6MPDP
  0750: 00 a0 0e 93 53 4e 55 4d 0c 68 16 62 04 a4 0a 01  ....SNUM.h.b....
  0760: a0 0e 93 53 4e 55 4d 0c 86 80 22 25 a4 0a 02 a0  ...SNUM..."%....
  0770: 0e 93 53 4e 55 4d 0c 86 80 27 25 a4 0a 02 a4 0a  ..SNUM...'%.....
  0780: 00 5b 82 80 55 04 53 42 52 47 08 5f 41 44 52 0c  .[..U.SBRG._ADR.
  0790: 00 00 1f 00 5b 82 2b 50 49 43 5f 08 5f 48 49 44  ....[.+PIC_._HID
  07a0: 0b 41 d0 08 5f 43 52 53 11 18 0a 15 47 01 20 00  .A.._CRS....G. .
  07b0: 20 00 00 02 47 01 a0 00 a0 00 00 02 22 04 00 79   ...G......."..y
  07c0: 00 5b 82 4e 04 44 4d 41 44 08 5f 48 49 44 0c 41  .[.N.DMAD._HID.A
  07d0: d0 02 00 08 5f 43 52 53 11 38 0a 35 2a 10 04 47  ...._CRS.8.5*..G
  07e0: 01 00 00 00 00 00 10 47 01 81 00 81 00 00 03 47  .......G.......G
  07f0: 01 87 00 87 00 00 01 47 01 89 00 89 00 00 03 47  .......G.......G
  0800: 01 8f 00 8f 00 00 01 47 01 c0 00 c0 00 00 20 79  .......G...... y
  0810: 00 5b 82 25 54 4d 52 5f 08 5f 48 49 44 0c 41 d0  .[.%TMR_._HID.A.
  0820: 01 00 08 5f 43 52 53 11 10 0a 0d 47 01 40 00 40  ..._CRS....G.-4b8TPpkIZ3Q@public.gmane.org@
  0830: 00 00 04 22 01 00 79 00 5b 82 25 52 54 43 30 08  ..."..y.[.%RTC0.
  0840: 5f 48 49 44 0c 41 d0 0b 00 08 5f 43 52 53 11 10  _HID.A...._CRS..
  0850: 0a 0d 47 01 70 00 70 00 00 02 22 00 01 79 00 5b  ..G.p.p..."..y.[
  0860: 82 44 05 50 53 32 4b 08 5f 48 49 44 0c 41 d0 03  .D.PS2K._HID.A..
  0870: 03 08 5f 43 49 44 0c 41 d0 03 0b 14 1b 5f 53 54  .._CID.A....._ST
  0880: 41 00 79 0a 01 0a 0a 60 a0 0b 7b 49 4f 53 54 60  A.y....`..{IOST`
  0890: 00 a4 0a 0f a4 0a 00 08 5f 43 52 53 11 18 0a 15  ........_CRS....
  08a0: 47 01 60 00 60 00 00 01 47 01 64 00 64 00 00 01  G.`.`...G.d.d...
  08b0: 22 02 00 79 00 5b 82 44 08 50 53 32 4d 08 5f 48  "..y.[.D.PS2M._H
  08c0: 49 44 0c 41 d0 0f 03 08 5f 43 49 44 0c 41 d0 0f  ID.A...._CID.A..
  08d0: 13 14 1b 5f 53 54 41 00 79 0a 01 0a 0c 60 a0 0b  ..._STA.y....`..
  08e0: 7b 49 4f 53 54 60 00 a4 0a 0f a4 0a 00 08 43 52  {IOST`........CR
  08f0: 53 31 11 08 0a 05 22 00 10 79 00 08 43 52 53 32  S1...."..y..CRS2
  0900: 11 18 0a 15 47 01 60 00 60 00 00 01 47 01 64 00  ....G.`.`...G.d.
  0910: 64 00 00 01 22 00 10 79 00 14 21 5f 43 52 53 00  d..."..y..!_CRS.
  0920: 79 0a 01 0a 0a 60 a0 0d 7b 49 4f 53 54 60 00 a4  y....`..{IOST`..
  0930: 43 52 53 31 a1 06 a4 43 52 53 32 5b 82 22 53 50  CRS1...CRS2[."SP
  0940: 4b 52 08 5f 48 49 44 0c 41 d0 08 00 08 5f 43 52  KR._HID.A...._CR
  0950: 53 11 0d 0a 0a 47 01 61 00 61 00 00 01 79 00 5b  S....G.a.a...y.[
  0960: 82 25 43 4f 50 52 08 5f 48 49 44 0c 41 d0 0c 04  .%COPR._HID.A...
  0970: 08 5f 43 52 53 11 10 0a 0d 47 01 f0 00 f0 00 00  ._CRS....G......
  0980: 10 22 00 20 79 00 5b 82 40 12 53 49 4f 52 08 5f  .". y.[.-7gqfvHGvUQY@public.gmane.org
  0990: 48 49 44 0c 41 d0 0c 02 14 0b 5f 55 49 44 00 a4  HID.A....._UID..
  09a0: 53 50 49 4f 08 43 52 53 5f 11 1d 0a 1a 47 01 00  SPIO.CRS_....G..
  09b0: 00 00 00 00 00 47 01 00 00 00 00 00 00 47 01 00  .....G.......G..
  09c0: 00 00 00 00 00 79 00 14 40 0e 5f 43 52 53 00 a0  .....y..-d5bZnOei+g4@public.gmane.org
  09d0: 4d 04 90 92 93 53 50 49 4f 0b f0 03 94 53 50 49  M....SPIO....SPI
  09e0: 4f 0a f0 8b 43 52 53 5f 0a 02 47 50 31 30 8b 43  O...CRS_..GP10.C
  09f0: 52 53 5f 0a 04 47 50 31 31 8c 43 52 53 5f 0a 07  RS_..GP11.CRS_..
  0a00: 47 50 4c 31 70 53 50 49 4f 47 50 31 30 70 53 50  GPL1pSPIOGP10pSP
  0a10: 49 4f 47 50 31 31 70 0a 02 47 50 4c 31 a0 42 04  IOGP11p..GPL1.B.
  0a20: 49 4f 31 42 8b 43 52 53 5f 0a 0a 47 50 32 30 8b  IO1B.CRS_..GP20.
  0a30: 43 52 53 5f 0a 0c 47 50 32 31 8c 43 52 53 5f 0a  CRS_..GP21.CRS_.
  0a40: 0f 47 50 4c 32 70 49 4f 31 42 47 50 32 30 70 49  .GPL2pIO1BGP20pI
  0a50: 4f 31 42 47 50 32 31 70 49 4f 31 4c 47 50 4c 32  O1BGP21pIO1LGPL2
  0a60: a0 42 04 49 4f 58 42 8b 43 52 53 5f 0a 12 47 50  .B.IOXB.CRS_..GP
  0a70: 33 30 8b 43 52 53 5f 0a 14 47 50 33 31 8c 43 52  30.CRS_..GP31.CR
  0a80: 53 5f 0a 17 47 50 4c 33 70 49 4f 58 42 47 50 33  S_..GPL3pIOXBGP3
  0a90: 30 70 49 4f 58 42 47 50 33 31 70 49 4f 58 4c 47  0pIOXBGP31pIOXLG
  0aa0: 50 4c 33 a4 43 52 53 5f 08 44 43 41 54 12 2c 15  PL3.CRS_.DCAT.,.
  0ab0: 0a 03 0a 02 0a 01 0a 00 0a ff 0a 0c 0a ff 0a ff  ................
  0ac0: 0a 0b 0a ff 0a ff 0a ff 0a ff 0a ff 0a ff 0a ff  ................
  0ad0: 0a ff 0a ff 0a ff 0a ff 0a ff 5b 01 4d 55 54 30  ..........[.MUT0
  0ae0: 00 14 14 45 4e 46 47 01 5b 23 4d 55 54 30 ff 0f  ...ENFG.[#MUT0..
  0af0: 70 68 4c 44 4e 5f 14 0c 45 58 46 47 00 5b 27 4d  phLDN_..EXFG.['M
  0b00: 55 54 30 14 1d 4c 50 54 4d 01 45 4e 46 47 43 47  UT0..LPTM.ENFGCG
  0b10: 4c 44 68 7b 4f 50 54 31 0a 02 60 45 58 46 47 a4  LDh{OPT1..`EXFG.
  0b20: 60 14 35 46 49 52 4d 01 45 4e 46 47 43 47 4c 44  `.5FIRM.ENFGCGLD
  0b30: 68 70 44 4d 43 48 60 45 58 46 47 a0 13 90 95 60  hpDMCH`EXFG....`
  0b40: 0a 04 92 93 7b 60 0a 03 61 0a 00 70 0a 01 60 a1  ....{`..a..p..`.
  0b50: 05 70 0a 00 60 a4 60 14 4a 04 55 48 49 44 01 a0  .p..`.`.J.UHID..
  0b60: 3c 93 68 0a 01 45 4e 46 47 43 47 4c 44 68 70 44  <.h..ENFGCGLDhpD
  0b70: 4d 43 48 60 45 58 46 47 a0 1b 90 95 44 4d 43 48  MCH`EXFG....DMCH
  0b80: 0a 04 92 93 7b 44 4d 43 48 0a 03 61 0a 00 a4 0c  ....{DMCH..a....
  0b90: 3a 63 60 01 a1 07 a4 0c 41 d0 05 10 a4 0c 41 d0  :c`.....A.....A.
  0ba0: 05 01 14 06 53 49 4f 53 01 14 06 53 49 4f 57 01  ....SIOS...SIOW.
  0bb0: 14 06 53 49 4f 48 00 5b 80 49 4f 49 44 01 53 50  ..SIOH.[.IOID.SP
  0bc0: 49 4f 0a 02 5b 81 10 49 4f 49 44 01 49 4e 44 58  IO..[..IOID.INDX
  0bd0: 08 44 41 54 41 08 5b 86 4b 06 49 4e 44 58 44 41  .DATA.[.K.INDXDA
  0be0: 54 41 01 00 38 4c 44 4e 5f 08 00 40 0d 46 44 43  TA..8LDN_..-rwK7kbT9Rn8@public.gmane.org
  0bf0: 50 01 00 02 4c 50 54 50 01 55 52 41 50 01 55 52  P...LPTP.URAP.UR
  0c00: 42 50 01 00 4a 06 41 43 54 52 08 00 48 17 49 4f  BP..J.ACTR..H.IO
  0c10: 41 48 08 49 4f 41 4c 08 49 4f 48 32 08 49 4f 4c  AH.IOAL.IOH2.IOL
  0c20: 32 08 00 40 06 49 4e 54 52 08 00 18 44 4d 43 48  2..-gw5aB26Wwp1AYB6CTDACrQ@public.gmane.org
  0c30: 08 00 48 3d 4f 50 54 31 08 4f 50 54 32 08 4f 50  ..H=OPT1.OPT2.OP
  0c40: 54 33 08 14 0f 43 47 4c 44 01 a4 83 88 44 43 41  T3...CGLD....DCA
  0c50: 54 68 00 14 37 44 53 54 41 01 70 0a 00 60 79 0a  Th..7DSTA.p..`y.
  0c60: 01 68 61 a0 25 7b 49 4f 53 54 61 00 45 4e 46 47  .ha.%{IOSTa.ENFG
  0c70: 43 47 4c 44 68 a0 09 41 43 54 52 70 0a 0f 60 a1  CGLDh..ACTRp..`.
  0c80: 05 70 0a 0d 60 45 58 46 47 a4 60 14 40 05 44 43  .p..`EXFG.`.-dBzwlLfsvXA@public.gmane.org
  0c90: 4e 54 02 45 4e 46 47 43 47 4c 44 68 79 49 4f 41  NT.ENFGCGLDhyIOA
  0ca0: 48 0a 08 61 7d 49 4f 41 4c 61 61 52 52 49 4f 68  H..a}IOALaaRRIOh
  0cb0: 69 61 0a 08 a0 1d 90 95 44 4d 43 48 0a 04 92 93  ia......DMCH....
  0cc0: 7b 44 4d 43 48 0a 03 61 0a 00 52 44 4d 41 68 69  {DMCH..a..RDMAhi
  0cd0: 75 61 70 69 41 43 54 52 45 58 46 47 08 43 52 53  uapiACTREXFG.CRS
  0ce0: 31 11 13 0a 10 22 00 00 2a 00 00 47 01 00 00 00  1...."..*..G....
  0cf0: 00 01 00 79 00 8b 43 52 53 31 0a 01 49 52 51 4d  ...y..CRS1..IRQM
  0d00: 8c 43 52 53 31 0a 04 44 4d 41 4d 8b 43 52 53 31  .CRS1..DMAM.CRS1
  0d10: 0a 08 49 4f 31 31 8b 43 52 53 31 0a 0a 49 4f 31  ..IO11.CRS1..IO1
  0d20: 32 8c 43 52 53 31 0a 0d 4c 45 4e 31 08 43 52 53  2.CRS1..LEN1.CRS
  0d30: 32 11 1b 0a 18 22 40 00 2a 04 00 47 01 00 00 00  2...."@.*..G....
  0d40: 00 01 00 47 01 00 00 00 00 01 00 79 00 8b 43 52  ...G.......y..CR
  0d50: 53 32 0a 01 49 52 51 45 8c 43 52 53 32 0a 04 44  S2..IRQE.CRS2..D
  0d60: 4d 41 45 8b 43 52 53 32 0a 08 49 4f 32 31 8b 43  MAE.CRS2..IO21.C
  0d70: 52 53 32 0a 0a 49 4f 32 32 8c 43 52 53 32 0a 0d  RS2..IO22.CRS2..
  0d80: 4c 45 4e 32 8b 43 52 53 32 0a 10 49 4f 33 31 8b  LEN2.CRS2..IO31.
  0d90: 43 52 53 32 0a 12 49 4f 33 32 8c 43 52 53 32 0a  CRS2..IO32.CRS2.
  0da0: 15 4c 45 4e 33 14 4d 08 44 43 52 53 01 45 4e 46  .LEN3.M.DCRS.ENF
  0db0: 47 43 47 4c 44 68 79 49 4f 41 48 0a 08 49 4f 31  GCGLDhyIOAH..IO1
  0dc0: 31 7d 49 4f 41 4c 49 4f 31 31 49 4f 31 31 70 49  1}IOALIO11IO11pI
  0dd0: 4f 31 31 49 4f 31 32 74 82 49 4f 31 31 00 0a 01  O11IO12t.IO11...
  0de0: 60 79 0a 01 60 4c 45 4e 31 a0 10 49 4e 54 52 79  `y..`LEN1..INTRy
  0df0: 0a 01 49 4e 54 52 49 52 51 4d a1 08 70 0a 00 49  ..INTRIRQM..p..I
  0e00: 52 51 4d a0 1d 90 95 44 4d 43 48 0a 04 92 93 7b  RQM....DMCH....{
  0e10: 44 4d 43 48 0a 03 61 0a 00 79 0a 01 61 44 4d 41  DMCH..a..y..aDMA
  0e20: 4d a1 08 70 0a 00 44 4d 41 4d 45 58 46 47 a4 43  M..p..DMAMEXFG.C
  0e30: 52 53 31 14 43 08 44 53 52 53 02 8b 68 0a 01 49  RS1.C.DSRS..h..I
  0e40: 52 51 4d 8c 68 0a 04 44 4d 41 4d 8b 68 0a 08 49  RQM.h..DMAM.h..I
  0e50: 4f 31 31 45 4e 46 47 43 47 4c 44 69 7b 49 4f 31  O11ENFGCGLDi{IO1
  0e60: 31 0a ff 49 4f 41 4c 7a 49 4f 31 31 0a 08 49 4f  1..IOALzIO11..IO
  0e70: 41 48 a0 13 49 52 51 4d 82 49 52 51 4d 60 74 60  AH..IRQM.IRQM`t`
  0e80: 0a 01 49 4e 54 52 a1 08 70 0a 00 49 4e 54 52 a0  ..INTR..p..INTR.
  0e90: 13 44 4d 41 4d 82 44 4d 41 4d 60 74 60 0a 01 44  .DMAM.DMAM`t`..D
  0ea0: 4d 43 48 a1 08 70 0a 04 44 4d 43 48 45 58 46 47  MCH..p..DMCHEXFG
  0eb0: 44 43 4e 54 69 0a 01 5b 82 47 13 52 4d 53 43 08  DCNTi..[.G.RMSC.
  0ec0: 5f 48 49 44 0c 41 d0 0c 02 08 5f 55 49 44 0a 10  _HID.A...._UID..
  0ed0: 08 43 52 53 5f 11 4e 08 0a 8a 47 01 10 00 10 00  .CRS_.N...G.....
  0ee0: 00 10 47 01 22 00 22 00 00 1e 47 01 44 00 44 00  ..G."."...G.D.D.
  0ef0: 00 1c 47 01 63 00 63 00 00 01 47 01 65 00 65 00  ..G.c.c...G.e.e.
  0f00: 00 01 47 01 67 00 67 00 00 09 47 01 72 00 72 00  ..G.g.g...G.r.r.
  0f10: 00 0e 47 01 80 00 80 00 00 01 47 01 84 00 84 00  ..G.......G.....
  0f20: 00 03 47 01 88 00 88 00 00 01 47 01 8c 00 8c 00  ..G.......G.....
  0f30: 00 03 47 01 90 00 90 00 00 10 47 01 a2 00 a2 00  ..G.......G.....
  0f40: 00 1e 47 01 e0 00 e0 00 00 10 47 01 d0 04 d0 04  ..G.......G.....
  0f50: 00 02 47 01 00 00 00 00 00 00 47 01 00 00 00 00  ..G.......G.....
  0f60: 00 00 79 00 14 4b 08 5f 43 52 53 00 8b 43 52 53  ..y..K._CRS..CRS
  0f70: 5f 0a 7a 47 50 30 30 8b 43 52 53 5f 0a 7c 47 50  _.zGP00.CRS_.|GP
  0f80: 30 31 8c 43 52 53 5f 0a 7f 47 50 30 4c 70 50 4d  01.CRS_..GP0LpPM
  0f90: 42 53 47 50 30 30 70 50 4d 42 53 47 50 30 31 70  BSGP00pPMBSGP01p
  0fa0: 50 4d 4c 4e 47 50 30 4c a0 42 04 47 50 42 53 8b  PMLNGP0L.B.GPBS.
  0fb0: 43 52 53 5f 0a 82 47 50 32 30 8b 43 52 53 5f 0a  CRS_..GP20.CRS_.
  0fc0: 84 47 50 32 31 8c 43 52 53 5f 0a 87 47 50 32 4c  .GP21.CRS_..GP2L
  0fd0: 70 47 50 42 53 47 50 32 30 70 47 50 42 53 47 50  pGPBSGP20pGPBSGP
  0fe0: 32 31 70 47 50 4c 4e 47 50 32 4c a4 43 52 53 5f  21pGPLNGP2L.CRS_
  0ff0: 5b 82 4e 09 4f 4d 53 43 08 5f 48 49 44 0c 41 d0  [.N.OMSC._HID.A.
  1000: 0c 02 08 5f 55 49 44 0a 00 08 43 52 53 5f 11 1d  ..._UID...CRS_..
  1010: 0a 1a 86 09 00 00 00 00 00 00 00 00 00 00 86 09  ................
  1020: 00 00 00 00 00 00 00 00 00 00 79 00 14 43 06 5f  ..........y..C._
  1030: 43 52 53 00 a0 46 05 41 50 43 42 8a 43 52 53 5f  CRS..F.APCB.CRS_
  1040: 0a 08 4d 4c 30 31 8a 43 52 53 5f 0a 04 4d 42 30  ..ML01.CRS_..MB0
  1050: 31 8a 43 52 53 5f 0a 14 4d 4c 30 32 8a 43 52 53  1.CRS_..ML02.CRS
  1060: 5f 0a 10 4d 42 30 32 70 41 50 43 42 4d 42 30 31  _..MB02pAPCBMB01
  1070: 70 41 50 43 4c 4d 4c 30 31 70 0c 00 00 e0 fe 4d  pAPCLML01p.....M
  1080: 42 30 32 70 0b 00 10 4d 4c 30 32 a4 43 52 53 5f  B02p...ML02.CRS_
  1090: 5b 82 4d 14 5c 2e 5f 53 42 5f 52 4d 45 4d 08 5f  [.M.\._SB_RMEM._
  10a0: 48 49 44 0c 41 d0 0c 01 08 5f 55 49 44 0a 01 08  HID.A...._UID...
  10b0: 43 52 53 5f 11 42 04 0a 3e 86 09 00 01 00 00 00  CRS_.B..>.......
  10c0: 00 00 00 0a 00 86 09 00 00 00 00 00 00 00 00 00  ................
  10d0: 00 86 09 00 00 00 00 0e 00 00 00 02 00 86 09 00  ................
  10e0: 01 00 00 10 00 00 00 00 00 86 09 00 00 00 00 00  ................
  10f0: 00 00 00 00 00 79 00 14 47 0e 5f 43 52 53 00 8a  .....y..G._CRS..
  1100: 43 52 53 5f 0a 10 42 41 53 31 8a 43 52 53 5f 0a  CRS_..BAS1.CRS_.
  1110: 14 4c 45 4e 31 8a 43 52 53 5f 0a 1c 42 41 53 32  .LEN1.CRS_..BAS2
  1120: 8a 43 52 53 5f 0a 20 4c 45 4e 32 8a 43 52 53 5f  .CRS_. LEN2.CRS_
  1130: 0a 2c 4c 45 4e 33 8a 43 52 53 5f 0a 34 42 41 53  .,LEN3.CRS_.4BAS
  1140: 34 8a 43 52 53 5f 0a 38 4c 45 4e 34 a0 05 4f 53  4.CRS_.8LEN4..OS
  1150: 46 4c a1 41 06 a0 28 4d 47 31 42 a0 22 94 4d 47  FL.A..(MG1B.".MG
  1160: 31 42 0c 00 00 0c 00 70 0c 00 00 0c 00 42 41 53  1B.....p.....BAS
  1170: 31 74 4d 47 31 42 42 41 53 31 4c 45 4e 31 a1 15  1tMG1BBAS1LEN1..
  1180: 70 0c 00 00 0c 00 42 41 53 31 70 0c 00 00 02 00  p.....BAS1p.....
  1190: 4c 45 4e 31 a0 1f 72 4d 47 31 42 4d 47 31 4c 60  LEN1..rMG1BMG1L`
  11a0: 70 60 42 41 53 32 74 0c 00 00 10 00 42 41 53 32  p`BAS2t.....BAS2
  11b0: 4c 45 4e 32 74 4d 47 32 42 0c 00 00 10 00 4c 45  LEN2tMG2B.....LE
  11c0: 4e 33 72 4d 47 32 42 4d 47 32 4c 42 41 53 34 74  N3rMG2BMG2LBAS4t
  11d0: 0a 00 42 41 53 34 4c 45 4e 34 a4 43 52 53 5f 10  ..BAS4LEN4.CRS_.
  11e0: 42 5e 5c 00 5b 80 5c 47 50 53 43 01 0a b2 0a 02  B^\.[.\GPSC.....
  11f0: 5b 81 11 5c 47 50 53 43 01 53 4d 43 4d 08 53 4d  [..\GPSC.SMCM.SM
  1200: 53 54 08 14 0d 5c 49 53 4d 49 09 70 68 53 4d 43  ST...\ISMI.phSMC
  1210: 4d 14 0d 5c 44 49 41 47 01 70 68 44 42 47 38 5b  M..\DIAG.phDBG8[
  1220: 80 5c 53 49 4f 47 01 49 4f 31 42 0a 10 5b 81 4c  .\SIOG.IO1B..[.L
  1230: 14 5c 53 49 4f 47 01 50 4f 30 30 01 50 4f 30 31  .\SIOG.PO00.PO01
  1240: 01 50 4f 30 32 01 50 4f 30 33 01 50 4f 30 34 01  .PO02.PO03.PO04.
  1250: 50 4f 30 35 01 50 4f 30 36 01 50 4f 30 37 01 50  PO05.PO06.PO07.P
  1260: 49 30 30 01 50 49 30 31 01 50 49 30 32 01 50 49  I00.PI01.PI02.PI
  1270: 30 33 01 50 49 30 34 01 50 49 30 35 01 50 49 30  03.PI04.PI05.PI0
  1280: 36 01 50 49 30 37 01 00 10 50 4f 31 30 01 50 4f  6.PI07...PO10.PO
  1290: 31 31 01 50 4f 31 32 01 50 4f 31 33 01 50 4f 31  11.PO12.PO13.PO1
  12a0: 34 01 50 4f 31 35 01 50 4f 31 36 01 50 4f 31 37  4.PO15.PO16.PO17
  12b0: 01 50 49 31 30 01 50 49 31 31 01 50 49 31 32 01  .PI10.PI11.PI12.
  12c0: 50 49 31 33 01 50 49 31 34 01 50 49 31 35 01 50  PI13.PI14.PI15.P
  12d0: 49 31 36 01 50 49 31 37 01 00 10 50 4f 32 30 01  I16.PI17...PO20.
  12e0: 50 4f 32 31 01 50 4f 32 32 01 50 4f 32 33 01 50  PO21.PO22.PO23.P
  12f0: 4f 32 34 01 50 4f 32 35 01 50 4f 32 36 01 50 4f  O24.PO25.PO26.PO
  1300: 32 37 01 50 49 32 30 01 50 49 32 31 01 50 49 32  27.PI20.PI21.PI2
  1310: 32 01 50 49 32 33 01 50 49 32 34 01 50 49 32 35  2.PI23.PI24.PI25
  1320: 01 50 49 32 36 01 50 49 32 37 01 50 4f 33 30 01  .PI26.PI27.PO30.
  1330: 50 4f 33 31 01 50 4f 33 32 01 50 4f 33 33 01 50  PO31.PO32.PO33.P
  1340: 4f 33 34 01 50 4f 33 35 01 50 4f 33 36 01 50 4f  O34.PO35.PO36.PO
  1350: 33 37 01 50 49 33 30 01 50 49 33 31 01 50 49 33  37.PI30.PI31.PI3
  1360: 32 01 50 49 33 33 01 50 49 33 34 01 50 49 33 35  2.PI33.PI34.PI35
  1370: 01 50 49 33 36 01 50 49 33 37 01 5b 80 5c 50 4d  .PI36.PI37.[.\PM
  1380: 49 4f 01 50 4d 42 53 0a 80 5b 81 42 08 5c 50 4d  IO.PMBS..[.B.\PM
  1390: 49 4f 01 00 40 08 00 01 54 44 54 59 03 54 45 4e  IO..-cjaTO3iNAyF8XjiK1ubb3Q@public.gmane.org
  13a0: 41 01 54 54 44 54 03 46 52 43 54 01 00 08 54 48  A.TTDT.FRCT...TH
  13b0: 4c 53 01 00 4e 0a 00 0b 53 42 50 53 01 00 04 00  LS..N...SBPS....
  13c0: 08 47 30 38 53 01 00 02 47 31 31 53 01 47 31 32  .G08S...G11S.G12
  13d0: 53 01 46 4c 50 53 01 00 02 00 02 54 50 4f 4c 01  S.FLPS.....TPOL.
  13e0: 00 05 00 08 00 08 47 30 38 45 01 00 02 47 31 31  ......G08E...G11
  13f0: 45 01 47 31 32 45 01 00 03 00 04 53 4c 50 45 01  E.G12E.....SLPE.
  1400: 00 03 00 18 00 04 53 4c 50 53 01 00 03 5b 80 5c  ......SLPS...[.\
  1410: 47 50 49 4f 01 47 50 42 53 0a 40 5b 81 41 04 5c  GPIO.GPBS.@[.A.\
  1420: 47 50 49 4f 01 00 40 06 00 19 43 42 53 55 01 00  GPIO..-x+25rMZ8fMnhvxM+mQhndA@public.gmane.org
  1430: 02 49 50 57 52 01 00 43 0e 00 0b 4c 49 44 4c 01  .IPWR..C...LIDL.
  1440: 00 01 46 4c 50 4c 01 00 42 05 42 4b 4c 54 01 53  ..FLPL..B.BKLT.S
  1450: 42 41 59 02 46 53 30 32 03 46 53 35 36 02 5b 80  BAY.FS02.FS56.[.
  1460: 5c 45 43 4d 53 01 0a 72 0a 02 5b 81 11 5c 45 43  \ECMS..r..[..\EC
  1470: 4d 53 11 45 49 4e 44 08 45 44 41 54 08 5b 86 47  MS.EIND.EDAT.[.G
  1480: 0e 45 49 4e 44 45 44 41 54 01 00 40 08 49 4b 46  .EINDEDAT..-Jv0LJbETNRo@public.gmane.org
  1490: 47 08 46 52 50 4e 10 52 41 4d 42 20 41 56 4f 4c  G.FRPN.RAMB AVOL
  14a0: 08 4c 42 54 4e 08 43 4b 4c 4e 08 43 4b 30 30 08  .LBTN.CKLN.CK00.
  14b0: 43 4b 30 31 08 43 4b 30 32 08 43 4b 30 33 08 43  CK01.CK02.CK03.C
  14c0: 4b 30 34 08 43 4b 30 35 08 43 4b 30 36 08 43 4b  K04.CK05.CK06.CK
  14d0: 30 37 08 43 4b 30 38 08 43 4b 30 39 08 43 4b 31  07.CK08.CK09.CK1
  14e0: 30 08 43 4b 31 31 08 43 4b 31 32 08 43 4b 31 33  0.CK11.CK12.CK13
  14f0: 08 43 4b 31 34 08 43 4b 31 35 08 43 4b 31 36 08  .CK14.CK15.CK16.
  1500: 43 4b 31 37 08 43 4b 31 38 08 43 4b 31 39 08 43  CK17.CK18.CK19.C
  1510: 4b 32 30 08 43 4b 32 31 08 43 4b 32 32 08 43 4b  K20.CK21.CK22.CK
  1520: 32 33 08 43 4b 32 34 08 43 4b 32 35 08 43 4b 32  23.CK24.CK25.CK2
  1530: 36 08 43 4b 32 37 08 43 4b 32 38 08 43 4b 32 39  6.CK27.CK28.CK29
  1540: 08 45 52 52 46 08 4f 43 4c 4b 08 57 49 44 45 01  .ERRF.OCLK.WIDE.
  1550: 4f 56 43 4b 02 53 34 32 4b 03 00 02 43 50 55 52  OVCK.S42K...CPUR
  1560: 06 43 50 55 46 02 5b 80 5c 52 41 4d 57 00 52 41  .CPUF.[.\RAMW.RA
  1570: 4d 42 0a ff 5b 81 46 0c 5c 52 41 4d 57 01 00 40  MB..[.F.\RAMW..@
  1580: 58 54 52 54 59 08 46 53 46 4e 08 46 53 54 41 10  XTRTY.FSFN.FSTA.
  1590: 46 41 44 52 20 46 53 49 5a 10 41 43 54 44 08 41  FADR FSIZ.ACTD.A
  15a0: 56 4c 44 08 53 45 54 44 08 41 43 50 46 01 44 43  VLD.SETD.ACPF.DC
  15b0: 50 46 01 43 48 47 46 01 00 05 50 41 44 4c 10 43  PF.CHGF...PADL.C
  15c0: 41 44 4c 10 43 53 54 45 10 4e 53 54 45 10 53 53  ADL.CSTE.NSTE.SS
  15d0: 54 45 10 53 46 55 4e 08 54 53 41 44 08 54 41 43  TE.SFUN.TSAD.TAC
  15e0: 33 08 54 41 43 32 08 54 41 43 31 08 54 41 43 30  3.TAC2.TAC1.TAC0
  15f0: 08 54 50 53 56 08 54 43 52 54 08 46 31 4c 30 08  .TPSV.TCRT.F1L0.
  1600: 46 32 4c 30 08 46 31 4c 31 08 46 32 4c 31 08 46  F2L0.F1L1.F2L1.F
  1610: 31 4c 32 08 46 32 4c 32 08 46 31 4c 33 08 46 32  1L2.F2L2.F1L3.F2
  1620: 4c 33 08 46 31 4c 34 08 46 32 4c 34 08 53 4c 50  L3.F1L4.F2L4.SLP
  1630: 54 08 44 42 52 44 20 53 49 44 53 08 08 4f 53 46  T.DBRD SIDS..OSF
  1640: 47 0a 00 08 4f 53 39 58 0a 01 08 4f 53 39 38 0a  G...OS9X...OS98.
  1650: 02 08 4f 53 4d 45 0a 04 08 4f 53 32 4b 0a 08 08  ..OSME...OS2K...
  1660: 4f 53 58 50 0a 10 14 40 0c 4f 53 56 52 00 a0 12  OSXP...-jWhnJXH6hPA@public.gmane.org
  1670: 5b 12 5c 5f 4f 53 49 60 70 4f 53 58 50 4f 53 46  [.\_OSI`pOSXPOSF
  1680: 47 a1 40 0a a0 26 4d 43 54 48 5c 5f 4f 53 5f 0d  G.-rVxdn2TrCWA@public.gmane.org&MCTH\_OS_.
  1690: 4d 69 63 72 6f 73 6f 66 74 20 57 69 6e 64 6f 77  Microsoft Window
  16a0: 73 00 70 4f 53 39 38 4f 53 46 47 a1 46 07 a0 3c  s.pOS98OSFG.F..<
  16b0: 4d 43 54 48 5c 5f 4f 53 5f 0d 4d 69 63 72 6f 73  MCTH\_OS_.Micros
  16c0: 6f 66 74 20 57 69 6e 64 6f 77 73 4d 45 3a 20 4d  oft WindowsME: M
  16d0: 69 6c 6c 65 6e 6e 69 75 6d 20 45 64 69 74 69 6f  illennium Editio
  16e0: 6e 00 70 4f 53 4d 45 4f 53 46 47 a1 36 a0 29 4d  n.pOSMEOSFG.6.)M
  16f0: 43 54 48 5c 5f 4f 53 5f 0d 4d 69 63 72 6f 73 6f  CTH\_OS_.Microso
  1700: 66 74 20 57 69 6e 64 6f 77 73 20 4e 54 00 70 4f  ft Windows NT.pO
  1710: 53 32 4b 4f 53 46 47 a1 0a 70 4f 53 58 50 4f 53  S2KOSFG..pOSXPOS
  1720: 46 47 a4 4f 53 46 47 5b 80 5c 53 49 4f 50 01 5c  FG.OSFG[.\SIOP.\
  1730: 53 50 49 4f 0a 02 5b 81 11 5c 53 49 4f 50 11 53  SPIO..[..\SIOP.S
  1740: 49 4f 49 08 53 49 4f 44 08 5b 86 19 53 49 4f 49  IOI.SIOD.[..SIOI
  1750: 53 49 4f 44 01 00 38 4c 44 4e 50 08 00 40 14 4c  SIOD..8LDNP..-4utBd9VADec@public.gmane.org
  1760: 44 43 50 08 14 45 04 5c 44 42 47 52 01 70 4c 44  DCP..E.\DBGR.pLD
  1770: 4e 50 60 70 0a 01 4c 44 4e 50 70 4c 44 43 50 61  NP`p..LDNPpLDCPa
  1780: 70 0a 01 4c 44 43 50 70 68 44 42 52 44 5c 49 53  p..LDCPphDBRD\IS
  1790: 4d 49 5c 41 44 42 52 70 0a 01 4c 44 4e 50 70 61  MI\ADBRp..LDNPpa
  17a0: 4c 44 43 50 70 60 4c 44 4e 50 08 4d 4e 41 4d 0d  LDCPp`LDNP.MNAM.
  17b0: 4d 32 4e 00 08 4f 4e 41 4d 0d 41 53 55 53 54 45  M2N..ONAM.ASUSTE
  17c0: 4b 00 10 17 5c 2e 5f 53 42 5f 50 43 49 30 14 0b  K...\._SB_PCI0..
  17d0: 5f 49 4e 49 00 5c 4f 53 56 52 10 4d 66 5c 2f 03  _INI.\OSVR.Mf\/.
  17e0: 5f 53 42 5f 50 43 49 30 53 42 52 47 5b 82 4a 65  _SB_PCI0SBRG[.Je
  17f0: 45 43 30 5f 08 5f 48 49 44 0c 41 d0 0c 09 08 5f  EC0_._HID.A...._
  1800: 43 52 53 11 15 0a 12 47 01 62 00 62 00 00 01 47  CRS....G.b.b...G
  1810: 01 66 00 66 00 00 01 79 00 08 5f 47 50 45 0a 1c  .f.f...y.._GPE..
  1820: 5b 01 4d 55 45 43 00 08 45 43 46 4c 00 14 0b 45  [.MUEC..ECFL...E
  1830: 43 41 56 00 a4 45 43 46 4c 5b 80 45 43 4f 52 03  CAV..ECFL[.ECOR.
  1840: 0a 00 0a 80 5b 81 4b 0e 45 43 4f 52 11 00 20 43  ....[.K.ECOR.. C
  1850: 4d 44 31 08 43 44 54 31 08 43 44 54 32 08 43 44  MD1.CDT1.CDT2.CD
  1860: 54 33 08 00 48 1d 50 35 30 49 01 00 01 00 01 50  T3..H.P50I.....P
  1870: 34 33 49 01 50 35 34 49 01 50 35 35 49 01 00 01  43I.P54I.P55I...
  1880: 00 01 50 35 34 44 08 50 35 35 44 08 00 10 50 35  ..P54D.P55D...P5
  1890: 34 53 08 50 35 35 53 08 50 35 30 53 08 50 34 33  4S.P55S.P50S.P43
  18a0: 53 08 50 35 34 54 08 50 35 35 54 08 50 35 30 54  S.P54T.P55T.P50T
  18b0: 08 50 34 33 54 08 50 36 30 53 08 50 36 31 53 08  .P43T.P60S.P61S.
  18c0: 50 36 32 53 08 50 36 33 53 08 50 36 34 53 08 50  P62S.P63S.P64S.P
  18d0: 36 35 53 08 50 36 36 53 08 50 36 37 53 08 50 36  65S.P66S.P67S.P6
  18e0: 30 54 08 50 36 31 54 08 50 36 32 54 08 50 36 33  0T.P61T.P62T.P63
  18f0: 54 08 50 36 34 54 08 50 36 35 54 08 50 36 36 54  T.P64T.P65T.P66T
  1900: 08 50 36 37 54 08 00 40 0c 50 36 30 49 01 50 36  .P67T..-S8FTQwsUo44@public.gmane.org
  1910: 31 49 01 50 36 32 49 01 50 36 33 49 01 50 36 34  1I.P62I.P63I.P64
  1920: 49 01 50 36 35 49 01 50 36 36 49 01 50 36 37 49  I.P65I.P66I.P67I
  1930: 01 08 53 4d 42 46 0a 00 5b 80 53 4d 42 58 03 0a  ..SMBF..[.SMBX..
  1940: 18 0a 28 5b 81 43 04 53 4d 42 58 01 50 52 54 43  ..([.C.SMBX.PRTC
  1950: 08 53 53 54 53 05 00 01 41 4c 46 47 01 43 44 46  .SSTS...ALFG.CDF
  1960: 47 01 41 44 44 52 08 43 4d 44 42 08 42 44 41 54  G.ADDR.CMDB.BDAT
  1970: 40 10 42 43 4e 54 08 00 01 41 4c 41 44 07 41 4c  @.BCNT...ALAD.AL
  1980: 44 30 08 41 4c 44 31 08 5b 81 12 53 4d 42 58 01  D0.ALD1.[..SMBX.
  1990: 00 20 44 41 54 30 08 44 41 54 31 08 5b 81 0d 53  . DAT0.DAT1.[..S
  19a0: 4d 42 58 01 00 20 44 54 32 42 10 5b 80 4e 53 42  MBX.. DT2B.[.NSB
  19b0: 53 03 0a 40 0a 04 5b 81 1a 4e 53 42 53 01 41 32  S..-rVxdn2TrCWA@public.gmane.org[..NSBS.A2
  19c0: 41 44 08 41 32 44 30 08 41 32 44 31 08 41 33 41  AD.A2D0.A2D1.A3A
  19d0: 44 08 14 1a 5f 49 4e 49 00 a0 13 92 94 5c 4f 53  D..._INI.....\OS
  19e0: 46 47 5c 4f 53 4d 45 70 01 45 43 46 4c 14 12 5f  FG\OSMEp.ECFL.._
  19f0: 52 45 47 02 a0 0b 93 68 0a 03 70 69 45 43 46 4c  REG....h..piECFL
  1a00: 14 1f 5f 51 30 31 00 a0 18 5c 2e 5f 53 42 5f 41  .._Q01...\._SB_A
  1a10: 54 4b 50 86 5c 2e 5f 53 42 5f 41 54 4b 44 0a 52  TKP.\._SB_ATKD.R
  1a20: 14 1f 5f 51 30 32 00 a0 18 5c 2e 5f 53 42 5f 41  .._Q02...\._SB_A
  1a30: 54 4b 50 86 5c 2e 5f 53 42 5f 41 54 4b 44 0a 53  TKP.\._SB_ATKD.S
  1a40: 14 1f 5f 51 30 33 00 a0 18 5c 2e 5f 53 42 5f 41  .._Q03...\._SB_A
  1a50: 54 4b 50 86 5c 2e 5f 53 42 5f 41 54 4b 44 0a 54  TKP.\._SB_ATKD.T
  1a60: 14 1f 5f 51 30 34 00 a0 18 5c 2e 5f 53 42 5f 41  .._Q04...\._SB_A
  1a70: 54 4b 50 86 5c 2e 5f 53 42 5f 41 54 4b 44 0a 55  TKP.\._SB_ATKD.U
  1a80: 14 1f 5f 51 30 35 00 a0 18 5c 2e 5f 53 42 5f 41  .._Q05...\._SB_A
  1a90: 54 4b 50 86 5c 2e 5f 53 42 5f 41 54 4b 44 0a 56  TKP.\._SB_ATKD.V
  1aa0: 14 13 5f 51 30 41 00 86 5c 2e 5f 53 42 5f 53 4c  .._Q0A..\._SB_SL
  1ab0: 50 42 0a 80 14 38 5f 51 30 42 00 a0 31 5c 2f 05  PB...8_Q0B..1\/.
  1ac0: 5f 53 42 5f 50 43 49 30 50 30 50 31 4d 50 43 49  _SB_PCI0P0P1MPCI
  1ad0: 4d 50 44 50 a0 18 5c 2e 5f 53 42 5f 41 54 4b 50  MPDP..\._SB_ATKP
  1ae0: 86 5c 2e 5f 53 42 5f 41 54 4b 44 0a 5d 14 48 04  .\._SB_ATKD.].H.
  1af0: 5f 51 30 45 00 a0 0d 94 4c 42 54 4e 0a 00 76 4c  _Q0E....LBTN..vL
  1b00: 42 54 4e a0 0f 94 4c 42 54 4e 0a 0f 70 0a 0f 4c  BTN...LBTN..p..L
  1b10: 42 54 4e 53 54 42 52 a0 1e 5c 2e 5f 53 42 5f 41  BTNSTBR..\._SB_A
  1b20: 54 4b 50 86 5c 2e 5f 53 42 5f 41 54 4b 44 72 4c  TKP.\._SB_ATKDrL
  1b30: 42 54 4e 0a 20 00 14 41 04 5f 51 30 46 00 a0 0d  BTN. ..A._Q0F...
  1b40: 95 4c 42 54 4e 0a 0f 75 4c 42 54 4e a1 08 70 0a  .LBTN..uLBTN..p.
  1b50: 0f 4c 42 54 4e 53 54 42 52 a0 1e 5c 2e 5f 53 42  .LBTNSTBR..\._SB
  1b60: 5f 41 54 4b 50 86 5c 2e 5f 53 42 5f 41 54 4b 44  _ATKP.\._SB_ATKD
  1b70: 72 4c 42 54 4e 0a 10 00 14 3a 5f 51 31 30 00 70  rLBTN....:_Q10.p
  1b80: 5c 42 4b 4c 54 60 7f 60 0a 01 60 70 60 5c 42 4b  \BKLT`.`..`p`\BK
  1b90: 4c 54 a0 20 5c 2e 5f 53 42 5f 41 54 4b 50 74 0a  LT. \._SB_ATKPt.
  1ba0: 34 5c 42 4b 4c 54 60 86 5c 2e 5f 53 42 5f 41 54  4\BKLT`.\._SB_AT
  1bb0: 4b 44 60 14 42 04 5f 51 31 31 00 46 48 4b 57 70  KD`.B._Q11.FHKWp
  1bc0: 5c 41 44 56 47 60 a0 23 5c 4e 41 54 4b 72 60 0a  \ADVG`.#\NATKr`.
  1bd0: 60 61 a0 17 5c 2e 5f 53 42 5f 41 54 4b 50 86 5c  `a..\._SB_ATKP.\
  1be0: 2e 5f 53 42 5f 41 54 4b 44 61 a1 07 5c 53 57 48  ._SB_ATKDa..\SWH
  1bf0: 47 60 46 48 4b 53 08 46 48 4b 4d 01 14 17 46 48  G`FHKS.FHKM...FH
  1c00: 4b 57 08 a2 0a 92 46 48 4b 4d 5b 22 0a 0a 70 00  KW....FHKM["..p.
  1c10: 46 48 4b 4d 14 0c 46 48 4b 53 08 70 01 46 48 4b  FHKM..FHKS.p.FHK
  1c20: 4d 14 1f 5f 51 31 33 00 a0 18 5c 2e 5f 53 42 5f  M.._Q13...\._SB_
  1c30: 41 54 4b 50 86 5c 2e 5f 53 42 5f 41 54 4b 44 0a  ATKP.\._SB_ATKD.
  1c40: 32 14 2f 5f 51 31 34 00 a0 0f 95 5c 41 56 4f 4c  2./_Q14....\AVOL
  1c50: 0a 0f 75 5c 41 56 4f 4c a0 18 5c 2e 5f 53 42 5f  ..u\AVOL..\._SB_
  1c60: 41 54 4b 50 86 5c 2e 5f 53 42 5f 41 54 4b 44 0a  ATKP.\._SB_ATKD.
  1c70: 31 14 2f 5f 51 31 35 00 a0 0f 94 5c 41 56 4f 4c  1./_Q15....\AVOL
  1c80: 0a 00 76 5c 41 56 4f 4c a0 18 5c 2e 5f 53 42 5f  ..v\AVOL..\._SB_
  1c90: 41 54 4b 50 86 5c 2e 5f 53 42 5f 41 54 4b 44 0a  ATKP.\._SB_ATKD.
  1ca0: 30 14 24 5f 51 32 30 00 a0 11 43 44 46 47 70 01  0.$_Q20...CDFGp.
  1cb0: 53 4d 42 46 70 00 43 44 46 47 a0 0b 41 4c 46 47  SMBFp.CDFG..ALFG
  1cc0: 70 00 41 4c 46 47 14 1f 5f 51 33 30 00 a0 18 5c  p.ALFG.._Q30...\
  1cd0: 2e 5f 53 42 5f 41 54 4b 50 86 5c 2e 5f 53 42 5f  ._SB_ATKP.\._SB_
  1ce0: 41 54 4b 44 0a 50 14 1f 5f 51 33 31 00 a0 18 5c  ATKD.P.._Q31...\
  1cf0: 2e 5f 53 42 5f 41 54 4b 50 86 5c 2e 5f 53 42 5f  ._SB_ATKP.\._SB_
  1d00: 41 54 4b 44 0a 51 14 1f 5f 51 33 32 00 a0 18 5c  ATKD.Q.._Q32...\
  1d10: 2e 5f 53 42 5f 41 54 4b 50 86 5c 2e 5f 53 42 5f  ._SB_ATKP.\._SB_
  1d20: 41 54 4b 44 0a 52 14 1f 5f 51 33 33 00 a0 18 5c  ATKD.R.._Q33...\
  1d30: 2e 5f 53 42 5f 41 54 4b 50 86 5c 2e 5f 53 42 5f  ._SB_ATKP.\._SB_
  1d40: 41 54 4b 44 0a 53 14 1f 5f 51 33 36 00 a0 18 5c  ATKD.S.._Q36...\
  1d50: 2e 5f 53 42 5f 41 54 4b 50 86 5c 2e 5f 53 42 5f  ._SB_ATKP.\._SB_
  1d60: 41 54 4b 44 0a 5c 08 4c 45 44 53 ff 14 48 07 45  ATKD.\.LEDS..H.E
  1d70: 43 30 53 01 a0 0b 93 68 0a 03 53 54 43 35 0a 2c  C0S....h..STC5.,
  1d80: a0 44 06 68 a0 40 06 95 68 0a 04 70 52 44 43 33  .D.h.-eQfXj+O8kBgtCF96LtyOCQ@public.gmane.org
  1d90: 0a 02 60 7b 60 0a e0 4c 45 44 53 7b 4c 45 44 53  ..`{`..LEDS{LEDS
  1da0: 0a 80 61 a0 09 92 61 53 54 43 35 0a 2f 7b 4c 45  ..a...aSTC5./{LE
  1db0: 44 53 0a 40 61 a0 09 92 61 53 54 43 35 0a 2e 7b  DS.-cMi9nDMyJ7HtBOXIM7BG6w@public.gmane.org{
  1dc0: 4c 45 44 53 0a 20 61 a0 09 92 61 53 54 43 35 0a  LEDS. a...aSTC5.
  1dd0: 2d 57 43 4d 44 0a cb 70 0b f4 01 60 a2 08 60 5b  -WCMD..p...`..`[
  1de0: 21 0a 0a 76 60 14 42 06 45 43 30 57 01 a0 0b 93  !..v`.B.EC0W....
  1df0: 68 0a 03 53 54 43 35 0a 4c a0 0f 93 68 0a 04 70  h..STC5.L...h..p
  1e00: 41 43 41 50 5c 41 43 50 46 a0 3e 68 a0 3b 95 68  ACAP\ACPF.>h.;.h
  1e10: 0a 04 7b 4c 45 44 53 0a 80 61 a0 09 92 61 53 54  ..{LEDS..a...aST
  1e20: 43 35 0a 4f 7b 4c 45 44 53 0a 40 61 a0 09 92 61  C5.O{LEDS.-9Y6fnZUAFxY@public.gmane.org
  1e30: 53 54 43 35 0a 4e 7b 4c 45 44 53 0a 20 61 a0 09  STC5.N{LEDS. a..
  1e40: 92 61 53 54 43 35 0a 4d 10 45 93 5c 2f 04 5f 53  .aSTC5.M.E.\/._S
  1e50: 42 5f 50 43 49 30 53 42 52 47 45 43 30 5f 14 3f  B_PCI0SBRGEC0_.?
  1e60: 57 43 4d 44 09 a0 1e 45 43 41 56 a0 18 93 5b 23  WCMD...ECAV...[#
  1e70: 4d 55 45 43 ff ff 0a 00 70 68 43 4d 44 31 5b 27  MUEC....phCMD1['
  1e80: 4d 55 45 43 a1 19 a0 17 93 5b 23 4d 55 45 43 ff  MUEC.....[#MUEC.
  1e90: ff 0a 00 45 43 57 43 68 5b 27 4d 55 45 43 14 44  ...ECWCh['MUEC.D
  1ea0: 06 44 4c 59 30 09 a0 08 92 45 43 41 56 a4 ff 70  .DLY0....ECAV..p
  1eb0: ff 60 a0 4e 04 93 5b 23 4d 55 45 43 ff ff 0a 00  .`.N..[#MUEC....
  1ec0: 70 68 43 44 54 31 70 0a 6b 43 44 54 32 70 0a 00  phCDT1p.kCDT2p..
  1ed0: 43 44 54 33 70 0a bb 43 4d 44 31 70 0a 7f 61 a2  CDT3p..CMD1p..a.
  1ee0: 0d 90 61 43 4d 44 31 5b 22 0a 01 76 61 a0 0d 93  ..aCMD1["..va...
  1ef0: 43 4d 44 31 00 70 43 44 54 31 60 5b 27 4d 55 45  CMD1.pCDT1`['MUE
  1f00: 43 a4 60 08 50 57 41 43 11 13 0a 10 01 05 0a 0f  C.`.PWAC........
  1f10: 14 19 1e 23 28 2d 32 37 3c 41 46 49 08 50 57 44  ...#(-27<AFI.PWD
  1f20: 43 11 13 0a 10 01 04 08 0c 10 14 18 1c 20 24 28  C............ $(
  1f30: 2c 30 34 38 3c 14 2d 53 54 42 52 08 a0 12 41 43  ,048<.-STBR...AC
  1f40: 41 50 70 83 88 50 57 41 43 4c 42 54 4e 00 60 a1  APp..PWACLBTN.`.
  1f50: 0e 70 83 88 50 57 44 43 4c 42 54 4e 00 60 53 54  .p..PWDCLBTN.`ST
  1f60: 44 41 60 14 4f 05 53 54 44 41 09 a0 45 05 45 43  DA`.O.STDA..E.EC
  1f70: 41 56 a0 4e 04 93 5b 23 4d 55 45 43 ff ff 0a 00  AV.N..[#MUEC....
  1f80: 70 68 43 44 54 31 70 0a d0 43 44 54 32 70 0a da  phCDT1p..CDT2p..
  1f90: 43 4d 44 31 70 0a 7f 60 a2 0d 90 60 43 4d 44 31  CMD1p..`...`CMD1
  1fa0: 5b 22 0a 01 76 60 a0 0d 93 43 4d 44 31 00 70 43  ["..v`...CMD1.pC
  1fb0: 44 54 31 60 a1 04 70 ff 60 5b 27 4d 55 45 43 a4  DT1`..p.`['MUEC.
  1fc0: 60 a4 ff 14 47 05 41 43 41 50 08 a0 26 45 43 41  `...G.ACAP..&ECA
  1fd0: 56 70 52 44 43 33 0a 06 60 a2 0c 93 60 ff 70 52  VpRDC3..`...`.pR
  1fe0: 44 43 33 0a 06 60 7b 60 0a 10 60 7a 60 0a 04 60  DC3..`{`..`z`..`
  1ff0: a4 60 a1 28 a0 26 93 5b 23 4d 55 45 43 ff ff 0a  .`.(.&.[#MUEC...
  2000: 00 70 45 43 52 50 0a 06 60 7a 60 0a 04 60 7b 60  .pECRP..`z`..`{`
  2010: 0a 01 60 5b 27 4d 55 45 43 a4 60 14 43 09 42 41  ..`['MUEC.`.C.BA
  2020: 54 50 09 a0 48 04 45 43 41 56 a0 1c 68 70 52 44  TP..H.ECAV..hpRD
  2030: 43 33 0a 04 60 a2 0c 93 60 ff 70 52 44 43 33 0a  C3..`...`.pRDC3.
  2040: 04 60 7b 60 0a 08 60 a1 1b 70 52 44 43 33 0a 05  .`{`..`..pRDC3..
  2050: 60 a2 0c 93 60 ff 70 52 44 43 33 0a 05 60 7b 60  `...`.pRDC3..`{`
  2060: 0a 20 60 a0 04 60 a4 00 a1 03 a4 01 a1 42 04 a0  . `..`.......B..
  2070: 3f 93 5b 23 4d 55 45 43 ff ff 0a 00 a0 0f 68 70  ?.[#MUEC......hp
  2080: 45 43 52 50 0a 04 60 7a 60 0a 03 60 a1 0e 70 45  ECRP..`z`..`..pE
  2090: 43 52 50 0a 05 60 7a 60 0a 05 60 7b 60 0a 01 60  CRP..`z`..`{`..`
  20a0: 5b 27 4d 55 45 43 a0 04 60 a4 00 a1 03 a4 01 14  ['MUEC..`.......
  20b0: 0c 43 48 47 53 08 a4 5c 50 49 32 37 14 44 07 53  .CHGS..\PI27.D.S
  20c0: 54 43 35 09 a0 4e 04 45 43 41 56 a0 47 04 93 5b  TC5..N.ECAV.G..[
  20d0: 23 4d 55 45 43 ff ff 0a 00 70 68 43 44 54 31 70  #MUEC....phCDT1p
  20e0: 0a c5 43 4d 44 31 70 0a 7f 60 a2 0d 90 60 43 4d  ..CMD1p..`...`CM
  20f0: 44 31 5b 22 0a 01 76 60 a0 0d 93 43 4d 44 31 00  D1["..v`...CMD1.
  2100: 70 43 44 54 31 60 a1 04 70 ff 60 5b 27 4d 55 45  pCDT1`..p.`['MUE
  2110: 43 a4 60 a1 1b a0 19 93 5b 23 4d 55 45 43 ff ff  C.`.....[#MUEC..
  2120: 0a 00 45 43 53 50 68 5b 27 4d 55 45 43 a4 01 a4  ..ECSPh['MUEC...
  2130: ff 14 46 07 52 44 43 33 09 a0 4e 04 45 43 41 56  ..F.RDC3..N.ECAV
  2140: a0 47 04 93 5b 23 4d 55 45 43 ff ff 0a 00 70 68  .G..[#MUEC....ph
  2150: 43 44 54 31 70 0a c3 43 4d 44 31 70 0a 7f 60 a2  CDT1p..CMD1p..`.
  2160: 0d 90 60 43 4d 44 31 5b 22 0a 01 76 60 a0 0d 93  ..`CMD1["..v`...
  2170: 43 4d 44 31 00 70 43 44 54 31 60 a1 04 70 ff 60  CMD1.pCDT1`..p.`
  2180: 5b 27 4d 55 45 43 a4 60 a1 1d a0 1b 93 5b 23 4d  ['MUEC.`.....[#M
  2190: 55 45 43 ff ff 0a 00 70 45 43 52 50 68 60 5b 27  UEC....pECRPh`['
  21a0: 4d 55 45 43 a4 60 a4 ff 14 44 07 52 42 41 54 0a  MUEC.`...D.RBAT.
  21b0: a0 08 92 45 43 41 56 a4 ff a0 41 06 93 5b 23 4d  ...ECAV...A..[#M
  21c0: 55 45 43 ff ff 0a 00 70 0a 03 60 a2 47 04 60 70  UEC....p..`.G.`p
  21d0: 68 43 44 54 32 70 69 61 79 61 0a 01 61 72 61 0a  hCDT2piaya..ara.
  21e0: da 61 70 61 43 4d 44 31 70 0a 7f 61 a2 0d 90 43  .apaCMD1p..a...C
  21f0: 4d 44 31 61 76 61 5b 22 0a 01 a0 11 93 43 4d 44  MD1ava[".....CMD
  2200: 31 0a 00 70 43 44 54 31 61 70 00 60 a1 06 70 ff  1..pCDT1ap.`..p.
  2210: 61 76 60 5b 27 4d 55 45 43 a4 61 a4 ff 14 45 04  av`['MUEC.a...E.
  2220: 46 4e 43 54 0a a0 3d 45 43 41 56 a0 37 93 5b 23  FNCT..=ECAV.7.[#
  2230: 4d 55 45 43 ff ff 0a 00 70 68 43 44 54 32 70 69  MUEC....phCDT2pi
  2240: 43 44 54 31 70 0a c4 43 4d 44 31 70 0a 7f 60 a2  CDT1p..CMD1p..`.
  2250: 0d 90 60 43 4d 44 31 5b 22 0a 01 76 60 5b 27 4d  ..`CMD1["..v`['M
  2260: 55 45 43 08 57 52 51 4b 0a 02 08 52 44 51 4b 0a  UEC.WRQK...RDQK.
  2270: 03 08 53 44 42 54 0a 04 08 52 43 42 54 0a 05 08  ..SDBT...RCBT...
  2280: 57 52 42 54 0a 06 08 52 44 42 54 0a 07 08 57 52  WRBT...RDBT...WR
  2290: 57 44 0a 08 08 52 44 57 44 0a 09 08 57 52 42 4c  WD...RDWD...WRBL
  22a0: 0a 0a 08 52 44 42 4c 0a 0b 08 50 43 4c 4c 0a 0c  ...RDBL...PCLL..
  22b0: 08 47 4f 4f 44 0a 00 08 55 4b 45 52 0a 07 08 44  .GOOD...UKER...D
  22c0: 41 45 52 0a 10 08 43 4d 44 4e 0a 12 08 55 4b 45  AER...CMDN...UKE
  22d0: 32 0a 13 08 44 41 44 4e 0a 17 08 53 42 54 4f 0a  2...DADN...SBTO.
  22e0: 18 08 55 53 50 54 0a 19 08 53 42 42 59 0a 1a 14  ..USPT...SBBY...
  22f0: 46 04 53 57 54 43 01 70 55 4b 45 52 60 70 68 61  F.SWTC.pUKER`pha
  2300: 7b 61 0b ff ff 61 a2 2d 61 a0 19 93 53 4d 42 46  {a...a.-a...SMBF
  2310: 0a 00 5b 22 0a 0a a0 0c 92 93 61 0b ff ff 74 61  ..["......a...ta
  2320: 0a 0a 61 a1 10 70 00 61 70 53 53 54 53 60 70 00  ..a..p.apSSTS`p.
  2330: 53 4d 42 46 a4 60 14 4c 14 53 4d 42 52 03 70 12  SMBF.`.L.SMBR.p.
  2340: 08 03 0a 07 0a 00 0a 00 60 a0 08 92 45 43 41 56  ........`...ECAV
  2350: a4 60 a0 2e 92 93 68 52 44 42 4c a0 25 92 93 68  .`....hRDBL.%..h
  2360: 52 44 57 44 a0 1c 92 93 68 52 44 42 54 a0 13 92  RDWD....hRDBT...
  2370: 93 68 52 43 42 54 a0 0a 92 93 68 52 44 51 4b a4  .hRCBT....hRDQK.
  2380: 60 a0 4f 0f 93 5b 23 4d 55 45 43 ff ff 0a 00 70  `.O..[#MUEC....p
  2390: 50 52 54 43 61 70 00 62 a2 28 92 93 61 0a 00 5b  PRTCap.b.(..a..[
  23a0: 21 0a 0a 75 62 a0 13 94 62 0b e8 03 70 53 42 42  !..ub...b...pSBB
  23b0: 59 88 60 0a 00 00 70 00 61 a1 07 70 50 52 54 43  Y.`...p.a..pPRTC
  23c0: 61 a0 49 0b 92 94 62 0b e8 03 79 69 0a 01 63 7d  a.I...b...yi..c}
  23d0: 63 0a 01 63 70 63 41 44 44 52 a0 17 92 93 68 52  c..cpcADDR....hR
  23e0: 44 51 4b a0 0e 92 93 68 52 43 42 54 70 6a 43 4d  DQK....hRCBTpjCM
  23f0: 44 42 70 68 50 52 54 43 70 53 57 54 43 0b d0 07  DBphPRTCpSWTC...
  2400: 88 60 0a 00 00 a0 45 07 93 83 88 60 0a 00 00 0a  .`....E....`....
  2410: 00 a0 1b 93 68 52 44 42 4c 70 42 43 4e 54 88 60  ....hRDBLpBCNT.`
  2420: 0a 01 00 70 42 44 41 54 88 60 0a 02 00 a0 19 93  ...pBDAT.`......
  2430: 68 52 44 57 44 70 0a 02 88 60 0a 01 00 70 44 54  hRDWDp...`...pDT
  2440: 32 42 88 60 0a 02 00 a0 19 93 68 52 44 42 54 70  2B.`......hRDBTp
  2450: 0a 01 88 60 0a 01 00 70 44 41 54 30 88 60 0a 02  ...`...pDAT0.`..
  2460: 00 a0 19 93 68 52 43 42 54 70 0a 01 88 60 0a 01  ....hRCBTp...`..
  2470: 00 70 44 41 54 30 88 60 0a 02 00 5b 27 4d 55 45  .pDAT0.`...['MUE
  2480: 43 a4 60 14 4b 10 53 4d 42 57 05 70 12 04 01 0a  C.`.K.SMBW.p....
  2490: 07 60 a0 08 92 45 43 41 56 a4 60 a0 2e 92 93 68  .`...ECAV.`....h
  24a0: 57 52 42 4c a0 25 92 93 68 57 52 57 44 a0 1c 92  WRBL.%..hWRWD...
  24b0: 93 68 57 52 42 54 a0 13 92 93 68 53 44 42 54 a0  .hWRBT....hSDBT.
  24c0: 0a 92 93 68 57 52 51 4b a4 60 a0 42 0c 93 5b 23  ...hWRQK.`.B..[#
  24d0: 4d 55 45 43 ff ff 0a 00 70 50 52 54 43 61 70 00  MUEC....pPRTCap.
  24e0: 62 a2 28 92 93 61 0a 00 5b 21 0a 0a 75 62 a0 13  b.(..a..[!..ub..
  24f0: 94 62 0b e8 03 70 53 42 42 59 88 60 0a 00 00 70  .b...pSBBY.`...p
  2500: 00 61 a1 07 70 50 52 54 43 61 a0 4c 07 92 94 62  .a..pPRTCa.L...b
  2510: 0b e8 03 79 69 0a 01 63 70 63 41 44 44 52 a0 17  ...yi..cpcADDR..
  2520: 92 93 68 57 52 51 4b a0 0e 92 93 68 53 44 42 54  ..hWRQK....hSDBT
  2530: 70 6a 43 4d 44 42 a0 13 93 68 57 52 42 4c 70 6b  pjCMDB...hWRBLpk
  2540: 42 43 4e 54 70 6c 42 44 41 54 a0 0d 93 68 57 52  BCNTplBDAT...hWR
  2550: 57 44 70 6c 44 54 32 42 a0 0d 93 68 57 52 42 54  WDplDT2B...hWRBT
  2560: 70 6c 44 41 54 30 a0 0d 93 68 53 44 42 54 70 6c  plDAT0...hSDBTpl
  2570: 44 41 54 30 70 68 50 52 54 43 70 53 57 54 43 0b  DAT0phPRTCpSWTC.
  2580: d0 07 88 60 0a 00 00 5b 27 4d 55 45 43 a4 60 5b  ...`...['MUEC.`[
  2590: 80 4b 36 32 50 01 0a 62 0a 01 5b 81 0b 4b 36 32  .K62P..b..[..K62
  25a0: 50 01 45 43 36 32 08 5b 80 4b 36 36 50 01 0a 66  P.EC62.[.K66P..f
  25b0: 0a 01 5b 81 0b 4b 36 36 50 01 45 43 36 36 08 06  ..[..K66P.EC66..
  25c0: 5c 47 31 32 45 4b 53 43 45 06 5c 47 31 32 53 4b  \G12EKSCE.\G12SK
  25d0: 53 43 53 14 28 57 45 49 45 00 70 0b 00 40 60 7b  SCS.(WEIE.p..@`{
  25e0: 45 43 36 36 0a 02 61 a2 14 90 92 93 60 00 93 61  EC66..a.....`..a
  25f0: 0a 02 7b 45 43 36 36 0a 02 61 76 60 14 28 57 45  ..{EC66..av`.(WE
  2600: 4f 46 00 70 0b 00 40 60 7b 45 43 36 36 0a 01 61  OF.p..@`{EC66..a
  2610: a2 14 90 92 93 60 00 93 61 0a 00 7b 45 43 36 36  .....`..a..{EC66
  2620: 0a 01 61 76 60 14 46 04 45 43 52 44 01 70 4b 53  ..av`.F.ECRD.pKS
  2630: 43 45 61 70 00 4b 53 43 45 57 45 49 45 70 0a 80  CEap.KSCEWEIEp..
  2640: 45 43 36 36 57 45 49 45 70 68 45 43 36 32 57 45  EC66WEIEphEC62WE
  2650: 4f 46 70 45 43 36 32 60 a2 0b 4b 53 43 53 70 01  OFpEC62`..KSCSp.
  2660: 4b 53 43 53 70 61 4b 53 43 45 a4 60 14 48 04 45  KSCSpaKSCE.`.H.E
  2670: 43 57 52 02 70 4b 53 43 45 61 70 00 4b 53 43 45  CWR.pKSCEap.KSCE
  2680: 57 45 49 45 70 0a 81 45 43 36 36 57 45 49 45 70  WEIEp..EC66WEIEp
  2690: 68 45 43 36 32 57 45 49 45 70 69 45 43 36 32 57  hEC62WEIEpiEC62W
  26a0: 45 49 45 a2 0b 4b 53 43 53 70 01 4b 53 43 53 70  EIE..KSCSp.KSCSp
  26b0: 61 4b 53 43 45 14 45 04 45 43 57 43 01 70 4b 53  aKSCE.E.ECWC.pKS
  26c0: 43 45 61 70 00 4b 53 43 45 57 45 49 45 70 0a 81  CEap.KSCEWEIEp..
  26d0: 45 43 36 36 57 45 49 45 70 0a 04 45 43 36 32 57  EC66WEIEp..EC62W
  26e0: 45 49 45 70 68 45 43 36 32 a2 0b 4b 53 43 53 70  EIEphEC62..KSCSp
  26f0: 01 4b 53 43 53 70 61 4b 53 43 45 14 3f 45 43 51  .KSCSpaKSCE.?ECQ
  2700: 52 00 70 4b 53 43 45 61 70 00 4b 53 43 45 57 45  R.pKSCEap.KSCEWE
  2710: 49 45 70 0a 84 45 43 36 36 57 45 49 45 57 45 4f  IEp..EC66WEIEWEO
  2720: 46 70 45 43 36 32 60 a2 0b 4b 53 43 53 70 01 4b  FpEC62`..KSCSp.K
  2730: 53 43 53 70 61 4b 53 43 45 a4 60 14 24 45 43 52  SCSpaKSCE.`.$ECR
  2740: 50 01 45 43 57 52 0a 05 68 45 43 57 52 0a 04 0a  P.ECWR..hECWR...
  2750: c3 a2 07 45 43 52 44 0a 04 a4 45 43 52 44 0a 05  ...ECRD...ECRD..
  2760: 14 1d 45 43 53 50 01 45 43 57 52 0a 05 68 45 43  ..ECSP.ECWR..hEC
  2770: 57 52 0a 04 0a c5 a2 07 45 43 52 44 0a 04 10 45  WR......ECRD...E
  2780: 09 5c 2f 04 5f 53 42 5f 50 43 49 30 53 42 52 47  .\/._SB_PCI0SBRG
  2790: 45 43 30 5f 14 1f 5f 51 36 39 00 a0 18 5c 2e 5f  EC0_.._Q69...\._
  27a0: 53 42 5f 41 54 4b 50 86 5c 2e 5f 53 42 5f 41 54  SB_ATKP.\._SB_AT
  27b0: 4b 44 0a 40 14 1f 5f 51 36 41 00 a0 18 5c 2e 5f  KD.-BC8w8uc/0BzhvxM+mQhndA@public.gmane.org\._
  27c0: 53 42 5f 41 54 4b 50 86 5c 2e 5f 53 42 5f 41 54  SB_ATKP.\._SB_AT
  27d0: 4b 44 0a 41 14 1f 5f 51 36 42 00 a0 18 5c 2e 5f  KD.A.._Q6B...\._
  27e0: 53 42 5f 41 54 4b 50 86 5c 2e 5f 53 42 5f 41 54  SB_ATKP.\._SB_AT
  27f0: 4b 44 0a 43 14 1f 5f 51 36 43 00 a0 18 5c 2e 5f  KD.C.._Q6C...\._
  2800: 53 42 5f 41 54 4b 50 86 5c 2e 5f 53 42 5f 41 54  SB_ATKP.\._SB_AT
  2810: 4b 44 0a 45 10 44 05 5c 2e 5f 53 42 5f 50 43 49  KD.E.D.\._SB_PCI
  2820: 30 5b 82 46 04 41 43 30 5f 08 5f 48 49 44 0d 41  0[.F.AC0_._HID.A
  2830: 43 50 49 30 30 30 33 00 14 1e 5f 50 53 52 00 a4  CPI0003..._PSR..
  2840: 5c 2f 05 5f 53 42 5f 50 43 49 30 53 42 52 47 45  \/._SB_PCI0SBRGE
  2850: 43 30 5f 41 43 41 50 08 5f 50 43 4c 12 0c 01 5c  C0_ACAP._PCL...\
  2860: 2e 5f 53 42 5f 50 43 49 30 10 4c 0c 5c 2f 04 5f  ._SB_PCI0.L.\/._
  2870: 53 42 5f 50 43 49 30 53 42 52 47 45 43 30 5f 14  SB_PCI0SBRGEC0_.
  2880: 46 0b 5f 51 33 34 00 53 54 42 52 a0 35 41 43 41  F._Q34.STBR.5ACA
  2890: 50 70 0a 02 41 43 57 41 70 01 5c 41 43 50 46 70  Pp..ACWAp.\ACPFp
  28a0: 0a 58 60 a0 1d 93 5b 23 4d 55 45 43 ff ff 0a 00  .X`...[#MUEC....
  28b0: 7b 50 36 34 53 0a ef 50 36 34 53 5b 27 4d 55 45  {P64S..P64S['MUE
  28c0: 43 a1 2a 70 00 5c 41 43 50 46 70 0a 57 60 a0 1d  C.*p.\ACPFp.W`..
  28d0: 93 5b 23 4d 55 45 43 ff ff 0a 00 7d 50 36 34 53  .[#MUEC....}P64S
  28e0: 0a 10 50 36 34 53 5b 27 4d 55 45 43 86 5c 2f 03  ..P64S['MUEC.\/.
  28f0: 5f 53 42 5f 50 43 49 30 41 43 30 5f 0a 80 4e 42  _SB_PCI0AC0_..NB
  2900: 41 54 0a 80 a0 17 5c 2e 5f 53 42 5f 41 54 4b 50  AT....\._SB_ATKP
  2910: 86 5c 2e 5f 53 42 5f 41 54 4b 44 60 86 5c 2e 5f  .\._SB_ATKD`.\._
  2920: 50 52 5f 43 50 55 31 0a 80 86 5c 2e 5f 50 52 5f  PR_CPU1...\._PR_
  2930: 43 50 55 31 0a 81 10 47 46 5c 2e 5f 53 42 5f 50  CPU1...GF\._SB_P
  2940: 43 49 30 08 53 43 49 56 0b 40 01 08 53 45 4e 52  CI0.SCIV.-DC8NOfry8DM@public.gmane.org
  2950: 0a 14 08 56 53 42 46 0a 38 08 44 56 4f 54 0a 0e  ...VSBF.8.DVOT..
  2960: 08 41 43 57 41 0a 00 14 3f 56 53 52 43 01 7b 68  .ACWA...?VSRC.{h
  2970: 0b ff ff 60 7b 60 0b 00 80 61 a0 10 61 80 60 60  ...`{`...a..a.``
  2980: 7b 60 0b ff ff 60 72 60 0a 01 60 77 60 0b e8 03  {`...`r`..`w`...
  2990: 60 77 0a 08 53 45 4e 52 61 78 60 61 62 63 77 63  `w..SENRax`abcwc
  29a0: 44 56 4f 54 63 a4 63 14 27 50 46 43 43 01 70 68  DVOTc.c.'PFCC.ph
  29b0: 60 77 60 0b e8 03 60 77 53 43 49 56 53 45 4e 52  `w`...`wSCIVSENR
  29c0: 61 78 60 61 62 63 77 63 44 56 4f 54 63 a4 63 5b  ax`abcwcDVOTc.c[
  29d0: 82 4d 3c 42 41 54 30 08 5f 48 49 44 0c 41 d0 0c  .M<BAT0._HID.A..
  29e0: 0a 08 5f 55 49 44 0a 00 08 5f 50 43 4c 12 0c 01  .._UID..._PCL...
  29f0: 5c 2e 5f 53 42 5f 50 43 49 30 14 29 5f 53 54 41  \._SB_PCI0.)_STA
  2a00: 00 a0 1d 5c 2f 05 5f 53 42 5f 50 43 49 30 53 42  ...\/._SB_PCI0SB
  2a10: 52 47 45 43 30 5f 42 41 54 50 0a 00 a4 0a 1f a1  RGEC0_BATP......
  2a20: 04 a4 0a 0f 08 43 41 50 44 0b c0 da 08 43 41 50  .....CAPD....CAP
  2a30: 47 0b 18 01 08 4e 42 49 46 12 35 0d 0a 00 0c ff  G....NBIF.5.....
  2a40: ff ff ff 0c ff ff ff ff 0a 01 0c ff ff ff ff 0c  ................
  2a50: ff ff ff ff 0c ff ff ff ff 0c ff ff ff ff 0c ff  ................
  2a60: ff ff ff 0d 20 00 0d 20 00 0d 20 00 0d 20 00 08  .... .. .. .. ..
  2a70: 50 42 49 46 12 33 0d 0a 00 0b c0 da 0b c0 da 0a  PBIF.3..........
  2a80: 01 0b b0 36 0b e0 15 0b f0 0a 0a 1c 0b 0a 05 0d  ...6............
  2a90: 4c 33 30 30 30 00 0d 20 00 0d 4c 49 6f 6e 00 0d  L3000.. ..LIon..
  2aa0: 41 53 55 53 54 65 4b 00 14 48 0d 5f 42 49 46 00  ASUSTeK..H._BIF.
  2ab0: a0 20 92 5c 2f 05 5f 53 42 5f 50 43 49 30 53 42  . .\/._SB_PCI0SB
  2ac0: 52 47 45 43 30 5f 42 41 54 50 0a 00 a4 4e 42 49  RGEC0_BATP...NBI
  2ad0: 46 70 5c 4d 4e 41 4d 88 50 42 49 46 0a 09 00 70  Fp\MNAM.PBIF...p
  2ae0: 5c 4f 4e 41 4d 88 50 42 49 46 0a 0c 00 70 5c 2f  \ONAM.PBIF...p\/
  2af0: 05 5f 53 42 5f 50 43 49 30 53 42 52 47 45 43 30  ._SB_PCI0SBRGEC0
  2b00: 5f 52 42 41 54 0a 05 0a 00 60 a0 41 07 92 93 60  _RBAT....`.A...`
  2b10: ff 79 60 0a 08 60 70 50 46 43 43 60 60 70 60 43  .y`..`pPFCC``p`C
  2b20: 41 50 44 70 60 88 50 42 49 46 0a 01 00 70 60 88  APDp`.PBIF...p`.
  2b30: 50 42 49 46 0a 02 00 78 60 0a 0a 61 62 70 62 88  PBIF...x`..abpb.
  2b40: 50 42 49 46 0a 05 00 74 60 62 63 70 63 88 50 42  PBIF...t`bcpc.PB
  2b50: 49 46 0a 07 00 78 60 0a 14 61 62 70 62 88 50 42  IF...x`..abpb.PB
  2b60: 49 46 0a 06 00 74 63 62 63 70 63 88 50 42 49 46  IF...tcbcpc.PBIF
  2b70: 0a 08 00 78 60 0a c8 61 43 41 50 47 a4 50 42 49  ...x`..aCAPG.PBI
  2b80: 46 08 50 42 53 54 12 0d 04 0a 00 0b 00 80 0b 00  F.PBST..........
  2b90: 80 0b b0 36 14 49 20 5f 42 53 54 00 a0 10 57 41  ...6.I _BST...WA
  2ba0: 4b 43 76 5c 57 41 4b 43 a4 50 42 53 54 a0 49 04  KCv\WAKC.PBST.I.
  2bb0: 92 5c 2f 05 5f 53 42 5f 50 43 49 30 53 42 52 47  .\/._SB_PCI0SBRG
  2bc0: 45 43 30 5f 42 41 54 50 0a 00 70 00 88 50 42 53  EC0_BATP..p..PBS
  2bd0: 54 0a 00 00 70 ff 88 50 42 53 54 0a 01 00 70 ff  T...p..PBST...p.
  2be0: 88 50 42 53 54 0a 02 00 70 ff 88 50 42 53 54 0a  .PBST...p..PBST.
  2bf0: 03 00 a4 50 42 53 54 70 01 60 a0 35 5c 2f 05 5f  ...PBSTp.`.5\/._
  2c00: 53 42 5f 50 43 49 30 53 42 52 47 45 43 30 5f 41  SB_PCI0SBRGEC0_A
  2c10: 43 41 50 a0 1c 5c 2f 05 5f 53 42 5f 50 43 49 30  CAP..\/._SB_PCI0
  2c20: 53 42 52 47 45 43 30 5f 43 48 47 53 70 0a 02 60  SBRGEC0_CHGSp..`
  2c30: a0 0e 41 43 57 41 70 0a 02 60 76 41 43 57 41 70  ..ACWAp..`vACWAp
  2c40: 60 88 50 42 53 54 0a 00 00 70 5c 2f 05 5f 53 42  `.PBST...p\/._SB
  2c50: 5f 50 43 49 30 53 42 52 47 45 43 30 5f 52 42 41  _PCI0SBRGEC0_RBA
  2c60: 54 0a 12 0a 00 61 a0 4a 04 92 93 61 ff 70 5c 2f  T....a.J...a.p\/
  2c70: 05 5f 53 42 5f 50 43 49 30 53 42 52 47 45 43 30  ._SB_PCI0SBRGEC0
  2c80: 5f 52 42 41 54 0a 13 0a 00 62 a0 26 92 93 62 ff  _RBAT....b.&..b.
  2c90: 7b 61 0a ff 61 7b 62 0a ff 62 79 61 0a 08 61 72  {a..a{b..bya..ar
  2ca0: 61 62 61 70 56 53 52 43 61 88 50 42 53 54 0a 01  abapVSRCa.PBST..
  2cb0: 00 70 5c 2f 05 5f 53 42 5f 50 43 49 30 53 42 52  .p\/._SB_PCI0SBR
  2cc0: 47 45 43 30 5f 52 42 41 54 0a 03 0a 00 61 a0 4b  GEC0_RBAT....a.K
  2cd0: 06 92 93 61 ff 70 5c 2f 05 5f 53 42 5f 50 43 49  ...a.p\/._SB_PCI
  2ce0: 30 53 42 52 47 45 43 30 5f 52 42 41 54 0a 17 0a  0SBRGEC0_RBAT...
  2cf0: 00 62 a0 47 04 92 93 62 ff 7b 61 0a ff 61 7b 62  .b.G...b.{a..a{b
  2d00: 0a ff 62 79 61 0a 08 61 72 61 62 61 70 50 46 43  ..bya..arabapPFC
  2d10: 43 61 62 a0 1c 95 62 43 41 50 44 74 43 41 50 44  Cab...bCAPDtCAPD
  2d20: 62 63 a0 0d 95 63 43 41 50 47 70 43 41 50 44 62  bc...cCAPGpCAPDb
  2d30: 70 62 88 50 42 53 54 0a 02 00 70 5c 2f 05 5f 53  pb.PBST...p\/._S
  2d40: 42 5f 50 43 49 30 53 42 52 47 45 43 30 5f 52 42  B_PCI0SBRGEC0_RB
  2d50: 41 54 0a 0b 0a 00 61 a0 16 92 93 61 ff 77 61 56  AT....a....a.waV
  2d60: 53 42 46 61 70 61 88 50 42 53 54 0a 03 00 70 83  SBFapa.PBST...p.
  2d70: 88 50 42 53 54 0a 01 00 61 70 83 88 50 42 53 54  .PBST...ap..PBST
  2d80: 0a 02 00 62 78 62 0a 0a 63 64 a0 0e 95 61 64 70  ...bxb..cd...adp
  2d90: 64 88 50 42 53 54 0a 01 00 a4 50 42 53 54 10 44  d.PBST....PBST.D
  2da0: 10 5c 2f 04 5f 53 42 5f 50 43 49 30 53 42 52 47  .\/._SB_PCI0SBRG
  2db0: 45 43 30 5f 14 42 09 5f 51 32 46 00 a0 2d 92 42  EC0_.B._Q2F..-.B
  2dc0: 41 54 50 0a 00 70 00 5c 44 43 50 46 a0 1d 93 5b  ATP..p.\DCPF...[
  2dd0: 23 4d 55 45 43 ff ff 0a 00 7b 50 35 35 53 0a ef  #MUEC....{P55S..
  2de0: 50 35 35 53 5b 27 4d 55 45 43 a1 26 70 01 5c 44  P55S['MUEC.&p.\D
  2df0: 43 50 46 a0 1d 93 5b 23 4d 55 45 43 ff ff 0a 00  CPF...[#MUEC....
  2e00: 7d 50 35 35 53 0a 10 50 35 35 53 5b 27 4d 55 45  }P55S..P55S['MUE
  2e10: 43 86 5c 2f 03 5f 53 42 5f 50 43 49 30 42 41 54  C.\/._SB_PCI0BAT
  2e20: 30 0a 01 86 5c 2f 03 5f 53 42 5f 50 43 49 30 42  0...\/._SB_PCI0B
  2e30: 41 54 30 0a 81 86 5c 2f 03 5f 53 42 5f 50 43 49  AT0...\/._SB_PCI
  2e40: 30 41 43 30 5f 0a 80 14 3b 5f 51 35 30 00 a0 18  0AC0_...;_Q50...
  2e50: 5c 2e 5f 53 42 5f 41 54 4b 50 86 5c 2e 5f 53 42  \._SB_ATKP.\._SB
  2e60: 5f 41 54 4b 44 0a 6e a1 1b a0 19 42 41 54 50 0a  _ATKD.n....BATP.
  2e70: 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30 42 41 54  ..\/._SB_PCI0BAT
  2e80: 30 0a 80 14 1f 4e 42 41 54 01 a0 18 42 41 54 50  0....NBAT...BATP
  2e90: 0a 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30 42 41  ...\/._SB_PCI0BA
  2ea0: 54 30 68 10 26 5c 5f 53 42 5f 5b 82 1e 53 4c 50  T0h.&\_SB_[..SLP
  2eb0: 42 08 5f 48 49 44 0c 41 d0 0c 0e 14 0e 5f 50 52  B._HID.A....._PR
  2ec0: 57 00 a4 12 06 02 0a 0a 0a 04 10 1a 5c 5f 47 50  W...........\_GP
  2ed0: 45 14 13 5f 4c 30 41 00 86 5c 2e 5f 53 42 5f 53  E.._L0A..\._SB_S
  2ee0: 4c 50 42 0a 02 10 24 5c 5f 53 42 5f 5b 82 1c 4c  LPB...$\_SB_[..L
  2ef0: 49 44 5f 08 5f 48 49 44 0c 41 d0 0c 0d 14 0c 5f  ID_._HID.A....._
  2f00: 4c 49 44 00 a4 5c 4c 49 44 4c 10 27 5c 5f 47 50  LID..\LIDL.'\_GP
  2f10: 45 14 20 5f 4c 31 42 08 7f 5c 4c 49 44 4c 0a 01  E. _L1B..\LIDL..
  2f20: 5c 4c 49 44 4c 86 5c 2e 5f 53 42 5f 4c 49 44 5f  \LIDL.\._SB_LID_
  2f30: 0a 80 10 40 46 5c 00 5b 80 53 4d 42 30 01 53 4d  ...-rzuCjS9p/VI@public.gmane.org\.[.SMB0.SM
  2f40: 42 53 0a 10 5b 81 4d 04 53 4d 42 30 01 48 53 54  BS..[.M.SMB0.HST
  2f50: 53 08 53 53 54 53 08 48 53 54 43 08 48 43 4d 44  S.SSTS.HSTC.HCMD
  2f60: 08 48 41 44 52 08 48 44 54 30 08 48 44 54 31 08  .HADR.HDT0.HDT1.
  2f70: 42 4c 4b 44 08 53 4c 43 54 08 53 48 43 4d 08 53  BLKD.SLCT.SHCM.S
  2f80: 4c 45 56 10 53 4c 44 54 10 53 43 46 47 08 53 41  LEV.SLDT.SCFG.SA
  2f90: 44 52 08 08 52 42 55 46 12 02 20 14 22 48 42 53  DR..RBUF.. ."HBS
  2fa0: 59 00 70 0c ff ff ff 00 60 a2 12 60 7b 48 53 54  Y.p.....`..`{HST
  2fb0: 53 0a 01 61 a0 05 92 61 a4 00 76 60 a4 01 14 29  S..a...a..v`...)
  2fc0: 57 54 53 42 00 70 0c ff ff ff 00 60 a2 19 60 76  WTSB.p.....`..`v
  2fd0: 60 7b 48 53 54 53 0a 1e 61 a0 07 93 61 0a 02 a4  `{HSTS..a...a...
  2fe0: 01 a0 04 61 a4 00 a4 00 5b 01 5c 50 34 53 4d 00  ...a....[.\P4SM.
  2ff0: 14 4f 05 53 42 59 54 0a a0 10 92 93 5b 23 5c 50  .O.SBYT.....[#\P
  3000: 34 53 4d ff ff 0a 00 a4 ff 70 0a 05 60 a2 39 60  4SM......p..`.9`
  3010: a0 07 48 42 53 59 76 60 a1 2e 70 68 48 41 44 52  ..HBSYv`..phHADR
  3020: 70 69 48 43 4d 44 70 0a ff 48 53 54 53 70 0a 44  piHCMDp..HSTSp.D
  3030: 48 53 54 43 a0 0e 57 54 53 42 5b 27 5c 50 34 53  HSTC..WTSB['\P4S
  3040: 4d a4 01 a1 03 76 60 5b 27 5c 50 34 53 4d a4 ff  M....v`['\P4SM..
  3050: 14 45 06 57 42 59 54 0b a0 10 92 93 5b 23 5c 50  .E.WBYT.....[#\P
  3060: 34 53 4d ff ff 0a 00 a4 ff 70 0a 05 60 a2 3f 60  4SM......p..`.?`
  3070: a0 07 48 42 53 59 76 60 a1 34 70 68 48 41 44 52  ..HBSYv`.4phHADR
  3080: 70 69 48 43 4d 44 70 6a 48 44 54 30 70 0a ff 48  piHCMDpjHDT0p..H
  3090: 53 54 53 70 0a 48 48 53 54 43 a0 0e 57 54 53 42  STSp.HHSTC..WTSB
  30a0: 5b 27 5c 50 34 53 4d a4 01 a1 03 76 60 5b 27 5c  ['\P4SM....v`['\
  30b0: 50 34 53 4d a4 ff 14 4c 07 57 57 52 44 0c a0 10  P4SM...L.WWRD...
  30c0: 92 93 5b 23 5c 50 34 53 4d ff ff 0a 00 a4 ff 70  ..[#\P4SM......p
  30d0: 0a 05 60 a2 46 05 60 a0 07 48 42 53 59 76 60 a1  ..`.F.`..HBSYv`.
  30e0: 4a 04 70 68 48 41 44 52 70 69 48 43 4d 44 7b 6a  J.phHADRpiHCMD{j
  30f0: 0a ff 61 7a 6a 0a 08 62 7b 62 0a ff 62 70 62 48  ..azj..b{b..bpbH
  3100: 44 54 30 70 61 48 44 54 31 70 0a ff 48 53 54 53  DT0paHDT1p..HSTS
  3110: 70 0a 4c 48 53 54 43 a0 0e 57 54 53 42 5b 27 5c  p.LHSTC..WTSB['\
  3120: 50 34 53 4d a4 01 a1 03 76 60 5b 27 5c 50 34 53  P4SM....v`['\P4S
  3130: 4d a4 ff 14 4b 08 57 42 4c 4b 0c a0 10 92 93 5b  M...K.WBLK.....[
  3140: 23 5c 50 34 53 4d ff ff 0a 00 a4 ff 70 0a 05 60  #\P4SM......p..`
  3150: a2 45 06 60 a0 07 48 42 53 59 76 60 a1 49 05 70  .E.`..HBSYv`.I.p
  3160: 68 48 41 44 52 70 69 48 43 4d 44 70 48 53 54 43  hHADRpiHCMDpHSTC
  3170: 61 70 6a 62 70 0a 00 61 a2 10 62 70 83 88 6b 61  apjbp..a..bp..ka
  3180: 00 42 4c 4b 44 76 62 75 61 70 6a 48 44 54 30 70  .BLKDvbuapjHDT0p
  3190: 48 53 54 43 61 70 0a ff 48 53 54 53 70 0a 54 48  HSTCap..HSTSp.TH
  31a0: 53 54 43 a0 0e 57 54 53 42 5b 27 5c 50 34 53 4d  STC..WTSB['\P4SM
  31b0: a4 01 a1 03 76 60 5b 27 5c 50 34 53 4d a4 ff 14  ....v`['\P4SM...
  31c0: 44 06 52 53 42 54 0a a0 10 92 93 5b 23 5c 50 34  D.RSBT.....[#\P4
  31d0: 53 4d ff ff 0a 00 a4 ff 70 0a 05 60 a2 3e 60 a0  SM......p..`.>`.
  31e0: 07 48 42 53 59 76 60 a1 33 7d 68 0a 01 48 41 44  .HBSYv`.3}h..HAD
  31f0: 52 70 69 48 43 4d 44 70 0a ff 48 53 54 53 70 0a  RpiHCMDp..HSTSp.
  3200: 44 48 53 54 43 a0 11 57 54 53 42 5b 27 5c 50 34  DHSTC..WTSB['\P4
  3210: 53 4d a4 48 44 54 30 a1 03 76 60 5b 27 5c 50 34  SM.HDT0..v`['\P4
  3220: 53 4d a4 ff 14 44 06 52 42 59 54 0a a0 10 92 93  SM...D.RBYT.....
  3230: 5b 23 5c 50 34 53 4d ff ff 0a 00 a4 ff 70 0a 05  [#\P4SM......p..
  3240: 60 a2 3e 60 a0 07 48 42 53 59 76 60 a1 33 7d 68  `.>`..HBSYv`.3}h
  3250: 0a 01 48 41 44 52 70 69 48 43 4d 44 70 0a ff 48  ..HADRpiHCMDp..H
  3260: 53 54 53 70 0a 48 48 53 54 43 a0 11 57 54 53 42  STSp.HHSTC..WTSB
  3270: 5b 27 5c 50 34 53 4d a4 48 44 54 30 a1 03 76 60  ['\P4SM.HDT0..v`
  3280: 5b 27 5c 50 34 53 4d a4 ff 14 48 07 52 57 52 44  ['\P4SM...H.RWRD
  3290: 0a a0 10 92 93 5b 23 5c 50 34 53 4d ff ff 0a 00  .....[#\P4SM....
  32a0: a4 ff 70 0a 05 60 a2 42 05 60 a0 07 48 42 53 59  ..p..`.B.`..HBSY
  32b0: 76 60 a1 46 04 7d 68 0a 01 48 41 44 52 70 69 48  v`.F.}h..HADRpiH
  32c0: 43 4d 44 70 0a ff 48 53 54 53 70 0a 4c 48 53 54  CMDp..HSTSp.LHST
  32d0: 43 a0 23 57 54 53 42 70 48 44 54 30 61 79 61 0a  C.#WTSBpHDT0aya.
  32e0: 08 61 70 48 44 54 31 62 72 61 62 61 5b 27 5c 50  .apHDT1braba['\P
  32f0: 34 53 4d a4 61 a1 03 76 60 5b 27 5c 50 34 53 4d  4SM.a..v`['\P4SM
  3300: a4 ff 14 40 09 52 42 4c 4b 0b a0 10 92 93 5b 23  ...-ao/eoJvbdwStXF2fZOsJYA@public.gmane.org[#
  3310: 5c 50 34 53 4d ff ff 0a 00 a4 ff 70 0a 05 60 a2  \P4SM......p..`.
  3320: 4a 06 60 a0 07 48 42 53 59 76 60 a1 4e 05 7d 68  J.`..HBSYv`.N.}h
  3330: 0a 01 48 41 44 52 70 69 48 43 4d 44 70 0a ff 48  ..HADRpiHCMDp..H
  3340: 53 54 53 70 0a 54 48 53 54 43 a0 3b 57 54 53 42  STSp.THSTC.;WTSB
  3350: 70 48 53 54 43 61 70 48 44 54 30 62 70 62 63 70  pHSTCapHDT0bpbcp
  3360: 0a 00 52 42 55 46 70 0a 00 61 a2 12 62 70 42 4c  ..RBUFp..a..bpBL
  3370: 4b 44 88 52 42 55 46 61 00 76 62 75 61 5b 27 5c  KD.RBUFa.vbua['\
  3380: 50 34 53 4d a4 63 a1 03 76 60 5b 27 5c 50 34 53  P4SM.c..v`['\P4S
  3390: 4d a4 ff 10 48 09 5c 00 08 46 41 4e 31 0a 00 08  M...H.\..FAN1...
  33a0: 46 41 4e 32 0a 00 5b 82 1b 46 4e 30 30 08 5f 48  FAN2..[..FN00._H
  33b0: 49 44 0c 41 d0 0c 0b 08 5f 50 52 30 12 06 01 47  ID.A...._PR0...G
  33c0: 46 41 4e 5b 84 30 47 46 41 4e 00 00 00 14 0b 5f  FAN[.0GFAN....._
  33d0: 53 54 41 00 a4 46 41 4e 31 14 0d 5f 4f 4e 5f 00  STA..FAN1.._ON_.
  33e0: 70 0a 01 46 41 4e 31 14 0d 5f 4f 46 46 00 70 0a  p..FAN1.._OFF.p.
  33f0: 00 46 41 4e 31 08 5c 2f 04 5f 53 42 5f 50 43 49  .FAN1.\/._SB_PCI
  3400: 30 53 42 52 47 5f 50 52 30 12 06 01 47 46 41 4e  0SBRG_PR0...GFAN
  3410: 14 07 46 41 4e 57 01 a3 14 13 46 41 4e 53 01 a0  ..FANW....FANS..
  3420: 0c 68 5c 2e 47 46 41 4e 5f 4f 46 46 10 18 5c 00  .h\.GFAN_OFF..\.
  3430: 08 54 53 50 5f 0a 0a 08 54 43 31 5f 0a 02 08 54  .TSP_...TC1_...T
  3440: 43 32 5f 0a 0a 10 49 14 5c 5f 54 5a 5f 14 18 4b  C2_...I.\_TZ_..K
  3450: 45 4c 56 01 7b 68 0a ff 60 77 60 0a 0a 60 72 60  ELV.{h..`w`..`r`
  3460: 0b ac 0a 60 a4 60 08 50 4c 43 59 0a 00 5b 85 46  ...`.`.PLCY..[.F
  3470: 0e 54 48 52 4d 14 0f 5f 43 52 54 00 a4 4b 45 4c  .THRM.._CRT..KEL
  3480: 56 54 43 52 54 14 29 5f 54 4d 50 00 70 0a 05 61  VTCRT.)_TMP.p..a
  3490: a2 18 61 70 52 54 4d 50 60 a0 09 94 60 54 43 52  ..apRTMP`...`TCR
  34a0: 54 76 61 a1 05 70 0a 00 61 a4 4b 45 4c 56 60 08  Tva..p..a.KELV`.
  34b0: 5f 50 53 4c 12 0c 01 5c 2e 5f 50 52 5f 43 50 55  _PSL...\._PR_CPU
  34c0: 31 14 10 5f 54 53 50 00 77 54 53 50 5f 0a 0a 60  1.._TSP.wTSP_..`
  34d0: a4 60 14 0b 5f 54 43 31 00 a4 54 43 31 5f 14 0b  .`.._TC1..TC1_..
  34e0: 5f 54 43 32 00 a4 54 43 32 5f 14 25 5f 50 53 56  _TC2..TC2_.%_PSV
  34f0: 00 a0 13 50 4c 43 59 74 54 50 53 56 0a 0a 60 a4  ...PLCYtTPSV..`.
  3500: 4b 45 4c 56 60 a1 0a a4 4b 45 4c 56 54 50 53 56  KELV`...KELVTPSV
  3510: 08 5f 41 4c 30 12 06 01 46 4e 30 30 14 20 5f 41  ._AL0...FN00. _A
  3520: 43 30 00 a0 0e 50 4c 43 59 a4 4b 45 4c 56 54 50  C0...PLCY.KELVTP
  3530: 53 56 a1 0a a4 4b 45 4c 56 54 41 43 33 14 17 5f  SV...KELVTAC3.._
  3540: 53 43 50 01 70 68 50 4c 43 59 54 43 48 47 86 54  SCP.phPLCYTCHG.T
  3550: 48 52 4d 0a 81 14 14 54 52 4d 53 01 a0 0d 68 5c  HRM....TRMS...h\
  3560: 2e 5f 54 5a 5f 54 4d 53 53 68 14 24 54 52 4d 57  ._TZ_TMSSh.$TRMW
  3570: 01 a0 1d 68 a0 1a 95 68 0a 04 5c 2e 5f 54 5a 5f  ...h...h..\._TZ_
  3580: 54 4d 53 57 68 5c 2e 5f 54 5a 5f 54 43 48 47 10  TMSWh\._TZ_TCHG.
  3590: 24 5c 5f 47 50 45 14 1d 5f 4c 30 30 08 5c 2e 5f  $\_GPE.._L00.\._
  35a0: 54 5a 5f 54 43 48 47 86 5c 2e 5f 54 5a 5f 54 48  TZ_TCHG.\._TZ_TH
  35b0: 52 4d 0a 80 10 45 35 5c 5f 54 5a 5f 08 46 4f 4e  RM...E5\_TZ_.FON
  35c0: 31 0a 76 08 46 4f 4e 32 0a a0 08 4c 54 4d 50 0a  1.v.FON2...LTMP.
  35d0: 3c 08 48 4c 4d 54 0a 46 08 4c 4c 4d 54 0a 32 08  <.HLMT.F.LLMT.2.
  35e0: 45 4c 4d 54 0a 02 14 46 05 54 4d 53 57 01 a0 4e  ELMT...F.TMSW..N
  35f0: 04 68 a0 4a 04 95 68 0a 04 57 42 59 54 54 53 41  .h.J..h..WBYTTSA
  3600: 44 0a 0b 0a 7f 57 42 59 54 54 53 41 44 0a 0c 0a  D....WBYTTSAD...
  3610: c9 57 42 59 54 54 53 41 44 0a 19 0a 7f 57 42 59  .WBYTTSAD....WBY
  3620: 54 54 53 41 44 0a 20 0a 7f 52 42 59 54 54 53 41  TTSAD. ..RBYTTSA
  3630: 44 0a 02 52 42 59 54 54 53 41 44 0a 02 14 4b 05  D..RBYTTSAD...K.
  3640: 54 4d 53 53 01 a0 32 92 94 68 0a 03 57 42 59 54  TMSS..2..h..WBYT
  3650: 54 53 41 44 0a 0d 0a 7f 57 42 59 54 54 53 41 44  TSAD....WBYTTSAD
  3660: 0a 0e 0a c9 52 42 59 54 54 53 41 44 0a 02 52 42  ....RBYTTSAD..RB
  3670: 59 54 54 53 41 44 0a 02 a0 20 93 68 0a 01 5c 2f  YTTSAD... .h..\/
  3680: 05 5f 53 42 5f 50 43 49 30 53 42 52 47 45 43 30  ._SB_PCI0SBRGEC0
  3690: 5f 46 4e 43 54 0a 85 0a 00 14 4a 1d 54 43 48 47  _FNCT.....J.TCHG
  36a0: 00 52 54 4d 50 a0 2c 94 4c 54 4d 50 54 43 52 54  .RTMP.,.LTMPTCRT
  36b0: 70 0a 7f 48 4c 4d 54 70 54 43 52 54 4c 4c 4d 54  p..HLMTpTCRTLLMT
  36c0: 70 46 31 4c 34 46 4f 4e 31 70 46 32 4c 34 46 4f  pF1L4FON1pF2L4FO
  36d0: 4e 32 a1 4d 11 a0 2e 94 4c 54 4d 50 54 50 53 56  N2.M....LTMPTPSV
  36e0: 70 54 43 52 54 48 4c 4d 54 70 54 50 53 56 4c 4c  pTCRTHLMTpTPSVLL
  36f0: 4d 54 70 46 31 4c 34 46 4f 4e 31 70 46 32 4c 34  MTpF1L4FON1pF2L4
  3700: 46 4f 4e 32 a1 4b 0e a0 2e 94 4c 54 4d 50 54 41  FON2.K....LTMPTA
  3710: 43 30 70 54 50 53 56 48 4c 4d 54 70 54 41 43 30  C0pTPSVHLMTpTAC0
  3720: 4c 4c 4d 54 70 46 31 4c 34 46 4f 4e 31 70 46 32  LLMTpF1L4FON1pF2
  3730: 4c 34 46 4f 4e 32 a1 49 0b a0 2e 94 4c 54 4d 50  L4FON2.I....LTMP
  3740: 54 41 43 31 70 54 41 43 30 48 4c 4d 54 70 54 41  TAC1pTAC0HLMTpTA
  3750: 43 31 4c 4c 4d 54 70 46 31 4c 33 46 4f 4e 31 70  C1LLMTpF1L3FON1p
  3760: 46 32 4c 33 46 4f 4e 32 a1 47 08 a0 2e 94 4c 54  F2L3FON2.G....LT
  3770: 4d 50 54 41 43 32 70 54 41 43 31 48 4c 4d 54 70  MPTAC2pTAC1HLMTp
  3780: 54 41 43 32 4c 4c 4d 54 70 46 31 4c 32 46 4f 4e  TAC2LLMTpF1L2FON
  3790: 31 70 46 32 4c 32 46 4f 4e 32 a1 45 05 a0 2e 94  1pF2L2FON2.E....
  37a0: 4c 54 4d 50 54 41 43 33 70 54 41 43 32 48 4c 4d  LTMPTAC3pTAC2HLM
  37b0: 54 70 54 41 43 33 4c 4c 4d 54 70 46 31 4c 31 46  TpTAC3LLMTpF1L1F
  37c0: 4f 4e 31 70 46 32 4c 31 46 4f 4e 32 a1 23 70 54  ON1pF2L1FON2.#pT
  37d0: 41 43 33 48 4c 4d 54 70 0a c9 4c 4c 4d 54 70 46  AC3HLMTp..LLMTpF
  37e0: 31 4c 30 46 4f 4e 31 70 46 32 4c 30 46 4f 4e 32  1L0FON1pF2L0FON2
  37f0: a0 22 50 4c 43 59 a0 1c 95 4c 54 4d 50 54 50 53  ."PLCY...LTMPTPS
  3800: 56 70 46 31 4c 30 46 4f 4e 31 70 46 32 4c 30 46  VpF1L0FON1pF2L0F
  3810: 4f 4e 32 72 48 4c 4d 54 0a 02 61 a0 09 94 61 0a  ON2rHLMT..a...a.
  3820: 7f 70 0a 7f 61 74 4c 4c 4d 54 0a 03 62 57 42 59  .p..atLLMT..bWBY
  3830: 54 54 53 41 44 0a 0d 61 57 42 59 54 54 53 41 44  TTSAD..aWBYTTSAD
  3840: 0a 0e 62 52 42 59 54 54 53 41 44 0a 02 52 42 59  ..bRBYTTSAD..RBY
  3850: 54 54 53 41 44 0a 02 5c 2f 05 5f 53 42 5f 50 43  TTSAD..\/._SB_PC
  3860: 49 30 53 42 52 47 45 43 30 5f 46 4e 43 54 0a 84  I0SBRGEC0_FNCT..
  3870: 46 4f 4e 31 14 22 52 54 4d 50 00 70 52 42 59 54  FON1."RTMP.pRBYT
  3880: 54 53 41 44 0a 01 60 a0 0a 80 60 00 70 60 4c 54  TSAD..`...`.p`LT
  3890: 4d 50 a4 4c 54 4d 50 14 47 06 52 46 41 4e 00 a0  MP.LTMP.G.RFAN..
  38a0: 10 93 46 4f 4e 31 46 31 4c 30 70 46 4e 43 30 60  ..FON1F1L0pFNC0`
  38b0: a1 4c 04 a0 10 93 46 4f 4e 31 46 31 4c 31 70 46  .L....FON1F1L1pF
  38c0: 4e 43 31 60 a1 38 a0 10 93 46 4f 4e 31 46 31 4c  NC1`.8...FON1F1L
  38d0: 32 70 46 4e 43 32 60 a1 25 a0 10 93 46 4f 4e 31  2pFNC2`.%...FON1
  38e0: 46 31 4c 33 70 46 4e 43 33 60 a1 12 a0 10 93 46  F1L3pFNC3`.....F
  38f0: 4f 4e 31 46 31 4c 34 70 46 4e 43 34 60 a4 60 14  ON1F1L4pFNC4`.`.
  3900: 0a 54 48 44 4c 00 54 43 48 47 10 48 26 5c 2e 5f  .THDL.TCHG.H&\._
  3910: 53 42 5f 50 43 49 30 5b 82 4a 25 56 47 41 5f 08  SB_PCI0[.J%VGA_.
  3920: 5f 41 44 52 0c 00 00 02 00 08 4c 43 44 4d 0b 08  _ADR......LCDM..
  3930: 08 08 43 52 54 4d 0b 01 01 08 54 56 4f 4d 0b 02  ..CRTM....TVOM..
  3940: 02 08 44 4f 4e 45 00 08 44 4f 53 46 01 14 1d 5f  ..DONE..DOSF..._
  3950: 49 4e 49 00 47 43 41 44 70 5c 43 41 44 4c 5c 50  INI.GCADp\CADL\P
  3960: 41 44 4c 47 43 44 44 47 4e 44 44 14 0c 5f 44 4f  ADLGCDDGNDD.._DO
  3970: 53 01 70 68 44 4f 53 46 14 14 5f 44 4f 44 00 a4  S.phDOSF.._DOD..
  3980: 12 0c 02 0c 00 01 01 00 0c 00 04 01 00 5b 82 4e  .............[.N
  3990: 06 43 52 54 44 08 5f 41 44 52 0b 00 01 14 19 5f  .CRTD._ADR....._
  39a0: 44 43 53 00 a0 0f 7b 5c 43 53 54 45 43 52 54 4d  DCS...{\CSTECRTM
  39b0: 00 a4 0a 1f a4 0a 1d 14 19 5f 44 47 53 00 a0 0f  ........._DGS...
  39c0: 7b 5c 4e 53 54 45 43 52 54 4d 00 a4 0a 01 a4 0a  {\NSTECRTM......
  39d0: 00 14 2b 5f 44 53 53 01 a0 24 7b 68 0c 00 00 00  ..+_DSS..${h....
  39e0: 40 00 a0 1a 7b 68 0c 00 00 00 80 00 70 5c 4e 53  @...{h......p\NS
  39f0: 54 45 5c 43 53 54 45 70 01 44 4f 4e 45 5b 82 4e  TE\CSTEp.DONE[.N
  3a00: 06 4c 43 44 44 08 5f 41 44 52 0b 00 04 14 19 5f  .LCDD._ADR....._
  3a10: 44 43 53 00 a0 0f 7b 5c 43 53 54 45 4c 43 44 4d  DCS...{\CSTELCDM
  3a20: 00 a4 0a 1f a4 0a 1d 14 19 5f 44 47 53 00 a0 0f  ........._DGS...
  3a30: 7b 5c 4e 53 54 45 4c 43 44 4d 00 a4 0a 01 a4 0a  {\NSTELCDM......
  3a40: 00 14 2b 5f 44 53 53 01 a0 24 7b 68 0c 00 00 00  ..+_DSS..${h....
  3a50: 40 00 a0 1a 7b 68 0c 00 00 00 80 00 70 5c 4e 53  @...{h......p\NS
  3a60: 54 45 5c 43 53 54 45 70 01 44 4f 4e 45 14 47 09  TE\CSTEp.DONE.G.
  3a70: 53 57 48 44 09 a0 2f 44 4f 53 46 70 0a 04 5c 53  SWHD../DOSFp..\S
  3a80: 46 55 4e 70 68 5c 53 53 54 45 49 53 4d 49 5c 53  FUNph\SSTEISMI\S
  3a90: 54 44 44 86 5c 2f 03 5f 53 42 5f 50 43 49 30 56  TDD.\/._SB_PCI0V
  3aa0: 47 41 5f 0a 81 a1 4f 05 a0 4a 04 92 93 5c 43 41  GA_...O..J...\CA
  3ab0: 44 4c 5c 50 41 44 4c 70 5c 43 41 44 4c 5c 50 41  DL\PADLp\CADL\PA
  3ac0: 44 4c a0 17 93 4f 53 46 47 4f 53 58 50 86 5c 2e  DL...OSFGOSXP.\.
  3ad0: 5f 53 42 5f 50 43 49 30 0a 00 a1 13 86 5c 2f 03  _SB_PCI0.....\/.
  3ae0: 5f 53 42 5f 50 43 49 30 56 47 41 5f 0a 00 5b 22  _SB_PCI0VGA_..["
  3af0: 0b e8 03 86 5c 2f 03 5f 53 42 5f 50 43 49 30 56  ....\/._SB_PCI0V
  3b00: 47 41 5f 0a 80 14 1d 47 43 44 44 00 70 0a 01 5c  GA_....GCDD.p..\
  3b10: 53 46 55 4e 49 53 4d 49 5c 47 54 44 44 a4 5c 43  SFUNISMI\GTDD.\C
  3b20: 53 54 45 14 1d 47 4e 44 44 00 70 0a 05 5c 53 46  STE..GNDD.p..\SF
  3b30: 55 4e 49 53 4d 49 5c 47 54 44 44 a4 5c 4e 53 54  UNISMI\GTDD.\NST
  3b40: 45 14 1d 47 43 41 44 00 70 0a 02 5c 53 46 55 4e  E..GCAD.p..\SFUN
  3b50: 49 53 4d 49 5c 47 54 44 44 a4 5c 43 41 44 4c 14  ISMI\GTDD.\CADL.
  3b60: 13 41 44 56 44 00 47 43 44 44 47 43 41 44 a4 47  .ADVD.GCDDGCAD.G
  3b70: 4e 44 44 10 47 09 5c 00 14 1a 41 44 56 47 00 a4  NDD.G.\...ADVG..
  3b80: 5c 2f 04 5f 53 42 5f 50 43 49 30 56 47 41 5f 41  \/._SB_PCI0VGA_A
  3b90: 44 56 44 14 4e 06 53 57 48 47 09 70 00 5c 2f 04  DVD.N.SWHG.p.\/.
  3ba0: 5f 53 42 5f 50 43 49 30 56 47 41 5f 44 4f 4e 45  _SB_PCI0VGA_DONE
  3bb0: 5c 2f 04 5f 53 42 5f 50 43 49 30 56 47 41 5f 53  \/._SB_PCI0VGA_S
  3bc0: 57 48 44 68 a0 3d 92 5c 2f 04 5f 53 42 5f 50 43  WHDh.=.\/._SB_PC
  3bd0: 49 30 56 47 41 5f 44 4f 53 46 70 0b f4 01 60 a2  I0VGA_DOSFp...`.
  3be0: 22 60 a0 17 5c 2f 04 5f 53 42 5f 50 43 49 30 56  "`..\/._SB_PCI0V
  3bf0: 47 41 5f 44 4f 4e 45 70 00 60 a1 07 5b 22 0a 0a  GA_DONEp.`..["..
  3c00: 76 60 14 08 4e 41 54 4b 00 a4 00 10 4b 57 5c 5f  v`..NATK....KW\_
  3c10: 53 42 5f 08 41 54 4b 50 00 5b 82 4c 56 41 54 4b  SB_.ATKP.[.LVATK
  3c20: 44 08 5f 48 49 44 0d 41 54 4b 30 31 30 30 00 08  D._HID.ATK0100..
  3c30: 5f 55 49 44 0c 00 01 01 01 14 12 49 4e 49 54 01  _UID.......INIT.
  3c40: 70 01 41 54 4b 50 a4 5c 4d 4e 41 4d 14 2d 42 53  p.ATKP.\MNAM.-BS
  3c50: 54 53 00 70 5c 49 4b 46 47 60 a0 1d 5c 2f 05 5f  TS.p\IKFG`..\/._
  3c60: 53 42 5f 50 43 49 30 53 42 52 47 45 43 30 5f 41  SB_PCI0SBRGEC0_A
  3c70: 43 41 50 7b 60 0a 7f 60 a4 60 14 2b 4d 4c 45 44  CAP{`..`.`.+MLED
  3c80: 01 a0 06 68 70 0a 31 60 a1 05 70 0a 51 60 5c 2f  ...hp.1`..p.Q`\/
  3c90: 05 5f 53 42 5f 50 43 49 30 53 42 52 47 45 43 30  ._SB_PCI0SBRGEC0
  3ca0: 5f 53 54 43 35 60 14 4e 05 54 4d 50 52 00 70 5c  _STC5`.N.TMPR.p\
  3cb0: 2e 5f 54 5a 5f 52 54 4d 50 60 70 5c 2e 5f 54 5a  ._TZ_RTMP`p\._TZ
  3cc0: 5f 52 46 41 4e 61 79 61 0a 10 61 72 5c 2e 5f 54  _RFANaya..ar\._T
  3cd0: 5a 5f 4b 45 4c 56 60 61 60 70 00 62 a0 0d 5c 54  Z_KELV`a`p.b..\T
  3ce0: 45 4e 41 70 5c 54 44 54 59 62 a1 0f a0 0d 5c 54  ENAp\TDTYb....\T
  3cf0: 48 4c 53 70 5c 54 54 44 54 62 79 62 0a 18 62 72  HLSp\TTDTbyb..br
  3d00: 60 62 60 a4 60 14 4c 05 53 46 55 4e 00 70 0a 37  `b`.`.L.SFUN.p.7
  3d10: 60 7d 60 0b 40 02 60 a0 21 93 5c 2f 05 5f 53 42  `}`.-4b8TPpkIZ3Q@public.gmane.org`.!.\/._SB
  3d20: 5f 50 43 49 30 50 30 50 31 4d 50 43 49 4d 50 44  _PCI0P0P1MPCIMPD
  3d30: 50 0a 01 7d 60 0b 00 01 60 a0 21 94 5c 2f 05 5f  P..}`...`.!.\/._
  3d40: 53 42 5f 50 43 49 30 50 30 50 31 4d 50 43 49 4d  SB_PCI0P0P1MPCIM
  3d50: 50 44 50 0a 01 7d 60 0b 00 08 60 72 60 0a 08 60  PDP..}`...`r`..`
  3d60: a4 60 08 46 4d 53 54 12 45 27 04 12 4b 09 04 12  .`.FMST.E'..K...
  3d70: 25 05 12 06 02 0a 55 0a 02 12 06 02 0a 64 0a 04  %.....U......d..
  3d80: 12 06 02 0a 69 0a 05 12 06 02 0a 6e 0a 06 12 06  ....i......n....
  3d90: 02 0a 73 0a 07 12 25 05 12 06 02 0a 71 0a 02 12  ..s...%.....q...
  3da0: 06 02 0a 85 0a 04 12 06 02 0a 8c 0a 05 12 06 02  ................
  3db0: 0a 93 0a 06 12 06 02 0a 99 0a 07 12 25 05 12 06  ............%...
  3dc0: 02 0a 8d 0a 02 12 06 02 0a a6 0a 04 12 06 02 0a  ................
  3dd0: af 0a 05 12 06 02 0a b7 0a 06 12 06 02 0a bf 0a  ................
  3de0: 07 12 25 05 12 06 02 0a aa 0a 02 12 06 02 0a c8  ..%.............
  3df0: 0a 04 12 06 02 0a d2 0a 05 12 06 02 0a dc 0a 06  ................
  3e00: 12 06 02 0a e6 0a 07 12 4c 09 04 12 25 05 12 06  ........L...%...
  3e10: 02 0a 5a 0a 03 12 06 02 0a 64 0a 04 12 06 02 0a  ..Z......d......
  3e20: 6e 0a 05 12 06 02 0a 78 0a 06 12 06 02 0a 82 0a  n......x........
  3e30: 07 12 25 05 12 06 02 0a 78 0a 03 12 06 02 0a 85  ..%.....x.......
  3e40: 0a 04 12 06 02 0a 93 0a 05 12 06 02 0a a0 0a 06  ................
  3e50: 12 06 02 0a ad 0a 07 12 25 05 12 06 02 0a 96 0a  ........%.......
  3e60: 03 12 06 02 0a a6 0a 04 12 06 02 0a b7 0a 05 12  ................
  3e70: 06 02 0a c7 0a 06 12 06 02 0a d9 0a 07 12 26 05  ..............&.
  3e80: 12 06 02 0a b4 0a 03 12 06 02 0a c8 0a 04 12 06  ................
  3e90: 02 0a dc 0a 05 12 06 02 0a f0 0a 05 12 07 02 0b  ................
  3ea0: 04 01 0a 07 12 4b 09 04 12 25 05 12 06 02 0a 5a  .....K...%.....Z
  3eb0: 0a 00 12 06 02 0a 64 0a 01 12 06 02 0a 69 0a 02  ......d......i..
  3ec0: 12 06 02 0a 6e 0a 03 12 06 02 0a 73 0a 04 12 25  ....n......s...%
  3ed0: 05 12 06 02 0a 78 0a 00 12 06 02 0a 85 0a 01 12  .....x..........
  3ee0: 06 02 0a 8c 0a 02 12 06 02 0a 93 0a 03 12 06 02  ................
  3ef0: 0a 99 0a 04 12 25 05 12 06 02 0a 96 0a 00 12 06  .....%..........
  3f00: 02 0a a6 0a 01 12 06 02 0a af 0a 02 12 06 02 0a  ................
  3f10: b7 0a 03 12 06 02 0a bf 0a 04 12 25 05 12 06 02  ...........%....
  3f20: 0a b4 0a 00 12 06 02 0a c8 0a 01 12 06 02 0a d2  ................
  3f30: 0a 02 12 06 02 0a dc 0a 03 12 06 02 0a e6 0a 04  ................
  3f40: 12 4c 09 04 12 25 05 12 06 02 0a 5a 0a 02 12 06  .L...%.....Z....
  3f50: 02 0a 64 0a 04 12 06 02 0a 78 0a 05 12 06 02 0a  ..d......x......
  3f60: 7d 0a 06 12 06 02 0a 82 0a 07 12 25 05 12 06 02  }..........%....
  3f70: 0a 78 0a 02 12 06 02 0a 85 0a 04 12 06 02 0a a0  .x..............
  3f80: 0a 05 12 06 02 0a a7 0a 06 12 06 02 0a ad 0a 07  ................
  3f90: 12 25 05 12 06 02 0a 96 0a 02 12 06 02 0a a6 0a  .%..............
  3fa0: 04 12 06 02 0a c8 0a 05 12 06 02 0a d0 0a 06 12  ................
  3fb0: 06 02 0a d9 0a 07 12 26 05 12 06 02 0a b4 0a 02  .......&........
  3fc0: 12 06 02 0a c8 0a 04 12 06 02 0a f0 0a 05 12 06  ................
  3fd0: 02 0a fa 0a 06 12 07 02 0b 04 01 0a 07 14 4a 06  ..............J.
  3fe0: 47 46 52 51 01 a0 13 93 5c 4f 56 43 4b 0a 00 a0  GFRQ....\OVCK...
  3ff0: 09 92 93 68 0a 01 a4 0a 00 70 83 88 46 4d 53 54  ...h.....p..FMST
  4000: 5c 46 53 35 36 00 60 70 83 88 60 5c 43 50 55 46  \FS56.`p..`\CPUF
  4010: 00 61 70 68 65 a0 19 93 65 0a 02 a0 13 5c 4f 56  .aphe...e....\OV
  4020: 43 4b 74 5c 4f 56 43 4b 0a 01 66 72 65 66 65 70  CKt\OVCK..frefep
  4030: 83 88 61 65 00 62 70 83 88 62 0a 00 00 63 77 63  ..ae.bp..b...cwc
  4040: 5c 43 50 55 52 64 a4 64 14 45 05 53 46 52 51 01  \CPURd.d.E.SFRQ.
  4050: 70 83 88 46 4d 53 54 5c 46 53 35 36 00 60 70 83  p..FMST\FS56.`p.
  4060: 88 60 5c 43 50 55 46 00 61 70 68 65 a0 19 93 65  .`\CPUF.aphe...e
  4070: 0a 02 a0 13 5c 4f 56 43 4b 74 5c 4f 56 43 4b 0a  ....\OVCKt\OVCK.
  4080: 01 66 72 65 66 65 70 83 88 61 65 00 62 70 83 88  .frefep..ae.bp..
  4090: 62 0a 01 00 63 70 63 5c 46 53 30 32 a4 01 14 1e  b...cpc\FS02....
  40a0: 57 44 45 56 00 a4 5c 2f 05 5f 53 42 5f 50 43 49  WDEV..\/._SB_PCI
  40b0: 30 50 30 50 31 4d 50 43 49 4d 50 44 50 14 1e 53  0P0P1MPCIMPDP..S
  40c0: 57 42 58 01 a0 17 68 5c 2f 04 5f 53 42 5f 50 43  WBX...h\/._SB_PC
  40d0: 49 30 49 44 45 30 53 50 57 52 0a 00 14 3c 41 49  I0IDE0SPWR...<AI
  40e0: 42 58 00 a0 33 5c 2f 05 5f 53 42 5f 50 43 49 30  BX..3\/._SB_PCI0
  40f0: 53 42 52 47 45 43 30 5f 41 49 42 50 a0 1a 5c 2f  SBRGEC0_AIBP..\/
  4100: 05 5f 53 42 5f 50 43 49 30 53 42 52 47 45 43 30  ._SB_PCI0SBRGEC0
  4110: 5f 49 44 45 50 a4 01 a4 00 14 0d 4f 53 56 52 01  _IDEP......OSVR.
  4120: 70 68 5c 4f 53 46 47 14 0c 47 50 4c 56 00 a4 5c  ph\OSFG..GPLV..\
  4130: 4c 42 54 4e 14 24 53 50 4c 56 01 70 68 5c 4c 42  LBTN.$SPLV.ph\LB
  4140: 54 4e 5c 2f 05 5f 53 42 5f 50 43 49 30 53 42 52  TN\/._SB_PCI0SBR
  4150: 47 45 43 30 5f 53 54 42 52 14 19 57 4c 45 44 01  GEC0_STBR..WLED.
  4160: a0 09 68 70 00 5c 50 4f 33 33 a1 08 70 01 5c 50  ..hp.\PO33..p.\P
  4170: 4f 33 33 14 13 53 44 53 50 01 a0 0c 5c 4e 41 54  O33..SDSP...\NAT
  4180: 4b 5c 53 57 48 47 68 10 4d 25 5c 00 08 50 4d 45  K\SWHGh.M%\..PME
  4190: 57 00 08 57 41 4b 43 00 08 4c 4c 30 42 00 14 4e  W..WAKC..LL0B..N
  41a0: 13 4f 45 4d 53 01 70 00 5c 4c 4c 30 42 7d 5c 2f  .OEMS.p.\LL0B}\/
  41b0: 05 5f 53 42 5f 50 43 49 30 50 30 50 31 43 42 53  ._SB_PCI0P0P1CBS
  41c0: 30 50 4d 45 31 0a 01 5c 2f 05 5f 53 42 5f 50 43  0PME1..\/._SB_PC
  41d0: 49 30 50 30 50 31 43 42 53 30 50 4d 45 31 7d 5c  I0P0P1CBS0PME1}\
  41e0: 2f 05 5f 53 42 5f 50 43 49 30 50 30 50 31 43 42  /._SB_PCI0P0P1CB
  41f0: 53 31 50 4d 45 31 0a 01 5c 2f 05 5f 53 42 5f 50  S1PME1..\/._SB_P
  4200: 43 49 30 50 30 50 31 43 42 53 31 50 4d 45 31 a0  CI0P0P1CBS1PME1.
  4210: 2a 93 68 0a 03 a0 14 92 94 5c 4f 53 46 47 5c 4f  *.h......\OSFG\O
  4220: 53 4d 45 70 01 5c 57 49 44 45 a1 08 70 00 5c 57  SMEp.\WIDE..p.\W
  4230: 49 44 45 70 00 5c 43 42 53 55 5c 2f 04 5f 53 42  IDEp.\CBSU\/._SB
  4240: 5f 50 43 49 30 55 53 42 31 55 53 42 53 68 5c 2f  _PCI0USB1USBSh\/
  4250: 04 5f 53 42 5f 50 43 49 30 55 53 42 32 55 53 42  ._SB_PCI0USB2USB
  4260: 53 68 5c 2f 04 5f 53 42 5f 50 43 49 30 55 53 42  Sh\/._SB_PCI0USB
  4270: 33 55 53 42 53 68 5c 2f 05 5f 53 42 5f 50 43 49  3USBSh\/._SB_PCI
  4280: 30 53 42 52 47 45 43 30 5f 45 43 30 53 68 a0 2f  0SBRGEC0_EC0Sh./
  4290: 93 68 0a 05 5c 2f 04 5f 53 42 5f 50 43 49 30 49  .h..\/._SB_PCI0I
  42a0: 44 45 30 53 54 42 59 0a 00 5c 2f 04 5f 53 42 5f  DE0STBY..\/._SB_
  42b0: 50 43 49 30 49 44 45 30 53 54 42 59 0a 01 a0 16  PCI0IDE0STBY....
  42c0: 93 68 0a 04 a0 10 93 4f 53 46 47 4f 53 32 4b 70  .h.....OSFGOS2Kp
  42d0: 68 53 34 32 4b 72 68 0a d0 44 42 47 38 14 47 10  hS42Krh..DBG8.G.
  42e0: 4f 45 4d 57 01 a0 0c 93 68 0a 03 70 01 5c 43 42  OEMW....h..p.\CB
  42f0: 53 55 a0 2c 5c 4c 4c 30 42 86 5c 2f 03 5f 53 42  SU.,\LL0B.\/._SB
  4300: 5f 50 43 49 30 50 30 50 31 0a 02 86 5c 2e 5f 53  _PCI0P0P1...\._S
  4310: 42 5f 53 4c 50 42 0a 02 70 00 5c 4c 4c 30 42 a0  B_SLPB..p.\LL0B.
  4320: 1b 93 68 0a 04 a0 15 92 94 5c 4f 53 46 47 5c 4f  ..h......\OSFG\O
  4330: 53 4d 45 70 0a 02 5c 57 41 4b 43 5c 2f 05 5f 53  SMEp..\WAKC\/._S
  4340: 42 5f 50 43 49 30 50 30 50 31 43 42 53 30 43 42  B_PCI0P0P1CBS0CB
  4350: 53 57 68 5c 2f 05 5f 53 42 5f 50 43 49 30 50 30  SWh\/._SB_PCI0P0
  4360: 50 31 43 42 53 31 43 42 53 57 68 70 5c 53 42 50  P1CBS1CBSWhp\SBP
  4370: 53 5c 50 4d 45 57 5c 2f 04 5f 53 42 5f 50 43 49  S\PMEW\/._SB_PCI
  4380: 30 55 53 42 31 55 53 42 57 68 5c 2f 04 5f 53 42  0USB1USBWh\/._SB
  4390: 5f 50 43 49 30 55 53 42 32 55 53 42 57 68 5c 2f  _PCI0USB2USBWh\/
  43a0: 04 5f 53 42 5f 50 43 49 30 55 53 42 33 55 53 42  ._SB_PCI0USB3USB
  43b0: 57 68 5c 2f 05 5f 53 42 5f 50 43 49 30 53 42 52  Wh\/._SB_PCI0SBR
  43c0: 47 45 43 30 5f 45 43 30 57 68 a0 12 93 68 0a 04  GEC0_EC0Wh...h..
  43d0: 86 5c 2e 5f 53 42 5f 53 4c 50 42 0a 02 72 68 0a  .\._SB_SLPB..rh.
  43e0: f0 44 42 47 38 10 42 13 5c 5f 47 50 45 14 25 5f  .DBG8.B.\_GPE.%_
  43f0: 4c 30 33 08 86 5c 2f 03 5f 53 42 5f 50 43 49 30  L03..\/._SB_PCI0
  4400: 55 53 42 31 0a 02 86 5c 2e 5f 53 42 5f 53 4c 50  USB1...\._SB_SLP
  4410: 42 0a 02 14 25 5f 4c 30 34 08 86 5c 2f 03 5f 53  B...%_L04..\/._S
  4420: 42 5f 50 43 49 30 55 53 42 32 0a 02 86 5c 2e 5f  B_PCI0USB2...\._
  4430: 53 42 5f 53 4c 50 42 0a 02 14 25 5f 4c 30 43 08  SB_SLPB...%_L0C.
  4440: 86 5c 2f 03 5f 53 42 5f 50 43 49 30 55 53 42 33  .\/._SB_PCI0USB3
  4450: 0a 02 86 5c 2e 5f 53 42 5f 53 4c 50 42 0a 02 14  ...\._SB_SLPB...
  4460: 25 5f 4c 30 44 08 86 5c 2f 03 5f 53 42 5f 50 43  %_L0D..\/._SB_PC
  4470: 49 30 45 48 43 49 0a 02 86 5c 2e 5f 53 42 5f 53  I0EHCI...\._SB_S
  4480: 4c 50 42 0a 02 14 25 5f 4c 30 35 08 86 5c 2f 03  LPB...%_L05..\/.
  4490: 5f 53 42 5f 50 43 49 30 4d 4f 44 4d 0a 02 86 5c  _SB_PCI0MODM...\
  44a0: 2e 5f 53 42 5f 53 4c 50 42 0a 02 14 4c 06 5f 4c  ._SB_SLPB...L._L
  44b0: 30 42 08 70 01 5c 4c 4c 30 42 a0 2e 5c 2f 05 5f  0B.p.\LL0B..\/._
  44c0: 53 42 5f 50 43 49 30 50 30 50 31 43 42 53 30 43  SB_PCI0P0P1CBS0C
  44d0: 42 53 52 86 5c 2f 04 5f 53 42 5f 50 43 49 30 50  BSR.\/._SB_PCI0P
  44e0: 30 50 31 43 42 53 30 0a 02 a0 2e 5c 2f 05 5f 53  0P1CBS0....\/._S
  44f0: 42 5f 50 43 49 30 50 30 50 31 43 42 53 31 43 42  B_PCI0P0P1CBS1CB
  4500: 53 52 86 5c 2f 04 5f 53 42 5f 50 43 49 30 50 30  SR.\/._SB_PCI0P0
  4510: 50 31 43 42 53 31 0a 02 10 41 0b 5c 2e 5f 53 42  P1CBS1...A.\._SB
  4520: 5f 41 54 4b 44 14 28 46 53 4d 49 01 70 68 5c 46  _ATKD.(FSMI.ph\F
  4530: 53 46 4e 7d 68 0a a0 60 70 60 5c 44 42 47 38 49  SFN}h..`p`\DBG8I
  4540: 53 4d 49 5c 57 46 41 54 a4 5c 46 53 54 41 14 13  SMI\WFAT.\FSTA..
  4550: 46 4c 53 48 01 70 68 5c 46 53 54 41 46 53 4d 49  FLSH.ph\FSTAFSMI
  4560: 0a 00 14 14 46 49 4e 49 01 70 68 5c 46 41 44 52  ....FINI.ph\FADR
  4570: a4 46 53 4d 49 0a 01 14 14 46 45 52 53 01 70 68  .FSMI....FERS.ph
  4580: 5c 46 53 54 41 a4 46 53 4d 49 0a 02 14 22 46 57  \FSTA.FSMI..."FW
  4590: 52 49 01 70 68 5c 46 41 44 52 70 0b 00 10 5c 46  RI.ph\FADRp...\F
  45a0: 53 49 5a a4 74 0b 00 10 46 53 4d 49 0a 03 00 14  SIZ.t...FSMI....
  45b0: 1a 46 57 52 50 00 70 0a 00 5c 46 53 49 5a a4 74  .FWRP.p..\FSIZ.t
  45c0: 0b 00 10 46 53 4d 49 0a 03 00 5b 82 4c 0a 55 41  ...FSMI...[.L.UA
  45d0: 52 32 08 5f 55 49 44 0a 02 14 0d 5f 48 49 44 00  R2._UID...._HID.
  45e0: a4 55 48 49 44 0a 01 14 0d 5f 53 54 41 00 a4 44  .UHID...._STA..D
  45f0: 53 54 41 0a 01 14 1b 5f 44 49 53 00 a0 14 94 5c  STA...._DIS....\
  4600: 4f 53 46 47 5c 4f 53 4d 45 44 43 4e 54 0a 01 0a  OSFG\OSMEDCNT...
  4610: 00 14 0d 5f 43 52 53 00 a4 44 43 52 53 0a 01 14  ..._CRS..DCRS...
  4620: 0d 5f 53 52 53 01 44 53 52 53 68 0a 01 14 0b 5f  ._SRS.DSRSh...._
  4630: 50 52 53 00 a4 43 4d 50 52 08 43 4d 50 52 11 39  PRS..CMPR.CMPR.9
  4640: 0a 36 22 18 00 30 2a 0e 00 47 01 f8 03 f8 03 01  .6"..0*..G......
  4650: 08 30 2a 0e 00 47 01 f8 02 f8 02 01 08 30 2a 0e  .0*..G.......0*.
  4660: 00 47 01 e8 03 e8 03 01 08 30 2a 0e 00 47 01 e8  .G.......0*..G..
  4670: 02 e8 02 01 08 38 79 00 5b 82 48 2b 46 44 43 30  .....8y.[.H+FDC0
  4680: 08 5f 48 49 44 0c 41 d0 07 00 14 29 5f 53 54 41  ._HID.A....)_STA
  4690: 00 a0 1b 92 94 5c 4f 53 46 47 5c 4f 53 4d 45 a0  .....\OSFG\OSME.
  46a0: 0d 92 46 53 54 41 5f 44 49 53 a4 0a 00 a4 44 53  ..FSTA_DIS....DS
  46b0: 54 41 0a 03 14 0e 5f 44 49 53 00 44 43 4e 54 0a  TA...._DIS.DCNT.
  46c0: 03 0a 00 14 48 05 5f 43 52 53 00 44 43 52 53 0a  ....H._CRS.DCRS.
  46d0: 03 70 49 52 51 4d 49 52 51 45 70 44 4d 41 4d 44  .pIRQMIRQEpDMAMD
  46e0: 4d 41 45 70 49 4f 31 31 49 4f 32 31 70 49 4f 31  MAEpIO11IO21pIO1
  46f0: 32 49 4f 32 32 70 0a 06 4c 45 4e 32 72 49 4f 32  2IO22p..LEN2rIO2
  4700: 31 0a 07 49 4f 33 31 70 49 4f 33 31 49 4f 33 32  1..IO31pIO31IO32
  4710: 70 0a 01 4c 45 4e 33 a4 43 52 53 32 14 0d 5f 53  p..LEN3.CRS2.._S
  4720: 52 53 01 44 53 52 53 68 0a 03 08 5f 50 52 53 11  RS.DSRSh..._PRS.
  4730: 4d 04 0a 49 31 00 22 40 00 2a 04 00 47 01 f0 03  M..I1."@.*..G...
  4740: f0 03 01 06 47 01 f7 03 f7 03 01 01 30 22 f8 1c  ....G.......0"..
  4750: 2a 0e 00 47 01 f0 03 f0 03 01 06 47 01 f7 03 f7  *..G.......G....
  4760: 03 01 01 30 22 f8 1c 2a 0e 00 47 01 70 03 70 03  ...0"..*..G.p.p.
  4770: 01 06 47 01 77 03 77 03 01 01 38 79 00 08 46 44  ..G.w.w...8y..FD
  4780: 44 53 0a 0f 14 20 53 50 57 52 01 a0 10 68 70 00  DS... SPWR...hp.
  4790: 5c 49 50 57 52 70 0a 0f 46 44 44 53 a1 08 70 01  \IPWRp..FDDS..p.
  47a0: 5c 49 50 57 52 14 3e 5f 49 4e 49 00 a0 2f 5c 2f  \IPWR.>_INI../\/
  47b0: 05 5f 53 42 5f 50 43 49 30 53 42 52 47 45 43 30  ._SB_PCI0SBRGEC0
  47c0: 5f 41 49 42 50 a0 16 93 5c 53 42 41 59 0a 02 a0  _AIBP...\SBAY...
  47d0: 0c 5c 49 50 57 52 53 50 57 52 0a 01 a1 07 53 50  .\IPWRSPWR....SP
  47e0: 57 52 0a 00 14 4c 06 46 53 54 41 00 a0 09 92 46  WR...L.FSTA....F
  47f0: 44 44 53 a4 0a 00 a1 4a 05 a0 0e 92 93 44 53 54  DDS....J.....DST
  4800: 41 0a 03 0a 0f a4 0a 00 a1 48 04 70 01 5c 46 4c  A........H.p.\FL
  4810: 50 53 a0 0f 93 5c 46 4c 50 4c 5c 46 4c 50 53 a4  PS...\FLPL\FLPS.
  4820: 0a 0f a0 1c 92 5c 2f 05 5f 53 42 5f 50 43 49 30  .....\/._SB_PCI0
  4830: 53 42 52 47 45 43 30 5f 41 49 42 50 a4 0a 00 a0  SBRGEC0_AIBP....
  4840: 0c 93 5c 53 42 41 59 0a 02 a4 0a 0f a1 04 a4 0a  ..\SBAY.........
  4850: 00 08 46 44 45 42 11 03 0a 14 8a 46 44 45 42 0a  ..FDEB.....FDEB.
  4860: 00 46 4c 50 30 8a 46 44 45 42 0a 04 46 4c 50 31  .FLP0.FDEB..FLP1
  4870: 8a 46 44 45 42 0a 08 46 4c 50 32 8a 46 44 45 42  .FDEB..FLP2.FDEB
  4880: 0a 0c 46 4c 50 33 8a 46 44 45 42 0a 10 54 41 50  ..FLP3.FDEB..TAP
  4890: 45 14 3a 5f 46 44 45 00 70 00 46 4c 50 31 70 00  E.:_FDE.p.FLP1p.
  48a0: 46 4c 50 32 70 00 46 4c 50 33 70 0a 02 54 41 50  FLP2p.FLP3p..TAP
  48b0: 45 a0 0c 46 53 54 41 70 0a 01 46 4c 50 30 a1 08  E..FSTAp..FLP0..
  48c0: 70 0a 00 46 4c 50 30 a4 46 44 45 42 14 36 52 45  p..FLP0.FDEB.6RE
  48d0: 4d 55 00 86 5c 2f 04 5f 53 42 5f 50 43 49 30 53  MU..\/._SB_PCI0S
  48e0: 42 52 47 46 44 43 30 0a 00 86 5c 2f 05 5f 53 42  BRGFDC0...\/._SB
  48f0: 5f 50 43 49 30 53 42 52 47 46 44 43 30 46 44 44  _PCI0SBRGFDC0FDD
  4900: 30 0a 01 5b 82 2d 46 44 44 30 08 5f 41 44 52 0a  0..[.-FDD0._ADR.
  4910: 00 14 14 5f 45 4a 30 01 70 01 5c 49 50 57 52 70  ..._EJ0.p.\IPWRp
  4920: 0a 00 46 44 44 53 14 0b 5f 53 54 41 00 a4 46 53  ..FDDS.._STA..FS
  4930: 54 41 10 48 06 5c 5f 47 50 45 14 40 06 5f 4c 31  TA.H.\_GPE.-ZWzmxHScPZk@public.gmane.org
  4940: 44 00 70 01 5c 46 4c 50 53 a0 26 93 5c 46 4c 50  D.p.\FLPS.&.\FLP
  4950: 4c 5c 46 4c 50 53 70 0a 0f 5c 2f 05 5f 53 42 5f  L\FLPSp..\/._SB_
  4960: 50 43 49 30 53 42 52 47 46 44 43 30 46 44 44 53  PCI0SBRGFDC0FDDS
  4970: 7f 5c 46 4c 50 4c 0a 01 5c 46 4c 50 4c 70 01 5c  .\FLPL..\FLPLp.\
  4980: 46 4c 50 53 5c 2f 05 5f 53 42 5f 50 43 49 30 53  FLPS\/._SB_PCI0S
  4990: 42 52 47 46 44 43 30 52 45 4d 55 5b 82 46 1c 4c  BRGFDC0REMU[.F.L
  49a0: 50 54 45 14 1c 5f 48 49 44 00 a0 0d 4c 50 54 4d  PTE.._HID...LPTM
  49b0: 0a 02 a4 0c 41 d0 04 01 a1 07 a4 0c 41 d0 04 00  ....A.......A...
  49c0: 14 0d 5f 53 54 41 00 a4 44 53 54 41 0a 02 14 0e  .._STA..DSTA....
  49d0: 5f 44 49 53 00 44 43 4e 54 0a 02 0a 00 14 4d 06  _DIS.DCNT.....M.
  49e0: 5f 43 52 53 00 44 43 52 53 0a 02 a0 48 05 4c 50  _CRS.DCRS...H.LP
  49f0: 54 4d 0a 02 70 49 52 51 4d 49 52 51 45 70 44 4d  TM..pIRQMIRQEpDM
  4a00: 41 4d 44 4d 41 45 70 49 4f 31 31 49 4f 32 31 70  AMDMAEpIO11IO21p
  4a10: 49 4f 31 32 49 4f 32 32 70 4c 45 4e 31 4c 45 4e  IO12IO22pLEN1LEN
  4a20: 32 72 49 4f 32 31 0b 00 04 49 4f 33 31 70 49 4f  2rIO21...IO31pIO
  4a30: 33 31 49 4f 33 32 70 4c 45 4e 32 4c 45 4e 33 a4  31IO32pLEN2LEN3.
  4a40: 43 52 53 32 a1 06 a4 43 52 53 31 14 0d 5f 53 52  CRS2...CRS1.._SR
  4a50: 53 01 44 53 52 53 68 0a 02 14 1a 5f 50 52 53 00  S.DSRSh...._PRS.
  4a60: a0 0c 4c 50 54 4d 0a 02 a4 45 50 50 52 a1 06 a4  ..LPTM...EPPR...
  4a70: 4c 50 50 52 08 4c 50 50 52 11 41 06 0a 5d 30 22  LPPR.LPPR.A..]0"
  4a80: f8 1c 2a 00 00 47 01 78 03 78 03 01 08 30 22 f8  ..*..G.x.x...0".
  4a90: 1c 2a 00 00 47 01 78 02 78 02 01 08 30 22 f8 1c  .*..G.x.x...0"..
  4aa0: 2a 00 00 47 01 bc 03 bc 03 01 04 30 22 00 00 2a  *..G.......0"..*
  4ab0: 00 00 47 01 78 03 78 03 01 08 30 22 00 00 2a 00  ..G.x.x...0"..*.
  4ac0: 00 47 01 78 02 78 02 01 08 30 22 00 00 2a 00 00  .G.x.x...0"..*..
  4ad0: 47 01 bc 03 bc 03 01 04 38 79 00 08 45 50 50 52  G.......8y..EPPR
  4ae0: 11 42 08 0a 7e 22 f8 1c 30 2a 0e 00 47 01 78 03  .B..~"..0*..G.x.
  4af0: 78 03 01 08 47 01 78 07 78 07 01 08 30 2a 0e 00  x...G.x.x...0*..
  4b00: 47 01 78 02 78 02 01 08 47 01 78 06 78 06 01 08  G.x.x...G.x.x...
  4b10: 30 2a 0e 00 47 01 bc 03 bc 03 01 04 47 01 bc 07  0*..G.......G...
  4b20: bc 07 01 04 30 2a 00 00 47 01 78 03 78 03 01 08  ....0*..G.x.x...
  4b30: 47 01 78 07 78 07 01 08 30 2a 00 00 47 01 78 02  G.x.x...0*..G.x.
  4b40: 78 02 01 08 47 01 78 06 78 06 01 08 30 2a 00 00  x...G.x.x...0*..
  4b50: 47 01 bc 03 bc 03 01 04 47 01 bc 07 bc 07 01 04  G.......G.......
  4b60: 38 79 00 5b 82 49 0b 46 57 48 5f 08 5f 48 49 44  8y.[.I.FWH_._HID
  4b70: 0c 41 d0 0c 02 08 5f 55 49 44 0a 02 08 43 52 53  .A...._UID...CRS
  4b80: 5f 11 1d 0a 1a 86 09 00 00 00 00 00 00 00 00 00  _...............
  4b90: 00 86 09 00 00 00 00 00 00 00 00 00 00 79 00 8a  .............y..
  4ba0: 43 52 53 5f 0a 04 42 53 30 30 8a 43 52 53 5f 0a  CRS_..BS00.CRS_.
  4bb0: 08 42 4c 30 30 8a 43 52 53 5f 0a 10 42 53 31 30  .BL00.CRS_..BS10
  4bc0: 8a 43 52 53 5f 0a 14 42 4c 31 30 14 42 05 5f 43  .CRS_..BL10.B._C
  4bd0: 52 53 00 70 0c 00 00 80 ff 60 82 46 48 44 30 61  RS.p.....`.FHD0a
  4be0: 76 61 a0 0a 61 77 61 0c 00 00 08 00 61 72 60 61  va..awa.....ar`a
  4bf0: 62 70 62 42 53 30 30 72 42 53 30 30 0c 00 00 40  bpbBS00rBS00...@
  4c00: 00 42 53 31 30 74 0a 00 42 53 31 30 42 4c 30 30  .BS10t..BS10BL00
  4c10: 70 42 4c 30 30 42 4c 31 30 a4 43 52 53 5f 5b 82  pBL00BL10.CRS_[.
  4c20: 4b 09 46 57 48 45 08 5f 48 49 44 0c 41 d0 0c 02  K.FWHE._HID.A...
  4c30: 08 5f 55 49 44 0a 03 08 43 52 53 5f 11 11 0a 0e  ._UID...CRS_....
  4c40: 86 09 00 00 00 00 00 00 00 00 00 00 79 00 14 4c  ............y..L
  4c50: 06 5f 43 52 53 00 8a 43 52 53 5f 0a 04 42 53 30  ._CRS..CRS_..BS0
  4c60: 30 8a 43 52 53 5f 0a 08 42 4c 30 30 a0 1a 93 5e  0.CRS_..BL00...^
  4c70: 5e 2e 46 57 48 5f 42 53 30 30 0a 00 5e 5e 2e 46  ^.FWH_BS00..^^.F
  4c80: 57 48 5f 5f 43 52 53 72 5e 5e 2e 46 57 48 5f 42  WH__CRSr^^.FWH_B
  4c90: 53 30 30 5e 5e 2e 46 57 48 5f 42 4c 30 30 42 53  S00^^.FWH_BL00BS
  4ca0: 30 30 74 5e 5e 2e 46 57 48 5f 42 53 31 30 42 53  00t^^.FWH_BS10BS
  4cb0: 30 30 42 4c 30 30 a4 43 52 53 5f 5b 80 46 48 52  00BL00.CRS_[.FHR
  4cc0: 30 02 0a e3 0a 01 5b 81 0b 46 48 52 30 01 46 48  0.....[..FHR0.FH
  4cd0: 44 30 08 5b 82 44 ea 49 44 45 30 08 5f 41 44 52  D0.[.D.IDE0._ADR
  4ce0: 0c 01 00 1f 00 10 40 19 5c 2f 04 5f 53 42 5f 50  ......-4b8TPpkIZ3Q@public.gmane.org\/._SB_P
  4cf0: 43 49 30 53 42 52 47 45 43 30 5f 14 29 41 49 42  CI0SBRGEC0_.)AIB
  4d00: 50 08 70 52 44 43 33 0a 05 60 a2 0c 93 60 ff 70  P.pRDC3..`...`.p
  4d10: 52 44 43 33 0a 05 60 7b 60 0a 10 60 a0 04 60 a4  RDC3..`{`..`..`.
  4d20: 00 a1 03 a4 01 08 50 49 44 45 0a 00 08 43 49 44  ......PIDE...CID
  4d30: 45 0a 00 14 4d 09 5f 51 32 45 00 70 41 49 42 50  E...M._Q2E.pAIBP
  4d40: 61 70 0a 03 63 a2 1a 63 5b 22 0a c8 70 41 49 42  ap..c..c["..pAIB
  4d50: 50 64 a0 06 93 61 64 76 63 a1 06 70 64 61 75 63  Pd...advc..pdauc
  4d60: a0 29 61 a0 1d 93 5b 23 4d 55 45 43 ff ff 0a 00  .)a...[#MUEC....
  4d70: 7d 50 35 34 53 0a 10 50 35 34 53 5b 27 4d 55 45  }P54S..P54S['MUE
  4d80: 43 70 49 44 45 50 43 49 44 45 a1 25 a0 1d 93 5b  CpIDEPCIDE.%...[
  4d90: 23 4d 55 45 43 ff ff 0a 00 7b 50 35 34 53 0a ef  #MUEC....{P54S..
  4da0: 50 35 34 53 5b 27 4d 55 45 43 70 00 43 49 44 45  P54S['MUECp.CIDE
  4db0: a0 10 92 93 50 49 44 45 43 49 44 45 49 45 56 54  ....PIDECIDEIEVT
  4dc0: 61 a1 06 46 45 56 54 61 70 43 49 44 45 50 49 44  a..FEVTapCIDEPID
  4dd0: 45 14 16 49 44 45 50 08 a0 0b 93 5c 53 42 41 59  E..IDEP....\SBAY
  4de0: 0a 02 a4 00 a1 03 a4 01 14 37 46 45 56 54 09 5c  .........7FEVT.\
  4df0: 2f 05 5f 53 42 5f 50 43 49 30 53 42 52 47 46 44  /._SB_PCI0SBRGFD
  4e00: 43 30 53 50 57 52 68 5c 2f 05 5f 53 42 5f 50 43  C0SPWRh\/._SB_PC
  4e10: 49 30 53 42 52 47 46 44 43 30 52 45 4d 55 a4 01  I0SBRGFDC0REMU..
  4e20: 14 45 05 49 45 56 54 09 a0 06 68 70 0a 59 60 a1  .E.IEVT...hp.Y`.
  4e30: 05 70 0a 5a 60 5c 2f 04 5f 53 42 5f 50 43 49 30  .p.Z`\/._SB_PCI0
  4e40: 49 44 45 30 53 50 57 52 68 5c 2f 04 5f 53 42 5f  IDE0SPWRh\/._SB_
  4e50: 50 43 49 30 49 44 45 30 52 45 4d 55 a0 17 5c 2e  PCI0IDE0REMU..\.
  4e60: 5f 53 42 5f 41 54 4b 50 86 5c 2e 5f 53 42 5f 41  _SB_ATKP.\._SB_A
  4e70: 54 4b 44 60 a4 01 14 40 07 53 50 57 52 01 a0 32  TKD`...-y73lYw+X1fk@public.gmane.org
  4e80: 68 70 00 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44  hp.\/._SB_PCI0ID
  4e90: 45 30 53 53 49 47 5b 22 0b d0 07 70 00 5c 49 50  E0SSIG["...p.\IP
  4ea0: 57 52 5b 22 0b 58 1b 5c 49 53 4d 49 5c 49 53 57  WR[".X.\ISMI\ISW
  4eb0: 50 a1 35 70 0a 01 5c 2f 04 5f 53 42 5f 50 43 49  P.5p..\/._SB_PCI
  4ec0: 30 49 44 45 30 53 53 49 47 70 01 5c 49 50 57 52  0IDE0SSIGp.\IPWR
  4ed0: 7b 54 49 4d 53 0b ff cc 54 49 4d 53 7b 53 54 4d  {TIMS...TIMS{STM
  4ee0: 53 0a 00 53 54 4d 53 14 41 05 52 45 4d 55 00 86  S..STMS.A.REMU..
  4ef0: 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44 45 30 43  \/._SB_PCI0IDE0C
  4f00: 48 4e 31 0a 00 86 5c 2f 05 5f 53 42 5f 50 43 49  HN1...\/._SB_PCI
  4f10: 30 49 44 45 30 43 48 4e 31 44 52 56 30 0a 01 86  0IDE0CHN1DRV0...
  4f20: 5c 2f 05 5f 53 42 5f 50 43 49 30 49 44 45 30 43  \/._SB_PCI0IDE0C
  4f30: 48 4e 31 44 52 56 31 0a 01 14 49 0a 5f 49 4e 49  HN1DRV1...I._INI
  4f40: 00 a0 4a 08 5c 2f 05 5f 53 42 5f 50 43 49 30 53  ..J.\/._SB_PCI0S
  4f50: 42 52 47 45 43 30 5f 41 49 42 50 a0 47 06 5c 2f  BRGEC0_AIBP.G.\/
  4f60: 05 5f 53 42 5f 50 43 49 30 53 42 52 47 45 43 30  ._SB_PCI0SBRGEC0
  4f70: 5f 49 44 45 50 70 01 5c 2f 05 5f 53 42 5f 50 43  _IDEPp.\/._SB_PC
  4f80: 49 30 53 42 52 47 45 43 30 5f 43 49 44 45 70 01  I0SBRGEC0_CIDEp.
  4f90: 5c 2f 05 5f 53 42 5f 50 43 49 30 53 42 52 47 45  \/._SB_PCI0SBRGE
  4fa0: 43 30 5f 50 49 44 45 a0 1b 5c 49 50 57 52 5c 2f  C0_PIDE..\IPWR\/
  4fb0: 04 5f 53 42 5f 50 43 49 30 49 44 45 30 53 50 57  ._SB_PCI0IDE0SPW
  4fc0: 52 0a 01 a1 08 70 0a 01 53 53 49 47 a1 16 5c 2f  R....p..SSIG..\/
  4fd0: 04 5f 53 42 5f 50 43 49 30 49 44 45 30 53 50 57  ._SB_PCI0IDE0SPW
  4fe0: 52 0a 00 08 52 45 47 46 0a 01 14 12 5f 52 45 47  R...REGF...._REG
  4ff0: 02 a0 0b 93 68 0a 02 70 69 52 45 47 46 5b 80 42  ....h..piREGF[.B
  5000: 41 52 30 02 0a 00 0b 00 01 5b 81 45 06 42 41 52  AR0......[.E.BAR
  5010: 30 03 00 40 20 54 49 4d 50 10 54 49 4d 53 10 53  0..@ TIMP.TIMS.S
  5020: 54 4d 50 04 53 54 4d 53 04 00 18 55 44 4d 50 02  TMP.STMS...UDMP.
  5030: 55 44 4d 53 02 00 0c 55 44 54 50 06 00 02 55 44  UDMS...UDTP...UD
  5040: 54 53 06 00 42 04 50 43 42 30 02 53 43 42 30 02  TS..B.PCB0.SCB0.
  5050: 50 43 41 30 02 53 43 41 30 02 00 04 46 50 42 30  PCA0.SCA0...FPB0
  5060: 02 46 53 42 30 02 50 53 49 47 02 53 53 49 47 02  .FSB0.PSIG.SSIG.
  5070: 08 54 49 4d 30 12 47 07 09 12 0b 04 0a 78 0a b4  .TIM0.G......x..
  5080: 0a f0 0b 84 03 12 0a 04 0a 23 0a 21 0a 10 0a 00  .........#.!....
  5090: 12 0a 04 0a 0b 0a 09 0a 04 0a 00 12 0e 06 0a 70  ...............p
  50a0: 0a 49 0a 36 0a 27 0a 19 0a 0f 12 0e 06 0a 00 0a  .I.6.'..........
  50b0: 01 0a 02 0a 01 0a 02 0a 01 12 0e 06 0a 00 0a 00  ................
  50c0: 0a 00 0a 01 0a 01 0a 01 12 0e 06 0a 00 0a 00 0a  ................
  50d0: 00 0a 00 0a 00 0a 01 12 0a 04 0a 04 0a 03 0a 02  ................
  50e0: 0a 00 12 0a 04 0a 02 0a 01 0a 00 0a 00 08 54 4d  ..............TM
  50f0: 44 30 11 03 0a 14 8a 54 4d 44 30 0a 00 50 49 4f  D0.....TMD0..PIO
  5100: 30 8a 54 4d 44 30 0a 04 44 4d 41 30 8a 54 4d 44  0.TMD0..DMA0.TMD
  5110: 30 0a 08 50 49 4f 31 8a 54 4d 44 30 0a 0c 44 4d  0..PIO1.TMD0..DM
  5120: 41 31 8a 54 4d 44 30 0a 10 43 48 4e 46 08 47 54  A1.TMD0..CHNF.GT
  5130: 49 4d 0a 00 08 47 53 54 4d 0a 00 08 47 55 44 4d  IM...GSTM...GUDM
  5140: 0a 00 08 47 55 44 54 0a 00 08 47 43 42 30 0a 00  ...GUDT...GCB0..
  5150: 08 47 46 42 30 0a 00 14 29 53 54 42 59 01 70 0a  .GFB0...)STBY.p.
  5160: a0 53 49 44 53 a0 0c 93 68 0a 01 70 0a b0 53 49  .SIDS...h..p..SI
  5170: 44 53 5c 49 53 4d 49 5c 49 53 54 42 5b 22 0b f4  DS\ISMI\ISTB["..
  5180: 01 5b 82 45 0e 43 48 4e 30 08 5f 41 44 52 0a 00  .[.E.CHN0._ADR..
  5190: 14 23 5f 47 54 4d 00 a4 47 54 4d 5f 54 49 4d 50  .#_GTM..GTM_TIMP
  51a0: 53 54 4d 50 55 44 4d 50 55 44 54 50 50 43 42 30  STMPUDMPUDTPPCB0
  51b0: 46 50 42 30 14 47 07 5f 53 54 4d 03 70 68 5b 31  FPB0.G._STM.ph[1
  51c0: 70 68 54 4d 44 30 70 54 49 4d 50 47 54 49 4d 70  phTMD0pTIMPGTIMp
  51d0: 55 44 54 50 47 55 44 54 a0 3b 53 54 4d 5f 70 47  UDTPGUDT.;STM_pG
  51e0: 54 49 4d 54 49 4d 50 70 47 53 54 4d 53 54 4d 50  TIMTIMPpGSTMSTMP
  51f0: 70 47 55 44 4d 55 44 4d 50 70 47 55 44 54 55 44  pGUDMUDMPpGUDTUD
  5200: 54 50 70 47 43 42 30 50 43 42 30 70 47 46 42 30  TPpGCB0PCB0pGFB0
  5210: 46 50 42 30 70 47 54 46 5f 0a 00 69 41 54 41 30  FPB0pGTF_..iATA0
  5220: 70 47 54 46 5f 0a 01 6a 41 54 41 31 5b 82 1c 44  pGTF_..jATA1[..D
  5230: 52 56 30 08 5f 41 44 52 0a 00 14 0f 5f 47 54 46  RV0._ADR...._GTF
  5240: 00 a4 52 41 54 41 41 54 41 30 5b 82 1c 44 52 56  ..RATAATA0[..DRV
  5250: 31 08 5f 41 44 52 0a 01 14 0f 5f 47 54 46 00 a4  1._ADR...._GTF..
  5260: 52 41 54 41 41 54 41 31 5b 82 47 1d 43 48 4e 31  RATAATA1[.G.CHN1
  5270: 08 5f 41 44 52 0a 01 14 23 5f 47 54 4d 00 a4 47  ._ADR...#_GTM..G
  5280: 54 4d 5f 54 49 4d 53 53 54 4d 53 55 44 4d 53 55  TM_TIMSSTMSUDMSU
  5290: 44 54 53 53 43 42 30 46 53 42 30 14 47 07 5f 53  DTSSCB0FSB0.G._S
  52a0: 54 4d 03 70 68 5b 31 70 68 54 4d 44 30 70 54 49  TM.ph[1phTMD0pTI
  52b0: 4d 53 47 54 49 4d 70 55 44 54 53 47 55 44 54 a0  MSGTIMpUDTSGUDT.
  52c0: 3b 53 54 4d 5f 70 47 54 49 4d 54 49 4d 53 70 47  ;STM_pGTIMTIMSpG
  52d0: 53 54 4d 53 54 4d 53 70 47 55 44 4d 55 44 4d 53  STMSTMSpGUDMUDMS
  52e0: 70 47 55 44 54 55 44 54 53 70 47 43 42 30 53 43  pGUDTUDTSpGCB0SC
  52f0: 42 30 70 47 46 42 30 46 53 42 30 70 47 54 46 5f  B0pGFB0FSB0pGTF_
  5300: 0a 00 69 41 54 41 32 70 47 54 46 5f 0a 01 6a 41  ..iATA2pGTF_..jA
  5310: 54 41 33 5b 82 45 09 44 52 56 30 08 5f 41 44 52  TA3[.E.DRV0._ADR
  5320: 0a 00 14 30 5f 45 4a 30 01 5c 2f 04 5f 53 42 5f  ...0_EJ0.\/._SB_
  5330: 50 43 49 30 49 44 45 30 53 54 42 59 0a 00 5c 2f  PCI0IDE0STBY..\/
  5340: 04 5f 53 42 5f 50 43 49 30 49 44 45 30 53 50 57  ._SB_PCI0IDE0SPW
  5350: 52 0a 00 14 46 04 5f 53 54 41 00 a0 3c 92 5c 49  R...F._STA..<.\I
  5360: 50 57 52 a0 34 5c 2f 05 5f 53 42 5f 50 43 49 30  PWR.4\/._SB_PCI0
  5370: 53 42 52 47 45 43 30 5f 41 49 42 50 a0 1b 5c 2f  SBRGEC0_AIBP..\/
  5380: 05 5f 53 42 5f 50 43 49 30 53 42 52 47 45 43 30  ._SB_PCI0SBRGEC0
  5390: 5f 49 44 45 50 a4 0a 0f a4 00 14 0f 5f 47 54 46  _IDEP......._GTF
  53a0: 00 a4 52 41 54 41 41 54 41 32 5b 82 45 09 44 52  ..RATAATA2[.E.DR
  53b0: 56 31 08 5f 41 44 52 0a 01 14 30 5f 45 4a 30 01  V1._ADR...0_EJ0.
  53c0: 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44 45 30 53  \/._SB_PCI0IDE0S
  53d0: 54 42 59 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30  TBY..\/._SB_PCI0
  53e0: 49 44 45 30 53 50 57 52 0a 00 14 46 04 5f 53 54  IDE0SPWR...F._ST
  53f0: 41 00 a0 3c 92 5c 49 50 57 52 a0 34 5c 2f 05 5f  A..<.\IPWR.4\/._
  5400: 53 42 5f 50 43 49 30 53 42 52 47 45 43 30 5f 41  SB_PCI0SBRGEC0_A
  5410: 49 42 50 a0 1b 5c 2f 05 5f 53 42 5f 50 43 49 30  IBP..\/._SB_PCI0
  5420: 53 42 52 47 45 43 30 5f 49 44 45 50 a4 0a 0f a4  SBRGEC0_IDEP....
  5430: 00 14 0f 5f 47 54 46 00 a4 52 41 54 41 41 54 41  ..._GTF..RATAATA
  5440: 33 14 4d 19 47 54 4d 5f 0e 70 ff 50 49 4f 30 70  3.M.GTM_.p.PIO0p
  5450: 50 49 4f 30 50 49 4f 31 70 50 49 4f 30 44 4d 41  PIO0PIO1pPIO0DMA
  5460: 30 70 50 49 4f 30 44 4d 41 31 70 00 43 48 4e 46  0pPIO0DMA1p.CHNF
  5470: a0 05 52 45 47 46 a1 06 a4 54 4d 44 30 a0 11 7b  ..REGF...TMD0..{
  5480: 68 0a 02 00 7d 43 48 4e 46 0a 02 43 48 4e 46 7a  h...}CHNF..CHNFz
  5490: 7b 68 0b 00 33 00 0a 08 65 70 89 83 88 54 49 4d  {h..3...ep...TIM
  54a0: 30 0a 01 00 02 65 00 0a 00 0a 00 66 70 83 88 83  0....e.....fp...
  54b0: 88 54 49 4d 30 0a 00 00 66 00 67 70 67 44 4d 41  .TIM0...f.gpgDMA
  54c0: 30 a0 0e 7b 68 0a 08 00 70 0b 84 03 50 49 4f 30  0..{h...p...PIO0
  54d0: a1 07 70 67 50 49 4f 30 a0 11 7b 68 0a 20 00 7d  ..pgPIO0..{h. .}
  54e0: 43 48 4e 46 0a 08 43 48 4e 46 a0 42 05 7b 68 0b  CHNF..CHNF.B.{h.
  54f0: 00 40 00 7d 43 48 4e 46 0a 10 43 48 4e 46 70 89  .-4b8TPpkIZ3Q@public.gmane.org}CHNF..CHNFp.
  5500: 83 88 54 49 4d 30 0a 02 00 02 69 00 0a 00 0a 00  ..TIM0....i.....
  5510: 65 70 83 88 83 88 54 49 4d 30 0a 00 00 65 00 66  ep....TIM0...e.f
  5520: 70 66 44 4d 41 31 a0 0e 7b 68 0a 80 00 70 0b 84  pfDMA1..{h...p..
  5530: 03 50 49 4f 31 a1 07 70 66 50 49 4f 31 a0 48 04  .PIO1..pfPIO1.H.
  5540: 7b 6a 0a 01 00 7b 6b 0a 03 65 a0 10 90 7b 6d 0a  {j...{k..e...{m.
  5550: 01 00 93 65 0a 01 72 65 0a 04 65 a1 0d a0 0b 7b  ...e..re..e....{
  5560: 6c 0a 01 00 72 65 0a 02 65 70 83 88 83 88 54 49  l...re..ep....TI
  5570: 4d 30 0a 03 00 65 00 44 4d 41 30 7d 43 48 4e 46  M0...e.DMA0}CHNF
  5580: 0a 01 43 48 4e 46 a0 4c 04 7b 6a 0a 02 00 7b 7a  ..CHNF.L.{j...{z
  5590: 6b 0a 04 00 0a 03 65 a0 10 90 7b 6d 0a 02 00 93  k.....e...{m....
  55a0: 65 0a 01 72 65 0a 04 65 a1 0d a0 0b 7b 6c 0a 02  e..re..e....{l..
  55b0: 00 72 65 0a 02 65 70 83 88 83 88 54 49 4d 30 0a  .re..ep....TIM0.
  55c0: 03 00 65 00 44 4d 41 31 7d 43 48 4e 46 0a 04 43  ..e.DMA1}CHNF..C
  55d0: 48 4e 46 70 54 4d 44 30 5b 31 a4 54 4d 44 30 14  HNFpTMD0[1.TMD0.
  55e0: 44 25 53 54 4d 5f 08 a0 05 52 45 47 46 a1 04 a4  D%STM_...REGF...
  55f0: 0a 00 7b 47 54 49 4d 0b 44 80 47 54 49 4d 70 0a  ..{GTIM.D.GTIMp.
  5600: 00 47 53 54 4d 70 0a 00 47 55 44 4d 70 0a 00 47  .GSTMp..GUDMp..G
  5610: 43 42 30 7b 47 55 44 54 0a cc 47 55 44 54 70 0a  CB0{GUDT..GUDTp.
  5620: 00 47 46 42 30 a0 47 07 7b 43 48 4e 46 0a 01 00  .GFB0.G.{CHNF...
  5630: 70 89 83 88 54 49 4d 30 0a 03 00 02 44 4d 41 30  p...TIM0....DMA0
  5640: 00 0a 00 0a 00 60 a0 09 94 60 0a 05 70 0a 05 60  .....`...`..p..`
  5650: 7d 47 55 44 54 83 88 83 88 54 49 4d 30 0a 04 00  }GUDT....TIM0...
  5660: 60 00 47 55 44 54 7d 47 43 42 30 83 88 83 88 54  `.GUDT}GCB0....T
  5670: 49 4d 30 0a 05 00 60 00 47 43 42 30 7d 47 46 42  IM0...`.GCB0}GFB
  5680: 30 83 88 83 88 54 49 4d 30 0a 06 00 60 00 47 46  0....TIM0...`.GF
  5690: 42 30 7d 47 55 44 4d 0a 01 47 55 44 4d a1 37 a0  B0}GUDM..GUDM.7.
  56a0: 35 7d 93 50 49 4f 30 ff 93 50 49 4f 30 0a 00 00  5}.PIO0..PIO0...
  56b0: a0 24 7b 95 44 4d 41 30 ff 94 44 4d 41 30 0a 00  .${.DMA0..DMA0..
  56c0: 00 70 44 4d 41 30 50 49 4f 30 7d 47 54 49 4d 0a  .pDMA0PIO0}GTIM.
  56d0: 08 47 54 49 4d a0 43 08 7b 43 48 4e 46 0a 04 00  .GTIM.C.{CHNF...
  56e0: 70 89 83 88 54 49 4d 30 0a 03 00 02 44 4d 41 31  p...TIM0....DMA1
  56f0: 00 0a 00 0a 00 60 a0 09 94 60 0a 05 70 0a 05 60  .....`...`..p..`
  5700: 7d 47 55 44 54 79 83 88 83 88 54 49 4d 30 0a 04  }GUDTy....TIM0..
  5710: 00 60 00 0a 04 00 47 55 44 54 7d 47 43 42 30 79  .`....GUDT}GCB0y
  5720: 83 88 83 88 54 49 4d 30 0a 05 00 60 00 0a 01 00  ....TIM0...`....
  5730: 47 43 42 30 7d 47 46 42 30 79 83 88 83 88 54 49  GCB0}GFB0y....TI
  5740: 4d 30 0a 06 00 60 00 0a 01 00 47 46 42 30 7d 47  M0...`....GFB0}G
  5750: 55 44 4d 0a 02 47 55 44 4d a1 37 a0 35 7d 93 50  UDM..GUDM.7.5}.P
  5760: 49 4f 31 ff 93 50 49 4f 31 0a 00 00 a0 24 7b 95  IO1..PIO1....${.
  5770: 44 4d 41 31 ff 94 44 4d 41 31 0a 00 00 70 44 4d  DMA1..DMA1...pDM
  5780: 41 31 50 49 4f 31 7d 47 54 49 4d 0a 80 47 54 49  A1PIO1}GTIM..GTI
  5790: 4d a0 14 7b 43 48 4e 46 0a 02 00 7d 47 54 49 4d  M..{CHNF...}GTIM
  57a0: 0a 03 47 54 49 4d a0 14 7b 43 48 4e 46 0a 08 00  ..GTIM..{CHNF...
  57b0: 7d 47 54 49 4d 0a 30 47 54 49 4d 7b 89 83 88 54  }GTIM.0GTIM{...T
  57c0: 49 4d 30 0a 00 00 04 50 49 4f 30 00 0a 00 0a 00  IM0....PIO0.....
  57d0: 0a 03 60 70 83 88 83 88 54 49 4d 30 0a 01 00 60  ..`p....TIM0...`
  57e0: 00 61 79 61 0a 08 62 7d 47 54 49 4d 62 47 54 49  .aya..b}GTIMbGTI
  57f0: 4d a0 3f 7b 43 48 4e 46 0a 10 00 7d 47 54 49 4d  M.?{CHNF...}GTIM
  5800: 0b 00 40 47 54 49 4d 7b 89 83 88 54 49 4d 30 0a  ..-P16D2CvGvMU@public.gmane.org{...TIM0.
  5810: 00 00 04 50 49 4f 31 00 0a 00 0a 00 0a 03 60 70  ...PIO1.......`p
  5820: 83 88 83 88 54 49 4d 30 0a 02 00 60 00 47 53 54  ....TIM0...`.GST
  5830: 4d a4 0a 01 08 41 54 30 31 11 0a 0a 07 03 00 00  M....AT01.......
  5840: 00 00 00 ef 08 41 54 30 32 11 0a 0a 07 00 00 00  .....AT02.......
  5850: 00 00 00 90 08 41 54 30 33 11 0a 0a 07 00 00 00  .....AT03.......
  5860: 00 00 00 c6 08 41 54 30 34 11 0a 0a 07 00 00 00  .....AT04.......
  5870: 00 00 00 91 08 41 54 41 30 11 03 0a 1d 08 41 54  .....ATA0.....AT
  5880: 41 31 11 03 0a 1d 08 41 54 41 32 11 03 0a 1d 08  A1.....ATA2.....
  5890: 41 54 41 33 11 03 0a 1d 08 41 54 41 42 11 03 0a  ATA3.....ATAB...
  58a0: 1d 8c 41 54 41 42 0a 00 43 4d 44 43 14 4c 05 47  ..ATAB..CMDC.L.G
  58b0: 54 46 42 0b 77 43 4d 44 43 0a 38 60 72 60 0a 08  TFB.wCMDC.8`r`..
  58c0: 61 5b 13 41 54 41 42 61 0a 38 43 4d 44 58 77 43  a[.ATABa.8CMDXwC
  58d0: 4d 44 43 0a 07 60 8c 41 54 41 42 72 60 0a 02 00  MDC..`.ATABr`...
  58e0: 41 30 30 31 8c 41 54 41 42 72 60 0a 06 00 41 30  A001.ATABr`...A0
  58f0: 30 35 70 68 43 4d 44 58 70 69 41 30 30 31 70 6a  05phCMDXpiA001pj
  5900: 41 30 30 35 75 43 4d 44 43 14 42 24 47 54 46 5f  A005uCMDC.B$GTF_
  5910: 0a 70 69 5b 31 70 0a 00 43 4d 44 43 08 49 44 34  .pi[1p..CMDC.ID4
  5920: 39 0b 00 0c 08 49 44 35 39 0a 00 08 49 44 35 33  9....ID59...ID53
  5930: 0a 04 08 49 44 36 33 0b 00 0f 08 49 44 38 38 0b  ...ID63....ID88.
  5940: 00 0f 08 49 52 44 59 0a 01 08 50 49 4f 54 0a 00  ...IRDY...PIOT..
  5950: 08 44 4d 41 54 0a 00 a0 4d 05 93 87 69 0b 00 02  .DMAT...M...i...
  5960: 8b 69 0a 62 49 57 34 39 70 49 57 34 39 49 44 34  .i.bIW49pIW49ID4
  5970: 39 8b 69 0a 6a 49 57 35 33 70 49 57 35 33 49 44  9.i.jIW53pIW53ID
  5980: 35 33 8b 69 0a 7e 49 57 36 33 70 49 57 36 33 49  53.i.~IW63pIW63I
  5990: 44 36 33 8b 69 0a 76 49 57 35 39 70 49 57 35 39  D63.i.vIW59pIW59
  59a0: 49 44 35 39 8b 69 0a b0 49 57 38 38 70 49 57 38  ID59.i..IW88pIW8
  59b0: 38 49 44 38 38 70 0a a0 67 a0 48 05 68 70 0a b0  8ID88p..g.H.hp..
  59c0: 67 7b 43 48 4e 46 0a 08 49 52 44 59 a0 12 7b 43  g{CHNF..IRDY..{C
  59d0: 48 4e 46 0a 10 00 70 50 49 4f 31 50 49 4f 54 a1  HNF...pPIO1PIOT.
  59e0: 0a 70 50 49 4f 30 50 49 4f 54 a0 27 7b 43 48 4e  .pPIO0PIOT.'{CHN
  59f0: 46 0a 04 00 a0 12 7b 43 48 4e 46 0a 10 00 70 44  F.....{CHNF...pD
  5a00: 4d 41 31 44 4d 41 54 a1 0a 70 44 4d 41 30 44 4d  MA1DMAT..pDMA0DM
  5a10: 41 54 a1 28 7b 43 48 4e 46 0a 02 49 52 44 59 70  AT.({CHNF..IRDYp
  5a20: 50 49 4f 30 50 49 4f 54 a0 12 7b 43 48 4e 46 0a  PIO0PIOT..{CHNF.
  5a30: 01 00 70 44 4d 41 30 44 4d 41 54 a0 47 04 90 90  ..pDMA0DMAT.G...
  5a40: 7b 49 44 35 33 0a 04 00 7b 49 44 38 38 0b 00 ff  {ID53...{ID88...
  5a50: 00 44 4d 41 54 70 89 83 88 54 49 4d 30 0a 03 00  .DMATp...TIM0...
  5a60: 02 44 4d 41 54 00 0a 00 0a 00 61 a0 09 94 61 0a  .DMAT.....a...a.
  5a70: 05 70 0a 05 61 47 54 46 42 41 54 30 31 7d 0a 40  .p..aGTFBAT01}.@
  5a80: 61 00 67 a1 46 04 a0 43 04 90 7b 49 44 36 33 0b  a.g.F..C..{ID63.
  5a90: 00 ff 00 50 49 4f 54 7b 89 83 88 54 49 4d 30 0a  ...PIOT{...TIM0.
  5aa0: 00 00 04 50 49 4f 54 00 0a 00 0a 00 0a 03 60 7d  ...PIOT.......`}
  5ab0: 0a 20 83 88 83 88 54 49 4d 30 0a 08 00 60 00 61  . ....TIM0...`.a
  5ac0: 47 54 46 42 41 54 30 31 61 67 a0 38 49 52 44 59  GTFBAT01ag.8IRDY
  5ad0: 7b 89 83 88 54 49 4d 30 0a 00 00 04 50 49 4f 54  {...TIM0....PIOT
  5ae0: 00 0a 00 0a 00 0a 03 60 7d 0a 08 83 88 83 88 54  .......`}......T
  5af0: 49 4d 30 0a 07 00 60 00 61 47 54 46 42 41 54 30  IM0...`.aGTFBAT0
  5b00: 31 61 67 a1 17 a0 15 7b 49 44 34 39 0b 00 04 00  1ag....{ID49....
  5b10: 47 54 46 42 41 54 30 31 0a 01 67 a0 24 90 7b 49  GTFBAT01..g.$.{I
  5b20: 44 35 39 0b 00 01 00 7b 49 44 35 39 0a ff 00 47  D59....{ID59...G
  5b30: 54 46 42 41 54 30 33 7b 49 44 35 39 0a ff 00 67  TFBAT03{ID59...g
  5b40: 70 41 54 41 42 5b 31 a4 41 54 41 42 14 2c 52 41  pATAB[1.ATAB.,RA
  5b50: 54 41 01 8c 68 0a 00 43 4d 44 4e 77 43 4d 44 4e  TA..h..CMDNwCMDN
  5b60: 0a 38 60 5b 13 68 0a 08 60 52 45 54 42 70 52 45  .8`[.h..`RETBpRE
  5b70: 54 42 5b 31 a4 52 45 54 42 5b 82 0f 53 4d 42 43  TB[1.RETB[..SMBC
  5b80: 08 5f 41 44 52 0c 03 00 1f 00 5b 82 1f 4d 4f 44  ._ADR.....[..MOD
  5b90: 4d 08 5f 41 44 52 0c 06 00 1f 00 14 0f 5f 50 52  M._ADR......._PR
  5ba0: 57 00 a4 47 50 52 57 0a 05 0a 03 5b 82 43 1c 55  W..GPRW....[.C.U
  5bb0: 53 42 31 08 5f 41 44 52 0c 00 00 1d 00 5b 80 42  SB1._ADR.....[.B
  5bc0: 41 52 30 02 0a c0 0a 05 5b 81 19 42 41 52 30 01  AR0.....[..BAR0.
  5bd0: 55 42 4c 31 10 00 10 50 30 57 45 01 50 31 57 45  UBL1...P0WE.P1WE
  5be0: 01 00 06 14 27 5f 50 53 57 01 a0 10 68 70 0a 01  ....'_PSW...hp..
  5bf0: 50 30 57 45 70 0a 01 50 31 57 45 a1 0f 70 0a 00  P0WEp..P1WE..p..
  5c00: 50 30 57 45 70 0a 00 50 31 57 45 14 34 55 50 41  P0WEp..P1WE.4UPA
  5c10: 43 01 70 00 60 a0 0d 93 4f 53 46 47 4f 53 39 58  C.p.`...OSFGOS9X
  5c20: 70 01 60 a1 0f a0 0d 93 4f 53 46 47 4f 53 39 38  p.`.....OSFGOS98
  5c30: 70 01 60 a0 0a 60 a0 07 93 68 0a 03 a4 01 a4 00  p.`..`...h......
  5c40: 5b 80 55 50 43 49 02 0a 20 0a 04 5b 81 0b 55 50  [.UPCI.. ..[..UP
  5c50: 43 49 01 55 42 41 53 20 08 42 41 53 41 0b 00 b4  CI.UBAS .BASA...
  5c60: 08 50 30 53 54 00 08 50 31 53 54 00 14 47 07 53  .P0ST..P1ST..G.S
  5c70: 53 54 41 00 70 55 42 41 53 42 41 53 41 7b 42 41  STA.pUBASBASA{BA
  5c80: 53 41 0c fe ff ff ff 42 41 53 41 5b 80 55 48 43  SA.....BASA[.UHC
  5c90: 49 01 42 41 53 41 0a 20 5b 81 38 55 48 43 49 01  I.BASA. [.8UHCI.
  5ca0: 52 53 54 50 01 48 52 53 54 01 47 52 53 54 01 00  RSTP.HRST.GRST..
  5cb0: 4d 07 43 43 53 30 01 43 53 43 30 01 50 45 44 30  M.CCS0.CSC0.PED0
  5cc0: 01 00 0d 43 43 53 31 01 43 53 43 31 01 50 45 44  ...CCS1.CSC1.PED
  5cd0: 31 01 70 43 43 53 30 50 30 53 54 70 43 43 53 31  1.pCCS0P0STpCCS1
  5ce0: 50 31 53 54 14 47 05 52 53 54 41 00 70 42 41 53  P1ST.G.RSTA.pBAS
  5cf0: 41 55 42 41 53 5b 80 55 48 43 49 01 42 41 53 41  AUBAS[.UHCI.BASA
  5d00: 0a 20 5b 81 38 55 48 43 49 01 52 53 54 50 01 48  . [.8UHCI.RSTP.H
  5d10: 52 53 54 01 47 52 53 54 01 00 4d 07 43 43 53 30  RST.GRST..M.CCS0
  5d20: 01 43 53 43 30 01 50 45 44 30 01 00 0d 43 43 53  .CSC0.PED0...CCS
  5d30: 31 01 43 53 43 31 01 50 45 44 31 01 14 11 55 53  1.CSC1.PED1...US
  5d40: 42 53 01 a0 0a 55 50 41 43 68 53 53 54 41 14 11  BS...UPAChSSTA..
  5d50: 55 53 42 57 01 a0 0a 55 50 41 43 68 52 53 54 41  USBW...UPAChRSTA
  5d60: 14 0f 5f 50 52 57 00 a4 47 50 52 57 0a 03 0a 03  .._PRW..GPRW....
  5d70: 5b 82 43 1c 55 53 42 32 08 5f 41 44 52 0c 01 00  [.C.USB2._ADR...
  5d80: 1d 00 5b 80 42 41 52 30 02 0a c0 0a 05 5b 81 19  ..[.BAR0.....[..
  5d90: 42 41 52 30 01 55 42 4c 31 10 00 10 50 30 57 45  BAR0.UBL1...P0WE
  5da0: 01 50 31 57 45 01 00 06 14 27 5f 50 53 57 01 a0  .P1WE....'_PSW..
  5db0: 10 68 70 0a 01 50 30 57 45 70 0a 01 50 31 57 45  .hp..P0WEp..P1WE
  5dc0: a1 0f 70 0a 00 50 30 57 45 70 0a 00 50 31 57 45  ..p..P0WEp..P1WE
  5dd0: 14 34 55 50 41 43 01 70 00 60 a0 0d 93 4f 53 46  .4UPAC.p.`...OSF
  5de0: 47 4f 53 39 58 70 01 60 a1 0f a0 0d 93 4f 53 46  GOS9Xp.`.....OSF
  5df0: 47 4f 53 39 38 70 01 60 a0 0a 60 a0 07 93 68 0a  GOS98p.`..`...h.
  5e00: 03 a4 01 a4 00 5b 80 55 50 43 49 02 0a 20 0a 04  .....[.UPCI.. ..
  5e10: 5b 81 0b 55 50 43 49 01 55 42 41 53 20 08 42 41  [..UPCI.UBAS .BA
  5e20: 53 41 0b 00 b4 08 50 30 53 54 00 08 50 31 53 54  SA....P0ST..P1ST
  5e30: 00 14 47 07 53 53 54 41 00 70 55 42 41 53 42 41  ..G.SSTA.pUBASBA
  5e40: 53 41 7b 42 41 53 41 0c fe ff ff ff 42 41 53 41  SA{BASA.....BASA
  5e50: 5b 80 55 48 43 49 01 42 41 53 41 0a 20 5b 81 38  [.UHCI.BASA. [.8
  5e60: 55 48 43 49 01 52 53 54 50 01 48 52 53 54 01 47  UHCI.RSTP.HRST.G
  5e70: 52 53 54 01 00 4d 07 43 43 53 30 01 43 53 43 30  RST..M.CCS0.CSC0
  5e80: 01 50 45 44 30 01 00 0d 43 43 53 31 01 43 53 43  .PED0...CCS1.CSC
  5e90: 31 01 50 45 44 31 01 70 43 43 53 30 50 30 53 54  1.PED1.pCCS0P0ST
  5ea0: 70 43 43 53 31 50 31 53 54 14 47 05 52 53 54 41  pCCS1P1ST.G.RSTA
  5eb0: 00 70 42 41 53 41 55 42 41 53 5b 80 55 48 43 49  .pBASAUBAS[.UHCI
  5ec0: 01 42 41 53 41 0a 20 5b 81 38 55 48 43 49 01 52  .BASA. [.8UHCI.R
  5ed0: 53 54 50 01 48 52 53 54 01 47 52 53 54 01 00 4d  STP.HRST.GRST..M
  5ee0: 07 43 43 53 30 01 43 53 43 30 01 50 45 44 30 01  .CCS0.CSC0.PED0.
  5ef0: 00 0d 43 43 53 31 01 43 53 43 31 01 50 45 44 31  ..CCS1.CSC1.PED1
  5f00: 01 14 11 55 53 42 53 01 a0 0a 55 50 41 43 68 53  ...USBS...UPAChS
  5f10: 53 54 41 14 11 55 53 42 57 01 a0 0a 55 50 41 43  STA..USBW...UPAC
  5f20: 68 52 53 54 41 14 0f 5f 50 52 57 00 a4 47 50 52  hRSTA.._PRW..GPR
  5f30: 57 0a 04 0a 03 5b 82 43 1c 55 53 42 33 08 5f 41  W....[.C.USB3._A
  5f40: 44 52 0c 02 00 1d 00 5b 80 42 41 52 30 02 0a c0  DR.....[.BAR0...
  5f50: 0a 05 5b 81 19 42 41 52 30 01 55 42 4c 31 10 00  ..[..BAR0.UBL1..
  5f60: 10 50 30 57 45 01 50 31 57 45 01 00 06 14 27 5f  .P0WE.P1WE....'_
  5f70: 50 53 57 01 a0 10 68 70 0a 01 50 30 57 45 70 0a  PSW...hp..P0WEp.
  5f80: 01 50 31 57 45 a1 0f 70 0a 00 50 30 57 45 70 0a  .P1WE..p..P0WEp.
  5f90: 00 50 31 57 45 14 34 55 50 41 43 01 70 00 60 a0  .P1WE.4UPAC.p.`.
  5fa0: 0d 93 4f 53 46 47 4f 53 39 58 70 01 60 a1 0f a0  ..OSFGOS9Xp.`...
  5fb0: 0d 93 4f 53 46 47 4f 53 39 38 70 01 60 a0 0a 60  ..OSFGOS98p.`..`
  5fc0: a0 07 93 68 0a 03 a4 01 a4 00 5b 80 55 50 43 49  ...h......[.UPCI
  5fd0: 02 0a 20 0a 04 5b 81 0b 55 50 43 49 01 55 42 41  .. ..[..UPCI.UBA
  5fe0: 53 20 08 42 41 53 41 0b 00 b4 08 50 30 53 54 00  S .BASA....P0ST.
  5ff0: 08 50 31 53 54 00 14 47 07 53 53 54 41 00 70 55  .P1ST..G.SSTA.pU
  6000: 42 41 53 42 41 53 41 7b 42 41 53 41 0c fe ff ff  BASBASA{BASA....
  6010: ff 42 41 53 41 5b 80 55 48 43 49 01 42 41 53 41  .BASA[.UHCI.BASA
  6020: 0a 20 5b 81 38 55 48 43 49 01 52 53 54 50 01 48  . [.8UHCI.RSTP.H
  6030: 52 53 54 01 47 52 53 54 01 00 4d 07 43 43 53 30  RST.GRST..M.CCS0
  6040: 01 43 53 43 30 01 50 45 44 30 01 00 0d 43 43 53  .CSC0.PED0...CCS
  6050: 31 01 43 53 43 31 01 50 45 44 31 01 70 43 43 53  1.CSC1.PED1.pCCS
  6060: 30 50 30 53 54 70 43 43 53 31 50 31 53 54 14 47  0P0STpCCS1P1ST.G
  6070: 05 52 53 54 41 00 70 42 41 53 41 55 42 41 53 5b  .RSTA.pBASAUBAS[
  6080: 80 55 48 43 49 01 42 41 53 41 0a 20 5b 81 38 55  .UHCI.BASA. [.8U
  6090: 48 43 49 01 52 53 54 50 01 48 52 53 54 01 47 52  HCI.RSTP.HRST.GR
  60a0: 53 54 01 00 4d 07 43 43 53 30 01 43 53 43 30 01  ST..M.CCS0.CSC0.
  60b0: 50 45 44 30 01 00 0d 43 43 53 31 01 43 53 43 31  PED0...CCS1.CSC1
  60c0: 01 50 45 44 31 01 14 11 55 53 42 53 01 a0 0a 55  .PED1...USBS...U
  60d0: 50 41 43 68 53 53 54 41 14 11 55 53 42 57 01 a0  PAChSSTA..USBW..
  60e0: 0a 55 50 41 43 68 52 53 54 41 14 0f 5f 50 52 57  .UPAChRSTA.._PRW
  60f0: 00 a4 47 50 52 57 0a 0c 0a 03 5b 82 4f 1d 45 48  ..GPRW....[.O.EH
  6100: 43 49 08 5f 41 44 52 0c 07 00 1d 00 5b 80 55 32  CI._ADR.....[.U2
  6110: 30 50 02 0a 00 0b 00 01 5b 81 2f 55 32 30 50 01  0P......[./U20P.
  6120: 00 20 00 01 4d 53 50 45 01 00 0e 00 40 05 4d 42  . ..MSPE....-x/U4kdNoLxg@public.gmane.org
  6130: 41 53 20 00 40 20 50 53 54 41 02 00 06 50 4d 45  AS .@ PSTA...PME
  6140: 45 01 00 06 50 4d 45 53 01 14 41 18 5f 50 53 57  E...PMES..A._PSW
  6150: 01 70 4d 42 41 53 60 7b 60 0c f0 ff ff ff 60 5b  .pMBAS`{`.....`[
  6160: 80 4d 4d 49 4f 00 60 0b 00 01 5b 81 27 4d 4d 49  .MMIO.`...[.'MMI
  6170: 4f 01 00 40 32 50 30 53 43 20 50 31 53 43 20 50  O..-Q+Myccc7dlE@public.gmane.org P1SC P
  6180: 32 53 43 20 50 33 53 43 20 50 34 53 43 20 50 35  2SC P3SC P4SC P5
  6190: 53 43 20 a0 47 13 92 60 70 50 53 54 41 62 70 00  SC .G..`pPSTAbp.
  61a0: 50 53 54 41 70 4d 53 50 45 63 70 01 4d 53 50 45  PSTApMSPEcp.MSPE
  61b0: a0 47 08 68 70 50 30 53 43 64 7d 64 0c 00 00 30  .G.hpP0SCd}d...0
  61c0: 00 64 70 64 50 30 53 43 70 50 31 53 43 64 7d 64  .dpdP0SCpP1SCd}d
  61d0: 0c 00 00 30 00 64 70 64 50 31 53 43 70 50 32 53  ...0.dpdP1SCpP2S
  61e0: 43 64 7d 64 0c 00 00 30 00 64 70 64 50 32 53 43  Cd}d...0.dpdP2SC
  61f0: 70 50 33 53 43 64 7d 64 0c 00 00 30 00 64 70 64  pP3SCd}d...0.dpd
  6200: 50 33 53 43 70 50 34 53 43 64 7d 64 0c 00 00 30  P3SCpP4SCd}d...0
  6210: 00 64 70 64 50 34 53 43 70 50 35 53 43 64 7d 64  .dpdP4SCpP5SCd}d
  6220: 0c 00 00 30 00 64 70 64 50 35 53 43 70 01 50 4d  ...0.dpdP5SCp.PM
  6230: 45 53 70 01 50 4d 45 45 a1 46 08 70 50 30 53 43  ESp.PMEE.F.pP0SC
  6240: 64 7b 64 0c ff ff cf ff 64 70 64 50 30 53 43 70  d{d.....dpdP0SCp
  6250: 50 31 53 43 64 7b 64 0c ff ff cf ff 64 70 64 50  P1SCd{d.....dpdP
  6260: 31 53 43 70 50 32 53 43 64 7b 64 0c ff ff cf ff  1SCpP2SCd{d.....
  6270: 64 70 64 50 32 53 43 70 50 33 53 43 64 7b 64 0c  dpdP2SCpP3SCd{d.
  6280: ff ff cf ff 64 70 64 50 33 53 43 70 50 34 53 43  ....dpdP3SCpP4SC
  6290: 64 7b 64 0c ff ff cf ff 64 70 64 50 34 53 43 70  d{d.....dpdP4SCp
  62a0: 50 35 53 43 64 7b 64 0c ff ff cf ff 64 70 64 50  P5SCd{d.....dpdP
  62b0: 35 53 43 70 01 50 4d 45 53 70 00 50 4d 45 45 70  5SCp.PMESp.PMEEp
  62c0: 63 4d 53 50 45 70 62 50 53 54 41 14 0f 5f 50 52  cMSPEpbPSTA.._PR
  62d0: 57 00 a4 47 50 52 57 0a 0d 0a 03 10 4f 2c 5c 2e  W..GPRW.....O,\.
  62e0: 5f 50 52 5f 43 50 55 31 08 54 59 50 45 0a 00 08  _PR_CPU1.TYPE...
  62f0: 50 44 43 52 0a 01 08 50 44 43 4d 0a 01 14 4b 06  PDCR...PDCM...K.
  6300: 5f 50 44 43 01 70 87 68 60 08 50 44 43 42 11 02  _PDC.p.h`.PDCB..
  6310: 60 70 68 50 44 43 42 8a 50 44 43 42 0a 00 52 45  `phPDCB.PDCB..RE
  6320: 56 5f 8a 50 44 43 42 0a 04 53 49 5a 45 a0 0e 92  V_.PDCB..SIZE...
  6330: 93 52 45 56 5f 50 44 43 52 a4 0a 00 a0 0b 95 53  .REV_PDCR......S
  6340: 49 5a 45 0a 01 a4 0a 00 8a 50 44 43 42 0a 08 44  IZE......PDCB..D
  6350: 41 54 30 a0 12 7b 44 41 54 30 50 44 43 4d 00 70  AT0..{DAT0PDCM.p
  6360: 0a 01 54 59 50 45 a4 0a 01 08 4d 50 43 54 12 2c  ..TYPE....MPCT.,
  6370: 02 11 14 0a 11 82 0c 00 7f 40 00 00 99 01 00 00  .........-E2U9adUjKaY@public.gmane.org
  6380: 00 00 00 00 79 00 11 14 0a 11 82 0c 00 7f 10 00  ....y...........
  6390: 00 98 01 00 00 00 00 00 00 79 00 08 50 50 43 54  .........y..PPCT
  63a0: 12 2c 02 11 14 0a 11 82 0c 00 01 10 00 00 b2 00  .,..............
  63b0: 00 00 00 00 00 00 79 00 11 14 0a 11 82 0c 00 01  ......y.........
  63c0: 08 00 00 b3 00 00 00 00 00 00 00 79 00 14 18 5f  ...........y..._
  63d0: 50 43 54 00 a0 0a 54 59 50 45 a4 4d 50 43 54 a1  PCT...TYPE.MPCT.
  63e0: 06 a4 50 50 43 54 08 4d 50 53 53 12 41 0c 0a 12  ..PPCT.MPSS.A...
  63f0: 12 06 0b 40 06 0b 00 7d 0a 0a 0a 0a 0b 31 10 0b  ...-47IYjYMXMt4@public.gmane.org}.....1..
  6400: 31 10 12 12 06 0b 40 06 0b 00 7d 0a 0a 0a 0a 0b  1.....-47IYjYMXMt4@public.gmane.org}.....
  6410: 31 10 0b 31 10 12 12 06 0b 40 06 0b 00 7d 0a 0a  1..1.....-47IYjYMXMt4@public.gmane.org}..
  6420: 0a 0a 0b 31 10 0b 31 10 12 12 06 0b 40 06 0b 00  ...1..1.....-47IYjYMXMt4@public.gmane.org
  6430: 7d 0a 0a 0a 0a 0b 31 10 0b 31 10 12 12 06 0b 40  }.....1..1.....@
  6440: 06 0b 00 7d 0a 0a 0a 0a 0b 31 10 0b 31 10 12 12  ...}.....1..1...
  6450: 06 0b 78 05 0b 60 6d 0a 0a 0a 0a 0b 2d 0e 0b 2d  ..x..`m.....-..-
  6460: 0e 12 12 06 0b b0 04 0b c0 5d 0a 0a 0a 0a 0b 24  .........].....$
  6470: 0c 0b 24 0c 12 12 06 0b e8 03 0b 20 4e 0a 0a 0a  ..$........ N...
  6480: 0a 0b 1d 0a 0b 1d 0a 12 12 06 0b 20 03 0b 80 3e  ........... ...>
  6490: 0a 0a 0a 0a 0b 15 08 0b 15 08 12 12 06 0b 58 02  ..............X.
  64a0: 0b e0 2e 0a 0a 0a 0a 0b 10 06 0b 10 06 08 50 50  ..............PP
  64b0: 53 53 12 43 0b 0a 12 10 06 0b 40 06 0b 00 7d 0a  SS.C......-47IYjYMXMt4@public.gmane.org}.
  64c0: 0a 0a 6e 0a 86 0a 00 12 10 06 0b 40 06 0b 00 7d  ..n........-47IYjYMXMt4@public.gmane.org}
  64d0: 0a 0a 0a 6e 0a 86 0a 00 12 10 06 0b 40 06 0b 00  ...n........-47IYjYMXMt4@public.gmane.org
  64e0: 7d 0a 0a 0a 6e 0a 86 0a 00 12 10 06 0b 40 06 0b  }...n........-rVxdn2TrCWA@public.gmane.org
  64f0: 00 7d 0a 0a 0a 6e 0a 86 0a 00 12 11 06 0b 40 06  .}...n........-4b8TPpkIZ3Q@public.gmane.org
  6500: 0b 00 7d 0a 0a 0a 6e 0b 86 00 0a 00 12 11 06 0b  ..}...n.........
  6510: 78 05 0b 60 6d 0a 0a 0a 6e 0b 86 01 0a 01 12 11  x..`m...n.......
  6520: 06 0b b0 04 0b c0 5d 0a 0a 0a 6e 0b 86 02 0a 02  ......]...n.....
  6530: 12 11 06 0b e8 03 0b 20 4e 0a 0a 0a 6e 0b 86 03  ....... N...n...
  6540: 0a 03 12 11 06 0b 20 03 0b 80 3e 0a 0a 0a 6e 0b  ...... ...>...n.
  6550: 86 04 0a 04 12 11 06 0b 58 02 0b e0 2e 0a 0a 0a  ........X.......
  6560: 6e 0b 86 05 0a 05 08 4e 50 53 53 0a 06 14 18 5f  n......NPSS...._
  6570: 50 53 53 00 a0 0a 54 59 50 45 a4 4d 50 53 53 a1  PSS...TYPE.MPSS.
  6580: 06 a4 50 50 53 53 14 24 5f 50 50 43 00 a0 0f 92  ..PPSS.$_PPC....
  6590: 94 87 50 50 53 53 4e 50 53 53 a4 0a 00 a1 0d a4  ..PPSSNPSS......
  65a0: 74 87 50 50 53 53 4e 50 53 53 00 10 45 42 5c 5f  t.PPSSNPSS..EB\_
  65b0: 53 42 5f 5b 80 5c 2f 04 5f 53 42 5f 50 43 49 30  SB_[.\/._SB_PCI0
  65c0: 53 42 52 47 49 52 4f 52 02 0a 00 0a ff 5b 81 43  SBRGIROR.....[.C
  65d0: 04 5c 2f 04 5f 53 42 5f 50 43 49 30 53 42 52 47  .\/._SB_PCI0SBRG
  65e0: 49 52 4f 52 01 00 40 30 50 49 52 41 08 50 49 52  IROR..-vDiu0stj7Tbl2ZiQzgSchg@public.gmane.org
  65f0: 42 08 50 49 52 43 08 50 49 52 44 08 00 20 50 49  B.PIRC.PIRD.. PI
  6600: 52 45 08 50 49 52 46 08 50 49 52 47 08 50 49 52  RE.PIRF.PIRG.PIR
  6610: 48 08 08 42 55 46 41 11 09 0a 06 23 00 80 18 79  H..BUFA....#...y
  6620: 00 8b 42 55 46 41 0a 01 49 43 52 53 14 16 4c 53  ..BUFA..ICRS..LS
  6630: 54 41 01 7b 68 0a 80 60 a0 05 60 a4 0a 09 a1 04  TA.{h..`..`.....
  6640: a4 0a 0b 14 18 4c 43 52 53 01 7b 68 0a 0f 60 79  .....LCRS.{h..`y
  6650: 0a 01 60 49 43 52 53 a4 42 55 46 41 14 17 4c 53  ..`ICRS.BUFA..LS
  6660: 52 53 01 8b 68 0a 01 49 53 52 53 82 49 53 52 53  RS..h..ISRS.ISRS
  6670: 60 a4 76 60 14 0c 4c 44 49 53 01 a4 7d 68 0a 80  `.v`..LDIS..}h..
  6680: 00 5b 82 48 06 4c 4e 4b 41 08 5f 48 49 44 0c 41  .[.H.LNKA._HID.A
  6690: d0 0c 0f 08 5f 55 49 44 0a 01 14 0f 5f 53 54 41  ...._UID...._STA
  66a0: 00 a4 4c 53 54 41 50 49 52 41 14 0b 5f 50 52 53  ..LSTAPIRA.._PRS
  66b0: 00 a4 50 52 53 41 14 13 5f 44 49 53 00 70 4c 44  ..PRSA.._DIS.pLD
  66c0: 49 53 50 49 52 41 50 49 52 41 14 0f 5f 43 52 53  ISPIRAPIRA.._CRS
  66d0: 00 a4 4c 43 52 53 50 49 52 41 14 10 5f 53 52 53  ..LCRSPIRA.._SRS
  66e0: 01 70 4c 53 52 53 68 50 49 52 41 5b 82 48 06 4c  .pLSRShPIRA[.H.L
  66f0: 4e 4b 42 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55  NKB._HID.A...._U
  6700: 49 44 0a 02 14 0f 5f 53 54 41 00 a4 4c 53 54 41  ID...._STA..LSTA
  6710: 50 49 52 42 14 0b 5f 50 52 53 00 a4 50 52 53 42  PIRB.._PRS..PRSB
  6720: 14 13 5f 44 49 53 00 70 4c 44 49 53 50 49 52 42  .._DIS.pLDISPIRB
  6730: 50 49 52 42 14 0f 5f 43 52 53 00 a4 4c 43 52 53  PIRB.._CRS..LCRS
  6740: 50 49 52 42 14 10 5f 53 52 53 01 70 4c 53 52 53  PIRB.._SRS.pLSRS
  6750: 68 50 49 52 42 5b 82 48 06 4c 4e 4b 43 08 5f 48  hPIRB[.H.LNKC._H
  6760: 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 03 14 0f  ID.A...._UID....
  6770: 5f 53 54 41 00 a4 4c 53 54 41 50 49 52 43 14 0b  _STA..LSTAPIRC..
  6780: 5f 50 52 53 00 a4 50 52 53 43 14 13 5f 44 49 53  _PRS..PRSC.._DIS
  6790: 00 70 4c 44 49 53 50 49 52 43 50 49 52 43 14 0f  .pLDISPIRCPIRC..
  67a0: 5f 43 52 53 00 a4 4c 43 52 53 50 49 52 43 14 10  _CRS..LCRSPIRC..
  67b0: 5f 53 52 53 01 70 4c 53 52 53 68 50 49 52 43 5b  _SRS.pLSRShPIRC[
  67c0: 82 48 06 4c 4e 4b 44 08 5f 48 49 44 0c 41 d0 0c  .H.LNKD._HID.A..
  67d0: 0f 08 5f 55 49 44 0a 04 14 0f 5f 53 54 41 00 a4  .._UID...._STA..
  67e0: 4c 53 54 41 50 49 52 44 14 0b 5f 50 52 53 00 a4  LSTAPIRD.._PRS..
  67f0: 50 52 53 44 14 13 5f 44 49 53 00 70 4c 44 49 53  PRSD.._DIS.pLDIS
  6800: 50 49 52 44 50 49 52 44 14 0f 5f 43 52 53 00 a4  PIRDPIRD.._CRS..
  6810: 4c 43 52 53 50 49 52 44 14 10 5f 53 52 53 01 70  LCRSPIRD.._SRS.p
  6820: 4c 53 52 53 68 50 49 52 44 5b 82 48 06 4c 4e 4b  LSRShPIRD[.H.LNK
  6830: 45 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44  E._HID.A...._UID
  6840: 0a 05 14 0f 5f 53 54 41 00 a4 4c 53 54 41 50 49  ...._STA..LSTAPI
  6850: 52 45 14 0b 5f 50 52 53 00 a4 50 52 53 45 14 13  RE.._PRS..PRSE..
  6860: 5f 44 49 53 00 70 4c 44 49 53 50 49 52 45 50 49  _DIS.pLDISPIREPI
  6870: 52 45 14 0f 5f 43 52 53 00 a4 4c 43 52 53 50 49  RE.._CRS..LCRSPI
  6880: 52 45 14 10 5f 53 52 53 01 70 4c 53 52 53 68 50  RE.._SRS.pLSRShP
  6890: 49 52 45 5b 82 48 06 4c 4e 4b 46 08 5f 48 49 44  IRE[.H.LNKF._HID
  68a0: 0c 41 d0 0c 0f 08 5f 55 49 44 0a 06 14 0f 5f 53  .A...._UID...._S
  68b0: 54 41 00 a4 4c 53 54 41 50 49 52 46 14 0b 5f 50  TA..LSTAPIRF.._P
  68c0: 52 53 00 a4 50 52 53 46 14 13 5f 44 49 53 00 70  RS..PRSF.._DIS.p
  68d0: 4c 44 49 53 50 49 52 46 50 49 52 46 14 0f 5f 43  LDISPIRFPIRF.._C
  68e0: 52 53 00 a4 4c 43 52 53 50 49 52 46 14 10 5f 53  RS..LCRSPIRF.._S
  68f0: 52 53 01 70 4c 53 52 53 68 50 49 52 46 5b 82 48  RS.pLSRShPIRF[.H
  6900: 06 4c 4e 4b 47 08 5f 48 49 44 0c 41 d0 0c 0f 08  .LNKG._HID.A....
  6910: 5f 55 49 44 0a 07 14 0f 5f 53 54 41 00 a4 4c 53  _UID...._STA..LS
  6920: 54 41 50 49 52 47 14 0b 5f 50 52 53 00 a4 50 52  TAPIRG.._PRS..PR
  6930: 53 47 14 13 5f 44 49 53 00 70 4c 44 49 53 50 49  SG.._DIS.pLDISPI
  6940: 52 47 50 49 52 47 14 0f 5f 43 52 53 00 a4 4c 43  RGPIRG.._CRS..LC
  6950: 52 53 50 49 52 47 14 10 5f 53 52 53 01 70 4c 53  RSPIRG.._SRS.pLS
  6960: 52 53 68 50 49 52 47 5b 82 48 06 4c 4e 4b 48 08  RShPIRG[.H.LNKH.
  6970: 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 08  _HID.A...._UID..
  6980: 14 0f 5f 53 54 41 00 a4 4c 53 54 41 50 49 52 48  .._STA..LSTAPIRH
  6990: 14 0b 5f 50 52 53 00 a4 50 52 53 48 14 13 5f 44  .._PRS..PRSH.._D
  69a0: 49 53 00 70 4c 44 49 53 50 49 52 48 50 49 52 48  IS.pLDISPIRHPIRH
  69b0: 14 0f 5f 43 52 53 00 a4 4c 43 52 53 50 49 52 48  .._CRS..LCRSPIRH
  69c0: 14 10 5f 53 52 53 01 70 4c 53 52 53 68 50 49 52  .._SRS.pLSRShPIR
  69d0: 48 10 48 13 5c 5f 53 42 5f 10 40 13 50 43 49 30  H.H.\_SB_.-qoVbUukB9bw@public.gmane.org
  69e0: 08 43 52 53 5f 11 4c 08 0a 88 88 0d 00 02 0c 00  .CRS_.L.........
  69f0: 00 00 00 00 ff 00 00 00 00 01 47 01 f8 0c f8 0c  ..........G.....
  6a00: 01 08 88 0d 00 01 0c 03 00 00 00 00 f7 0c 00 00  ................
  6a10: f8 0c 88 0d 00 01 0c 03 00 00 00 0d ff ff 00 00  ................
  6a20: 00 f3 87 17 00 00 0c 03 00 00 00 00 00 00 0a 00  ................
  6a30: ff ff 0b 00 00 00 00 00 00 00 02 00 87 17 00 00  ................
  6a40: 0c 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  6a50: 00 00 00 00 00 00 87 17 00 00 0c 03 00 00 00 00  ................
  6a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  6a70: 79 00 8a 43 52 53 5f 0a 5c 4d 49 4e 35 8a 43 52  y..CRS_.\MIN5.CR
  6a80: 53 5f 0a 60 4d 41 58 35 8a 43 52 53 5f 0a 68 4c  S_.`MAX5.CRS_.hL
  6a90: 45 4e 35 8a 43 52 53 5f 0a 76 4d 49 4e 36 8a 43  EN5.CRS_.vMIN6.C
  6aa0: 52 53 5f 0a 7a 4d 41 58 36 8a 43 52 53 5f 0a 82  RS_.zMAX6.CRS_..
  6ab0: 4c 45 4e 36 14 45 05 5f 43 52 53 00 70 4d 47 31  LEN6.E._CRS.pMG1
  6ac0: 42 4d 49 4e 35 70 4d 47 31 4c 4c 45 4e 35 70 4d  BMIN5pMG1LLEN5pM
  6ad0: 47 31 4c 60 a0 0d 60 72 4d 49 4e 35 76 60 4d 41  G1L`..`rMIN5v`MA
  6ae0: 58 35 70 4d 47 32 42 4d 49 4e 36 70 4d 47 32 4c  X5pMG2BMIN6pMG2L
  6af0: 4c 45 4e 36 70 4d 47 32 4c 60 72 4d 49 4e 36 76  LEN6pMG2L`rMIN6v
  6b00: 60 4d 41 58 36 a4 43 52 53 5f a0 40 07 53 53 31  `MAX6.CRS_.-GCyjF9ZfFuk@public.gmane.org
  6b10: 5f 08 5c 2f 03 5f 53 42 5f 50 43 49 30 5f 53 31  _.\/._SB_PCI0_S1
  6b20: 44 0a 02 08 5c 2f 04 5f 53 42 5f 50 43 49 30 50  D...\/._SB_PCI0P
  6b30: 30 50 31 5f 53 31 44 0a 02 08 5c 2f 04 5f 53 42  0P1_S1D...\/._SB
  6b40: 5f 50 43 49 30 55 53 42 31 5f 53 31 44 0a 02 08  _PCI0USB1_S1D...
  6b50: 5c 2f 04 5f 53 42 5f 50 43 49 30 55 53 42 32 5f  \/._SB_PCI0USB2_
  6b60: 53 31 44 0a 02 08 5c 2f 04 5f 53 42 5f 50 43 49  S1D...\/._SB_PCI
  6b70: 30 55 53 42 33 5f 53 31 44 0a 02 a0 40 07 53 53  0USB3_S1D...-aPBB96i5R6g@public.gmane.org
  6b80: 33 5f 08 5c 2f 03 5f 53 42 5f 50 43 49 30 5f 53  3_.\/._SB_PCI0_S
  6b90: 33 44 0a 02 08 5c 2f 04 5f 53 42 5f 50 43 49 30  3D...\/._SB_PCI0
  6ba0: 50 30 50 31 5f 53 33 44 0a 02 08 5c 2f 04 5f 53  P0P1_S3D...\/._S
  6bb0: 42 5f 50 43 49 30 55 53 42 31 5f 53 33 44 0a 02  B_PCI0USB1_S3D..
  6bc0: 08 5c 2f 04 5f 53 42 5f 50 43 49 30 55 53 42 32  .\/._SB_PCI0USB2
  6bd0: 5f 53 33 44 0a 02 08 5c 2f 04 5f 53 42 5f 50 43  _S3D...\/._SB_PC
  6be0: 49 30 55 53 42 33 5f 53 33 44 0a 02 a0 2d 53 53  I0USB3_S3D...-SS
  6bf0: 34 5f 08 5c 2f 03 5f 53 42 5f 50 43 49 30 5f 53  4_.\/._SB_PCI0_S
  6c00: 34 44 0a 02 08 5c 2f 04 5f 53 42 5f 50 43 49 30  4D...\/._SB_PCI0
  6c10: 50 30 50 31 5f 53 34 44 0a 02 14 27 5f 50 54 53  P0P1_S4D...'_PTS
  6c20: 01 70 68 44 42 47 38 50 54 53 5f 68 70 0a 00 88  .phDBG8PTS_hp...
  6c30: 57 41 4b 50 0a 00 00 70 0a 00 88 57 41 4b 50 0a  WAKP...p...WAKP.
  6c40: 01 00 08 53 4c 49 44 0a 01 14 42 04 5f 57 41 4b  ...SLID...B._WAK
  6c50: 01 79 68 0a 04 44 42 47 38 70 0a 01 53 4c 49 44  .yh..DBG8p..SLID
  6c60: 57 41 4b 5f 68 a0 15 83 88 57 41 4b 50 0a 00 00  WAK_h....WAKP...
  6c70: 70 0a 00 88 57 41 4b 50 0a 01 00 a1 0b 70 68 88  p...WAKP.....ph.
  6c80: 57 41 4b 50 0a 01 00 a4 57 41 4b 50 08 5f 53 30  WAKP....WAKP._S0
  6c90: 5f 12 0a 04 0a 00 0a 00 0a 00 0a 00 a0 15 53 53  _.............SS
  6ca0: 31 5f 08 5f 53 31 5f 12 0a 04 0a 02 0a 00 0a 00  1_._S1_.........
  6cb0: 0a 00 a0 15 53 53 33 5f 08 5f 53 33 5f 12 0a 04  ....SS3_._S3_...
  6cc0: 0a 05 0a 00 0a 00 0a 00 a0 15 53 53 34 5f 08 5f  ..........SS4_._
  6cd0: 53 34 5f 12 0a 04 0a 06 0a 00 0a 00 0a 00 08 5f  S4_............_
  6ce0: 53 35 5f 12 0a 04 0a 07 0a 00 0a 00 0a 00 14 1e  S5_.............
  6cf0: 50 54 53 5f 01 a0 12 68 46 41 4e 53 68 5c 2e 5f  PTS_...hFANSh\._
  6d00: 54 5a 5f 54 52 4d 53 68 4f 45 4d 53 68 14 1b 57  TZ_TRMShOEMSh..W
  6d10: 41 4b 5f 01 46 41 4e 57 68 5c 2e 5f 54 5a 5f 54  AK_.FANWh\._TZ_T
  6d20: 52 4d 57 68 4f 45 4d 57 68                       RMWhOEMWh

FACS @ 0x1f750000
  0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00  FACS-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

OEMB @ 0x1f750040
  0000: 4f 45 4d 42 4d 00 00 00 01 24 41 20 4d 20 49 20  OEMBM....$A M I 
  0010: 4f 45 4d 42 49 4f 53 20 10 03 00 06 4d 53 46 54  OEMBIOS ....MSFT
  0020: 97 00 00 00 0d 0e 14 00 00 80 1f 00 00 f8 ff 00  ................
  0030: 00 0d 00 00 00 01 00 00 00 80 1f 00 00 80 e0 2e  ................
  0040: 00 00 e4 80 00 e8 10 80 04 10 00 ec 40           ............@


--===-=-=
Content-Disposition: inline; filename=lspci

00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 1751
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at <unassigned> (32-bit, prefetchable)
	Capabilities: [40] #09 [a105]

00:00.1 System peripheral: Intel Corp.: Unknown device 3584 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 175a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:00.3 System peripheral: Intel Corp.: Unknown device 3585 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 175b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 1712
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at ffa80000 (32-bit, non-prefetchable) [size=512K]
	Region 2: I/O ports at dc00 [size=8]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 1712
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at ff980000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1758
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at d480 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1758
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at d800 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1758
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 5
	Region 4: I/O ports at d880 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1759
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 4
	Region 0: Memory at ffa7fc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ff700000-ff7fffff
	Prefetchable memory behind bridge: de900000-deafffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 1758
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at 1f800000 (32-bit, non-prefetchable) [size=1K]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 03)
	Subsystem: Asustek Computer, Inc.: Unknown device 1713
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 0
	Region 0: I/O ports at e000 [size=256]
	Region 1: I/O ports at e100 [size=64]
	Region 2: Memory at 1f800400 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at 1f800600 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Asustek Computer, Inc.: Unknown device 1716
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 0
	Region 0: I/O ports at e200 [size=256]
	Region 1: I/O ports at e300 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:03.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a9)
	Subsystem: Asustek Computer, Inc.: Unknown device 1754
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 1f801000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

01:03.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a9)
	Subsystem: Asustek Computer, Inc.: Unknown device 1754
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 0
	Region 0: Memory at 1f802000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=01, secondary=06, subordinate=09, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

01:03.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 01) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1757
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at ff7ef000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 1045
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at c800 [size=256]
	Region 1: Memory at ff7efc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corp.: Unknown device 2527
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at ff7ff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-


--===-=-=
Content-Disposition: inline; filename=interrupts

           CPU0       
  0:     234857          XT-PIC  timer
  1:        740          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:          0          XT-PIC  ehci_hcd
  5:        217          XT-PIC  uhci_hcd, uhci_hcd, uhci_hcd, eth0
  8:          4          XT-PIC  rtc
 12:         86          XT-PIC  i8042
 14:       4327          XT-PIC  ide0
 15:         10          XT-PIC  ide1
NMI:          0 
LOC:     234807 
ERR:          0
MIS:          0

--===-=-=


-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--===-=-=--

--====-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFADmxMbvivwoZXSsoRAgfAAJ9r4Zx2C8iCyI/XvCVjHKDpYABgrwCfdOjd
Yjan8O9TC7CM7YECbuMINjM=
=UbV0
-----END PGP MESSAGE-----
--====-=-=--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
