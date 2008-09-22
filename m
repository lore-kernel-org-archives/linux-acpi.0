From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: /proc/acpi/ removal plan
Date: Mon, 22 Sep 2008 09:33:52 +0800
Message-ID: <1222047232.32459.10.camel@rzhang-dt>
References: <200809181633.m8IGX1s7019188@hera.kernel.org>
	 <7C8E86B73C916D47820B1A143DB97BC00887719AEE@pdsmsx502.ccr.corp.intel.com>
	 <200809200007.17889.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3683 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894AbYIVBej (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Sep 2008 21:34:39 -0400
In-Reply-To: <200809200007.17889.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@hera.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2008-09-19 at 16:07 -0600, Rafael J. Wysocki wrote:
> On Friday, 19 of September 2008, Zhang, Rui wrote:
> > >From: Len Brown [mailto:lenb@hera.kernel.org]
> > >Sent: Friday, September 19, 2008 12:33 AM
> > >To: dmitry.torokhov@gmail.com; linux-acpi@vger.kernel.org; rjw@sisk.pl; Zhang,
> > >Rui
> > >Subject: Re: /proc/acpi/ removal plan
> > >
> > >> processor throttling state I/F
> > >> As processor T-state is used for thermal control only,
> > >> processor t-state is mapped to a cooling_device's cooling_state
> > >> in the generic thermal driver, combined with the processor's p-state.
> > >
> > >> # ls -l /sys/class/thermal/cooling_device0/
> > >
> > >When I scribble into cur_state
> > >I do not see anything reflected in
> > >/proc/acpi/processor/*/throttling
> > >
> > >Also, max_state is 10, when surely my processor
> > >has only 8 T-states.
> > >
> > the cooling state of processor is a combination of p-state and t-state.
> > because reducing the frequency is preferred when system is overheat.
> > e.g cooling state 0 mean processor can be run in the maximum frequency, and it's in the T0 state. And cooling state 9 means processor is in the minimum frequency, T7 state.
> >
> > >If user-space can not provoke processor T-states via this I/F,
> > >then those using the old /proc I/F will flag it as a regression
> > >when it goes away.  (even if few should ever need it)
> > >
> > >> wakeup control,
> > >> /sys/devices/.../wakeup should be in the todo list. :)
> > >
> > >I thought that Rafael said the wakeup file
> > >in the device tree was working now -- at least
> > >for PCI devices, no?
> > >
> > Rafael's patch did bind the "wakeup" file together with the ACPI device.
> > It calls the acpi_enable_wakeup_device_power of the ACPI device, but it
> > doesn't touch the wakeup GPE at all. So, I don't think it actually works...
> 
> Have you noticed that the GPEs are actually set up right before
> entering the sleep state?  acpi_enable_wakeup_device() does that, so in fact
> yes, it does work.
> 
acpi_enable_wakeup_device will enable all the valid wakeup GPEs, that's
why dev->wakeup.state.enabled is set when writing to /proc/acpi/wakeup.
And I don't think this flag is set in acpi_pm_device_sleep_wake,
or do I miss something?

> >
> > >I think the biggest problem with sysfs wakeup is that every
> > >device in the tree gets a wakeup file, even if it
> > >has no wakeup capability...
> > >
> > that's okay.
> > The wakeup file return null string if it doesn't have the wakeup ability.
> > To be honest, there is one thing that I'm still concerned about.
> > The wakeup file is a runtime device wakeup flag rather than a system wakeup
> > flag.  i.e. "enabled" means that the device can be suspend/resumed at
> > runtime.
> 
> No, it is _NOT_.  'enabled' means that the device is allowed to wake up the
> system from a sleep state if so configured.
> 

> > It doesn't ensure that it can wakeup the system from a sleep state.
> > If /proc/acpi/wakeup is replaced by the /sys/devices/.../wakeup, users may
> > be confused because the device can not wakeup the system even if the wakeup
> > file is set to "enabled".
> 
> That is actually true, but OTOH there's no any 'binary' interface that can be
> used for that, because for example network adapters can wake-up the system in
> many different situations (ie. they can react to many different types of
> packets).
> 

> To avoid the confusion, I started to change the wake-on-LAN ioctls of network
> adapters so that they update the 'wakeup' flag whey the device is set up to
> wake up.
> 
that would be great. :)

thanks,
rui

