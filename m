From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / device_sysfs: Leave modalias empty for devices
 which are not present
Date: Fri, 17 Nov 2017 16:09:04 +0200
Message-ID: <20171117140904.GH17200@lahna.fi.intel.com>
References: <20171015192449.16035-1-hdegoede@redhat.com>
 <CAJZ5v0hAx_-OUQNBngScNKHstZhZ42A42LwcBOFhR2g5pCFXOA@mail.gmail.com>
 <2550330b-38ff-28b1-6294-d55462c03cca@redhat.com>
 <2395808.6y9gh4NH3i@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:3230 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756904AbdKQORu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 09:17:50 -0500
Content-Disposition: inline
In-Reply-To: <2395808.6y9gh4NH3i@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Fri, Nov 17, 2017 at 02:42:44PM +0100, Rafael J. Wysocki wrote:
> [+Mika & Andy]
> 
> On Monday, October 16, 2017 1:44:40 PM CET Hans de Goede wrote:
> > Hi,
> > 
> > On 16-10-17 01:47, Rafael J. Wysocki wrote:
> > > On Sun, Oct 15, 2017 at 9:24 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > >> Most Bay and Cherry Trail devices use a generic DSDT with all possible
> > >> peripheral devices present in the DSDT, with their _STA returning 0x00 or
> > >> 0x0f based on AML variables which describe what is actually present on
> > >> the board.
> > >>
> > >> Since ACPI device objects with a 0x00 status (not present) still get an
> > >> entry under /sys/bus/acpi/devices, and those entry had an acpi:PNPID
> > >> modalias, userspace would end up loading modules for non present hardware.
> > >>
> > >> This commit fixes this by leaving the modalias empty for non present
> > >> devices. This results in 10 modules less being loaded with a generic
> > >> distro kernel config on my Cherry Trail test-device (a GPD pocket).
> > > 
> > > Well, what about hotplug?
> > > 
> > > On some systems _STA may change from 0 to nonzero for some devices, so
> > > what's going to happen to the modalias then?
> > 
> > A good question. I would expect a change uevent to be generated in
> > this case and when the device has become present in this new uvent the
> > modalias will no longer be empty and the module will get loaded, so
> > the module will not get loaded until the actual hotplug.
> > 
> > The actual generation of this uevent should be done by the various
> > subsystems based on ACPI_RECONFIG_DEVICE_ADD messages, at which point
> > adev->status is already updated and then when the subsys calls
> > acpi_device_uevent_modalias() for the new uevent it will return a
> > non-empty modalias.
> 
> Mika, I need your input here.
> 
> I have to say I'm not quite sure about possible implications of this change,
> what do you think?

I think this could work because we are actually interested in physical
Linux devices, not the struct acpi_device things. So to my understanding
whenever _STA of an ACPI device goes from 0x0 to 0xf the corresponding
physical device (platform, spi, i2c) gets created. Userspace is then
notified by a uevent and it then reads attributes including updated
modalias of that physical device.
