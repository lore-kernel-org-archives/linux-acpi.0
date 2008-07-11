From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 6/8] PCI ACPI: Rework PCI handling of wake-up (rev. 5)
Date: Fri, 11 Jul 2008 22:30:33 +0200
Message-ID: <20080711203033.GB6843@elf.ucw.cz>
References: <200807012356.26669.rjw@sisk.pl> <200807070330.02849.rjw@sisk.pl> <200807070334.48957.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41131 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYGKUaF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jul 2008 16:30:05 -0400
Content-Disposition: inline
In-Reply-To: <200807070334.48957.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

On Mon 2008-07-07 03:34:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> PCI ACPI: Rework PCI handling of wake-up (rev. 5)
> 
> * Introduce function acpi_pm_device_sleep_wake() for enabling and
>   disabling the system wake-up capability of devices that are power
>   manageable by ACPI.
> 
> * Introduce function acpi_bus_can_wakeup() allowing other (dependent)
>   subsystems to check if ACPI is able to enable the system wake-up
>   capability of given device.
> 
> * Introduce callback .sleep_wake() in struct pci_platform_pm_ops and
>   for the ACPI PCI 'driver' make it use acpi_pm_device_sleep_wake().
> 
> * Introduce callback .can_wakeup() in struct pci_platform_pm_ops and
>   for the ACPI 'driver' make it use acpi_bus_can_wakeup().
> 
> * Move the PME# handlig code out of pci_enable_wake() and split it
>   into two functions, pci_pme_capable() and pci_pme_active(),
>   allowing the caller to check if given device is capable of
>   generating PME# from given power state and to enable/disable the
>   device's PME# functionality, respectively.
> 
> * Modify pci_enable_wake() to use the new ACPI callbacks and the new
>   PME#-related functions.
> 
> * Drop the generic .platform_enable_wakeup() callback that is not
>   used any more.
> 
> * Introduce device_set_wakeup_capable() that will set the
>   power.can_wakeup flag of given device.
> 
> * Rework PCI device PM initialization so that, if given device is
>   capable of generating wake-up events, either natively through the
>   PME# mechanism, or with the help of the platform, its
>   power.can_wakeup flag is set and its power.should_wakeup flag is
>   unset as appropriate.
> 
> * Make ACPI set the power.can_wakeup flag for devices found to be
>   wake-up capable by it.
> 
> * Make the ACPI wake-up code enable/disable GPEs for devices that
>   have the wakeup.flags.prepared flag set (which means that their
>   wake-up power has been enabled).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looks ok to me.

ACK.
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
