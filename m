From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Thu, 19 Sep 2002 23:02:38 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020919230238.A10834@sci.fi>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE80-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>; from andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Wed, Sep 18, 2002 at 11:27:01PM -0700
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Abit KT7-RAID motherboard.

> - DOES IT BOOT?

Yes.

> - DOES IT ASSIGN INTERRUPTS PROPERLY?

Sort of. I have "PNP OS" disabled so my BIOS already assigns the IRQs. 

ACPI: PCI Interrupt Link [LNKA] (IRQs 1 *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15, enabled
at IRQ 9)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)

The code respects the BIOS choice for LNKC even though 9 isn't in the
_PRS. A bug in the _PRS really.


  0:     117624          XT-PIC  timer
  1:      10225          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       7471          XT-PIC  MGA Vertical Sync, eth0
  7:          8          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:       9769          XT-PIC  ide2, ide3
 10:         35          XT-PIC  acpi, sym53c8xx
 12:       3645          XT-PIC  PS/2 Mouse
 14:         14          XT-PIC  ide0
 15:          9          XT-PIC  ide1

The BIOS assings my G400 to IRQ 3 but the code sticks it in 5 for some
reason. The AGP slot should share the IRQ with the first PCI slot. I
don't have a card in there so I don't know how things would look then.

lspci -vt:
-[00]-+-00.0  VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
      +-01.0-[01]----00.0  Matrox Graphics, Inc. MGA G400 AGP
      +-07.0  VIA Technologies, Inc. VT82C686 [Apollo Super South]
      +-07.1  VIA Technologies, Inc. Bus Master IDE
      +-07.4  VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
      +-0b.0  Symbios Logic Inc. (formerly NCR) 53c875
      +-0d.0  3Com Corporation 3c905C-TX [Fast Etherlink]
      +-0f.0  Brooktree Corporation Bt849A Video capture
      \-13.0  Triones Technologies, Inc. HPT366

So the G400 should use the IRQ assignement for 00:01.0 which doesn't have
an IRQ but is mentioned in the _PRT:

 Package(0x04){
   0x0001FFFF,
   0x00,
   \_SB.PCI0.LNKA,
   0x00
 },

So it should use LNKA's IRQ assignment but it doesn't.

Other IRQ stuff seems fine.



Other stuff:
ACPI: Power Button (FF) [PWRF]
- Works.
ACPI: Sleep Button (CM) [SLPB]
- I don't have a button in my case for this so I don't know if it works.
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
- Everything seems to work.

I also get messages like:
pci_bind-0191 [05] acpi_pci_bind         : Device 00:00:07.02 not present
in PCI namespace

Those are for modem, audio and USB. Maybe these messages shouldn't be
printed since it's not a real problem?



And my computer still reboots with ISA GUS PnP + SCSI CD-ROM + ACPI. I
tried changing ACPI_OS_NAME to "Microsoft Windows" or "Microsoft Windows
NT" since the DSDT does something different in \_SB.PCI0._INI with those
values but neither helped. So it looks like ACPI will still remain off
limits for me :(

-- 
Ville Syrjälä
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
