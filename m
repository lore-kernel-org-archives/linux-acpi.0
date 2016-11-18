From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Unable to use iTCO watchdog on Broadwell SOC:
Date: Fri, 18 Nov 2016 22:26:19 +0100
Message-ID: <5145970.FrABMDTXiu@vostro.rjw.lan>
References: <CAHex0coy_mgDHi8N7UbAsWP5XLWhTAMK+JRkF1KMj7w=y5sbpw@mail.gmail.com> <CAHex0cpzrVeKft6yB+4kphyi7jnOwrk7PERvDRgag7wp3ZbsKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44854 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752421AbcKRVSm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Nov 2016 16:18:42 -0500
In-Reply-To: <CAHex0cpzrVeKft6yB+4kphyi7jnOwrk7PERvDRgag7wp3ZbsKA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Friday, November 18, 2016 03:05:53 PM Jonathan Nicklin wrote:
> Hello again,
> 
> We have confirmed with the board manufacturer that the TOC watchdog
> was actually disabled via hardware. We have since modified the
> hardware and successfully initialized the TOC watchdog on a Broadwell
> SOC. Our immediate issue was not a software / driver issue. That said,
> we have yet to hear back from SuperMicro regarding their boards.

On some boards you may need to use the WDAT-based watchdog driver
introduced by commit 058dfc767008 (ACPI / watchdog: Add support for WDAT
hardware watchdog).

Thanks,
Rafael


> On Wed, Nov 16, 2016 at 11:08 AM, Jonathan Nicklin
> <jnicklin@blockbridge.com> wrote:
> > Hi Everyone,
> >
> > We have a number of systems that fail to initialize the iTCO watchdog
> > with “unable to reset NO_REBOOT flag, device disabled by
> > hardware/BIOS”. The systems include Broadwell SOC, Haswell w/ C222,
> > and Ivy Bridge w/ C600/X79. These systems have different BIOS
> > vendors/versions. We have tested with a few different kernel versions
> > as recent as 4.4. We have only managed successfully configure the iTCO
> > watchdog on a Haswell w/ C610/X99 system.
> >
> > Has anyone successfully used the iTCO watchdog on a Broadwell
> > Xeon-D/SOC system? Can anyone provide advice on how to debug this
> > issue?
> >
> > Thanks,
> > -Jonathan
> >
> > # uname -a
> > Linux soc 4.4.23-1.el7.elrepo.x86_64 #1 SMP Fri Sep 30 09:11:50 EDT
> > 2016 x86_64 x86_64 x86_64 GNU/Linux
> >
> > # dmesg | grep iTCO
> > [   18.544987] iTCO_vendor_support: vendor-support=0
> > [   18.549213] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> > [   18.549245] iTCO_wdt: unable to reset NO_REBOOT flag, device
> > disabled by hardware/BIOS
> >
> > # find /sys/devices | grep iTCO
> > /sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto
> > /sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/power
> > /sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/power/control
> > /sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/power/runtime_active_time
> > /sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/power/autosuspend_delay_ms
> > /sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/power/runtime_status
> > /sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/power/runtime_suspended_time
> > /sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/driver_override
> > /sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/modalias
> > /sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/subsystem
> > /sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/uevent
> > /sys/devices/pci0000:00/0000:00:1f.0/iTCO_wdt.0.auto/firmware_node
> --

