From: Hiroshi Takekawa <sian-whu2oojL+5h4Eiagz67IpQ@public.gmane.org>
Subject: Re: ACPI patches updated (20021205)
Date: Sat, 07 Dec 2002 19:24:34 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021207.192434.10655802.sian@big.or.jp>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A57A@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A57A-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> New ACPI patches against 2.4.20 and 2.5.50 are now available at
> http://sf.net/projects/acpi . Non-Linux releases will be available tonight,
> from http://developer.intel.com/technology/iapc/acpi/downloads.htm .

Finally, ACPI on my notebook works.
Kudos to all ACPI developpers!

> Fixed a problem where an internal error was generated if a
> control method invocation was used in an OperationRegion,
> Buffer, or Package declaration.  This was caused by the
> deferred parsing of the control method and thus the deferred
> creation of the internal method object.  The solution to this
> problem was to create the internal method object at the moment
> the method is encountered in the first pass - so that
> subsequent references to the method will able to obtain the
> required parameter count and thus properly parse the method
> invocation.  This problem presented itself as an
> AE_AML_INTERNAL during the pass 1 parse phase during table
> load.

AE_AML_INTERNAL is the problem that I had encountered for a long time.
This fix got the problem away.

$ bzcat docs/dmesg/dmesg-2.4.20-ac1-acpi.log.bz2 |grep -i ACPI
 BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
 BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f7450
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0fefb725
ACPI: FADT (v002 MATBIO CFA3-1   01540.00000) @ 0x0fefef54
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0fefefd8
ACPI: DSDT (v001 MATBIO   CFA3-1 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Subsystem revision 20021205
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully acquired
ACPI Namespace successfully loaded at root c02fe13c
evxfevnt-0074 [04] Acpi_enable           : Transition to ACPI mode successful
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 10, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs *9)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
pci_bind-0194 [10] acpi_pci_bind         : Device 00:00:09.00 not present in PCI namespace
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BATA] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [TZC] (59 C)
 pci_irq-0297 [09] acpi_pci_irq_derive   : Unable to derive IRQ for device 01:00.2

Regards,

Hiroshi Takekawa <sian-whu2oojL+5h4Eiagz67IpQ@public.gmane.org>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
