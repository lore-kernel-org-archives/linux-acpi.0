From: Ole Myren Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>
Subject: Re: Weirdness in arch/i386/kernel/acpi_wakeup.S
Date: 12 Feb 2003 18:07:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3ptpxo2ak.fsf@pcpenn04.cern.ch>
References: <20030210170928.GD443@elf.ucw.cz>
	<Pine.LNX.4.33.0302121245090.6226-100000@godzilla.axis.se>
	<20030212142405.GB13327@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030212142405.GB13327-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org> writes:

> Yes, exactly. I'd suggest 8 leds on printer port as a debugging
> trick... [VGA is easier -- when it works. Try moving 'L' just after
> "call bios" to see if it ever returns etc.]

I've tried incrementing a byte in nvram, ie something like

        mov $14, %al
        outb %al, $0x70
        mov $1, %al
        outb %al, $0x71 

FWIW, it wasn't very successful on my Fujitsu P2120:

1. I don't know if playing with nvram is dangerous or just stupid...

2. I'm not sure which byte to use, it should be unused and outside
   checksummed areas. IUC, byte 14 is available and shows up as the
   first byte in /dev/nvram

3. Instead of hanging on resume, my machine now spontaneously rebooted
   (like jmp $0xffff,$0x0)

The third point left me with a question of what you can actually
expect of on a S3 resume. As I read the specs, only memory access is
guaranteed and the memory map can be either "boot" or "pre S3".

If access to the VGA fb is through some not-yet powered bridge,
perhaps the tracing could even cause the system to hang? Well,
that's enough speculation for now...

Ole

I append my /sbin/lspci hoping someone will look for suspicious
devices...

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 03)
00:00.1 RAM memory: Transmeta Corporation SDRAM controller
00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:04.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 01)
00:06.0 Bridge: ALi Corporation M7101 PMU
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:09.0 USB Controller: NEC Corporation USB (rev 41)
00:09.1 USB Controller: NEC Corporation USB (rev 41)
00:09.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
00:0c.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:12.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
00:13.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
00:14.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
