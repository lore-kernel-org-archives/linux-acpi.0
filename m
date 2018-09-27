From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 0/6] mm: online/offline_pages called w.o. mem_hotplug_lock
Date: Thu, 27 Sep 2018 11:25:48 +0200
Message-ID: <20180927092554.13567-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: linux-mm@kvack.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>, linux-doc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Rashmica Gupta <rashmica.g@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, David Hildenbrand <david@redhat.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Haiyang Zhang <haiyangz@microsoft.com>, YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>Nathan Fontenot <n>
List-Id: linux-acpi@vger.kernel.org

@Andrew, Only patch #5 changed (see change notes below). Thanks!


Reading through the code and studying how mem_hotplug_lock is to be used,
I noticed that there are two places where we can end up calling
device_online()/device_offline() - online_pages()/offline_pages() without
the mem_hotplug_lock. And there are other places where we call
device_online()/device_offline() without the device_hotplug_lock.

While e.g.
	echo "online" > /sys/devices/system/memory/memory9/state
is fine, e.g.
	echo 1 > /sys/devices/system/memory/memory9/online
Will not take the mem_hotplug_lock. However the device_lock() and
device_hotplug_lock.

E.g. via memory_probe_store(), we can end up calling
add_memory()->online_pages() without the device_hotplug_lock. So we can
have concurrent callers in online_pages(). We e.g. touch in online_pages()
basically unprotected zone->present_pages then.

Looks like there is a longer history to that (see Patch #2 for details),
and fixing it to work the way it was intended is not really possible. We
would e.g. have to take the mem_hotplug_lock in device/base/core.c, which
sounds wrong.

Summary: We had a lock inversion on mem_hotplug_lock and device_lock().
More details can be found in patch 3 and patch 6.

I propose the general rules (documentation added in patch 6):

1. add_memory/add_memory_resource() must only be called with
   device_hotplug_lock.
2. remove_memory() must only be called with device_hotplug_lock. This is
   already documented and holds for all callers.
3. device_online()/device_offline() must only be called with
   device_hotplug_lock. This is already documented and true for now in core
   code. Other callers (related to memory hotplug) have to be fixed up.
4. mem_hotplug_lock is taken inside of add_memory/remove_memory/
   online_pages/offline_pages.

To me, this looks way cleaner than what we have right now (and easier to
verify). And looking at the documentation of remove_memory, using
lock_device_hotplug also for add_memory() feels natural.


v2 -> v3:
- Take device_hotplug_lock outside of loop in patch #5
- Added Ack to patch #5

v1 -> v2:
- Upstream changes in powerpc/powernv code required modifications to
  patch #1, #4 and #5.
- Minor patch description changes.
- Added more locking details in patch #6.
- Added rb's

RFCv2 -> v1:
- Dropped an unnecessary _ref from remove_memory() in patch #1
- Minor patch description fixes.
- Added rb's

RFC -> RFCv2:
- Don't export device_hotplug_lock, provide proper remove_memory/add_memory
  wrappers.
- Split up the patches a bit.
- Try to improve powernv memtrace locking
- Add some documentation for locking that matches my knowledg

David Hildenbrand (6):
  mm/memory_hotplug: make remove_memory() take the device_hotplug_lock
  mm/memory_hotplug: make add_memory() take the device_hotplug_lock
  mm/memory_hotplug: fix online/offline_pages called w.o.
    mem_hotplug_lock
  powerpc/powernv: hold device_hotplug_lock when calling device_online()
  powerpc/powernv: hold device_hotplug_lock when calling
    memtrace_offline_pages()
  memory-hotplug.txt: Add some details about locking internals

 Documentation/memory-hotplug.txt              | 42 ++++++++++++-
 arch/powerpc/platforms/powernv/memtrace.c     |  8 ++-
 .../platforms/pseries/hotplug-memory.c        |  8 +--
 drivers/acpi/acpi_memhotplug.c                |  4 +-
 drivers/base/memory.c                         | 22 +++----
 drivers/xen/balloon.c                         |  3 +
 include/linux/memory_hotplug.h                |  4 +-
 mm/memory_hotplug.c                           | 59 +++++++++++++++----
 8 files changed, 114 insertions(+), 36 deletions(-)

-- 
2.17.1
