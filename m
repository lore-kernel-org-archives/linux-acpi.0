From: Magnus Sandberg <mem-P9zfqOBuU5vLoDKTGw+V6w@public.gmane.org>
Subject: FSC Amilo M-3438G
Date: Thu, 12 Jan 2006 10:21:18 +0100
Message-ID: <20060112092118.84F211C812@debian.datakon.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mem-P9zfqOBuU5vLoDKTGw+V6w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm new to this list and I have just got a Fujitsu-Siemens Amilo M-3438G 
which I'm installing Debian on.

I have some problems with ACPI on the machine. The problems I have found so 
far is that;
- I don't get any events when the battery is discharged or running low
- The lid button only reports close events so the lid-state is always
  "closed"
- I don't know if "Fn"-keys should be reported via ACPI or not?
  I only get the "sleep mode" Fn-key event, no other Fn-keys.
- I don't get events for "special hot keys" like "silent mode", etc
  (The Amilo M3438 has 4 hot keys above the Fn-keys)

Things that do work;
- Power button generate event
- I get events for AC, CPU and BAT when I add or remove AC-adator
- As mentioned above Fn-key for sleep button works
- I can read battery state and battery info. Remaining capacity and voltage
  seams to be okay. Remaining capacity is like 2 mAh just before the
  machine dies. Warning and low levels seams to be calculated from
  "last full capacity", I don't know if that is the way it should be done?
- Thermal Zone seams to work, get values in the range 31 C - 53 C

My questions are if I have to compile a new DSDT or if I should do 
something else to correct the problems. And what things should or can ACPI 
support (like Fn-keys or hot keys, etc)?

I changed the scripts in /etc/acpi to send all unknown events via logger to 
/var/log/messages

If I remove the AC, I get the following;

ac_adapter AC0 00000080 00000000
battery BAT0 00000080 00000001
processor CPU1 00000080 00000006

If I connect the AC, I get;

ac_adapter AC0 00000080 00000001
battery BAT0 00000080 00000001
processor CPU1 00000080 00000005


On my system I can find all ACPI related things in /var/log/kern.log.
I did a 'grep -i acpi kern.log | cut -d: -f4-12' and got the following 
output (removed dates, etc for readability);

 000000003ffd0000 - 000000003ffde000 (ACPI data)
 000000003ffde000 - 0000000040000000 (ACPI NVS)
 RSDP (v000 ACPIAM                                ) @ 0x000f8110
 RSDT (v001 A M I  OEMRSDT  0x10000505 MSFT 0x00000097) @ 0x3ffd0000
 FADT (v002 A M I  OEMFACP  0x10000505 MSFT 0x00000097) @ 0x3ffd0200
 MADT (v001 A M I  OEMAPIC  0x10000505 MSFT 0x00000097) @ 0x3ffd0390
 MCFG (v001 A M I  OEMMCFG  0x10000505 MSFT 0x00000097) @ 0x3ffd03f0
 OEMB (v001 A M I  AMI_OEM  0x10000505 MSFT 0x00000097) @ 0x3ffde040
 MCFG (v001 A M I  OEMMCFG  0x10000505 MSFT 0x00000097) @ 0x3ffd4e80
 SSDT (v001    AMI   CPU1PM 0x00000001 INTL 0x02002026) @ 0x3ffd4ec0
 DSDT (v001 UW____ F18_____ 0x00000001 INTL 0x02002026) @ 0x00000000
 PM-Timer IO Port: 0x808
 Local APIC address 0xfee00000
 LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
 IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
 INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
 INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
 IRQ0 used by override.
 IRQ2 used by override.
 IRQ9 used by override.
 2 duplicate MCFG table ignored.

 Subsystem revision 20050309
 Interpreter enabled
 Using IOAPIC for interrupt routing
 PCI Root Bridge [PCI0] (0000:00)
 PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
 Embedded Controller [EC0] (gpe 24)
 PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
 PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
 PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
 PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
 PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
 PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
 PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
 PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
 PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
 PnP ACPI init
 PnP ACPI: found 12 devices
 Disabled by ACPI PNP
 Using ACPI for IRQ routing
 PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
 PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169

 (supports S0 S3 S4 S5)
 PCI Interrupt 0000:01:07.0[A] -> GSI 16 (level, low) -> IRQ 169
 PCI Interrupt 0000:01:04.0[A] -> GSI 18 (level, low) -> IRQ 201
 PCI Interrupt 0000:01:05.0[A] -> GSI 19 (level, low) -> IRQ 209
 PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 201
 PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
 PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 217
 PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 209
 PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 201
 PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
 PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 217
 Battery Slot [BAT0] (battery present)
 AC Adapter [AC0] (off-line)
 CPU0 (power states: C1[C1] C2[C2])
 Processor [CPU1] (supports 8 throttling states)
 Power Button (FF) [PWRF]
 Lid Switch [LID]
 Sleep Button (CM) [SLPB]
 Thermal Zone [THRM] (52 C)


At some points I have got the following;
(grep Error kern.log | cut -d: -f4-12)

     ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.BAT0._BIF] 
(Node dfdc04a0), AE_TIME
     ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.BAT0._BIF] 
