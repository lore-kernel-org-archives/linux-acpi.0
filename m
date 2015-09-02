From: Tejun Heo <tj@kernel.org>
Subject: Re: Possible deadlock related to CPU hotplug and kernfs
Date: Wed, 2 Sep 2015 12:14:45 -0400
Message-ID: <20150902161445.GI22326@mtj.duckdns.org>
References: <55E54FE2.7030601@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35917 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbbIBQOs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Sep 2015 12:14:48 -0400
Content-Disposition: inline
In-Reply-To: <55E54FE2.7030601@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux hotplug mailing <linux-hotplug@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Sep 01, 2015 at 03:12:34PM +0800, Jiang Liu wrote:
> Hi Rafael and Tejun,
> 	When running CPU hotplug tests, it triggers an lockdep warning
> as follow. The two possible deadlock paths are:
> 1) echo x > /sys/devices/system/cpu/cpux/online
>    ->kernfs_fop_write()
>      ->kernfs_get_active()
> 1.a)   ->rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_);
>          ->cpu_up()
> 1.b)       ->cpu_hotplug_begin()[lock_map_acquire(&cpu_hotplug.dep_map)]
> 2) hardware triggers hotplug evetns
>    ->acpi_device_hotplug()
>      ->acpi_processor_remove()
> 2.a)   ->cpu_hotplug_begin()[lock_map_acquire(&cpu_hotplug.dep_map)]
>          ->unregister_cpu()
>            ->device_del()
>              ->kernfs_remove_by_name_ns()
>                ->__kernfs_remove()
>                  ->kernfs_drain()
> 2.b)               ->rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_)
> 
> So there is a possible deadlock scenario among 1.a, 1.b, 2.a and 2.b.
> I'm not familiar with kernfs, so could you please help to comment:
> 1) whether is a real deadlock issue?

Yes, it seems to be.  It's highly unlikely but still possible.

> 2) any recommended way to get it fixed?

This usually happens with "delete" files and it's worked around by
performing special self-removal on the file before actually removing
the device.  I suppose on/offline files would need to turn off
active_protection with kernfs_[un]break_active_protection() which
should probably grow sysfs and device layer wrappers.

Thanks.

-- 
tejun
