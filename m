From: "Josue Resende" <josue.resende@gmail.com>
Subject: Re: Please send dmidecode to linux-acpi@vger.kernel.org - Compal HEL8X
Date: Sun, 27 Jan 2008 10:11:57 -0200
Message-ID: <620719eb0801270411t47bfe6d3h97e4be95eea5654d@mail.gmail.com>
References: <620719eb0711040521v5503be45y1c06d725fa348b87@mail.gmail.com>
	 <200801190005.38246.lenb@kernel.org>
	 <620719eb0801191342w2acdfbafs6422853c5e6767f0@mail.gmail.com>
	 <200801210025.04430.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:50343 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbYA0MMB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Jan 2008 07:12:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2324290wah.23
        for <linux-acpi@vger.kernel.org>; Sun, 27 Jan 2008 04:11:58 -0800 (PST)
In-Reply-To: <200801210025.04430.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

[    0.000000] Kernel command line:
root=UUID=1bc00e49-e21a-47fc-8641-fbd7b557f8dd ro acpi_osi=!Linux
==> /proc/acpi/ac_adapter <==

==> /proc/acpi/alarm <==
2008-01-00 00:38:15

==> /proc/acpi/battery <==

==> /proc/acpi/button <==

==> /proc/acpi/embedded_controller <==

==> /proc/acpi/fan <==

==> /proc/acpi/info <==
version:                 20070126

==> /proc/acpi/power_resource <==

==> /proc/acpi/processor <==

==> /proc/acpi/sleep <==
S0 S3 S4 S5

==> /proc/acpi/thermal_zone <==

==> /proc/acpi/video <==

==> /proc/acpi/wakeup <==
Device	S-state	  Status   Sysfs node
HDEF	  S4	 disabled  pci:0000:00:1b.0
PXS3	  S5	 disabled  pci:0000:04:00.0
LANC	  S0	 disabled
MODM	  S3	 disabled
state:                   off-line
==> /proc/acpi/battery/BAT1/alarm <==
alarm:                   unsupported

==> /proc/acpi/battery/BAT1/info <==
present:                 yes
design capacity:         4800 mAh
last full capacity:      3732 mAh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 373 mAh
design capacity low:     113 mAh
capacity granularity 1:  264 mAh
capacity granularity 2:  3780 mAh
model number:            HEL8X000
serial number:           3041
battery type:            Li-Ion
OEM info:                LIBP

==> /proc/acpi/battery/BAT1/state <==
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            1519 mA
remaining capacity:      426 mAh
present voltage:         10821 mV


[    0.000000] Kernel command line:
root=UUID=1bc00e49-e21a-47fc-8641-fbd7b557f8dd ro acpi_osi=Linux
==> /proc/acpi/ac_adapter <==

==> /proc/acpi/alarm <==
2008-01-00 00:38:15

==> /proc/acpi/battery <==

==> /proc/acpi/button <==

==> /proc/acpi/embedded_controller <==

==> /proc/acpi/fan <==

==> /proc/acpi/info <==
version:                 20070126

==> /proc/acpi/power_resource <==

==> /proc/acpi/processor <==

==> /proc/acpi/sleep <==
S0 S3 S4 S5

==> /proc/acpi/thermal_zone <==

==> /proc/acpi/video <==

==> /proc/acpi/wakeup <==
Device	S-state	  Status   Sysfs node
HDEF	  S4	 disabled  pci:0000:00:1b.0
PXS3	  S5	 disabled  pci:0000:04:00.0
LANC	  S0	 disabled
MODM	  S3	 disabled
state:                   off-line
==> /proc/acpi/battery/BAT1/alarm <==
alarm:                   unsupported

==> /proc/acpi/battery/BAT1/info <==
present:                 yes
design capacity:         4800 mAh
last full capacity:      3732 mAh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 373 mAh
design capacity low:     113 mAh
capacity granularity 1:  264 mAh
capacity granularity 2:  3780 mAh
model number:            HEL8X000
serial number:           3041
battery type:            Li-Ion
OEM info:                LIBP

==> /proc/acpi/battery/BAT1/state <==
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            1439 mA
remaining capacity:      338 mAh
present voltage:         10819 mV

2008/1/21, Len Brown <lenb@kernel.org>:
> On Saturday 19 January 2008 16:42, Josue Resende wrote:
>
> > 2008/1/19, Len Brown <lenb@kernel.org>:
> > > On Sunday 04 November 2007 08:21, Josue Resende wrote:
> > > > System Information
> > > > Manufacturer: COMPAL
> > > > Product Name: HEL81I
> > > > Version: *
> > > > Serial Number: 2057336701224
> > > > UUID: 5D703279-5869-11DB-9D7E-0016D457FA87
> > > > Wake-up Type: Power Switch
> > > > SKU Number: Not Specified
> > > > Family: Not Specified
> > > >
> > > > Handle 0x0002, DMI type 2, 8 bytes
> > > > Base Board Information
> > > > Manufacturer: COMPAL
> > > > Product Name: HEL8X
>
> thanks for the acpidump
>
> Please verify that your battery information and AC/DC
> transitions are properly reported in /proc/acpi/
> both with and without acpi_osi=Linux
>
> -Len
> -------------
>
>     Name (ECDY, 0x05)
> ...
>            If (CondRefOf (_OSI, Local0))
>             {
>                 If (_OSI ("Linux"))
>                 {
>                     Store (0x03E8, OSYS)
> ## setting OSYS is a NOP, since it gets overwritten
>                     Store (Zero, ECDY)
> ## clearing ECDY may have implications in wakeup,
> ## battery, and some ACPI general purpose events
>                 }
>
>                 If (_OSI ("Windows 2001"))
>                 {
>                     Store (0x07D1, OSYS)
>
