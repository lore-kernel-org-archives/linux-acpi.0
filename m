From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 6/8] PCI ACPI: Rework PCI handling of wake-up (rev. 3)
Date: Tue, 01 Jul 2008 10:26:40 +0800
Message-ID: <1214879200.31478.10.camel@yakui_zhao.sh.intel.com>
References: <200806270022.24496.rjw@sisk.pl>
	 <200806280240.13939.rjw@sisk.pl>
	 <1214791528.26947.12.camel@yakui_zhao.sh.intel.com>
	 <200806301219.02189.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61943 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755153AbYGACPR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Jun 2008 22:15:17 -0400
In-Reply-To: <200806301219.02189.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>

On Mon, 2008-06-30 at 12:19 +0200, Rafael J. Wysocki wrote:
> On Monday, 30 of June 2008, Zhao Yakui wrote:
> > On Sat, 2008-06-28 at 02:40 +0200, Rafael J. Wysocki wrote:
> > > On Friday, 27 of June 2008, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> > > @@ -107,10 +113,15 @@ void acpi_disable_wakeup_device(u8 sleep
> > >  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> > >  		struct acpi_device *dev =
> > >  		    container_of(node, struct acpi_device, wakeup_list);
> > > +		struct device *ldev;
> > > +		bool wakeup_enabled;
> > >  
> > >  		if (!dev->wakeup.flags.valid)
> > >  			continue;
> > > -		if (!dev->wakeup.state.enabled ||
> > > +		ldev = acpi_get_physical_device(dev->handle);
> > > +		wakeup_enabled = dev->wakeup.state.enabled ||
> > > +			(ldev ? device_may_wakeup(ldev) : false);
> > > +		if (!wakeup_enabled ||
> > >  		    sleep_state > (u32) dev->wakeup.sleep_state) {
> > >  			if (dev->wakeup.flags.run_wake) {
> > >  				spin_unlock(&acpi_device_lock);
> > It seems that the device_init_wakeup(dev,1) will be called in many
> > drivers regardless of userspace, which will enable the corresponding
> > GPE. Maybe some laptops will be resumed immediately from the sleeping
> > state.
> > 
> > Is it more reasonable that default state is set as "wake-up disabled" in
> > driver and userspace can change it from "disabled" to "enabled"?
> 
> Yes, it is, IMO.
> 
> One possible way to make it happen is to modify device_init_wakeup() so that
> it always clears power.should_wakeup.
> 
> Still, that may lead to functional "regressions", ie. if we do that, some
> people will have to manually write "enable" to /sys/devices/.../power/wakeup to
> make their usual wake-up devices work.
What you said is right. If the power.should_wakeup is clear in
device_init_wakeup, some people need to write "enable" so that the
device can wake up the sleeping system. 
But it can avoid that some system will be resumed immediately from the
sleeping state.
> Either way, there is possibility of breaking something.
> 
> Thanks,
> Rafael

