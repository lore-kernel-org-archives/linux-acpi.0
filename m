From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: Strange interpreter behaviour
Date: Mon, 16 Jan 2006 22:27:28 +0100
Message-ID: <43CC0FC0.9090806@tzi.de>
References: <43BFF7DE.1000909@tzi.de> <20060116171932.GF25115@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060116171932.GF25115-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Sound like \_SB.INV7 is a bit into a GPIO.
> More, the associated OR is defined like that:
> 	OperationRegion (GPIO, SystemIO, IO2B, 0x40) 
> 
> Note that IO2B is given here:
>     OperationRegion (BIOS, SystemMemory, 0x1FF50064, 0xFF)
>     Field (BIOS, ByteAcc, NoLock, Preserve)
>     {
>         SS1,    1,
>         SS2,    1,
>         SS3,    1,
>         SS4,    1,
>         Offset (0x01),
>         IOST,   16,
>         SPIO,   16,
>         PMBS,   16,
>         PMLN,   8,
>         SMBS,   16,
>         SMLN,   8,
>         IO1B,   16,
>         IO1L,   8,
>         IO2B,   16,
>         IO2L,   8,
>         TOPM,   32,
>         ROMS,   32,
> 
> Therefore one think to check is that IO2B is set correctly to point to
> the GPIO's, then look if the GPIO is configured as a GPO (not as a GPI).
> 
> For checking if IO2B is correct:
> sudo dd if=/dev/mem bs=1c skip=536150130 count=2 | hexdump
> 
Here it get's strange :
scotchmobil scotch # dd if=/dev/mem bs=1c skip=536150130 count=2
dd: reading `/dev/mem': Bad address
0+0 records in
0+0 records out


> ./acpixtract FACP < acpidump.out | ./acpitbl
> 
> where acpidump.txt is the output from ./acpidump.  I assume you know
> what I'm talking about reading the bugzilla report, or else do something
> like that:
> 
> wget ftp://ftp.kernel.org//pub/linux/kernel/people/lenb/acpi/utils/pmtools-20050926.tar.bz2
> tar xjvfp pmtools-20050926.tar.bz2
> cd pmtools
> make
> cd acpidump
> sudo ./acpidmp > acpidmp.out
> 
> I think the value given by the 'sudo dd' above should correspond to the
> GPE0_BLK: field from the ./acpitbl above.
> 
> For checking if the register where the INV7 is defined is configured as
> a GPO, well I have to know the ouput from 'lspci -v -xxx -s"the southbridge"'
> 
Uhm as far as I know "the southbridge" is is the Intel 82801. There are 
more than one 82801 devices, so I just post all except the USB devices, 
sorry for that :

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83) 
(prog-if 00 [Normal decode])
         Flags: bus master, fast devsel, latency 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
         I/O behind bridge: 00001000-00001fff
         Memory behind bridge: ff900000-ff9fffff
         Prefetchable memory behind bridge: dea00000-deafffff
00: 86 80 48 24 07 01 80 80 83 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 40 10 10 80 02
20: 90 ff 90 ff a0 de a0 de 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 00
40: 02 28 20 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 74 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 10 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 01 00 02 00 00 00 c0 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 2c 48

00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface 
Bridge (rev 03)
         Flags: bus master, medium devsel, latency 0
00: 86 80 cc 24 0f 01 80 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 04 00 00 10 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 01 05 00 00 10 00 00 00
60: 0b 04 0a 05 90 00 00 00 80 80 80 0a 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: ff fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 28 03 00 00 00 00 00 00 0d 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 80 02 02 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 02 28 00 00 02 cf 00 00 04 00 00 00 00 00 00 00
e0: 12 00 00 c0 00 00 06 34 33 22 11 00 00 00 67 45
f0: 00 00 01 00 00 00 00 00 60 0f 03 00 00 00 80 02

00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE 
Controller (rev 03) (prog-if 8a [Master SecP PriP])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1869
         Flags: bus master, medium devsel, latency 0, IRQ 10
         I/O ports at <unassigned>
         I/O ports at <unassigned>
         I/O ports at <unassigned>
         I/O ports at <unassigned>
         I/O ports at ffa0 [size=16]
         Memory at 30000000 (32-bit, non-prefetchable) [size=1K]
00: 86 80 ca 24 07 00 80 02 03 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: a1 ff 00 00 00 00 00 30 00 00 00 00 43 10 69 18
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
40: 07 e3 07 e3 00 00 00 00 05 00 01 02 00 00 00 00
50: 00 00 00 00 31 14 00 00 00 00 00 00 00 00 00 00
60: 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
SMBus Controller (rev 03)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1869
         Flags: medium devsel
         I/O ports at 0540 [size=32]
00: 86 80 c3 24 01 00 80 02 03 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 05 00 00 00 00 00 00 00 00 00 00 43 10 69 18
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00
40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00



-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
