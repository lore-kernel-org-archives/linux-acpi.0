From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problem with resuming ATI SATA on HPC nx6325
Date: Wed, 6 Sep 2006 12:42:05 +0200
Message-ID: <20060906104205.GE4987@atrey.karlin.mff.cuni.cz>
References: <200609041332.19780.rjw@sisk.pl> <20060905062438.GD1958@elf.ucw.cz> <200609051338.35059.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12175 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750734AbWIFKmA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Sep 2006 06:42:00 -0400
Content-Disposition: inline
In-Reply-To: <200609051338.35059.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi!

> Now, the output of /proc/interrupts with everything loaded is
> 
>            CPU0       CPU1       
>   0:     511683          0  local-APIC-edge  timer
>   1:       6164          0    IO-APIC-edge  i8042
>   8:          0          0    IO-APIC-edge  rtc
>  12:        148          0    IO-APIC-edge  i8042
>  14:      18053          0    IO-APIC-edge  ide0
> 169:        140          0   IO-APIC-level  acpi
> 177:          4          0   IO-APIC-level  yenta, ohci1394, sdhci:slot0
> 217:      48306          0   IO-APIC-level  libata, HDA Intel
> 225:      22528          0   IO-APIC-level  ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
> 233:      30024          0   IO-APIC-level  eth0
> NMI:        682       1125 
> LOC:     511687     511654 
> ERR:          0
> MIS:          0
> 
> so it looks like the problems are related to the drivers of interrupt vectors
> above 14.  However, powernow_k8 doesn't seem to fit.

Its possible that pn_k8 has some separate problem...

> 3) when it breaks, the kernel reports:
> 
> sd 0:0:0:0 SCSI error, return code = 0x00070000
> end_request: I/O error, dev sda, sector <sector_number>
> lost page write due to I/O error on sda
> 
> for each sector that is attempted to be read from/written to.  Interestingly
> enough, when this happens, the other devices seem to work (eg. the tg3 driver
> evidently works).

That actually points to interrupt problems.

> I'm attaching the output of dmesg after a fresh boot (I think I'll create a
> bugzilla entry and put all of the information in there).

Yes please. Big question is who to assign it to...
									Pavel

-- 
Thanks, Sharp!
