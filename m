From: Thomas Kosch <t.kosch-FfjHXTYIe3sI54nVjq4dGti2O/JbrIOy@public.gmane.org>
Subject: Report Toshiba Satellite300-214
Date: Mon, 03 Mar 2003 18:56:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <microsoft-free.m3k7fg49lq.fsf@grisu.schuckeduster.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-Message-Id: <200303031830.h23IUMxJ003283-8A2TNqV3M4oBScXL0D1mPSXhvhbocSXeYPYVAmT7z5s@public.gmane.org>
Resent-To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
i wuold like to give you an report for my satellite3000-214. I use the
latest patch with Brunos dsdt, SuSEs TIOCGDEV-patch, packet writing
patch and SuSEs boot-splash patch.

First, it works great. Second, the report.

,----
| tom@gryffindor:~> dmesg | grep ACPI
|  BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
|  BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
| ACPI: have wakeup address 0xc0001000
| ACPI: RSDP (v000 TOSCPL                     ) @ 0x000f7020
| ACPI: RSDT (v001 TOSCPL   RSDT   01540.00000) @ 0x0fef99c1
| ACPI: FADT (v001 TOSCPL 888M2    01540.00000) @ 0x0fefef8c
| ACPI: DSDT (v001 TOSCPL ALMADOR  01540.00000) @ 0x00000000
| ACPI: BIOS passes blacklist
| ACPI: Subsystem revision 20030122
|     ACPI-0273: *** Info: Table [DSDT] replaced by host OS
|     ACPI-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
|     ACPI-0262: *** Info: GPE Block1 defined as GPE16 to GPE31
| ACPI: Interpreter enabled
| ACPI: Using PIC for interrupt routing
| ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
| ACPI: PCI Root Bridge [PCI0] (00:00)
| ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
| ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
| ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
| ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
| ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
| ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
| ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12 14 15)
| ACPI: Embedded Controller [EC0] (gpe 28)
| PCI: Using ACPI for IRQ routing
| ACPI: AC Adapter [ACAD] (off-line)
| ACPI: Battery Slot [BAT1] (battery present)
| ACPI: Battery Slot [BAT2] (battery present)
`----

? I have only one battery.

,----
| ACPI: Power Button (FF) [PWRF]
| ACPI: Lid Switch [LID]
| ACPI: Processor [CPU0] (supports C1 C2 C3, 2 performance states)
| ACPI: Thermal Zone [THM0] (44 C)
`----

Sometimes i get an
,----
| Mar  3 14:52:18 gryffindor kernel:     ACPI-0322: *** Error: Handler for
|      [embedded_control] returned AE_TIME=20
| Mar  3 14:52:18 gryffindor kernel:     ACPI-1102: *** Error: Method
|      execution failed [\_SB_.PCI0.LPCB.THM0._TMP] (Node c12d02c0), AE_TIM=
E=20
`----
or
,----
| Mar  2 02:24:22 gryffindor kernel:     ACPI-0322: *** Error: Handler for
|      [embedded_control] returned AE_TIME=20
| Mar  2 02:24:22 gryffindor kernel:     ACPI-1102: *** Error: Method
|      execution failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node c12d1f60), AE_TIME
`----
in the syslog.

The S1 sleep works but i must reload the ide-scsi module, without the
machine hangs on the first access.

The present rate is always 0.
,----
| gryffindor:/proc/acpi # cat battery/BAT1/state
| present:                 yes
| capacity state:          ok
| charging state:          discharging
| present rate:            0 mA
| remaining capacity:      2760 mAh
| present voltage:         14800 mV
| gryffindor:/proc/acpi #
`----

The prozessor is alway in C2 state
,----
| gryffindor:/proc/acpi # cat processor/CPU0/power
| active state:            C2
| default state:           C1
| bus master activity:     ffffffff
| states:
|     C1:                  promotion[C2] demotion[--] latency[000] usage[00=
005860]
|    *C2:                  promotion[C3] demotion[C1] latency[010] usage[00=
477940]
|     C3:                  promotion[--] demotion[C2] latency[100] usage[00=
000000]
| gryffindor:/proc/acpi #
`----

Why is there no throttling support?
,----
| gryffindor:/proc/acpi # cat processor/CPU0/info
| processor id:            0
| acpi id:                 0
| bus mastering control:   yes
| power management:        yes
| throttling control:      no
| performance management:  yes
| limit interface:         yes
`----
=20

ttyler, t.k.

=2D-=20
Das Internet wurde geschaffen um auch nach einem Atomschlag die weltweite V=
er-
sorgung mit Fickelbildchen, Warez und MP3-Dateien sicherzustellen. Bill Gat=
es
hat es erfunden und heute wird es von AOL exklusiv vertrieben. Das zugrunde=
lie-
gende Prinzip hei=DFt Fido, benannt nach Boris Beckers Hund. (HG Bickel in =
dafu-l)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
