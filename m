From: =?ISO-8859-1?Q?David_G=F3mez?= <david-0d+f1cuTMnnk1uMJSBkQmQ@public.gmane.org>
Subject: Battery information not showed
Date: Fri, 03 Sep 2004 17:58:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <413894AE.3080701@pleyades.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060007000606000708040307"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

This is a multi-part message in MIME format.
--------------060007000606000708040307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'm trying to configure ACPI in my laptop, and it seems to work (acpid
get power button, lid, sleep events). But not all the info is displayed
in /proc/acpi. Mainly i'm interested in battery (or i'll never know when
it runs out of stuff ;)). For instance, acpi command only shows thermal
information:

[huma@miller] [~] % acpi -V
      Thermal 1: ok, 55.0 degrees C
[huma@miller] [~] %

And /proc/acpi/battery has no files inside it

Laptop is and Acer Travelmate 4001LMi.

Attached is the output of dmesg| grep ACPI. As i suppose for other
people posts to the list, it should detect the battery and ac-adapter at
boot, but it seems to be able to 'see' only fans, thermal and buttons
information.

Thanks in advance






--------------060007000606000708040307
Content-Type: text/x-log;
 name="acpi.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi.log"

 BIOS-e820: 000000001eee0000 - 000000001eeec000 (ACPI data)
 BIOS-e820: 000000001eeec000 - 000000001ef00000 (ACPI NVS)
ACPI: RSDP (v000 ACER                                      ) @ 0x000f62e0
ACPI: RSDT (v001 ACER   Kestrel  0x20020707  LTP 0x00000000) @ 0x1eee6708
ACPI: FADT (v001 ACER   Kestrel  0x20020707 PTL  0x00000050) @ 0x1eeebf2c
ACPI: HPET (v001 ACER   Kestrel  0x20020707 PTL  0x00000000) @ 0x1eeebfa0
ACPI: BOOT (v001 ACER   Kestrel  0x20020707  LTP 0x00000001) @ 0x1eeebfd8
ACPI: DSDT (v001 ACER   Kestrel  0x20020707 MSFT 0x0100000e) @ 0x00000000
ACPI: HPET id: 0x8086a201 base: 0x0
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
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
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 6 (level, low) -> IRQ 6
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
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:06.2[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:06.3[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (35 C)
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: (supports S0 S3 S4 S5)
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:06.2[A] -> GSI 10 (level, low) -> IRQ 10


--------------060007000606000708040307--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
