From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] Introduce GPE refcounting (was: Re: Recent GPE patches - some questions.)
Date: Sun, 14 Feb 2010 03:24:17 +0100
Message-ID: <201002140324.17650.rjw@sisk.pl>
References: <4911F71203A09E4D9981D27F9D83085855AF782E@orsmsx503.amr.corp.intel.com> <201002112134.27386.rjw@sisk.pl> <1266077283.25058.1.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58385 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134Ab0BNCXq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Feb 2010 21:23:46 -0500
In-Reply-To: <1266077283.25058.1.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Saturday 13 February 2010, Maxim Levitsky wrote:
> On Thu, 2010-02-11 at 21:34 +0100, Rafael J. Wysocki wrote: 
> > On Thursday 11 February 2010, Maxim Levitsky wrote:
> > > On Wed, 2010-02-10 at 22:36 +0100, Rafael J. Wysocki wrote: 
> > > > On Wednesday 10 February 2010, Maxim Levitsky wrote:
> > > > > On Sun, 2010-02-07 at 03:17 +0100, Rafael J. Wysocki wrote: 
> > > > > > On Sunday 07 February 2010, Rafael J. Wysocki wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On Wednesday 03 February 2010, Moore, Robert wrote:
> > > > > > > > Matthew, 
> > > > > > > > 
> > > > > > > > Thanks for your response to my questions.
> > > > > > > > 
> > > > > > > > I've been thinking about these interfaces:
> > > > > > > > 
> > > > > > > > acpi_ref_runtime_gpe
> > > > > > > > acpi_ref_wakeup_gpe
> > > > > > > > acpi_unref_runtime_gpe
> > > > > > > > acpi_unref_wakeup_gpe
> > > > > > > > 
> > > > > 
> > > > > One minor, mostly off-topic question.
> > > > > Currently to enable static wakeup one has to write /proc/acpi/wakeup.
> > > > 
> > > > That depends on the device.  For PCI devices there's another interface for
> > > > that, which is /sys/devices/.../power/wakeup .
> > > > 
> > > > > Do you consider propagating device wakeup settings to acpi,
> > > > > so /proc/acpi/wakeup could finally be deprecated?
> > > > 
> > > > We already do that for PCI devices.
> > > 
> > > Not in 2.6.33-rc6
> > > 
> > > maxim@maxim-laptop:~$ cat /proc/acpi/wakeup 
> > > Device S-state   Status   Sysfs node
> > > UHC1   S3 disabled  pci:0000:00:1d.0
> > > UHC2   S3 disabled  pci:0000:00:1d.1
> > > UHC3   S3 disabled  pci:0000:00:1d.2
> > > UHC4   S3 disabled  pci:0000:00:1a.0
> > > UHC5   S3 disabled  pci:0000:00:1a.1
> > > EHC1   S3 disabled  pci:0000:00:1d.7
> > > EHC2   S3 disabled  pci:0000:00:1a.7
> > > EXP3   S4 disabled  pci:0000:00:1c.2
> > > EXP5   S4 disabled  
> > > EXP6   S4 disabled  
> > > AZAL   S4 disabled  pci:0000:00:1b.0
> > > MODM   S4 disabled  
> > > 
> > > maxim@maxim-laptop:~$ echo enabled | sudo tee  /sys/devices/pci0000
> > > \:00/0000\:00\:1d.0/power/wakeup 
> > > enabled
> > > 
> > > cat /sys/devices/pci0000\:00/0000\:00\:1d.0/power/wakeup enabled
> > > 
> > > 
> > > maxim@maxim-laptop:~$ cat /proc/acpi/wakeup 
> > > Device S-state   Status   Sysfs node
> > > UHC1   S3 disabled  pci:0000:00:1d.0
> > > UHC2   S3 disabled  pci:0000:00:1d.1
> > > UHC3   S3 disabled  pci:0000:00:1d.2
> > > UHC4   S3 disabled  pci:0000:00:1a.0
> > > UHC5   S3 disabled  pci:0000:00:1a.1
> > > EHC1   S3 disabled  pci:0000:00:1d.7
> > > EHC2   S3 disabled  pci:0000:00:1a.7
> > > EXP3   S4 disabled  pci:0000:00:1c.2
> > > EXP5   S4 disabled  
> > > EXP6   S4 disabled  
> > > AZAL   S4 disabled  pci:0000:00:1b.0
> > > MODM   S4 disabled  
> > > 
> > > 
> > > Or am I mistaken somehow?
> > 
> > You are.  Please ignore the "Status" column in /proc/acpi/wakeup, it shows
> > the value of a flag that's not used for PCI devices (unless you set it via
> > /proc/acpi/wakeup
> 
> It is indeed true.
> 
> PnP device too are supported in this way?

I don't know really.

> Then I think it would be very nice to remove all pci and pnp devices
> from this list to avoid confusion.

I wouldn't do that, because it allows us to see easily which devices are seen
by ACPI as wakeup-capable.  Perhaps the format of the file may be changed,
though.

Rafael
