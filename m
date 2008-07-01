From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/8] PCI ACPI: Rework PCI handling of wake-up (rev. 3)
Date: Tue, 1 Jul 2008 15:57:20 +0200
Message-ID: <200807011557.21707.rjw@sisk.pl>
References: <200806270022.24496.rjw@sisk.pl> <200806301219.02189.rjw@sisk.pl> <1214879200.31478.10.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58263 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465AbYGANzZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jul 2008 09:55:25 -0400
In-Reply-To: <1214879200.31478.10.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Andi Kleen <andi@firstfloor.org>

On Tuesday, 1 of July 2008, Zhao Yakui wrote:
> On Mon, 2008-06-30 at 12:19 +0200, Rafael J. Wysocki wrote:
> > On Monday, 30 of June 2008, Zhao Yakui wrote:
> > > On Sat, 2008-06-28 at 02:40 +0200, Rafael J. Wysocki wrote:
> > > > On Friday, 27 of June 2008, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > > > @@ -107,10 +113,15 @@ void acpi_disable_wakeup_device(u8 sleep
> > > >  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> > > >  		struct acpi_device *dev =
> > > >  		    container_of(node, struct acpi_device, wakeup_list);
> > > > +		struct device *ldev;
> > > > +		bool wakeup_enabled;
> > > >  
> > > >  		if (!dev->wakeup.flags.valid)
> > > >  			continue;
> > > > -		if (!dev->wakeup.state.enabled ||
> > > > +		ldev = acpi_get_physical_device(dev->handle);
> > > > +		wakeup_enabled = dev->wakeup.state.enabled ||
> > > > +			(ldev ? device_may_wakeup(ldev) : false);
> > > > +		if (!wakeup_enabled ||
> > > >  		    sleep_state > (u32) dev->wakeup.sleep_state) {
> > > >  			if (dev->wakeup.flags.run_wake) {
> > > >  				spin_unlock(&acpi_device_lock);
> > > It seems that the device_init_wakeup(dev,1) will be called in many
> > > drivers regardless of userspace, which will enable the corresponding
> > > GPE. Maybe some laptops will be resumed immediately from the sleeping
> > > state.
> > > 
> > > Is it more reasonable that default state is set as "wake-up disabled" in
> > > driver and userspace can change it from "disabled" to "enabled"?
> > 
> > Yes, it is, IMO.
> > 
> > One possible way to make it happen is to modify device_init_wakeup() so that
> > it always clears power.should_wakeup.
> > 
> > Still, that may lead to functional "regressions", ie. if we do that, some
> > people will have to manually write "enable" to /sys/devices/.../power/wakeup to
> > make their usual wake-up devices work.
> What you said is right. If the power.should_wakeup is clear in
> device_init_wakeup, some people need to write "enable" so that the
> device can wake up the sleeping system. 
> But it can avoid that some system will be resumed immediately from the
> sleeping state.

I think I can override this issue by using the 'prepared' bit introduced in one
of the previous patches to check whether the GPE should be enabled.

While this won't solve the problem entirely, it will restrict it to the devices
that call pci_enable_wake(dev, state, true).

Please have a look at the next iteration of the patchset that I'm going to send
later today.

Thanks,
Rafael