(Node dfdc04a0), AE_TIME
     ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.BAT0._BST] 
(Node dfdc0460), AE_TIME
     ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.BAT0._BIF] 
(Node dfdc04a0), AE_TIME
     ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
     ACPI-1138: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.EC0_._Q39] (Node dfdc05e0), AE_TIME
     ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.BAT0._BST] 
(Node dfdc0460), AE_TIME

# find /proc/acpi/
/proc/acpi/
/proc/acpi/thermal_zone
/proc/acpi/thermal_zone/THRM
/proc/acpi/thermal_zone/THRM/polling_frequency
/proc/acpi/thermal_zone/THRM/cooling_mode
/proc/acpi/thermal_zone/THRM/trip_points
/proc/acpi/thermal_zone/THRM/temperature
/proc/acpi/thermal_zone/THRM/state
/proc/acpi/fan
/proc/acpi/button
/proc/acpi/button/sleep
/proc/acpi/button/sleep/SLPB
/proc/acpi/button/sleep/SLPB/info
/proc/acpi/button/lid
/proc/acpi/button/lid/LID
/proc/acpi/button/lid/LID/state
/proc/acpi/button/lid/LID/info
/proc/acpi/button/power
/proc/acpi/button/power/PWRF
/proc/acpi/button/power/PWRF/info
/proc/acpi/processor
/proc/acpi/processor/CPU1
/proc/acpi/processor/CPU1/power
/proc/acpi/processor/CPU1/limit
/proc/acpi/processor/CPU1/throttling
/proc/acpi/processor/CPU1/info
/proc/acpi/ac_adapter
/proc/acpi/ac_adapter/AC0
/proc/acpi/ac_adapter/AC0/state
/proc/acpi/battery
/proc/acpi/battery/BAT0
/proc/acpi/battery/BAT0/alarm
/proc/acpi/battery/BAT0/state
/proc/acpi/battery/BAT0/info
/proc/acpi/wakeup
/proc/acpi/alarm
/proc/acpi/sleep
/proc/acpi/event
/proc/acpi/fadt
/proc/acpi/dsdt
/proc/acpi/info
/proc/acpi/power_resource
/proc/acpi/embedded_controller
/proc/acpi/embedded_controller/EC0
/proc/acpi/embedded_controller/EC0/info

# find /sys/firmware/acpi/
/sys/firmware/acpi/
/sys/firmware/acpi/namespace
/sys/firmware/acpi/namespace/ACPI
/sys/firmware/acpi/namespace/ACPI/_TZ
/sys/firmware/acpi/namespace/ACPI/_TZ/THRM
/sys/firmware/acpi/namespace/ACPI/_SB
/sys/firmware/acpi/namespace/ACPI/_SB/LNKH
/sys/firmware/acpi/namespace/ACPI/_SB/LNKG
/sys/firmware/acpi/namespace/ACPI/_SB/LNKF
/sys/firmware/acpi/namespace/ACPI/_SB/LNKE
/sys/firmware/acpi/namespace/ACPI/_SB/LNKD
/sys/firmware/acpi/namespace/ACPI/_SB/LNKC
/sys/firmware/acpi/namespace/ACPI/_SB/LNKB
/sys/firmware/acpi/namespace/ACPI/_SB/LNKA
/sys/firmware/acpi/namespace/ACPI/_SB/PWRB
/sys/firmware/acpi/namespace/ACPI/_SB/SLPB
/sys/firmware/acpi/namespace/ACPI/_SB/LID
/sys/firmware/acpi/namespace/ACPI/_SB/RMEM
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P2
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P2/NEWC
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P3
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P3/PEG
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P3/PEG/AMW0
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P3/PEG/DVIA
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P3/PEG/DVI
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P3/PEG/LCD
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P3/PEG/TV
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P3/PEG/CRT
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE1
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P7
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P6
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P5
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/AZC
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/MC97
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/EUSB
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB4
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB3
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB2
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/USB1
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE0
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE0/CHN1
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE0/CHN1/DRV1
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE0/CHN1/DRV0
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE0/CHN0
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE0/CHN0/DRV1
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDE0/CHN0/DRV0
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/AC0
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/BAT0
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/PCIE
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/SBRG
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/SBRG/EC0
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/SBRG/OMSC
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/SBRG/RMSC
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/SBRG/COPR
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/SBRG/SPKR
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/SBRG/PS2M
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/SBRG/PS2K
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/SBRG/RTC0
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/SBRG/TMR
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/SBRG/DMAD
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/SBRG/PIC
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P1
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P1/IE3A
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P1/LAN
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P1/RAID
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/P0P1/MPC1
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/MCH
/sys/firmware/acpi/namespace/ACPI/CPU1
/sys/firmware/acpi/namespace/ACPI/PWRF


Regards,


                                  _\\|//_
                                  (-0-0-)
                      /---------ooO-(_)-Ooo--------\
                      |       Magnus Sandberg      |
                      |   Email:  mem-P9zfqOBuU5vLoDKTGw+V6w@public.gmane.org   |
                      |   GSM:   +46-70-205 81 84  |
                      \----------------------------/
                                  ||   ||
                                 ooO   Ooo


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
