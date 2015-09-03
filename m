From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Possible deadlock related to CPU hotplug and kernfs
Date: Thu, 03 Sep 2015 02:58:16 +0200
Message-ID: <12669324.bPBpI0mOPP@vostro.rjw.lan>
References: <55E54FE2.7030601@linux.intel.com> <20150902161445.GI22326@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44910 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754652AbbICAae (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Sep 2015 20:30:34 -0400
In-Reply-To: <20150902161445.GI22326@mtj.duckdns.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, linux hotplug mailing <linux-hotplug@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wednesday, September 02, 2015 12:14:45 PM Tejun Heo wrote:
> On Tue, Sep 01, 2015 at 03:12:34PM +0800, Jiang Liu wrote:
> > Hi Rafael and Tejun,
> > 	When running CPU hotplug tests, it triggers an lockdep warning
> > as follow. The two possible deadlock paths are:
> > 1) echo x > /sys/devices/system/cpu/cpux/online
> >    ->kernfs_fop_write()
> >      ->kernfs_get_active()
> > 1.a)   ->rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_);
> >          ->cpu_up()
> > 1.b)       ->cpu_hotplug_begin()[lock_map_acquire(&cpu_hotplug.dep_map)]
> > 2) hardware triggers hotplug evetns
> >    ->acpi_device_hotplug()
> >      ->acpi_processor_remove()
> > 2.a)   ->cpu_hotplug_begin()[lock_map_acquire(&cpu_hotplug.dep_map)]
> >          ->unregister_cpu()
> >            ->device_del()
> >              ->kernfs_remove_by_name_ns()
> >                ->__kernfs_remove()
> >                  ->kernfs_drain()
> > 2.b)               ->rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_)
> > 
> > So there is a possible deadlock scenario among 1.a, 1.b, 2.a and 2.b.
> > I'm not familiar with kernfs, so could you please help to comment:
> > 1) whether is a real deadlock issue?
> 
> Yes, it seems to be.  It's highly unlikely but still possible.

Hmm.

So acpi_device_hotplug() calls lock_device_hotplug() which simply
acquires device_hotplug_lock.  It is held throughout the entire
hot-add/hot-remove code path.

Witing anything to /sys/devices/system/cpu/cpux/online goes through
online_store() in drivers/base/core.c and that does
lock_device_hotplug_sysfs() which then attempts to acquire
device_hotplug_lock using mutex_trylock().  And it only calls
either device_online() or device_offline() if it ends up with the
lock held.

Quite frankly, I don't see how these particular two code paths can
deadlock in any way.

So either a third code path is involved which is not executed
under device_hotplug_lock, or lockdep needs to be told to actually
take device_hotplug_lock into account in this case IMO.

> > 2) any recommended way to get it fixed?
> 
> This usually happens with "delete" files and it's worked around by
> performing special self-removal on the file before actually removing
> the device.  I suppose on/offline files would need to turn off
> active_protection with kernfs_[un]break_active_protection() which
> should probably grow sysfs and device layer wrappers.

Thanks,
Rafael

