From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Sys backlight is empty since landing of "ACPI / PCI: Make PCI root driver use struct acpi_scan_handler"
Date: Thu, 27 Jun 2013 14:18 +0200
Message-ID: <8927254.OY0MsSb7nL@vostro.rjw.lan>
References: <117469492.1598370.1372275060043.JavaMail.root@qzdev.se> <51CB97A9.30704@intel.com> <1009903920.1599574.1372311606171.JavaMail.root@qzdev.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:53189 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199Ab3F0MIa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jun 2013 08:08:30 -0400
In-Reply-To: <1009903920.1599574.1372311606171.JavaMail.root@qzdev.se>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cork <kernel@box.qzdev.se>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org

On Thursday, June 27, 2013 05:40:06 AM Cork wrote:
> Yes, 3.10.0-rc6 fixes the problem (sorry for not checking this before contacting you).

OK, great!

Thanks,
Rafael


> Rafael:
> 3.8:      /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:18/LNXVIDEO:00
> 3.9:      /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:18/LNXVIDEO:00
> 3.10-rc6: /sys/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:19/LNXVIDEO:00
> 
> // Cork
> 
> ----- Original Message -----
> > From: "Aaron Lu" <aaron.lu@intel.com>
> > To: "Rafael J. Wysocki" <rjw@sisk.pl>, "Cork" <kernel@box.qzdev.se>
> > Cc: linux-acpi@vger.kernel.org
> > Sent: Thursday, 27 June, 2013 3:38:49 AM
> > Subject: Re: Sys backlight is empty since landing of "ACPI / PCI: Make PCI root driver use struct acpi_scan_handler"
> > 
> > On 06/27/2013 06:08 AM, Rafael J. Wysocki wrote:
> > > On Wednesday, June 26, 2013 08:38:49 PM Cork wrote:
> > >> // Cork
> > > 
> > > OK, thanks.
> > > 
> > > The initialization ordering obviously changed in 3.9 and the ACPI
> > > video
> > > driver fails to find your backlight device.
> > > 
> > > Can you please tell me what the output of
> > > 
> > > $ find /sys/devices/ -name LNXVIDEO\*
> > > 
> > > is on your system in 3.9 and 3.8?
> > 
> > This should be the same problem as bug 58091, where one of the
> > reporter
> > is using a similar system Clevo_P150HMx. And I've checked the ACPI
> > dump
> > of Cork's system, there is also a _ROM method under PCI0.
> > 
> > Cork,
> > Possible to test v3.10-rc6 or later kernels? There is a fix for your
> > problem, thanks.
> > 
> > Reference: https://bugzilla.kernel.org/show_bug.cgi?id=58091
> > 
> > -Aaron
> > 
> > > 
> > > Rafael
> > > 
> > > 
> > >>
> > >> ----- Original Message -----
> > >>> From: "Rafael J. Wysocki" <rjw@sisk.pl>
> > >>> To: "Cork" <kernel@box.qzdev.se>
> > >>> Cc: linux-acpi@vger.kernel.org, "Aaron Lu" <aaron.lu@intel.com>
> > >>> Sent: Wednesday, 26 June, 2013 10:05:38 PM
> > >>> Subject: Re: Sys backlight is empty since landing of "ACPI / PCI:
> > >>> Make PCI root driver use struct acpi_scan_handler"
> > >>>
> > >>> On Wednesday, June 26, 2013 09:52:46 PM Rafael J. Wysocki wrote:
> > >>>> On Wednesday, June 26, 2013 07:31:00 PM Cork wrote:
> > >>>>> Hello. This is my first time sending a report like this, so
> > >>>>> please excuse me if I'm missing some vital information.
> > >>>>>
> > >>>>> From updating the kernel in Arch linux to 3.9 the brightness
> > >>>>> controls stopped working on my Clevo P0150HM. I have tried the
> > >>>>> acpi_backlight=vendor boot parameter but it makes no
> > >>>>> difference.
> > >>>>>
> > >>>>> While researching this problem I've found that
> > >>>>> /sys/class/backlight is empty in the versions where the buttons
> > >>>>> isn't working. Bisecting points to
> > >>>>> 00c43b9682507dc622c03172fde1032e2a216e9d [1] as the first
> > >>>>> commit
> > >>>>> showing the symptoms.
> > >>>>>
> > >>>>> Attached is the output from journalctl -b _TRANSFORM=kernel for
> > >>>>> the two versions. Not sure what other useful information I can
> > >>>>> provide apart from that, so please direct me if there is
> > >>>>> something missing.
> > >>>>>
> > >>>>> [1]
> > >>>>> https://github.com/torvalds/linux/commit/00c43b9682507dc622c03172fde1032e2a216e9d
> > >>>>
> > >>>> Interesting.
> > >>>>
> > >>>> Please send the output of acpidump from your machine.
> > >>>
> > >>> Also please put initcall_debug into the kernel command line and
> > >>> send
> > >>> dmesg from
> > >>> the working and not working kernels with that.
> > >>>
> > >>> Thanks,
> > >>> Rafael
> > >>>
> > >>>
> > >>> --
> > >>> I speak only for myself.
> > >>> Rafael J. Wysocki, Intel Open Source Technology Center.
> > >>>
> > 
> > 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
