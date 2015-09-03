From: Tejun Heo <tj@kernel.org>
Subject: Re: Possible deadlock related to CPU hotplug and kernfs
Date: Thu, 3 Sep 2015 12:19:04 -0400
Message-ID: <20150903161904.GC10394@mtj.duckdns.org>
References: <55E54FE2.7030601@linux.intel.com>
 <20150902161445.GI22326@mtj.duckdns.org>
 <12669324.bPBpI0mOPP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12669324.bPBpI0mOPP@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, linux hotplug mailing <linux-hotplug@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hello, Rafael.

On Thu, Sep 03, 2015 at 02:58:16AM +0200, Rafael J. Wysocki wrote:
> So acpi_device_hotplug() calls lock_device_hotplug() which simply
> acquires device_hotplug_lock.  It is held throughout the entire
> hot-add/hot-remove code path.
> 
> Witing anything to /sys/devices/system/cpu/cpux/online goes through
> online_store() in drivers/base/core.c and that does
> lock_device_hotplug_sysfs() which then attempts to acquire
> device_hotplug_lock using mutex_trylock().  And it only calls
> either device_online() or device_offline() if it ends up with the
> lock held.
> 
> Quite frankly, I don't see how these particular two code paths can
> deadlock in any way.
> 
> So either a third code path is involved which is not executed
> under device_hotplug_lock, or lockdep needs to be told to actually
> take device_hotplug_lock into account in this case IMO.

Hmm... all sysfs rw functions are protected from removal.  ie. by
default, removal of a sysfs file drains in-flight rw operations, so
the hot plug path grabs a lock and then tries to remove a file and
writing to the online file makes the file's write method to try to
grab the same lock.  It deadlocks if the hotunplug path already has
the lock and trying to drain the online file for removal.

The same problem exists for "delete" files but that's already handled
from device core side.

Thanks.

-- 
tejun
