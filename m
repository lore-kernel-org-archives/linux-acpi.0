From: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: 2.6.21-rc7-mm2 -- gnome-power-manager always shows the power as coming from AC
Date: Thu, 26 Apr 2007 15:52:33 -0700
Message-ID: <a44ae5cd0704261552o20e01dabsdac02dfd7c28f16a@mail.gmail.com>
References: <a44ae5cd0704261213o37944b46u5dbdd231fc6a2490@mail.gmail.com>
	 <20070426142824.9da91feb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755183AbXDZWwi@vger.kernel.org>
In-Reply-To: <20070426142824.9da91feb.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 4/26/07, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 26 Apr 2007 12:13:00 -0700 "Miles Lane" <miles.lane@gmail.com> wrote:
>
> > One possible issue is that /proc/acpi/power_resource/ is an empty directory.
> > Otherwise, the ACPI information seems to be fine:
> >
> > # cat /proc/acpi/ac_adapter/ACAD/state
> > state:                   on-line
> > # cat /proc/acpi/ac_adapter/ACAD/state
> > state:                   off-line
> >
> > # cat /proc/acpi/battery/BAT0/state
> > present:                 yes
> > capacity state:          ok
> > charging state:          discharging
> > present rate:            0 mA
> > remaining capacity:      7072 mAh
> > present voltage:         12487 mV
> >
> > When I unplug the power cable, /proc/acpi/battery/BAT0/state (present
> > rate) shows that current flowing from the battery.
> >
> > # cat /proc/acpi/button/lid/LID0/state
> > state:      closed
> > # cat /proc/acpi/button/lid/LID0/state
> > state:      open
>
> hm, I'm looking suspiciously at "ACPI: Cache battery status instead of
> re-evaluating AML".
>
> What sort of machine is this?

HP Pavilion dv1240us

00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82852/855GM
Integrated Graphics Device (rev 02)
00:02.1 Display controller: Intel Corporation 82852/855GM Integrated
Graphics Device (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface
Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 03)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 03)
01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
01:06.0 Network controller: Intel Corporation PRO/Wireless 2200BG
Network Connection (rev 05)
01:09.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
01:09.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE
1394 Host Controller
01:09.3 Mass storage controller: Texas Instruments PCIxx21 Integrated
FlashMedia Controller
01:09.4 Generic system peripheral [0805]: Texas Instruments
PCI6411/6421/6611/6621/7411/7421/7611/7621 Secure Digital Controller
