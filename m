From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC] Shutdown on thermal HOT event if no userspace tool registered being able to do S4
Date: Tue, 13 Apr 2010 10:54:52 +0200
Message-ID: <201004131054.52301.trenn@suse.de>
References: <201003301123.10711.trenn@suse.de> <1271039894.7167.113.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:55589 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351Ab0DMIxV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Apr 2010 04:53:21 -0400
In-Reply-To: <1271039894.7167.113.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Joey Lee <jlee@novell.com>, Holger Macht <hmacht@suse.de>, Rafael Wysocki <rwysocki@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Hi,

On Monday 12 April 2010 04:38:14 Zhang Rui wrote:
> On Tue, 2010-03-30 at 17:23 +0800, Thomas Renninger wrote:
> > Hi,
> > 
> > this is related to:
> > commit fa80945269f312bc609e8384302f58b03c916e12
> >     ACPI thermal: Don't invalidate thermal zone if critical trip point is bad
> > and
> > commit 8b7ef6d8f16274da42344cd50746ddb1c93c25ea
> >     ACPI thermal: Check for thermal zone requirement
> > 
> > There the critical trip point is replaced with the hot trip
> > point if latest Windows OS is detected (Vista also? I think yes,
> > but need to double check).
> > 
> > This seem to get more common and it looks like Windows suggests
> > to use hot trip points for thermal emergency shutdowns (S4).
> > It looks like the default Windows thermal emergency power off is
> > S4. Thus the hot trip point is used and the critical trip point
> > is of no use anymore (and often gets replaced or is invalid).
> > 
> > As thermal emergency shut down is something urgent there is this
> > direct call /sbin/poweroff in orderly_poweroff(true) compare with
> > kernel/sys.c and drivers/thermal/thermal_sys.c
> > This won't work in above cases when BIOS writers assume the machine
> > is shut down with _HOT already and do not provide _CRT anymore.
> > 
> > My idea is to also shutdown the system on _HOT by default,
> > the same way as done if _CRT is exceeded as long as no userspace
> > explicitly set a sysfs (only one file set by thermal_sys.c somewhere
> > in /sys?).
> > Background is that S4 needs some setup (e.g. swap) or userspace hooks
> > to make sure S4 succeeds and everything (network, whatever...) is set
> > up correctly afterwards.
> > 
> > Requirement for the userspace tool setting the "do not shutdown if a
> > hot thermal event happened" would be:
> >   - Fetch the thermal hot event
> 
> We need to introduce the notification mechanism, probably via netlink,
> if we want to do this in the thermal sysfs driver.
> 
> >   - Reliably power off the system (shutdown if S4 did not succeed)
> >   - ...
> > 
> Any then introduce another sysfs attribute for each trip point, say
> "trippoint_x_mode".
Not sure whether a policy per trip point is really needed.
  - active and passive trip points should always be handled in the kernel
    Eventually notifying userspace might make sense, not sure.
  - critical should get handled in kernel as well, the current power_off
    from kernel isn't that bad and always works.
  - Hot is difficult. S4 must get initiated from userspace, but if it fails
    or especially if you miss the package(s) handling it, your machine
    will shut off hard with eventuall data loss.
> kernel driver takes default actions when the threshold is reached when
> it's set "kernel", and takes no action if it's set "user".
> users can get the hot event via netlink and take any actions they want..
> 
> On the other hand, we can do this in ACPI thermal driver as well.
> Because
> 1. netlink event has already been supported.
> 2. we can disable the kernel action of _HOT by module parameters, say
> thermal.hot=on(default, s4 or shutdown in kernel)/off(no action, no
> events)/ignore(no action, but still sends events to userspace).
> 
> we don't have any notification mechanism in the thermal sys driver
> currently. 
> So If we want to do this in the generic thermal driver, we need to
> introduce the
This was just a heads up, that critical thermal shut downs may not work
with some (a lot?) recent laptops.
IMO it's still not "that" urgent. You could get (more) data loss if your system
is switched off hard, than shut down properly (or best suspended).
HW damage must still not happen. The point Henrique brought up, with the
exploiding battery is a bit of a horror scenario that must never happen.

If I find the time, I'll have a look at the mentioned userspace tools what
is already there and come back then (also considering Henriques suggestion
of native laptop driver which may want to emergency shutdown/S4 the system
for other events than thermal ones).

Thanks for the suggestions,

    Thomas
