From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: /proc/acpi/ removal plan
Date: Mon, 22 Sep 2008 17:51:37 +0200
Message-ID: <200809221751.38221.rjw@sisk.pl>
References: <200809181633.m8IGX1s7019188@hera.kernel.org> <200809200007.17889.rjw@sisk.pl> <1222047232.32459.10.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33914 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbYIVPqJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Sep 2008 11:46:09 -0400
In-Reply-To: <1222047232.32459.10.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@hera.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Monday, 22 of September 2008, Zhang Rui wrote:
> On Fri, 2008-09-19 at 16:07 -0600, Rafael J. Wysocki wrote:
> > On Friday, 19 of September 2008, Zhang, Rui wrote:
> > > >From: Len Brown [mailto:lenb@hera.kernel.org]
> > > >Sent: Friday, September 19, 2008 12:33 AM
> > > >To: dmitry.torokhov@gmail.com; linux-acpi@vger.kernel.org; rjw@sisk.pl; Zhang,
> > > >Rui
> > > >Subject: Re: /proc/acpi/ removal plan
> > > >
> > > >> processor throttling state I/F
> > > >> As processor T-state is used for thermal control only,
> > > >> processor t-state is mapped to a cooling_device's cooling_state
> > > >> in the generic thermal driver, combined with the processor's p-state.
> > > >
> > > >> # ls -l /sys/class/thermal/cooling_device0/
> > > >
> > > >When I scribble into cur_state
> > > >I do not see anything reflected in
> > > >/proc/acpi/processor/*/throttling
> > > >
> > > >Also, max_state is 10, when surely my processor
> > > >has only 8 T-states.
> > > >
> > > the cooling state of processor is a combination of p-state and t-state.
> > > because reducing the frequency is preferred when system is overheat.
> > > e.g cooling state 0 mean processor can be run in the maximum frequency, and it's in the T0 state. And cooling state 9 means processor is in the minimum frequency, T7 state.
> > >
> > > >If user-space can not provoke processor T-states via this I/F,
> > > >then those using the old /proc I/F will flag it as a regression
> > > >when it goes away.  (even if few should ever need it)
> > > >
> > > >> wakeup control,
> > > >> /sys/devices/.../wakeup should be in the todo list. :)
> > > >
> > > >I thought that Rafael said the wakeup file
> > > >in the device tree was working now -- at least
> > > >for PCI devices, no?
> > > >
> > > Rafael's patch did bind the "wakeup" file together with the ACPI device.
> > > It calls the acpi_enable_wakeup_device_power of the ACPI device, but it
> > > doesn't touch the wakeup GPE at all. So, I don't think it actually works...
> > 
> > Have you noticed that the GPEs are actually set up right before
> > entering the sleep state?  acpi_enable_wakeup_device() does that, so in fact
> > yes, it does work.
> > 
> acpi_enable_wakeup_device will enable all the valid wakeup GPEs, that's
> why dev->wakeup.state.enabled is set when writing to /proc/acpi/wakeup.
> And I don't think this flag is set in acpi_pm_device_sleep_wake,
> or do I miss something?

Actually, yes, you do. :-)

Please read the last paragraph of the changelog of
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=eb9d0fe40e313c0a74115ef456a2e43a6c8da72f

Thanks,
Rafael
