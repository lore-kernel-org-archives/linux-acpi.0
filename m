From: Alistair John Strachan <s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org>
Subject: Re: Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 17:42:55 +0000
Message-ID: <200502151742.55362.s0348365@sms.ed.ac.uk>
References: <20050214211105.GA12808@elf.ucw.cz> <1108482083.12031.10.camel@elrond.flymine.org> <42122054.8010408@colitti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
In-Reply-To: <42122054.8010408-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 15 Feb 2005 16:16, Lorenzo Colitti wrote:
[snip]
>
> Ok, here is the output from dmidecode (Debian package) and from lspci. I
> don't have acpidmp and I don't know where to get it, but if you think
> it's necessary I can download it if you tell me where to find it.

Find below a diff of my dmidecode output versus Lorenzo's. Nothing much
to call home about.

[alistair] 17:40 [~/dmidecode-2.5] diff -Nudr -U3 lorenzo dmiout
--- lorenzo     2005-02-15 17:37:36.091770768 +0000
+++ dmiout      2005-02-15 17:40:08.801555352 +0000
@@ -1,13 +1,13 @@
 # dmidecode 2.5
 SMBIOS 2.3 present.
 31 structures occupying 1354 bytes.
-Table at 0x000FF2EB.
+Table at 0x000FA1EE.
 Handle 0x0000
        DMI type 0, 20 bytes.
        BIOS Information
                Vendor: Hewlett-Packard
-               Version: 68BDD Ver. F.0F
-               Release Date: 07/23/2004
+               Version: 68BDD Ver. F.11
+               Release Date: 11/22/2004
                Address: 0xE0000
                Runtime Size: 128 kB
                ROM Size: 1024 kB
@@ -37,10 +37,10 @@
        DMI type 1, 25 bytes.
        System Information
                Manufacturer: Hewlett-Packard
-               Product Name: HP Compaq nc6000 (DJ254A#ABB)
-               Version: F.0F
-               Serial Number: XXXXXXXXXX
-               UUID: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
+               Product Name: HP Compaq nc6000 (PK522PS#UUF)
+               Version: F.11
+               Serial Number: <censored>
+               UUID: <censored>
                Wake-up Type: Power Switch
 Handle 0x0002
        DMI type 2, 8 bytes.
@@ -52,11 +52,11 @@
 Handle 0x0003
        DMI type 3, 13 bytes.
        Chassis Information
-               Manufacturer: Hewlett-Packard
+               Manufacturer: Hewlett-Packard
                Type: Notebook
                Lock: Not Present
                Version: Not Specified
-               Serial Number: XXXXXXXXXX
+               Serial Number: <censored>
                Asset Tag:
                Boot-up State: Safe
                Power Supply State: Safe
@@ -69,8 +69,8 @@
                Type: Central Processor
                Family: Pentium M
                Manufacturer: Intel(R)
-               ID: XX XX XX XX XX XX XX XX
-               Signature: Type 0, Family 6, Model 9, Stepping 5
+               ID: D6 06 00 00 BF F9 E9 AF
+               Signature: Type 0, Family 6, Model 13, Stepping 6
                Flags:
                        FPU (Floating-point unit on-chip)
                        VME (Virtual mode extension)
@@ -93,13 +93,14 @@
                        FXSR (Fast floating-point save and restore)
                        SSE (Streaming SIMD extensions)
                        SSE2 (Streaming SIMD extensions 2)
+                       SS (Self-snoop)
                        TM (Thermal monitor supported)
                        SBF (Signal break on FERR)
-               Version: Intel(R) Pentium(R) M processor 1400MHz
+               Version: Intel(R) Pentium(R) M processor 1.60GHz
                Voltage: 1.8 V
                External Clock: 100 MHz
-               Max Speed: 1400 MHz
-               Current Speed: 1400 MHz
+               Max Speed: 1600 MHz
+               Current Speed: 1600 MHz
                Status: Populated, Enabled
                Upgrade: None
                L1 Cache Handle: 0x0005
@@ -131,8 +132,8 @@
                Configuration: Enabled, Not Socketed, Level 2
                Operational Mode: Write Back
                Location: External
-               Installed Size: 1024 KB
-               Maximum Size: 1024 KB
+               Installed Size: 2048 KB
+               Maximum Size: 2048 KB
                Supported SRAM Types:
                        Burst
                Installed SRAM Type: Burst
@@ -194,7 +195,7 @@
                Form Factor: SODIMM
                Set: None
                Locator: DIMM #1
-               Bank Locator: 030B2C25
+               Bank Locator: 6605F934
                Type: DDR
                Type Detail: Synchronous
                Speed: 142 MHz (7.0 ns)
@@ -213,12 +214,12 @@
                Form Factor: SODIMM
                Set: None
                Locator: DIMM #2
-               Bank Locator: 051FD180
+               Bank Locator: 0322BB20
                Type: DDR
                Type Detail: Synchronous
                Speed: 142 MHz (7.0 ns)
                Manufacturer: Not Specified
-               Serial Number: XXXXXXXXXXXX-XXXXX
+               Serial Number: <censored>
                Asset Tag: Not Specified
                Part Number: Not Specified
 Handle 0x000E
@@ -294,8 +295,8 @@
        Portable Battery
                Location: Primary
                Manufacturer: Hewlett-Packard
-               Manufacture Date: 12/12/2003
-               Serial Number: 00001
+               Manufacture Date: 08/20/2004
+               Serial Number: 01726
                Name: Not Specified
                Chemistry: Lithium Ion
                Design Capacity: 2700 mWh
@@ -357,11 +358,11 @@
        DMI type 133, 34 bytes.
        OEM-specific Type
                Header and Data:
-                       85 22 85 00 01 30 11 1F 0D CE 0B 02 00 6E 00 15
-                       00 24 30 B2 00 5C 2B 02 80 00 00 00 0D 10 13 10
-                       05 10
+                       85 22 85 00 01 30 11 84 0E 84 0E 04 00 20 00 17
+                       00 C8 2F 91 F8 5C 2B 02 C0 00 00 00 F2 0F F7 0F
+                       DF 0F
                Strings:
-                       00001 12/12/2003
+                       01726 08/20/2004
                        HP
 Handle 0x0086
        DMI type 126, 34 bytes.

[root] 17:41 [/home/alistair/dmidecode-2.5] lspci
00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801 Mobile PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corp. 82801DBM (ICH4-M) LPC Interface Bridge (rev 03)
00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4-M) IDE Controller (rev 03)
00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10]
02:04.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
02:06.0 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus MultiMediaBay Controller
02:06.1 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus MultiMediaBay Controller
02:06.2 System peripheral: O2 Micro, Inc. OZ711Mx MultiMediaBay Accelerator
02:06.3 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus MultiMediaBay Controller
02:0e.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705M_2 Gigabit Ethernet (rev 03)

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
