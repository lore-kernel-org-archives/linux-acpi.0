From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v1 0/6] mm: online/offline_pages called w.o.
 mem_hotplug_lock
Date: Wed, 19 Sep 2018 11:22:07 +1000
Message-ID: <20180919012207.GD8537@350D>
References: <20180918114822.21926-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180918114822.21926-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, John Allen <jallen@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@ke>
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 18, 2018 at 01:48:16PM +0200, David Hildenbrand wrote:
> Reading through the code and studying how mem_hotplug_lock is to be used,
> I noticed that there are two places where we can end up calling
> device_online()/device_offline() - online_pages()/offline_pages() without
> the mem_hotplug_lock. And there are other places where we call
> device_online()/device_offline() without the device_hotplug_lock.
> 
> While e.g.
> 	echo "online" > /sys/devices/system/memory/memory9/state
> is fine, e.g.
> 	echo 1 > /sys/devices/system/memory/memory9/online
> Will not take the mem_hotplug_lock. However the device_lock() and
> device_hotplug_lock.
> 
> E.g. via memory_probe_store(), we can end up calling
> add_memory()->online_pages() without the device_hotplug_lock. So we can
> have concurrent callers in online_pages(). We e.g. touch in online_pages()
> basically unprotected zone->present_pages then.
> 
> Looks like there is a longer history to that (see Patch #2 for details),
> and fixing it to work the way it was intended is not really possible. We
> would e.g. have to take the mem_hotplug_lock in device/base/core.c, which
> sounds wrong.
> 
> Summary: We had a lock inversion on mem_hotplug_lock and device_lock().
> More details can be found in patch 3 and patch 6.
> 
> I propose the general rules (documentation added in patch 6):
> 
> 1. add_memory/add_memory_resource() must only be called with
>    device_hotplug_lock.
> 2. remove_memory() must only be called with device_hotplug_lock. This is
>    already documented and holds for all callers.
> 3. device_online()/device_offline() must only be called with
>    device_hotplug_lock. This is already documented and true for now in core
>    code. Other callers (related to memory hotplug) have to be fixed up.
> 4. mem_hotplug_lock is taken inside of add_memory/remove_memory/
>    online_pages/offline_pages.
> 
> To me, this looks way cleaner than what we have right now (and easier to
> verify). And looking at the documentation of remove_memory, using
> lock_device_hotplug also for add_memory() feels natural.
>

That seems reasonable, but also implies that device_online() would hold
back add/remove memory, could you please also document what mode
read/write the locks need to be held? For example can the device_hotplug_lock
be held in read mode while add/remove memory via (mem_hotplug_lock) is held
in write mode?

Balbir Singh.
 
