From: Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Subject: Re: [PATCH RFCv2 2/6] mm/memory_hotplug: make add_memory() take the
 device_hotplug_lock
Date: Thu, 30 Aug 2018 19:36:43 +0000
Message-ID: <b535ed4a-faa1-9281-e759-ef4b599298ae@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-3-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180821104418.12710-3-david@redhat.com>
Content-Language: en-US
Content-ID: <E7952786F61346438E390595BBDF6E0B@namprd21.prod.outlook.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: David Hildenbrand <david@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: Michal Hocko <mhocko@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Dan Williams <dan.j.williams@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Len Brown <lenb@kernel.org>, YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>, Mathieu Malaterre <malat@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John
List-Id: linux-acpi@vger.kernel.org

On 8/21/18 6:44 AM, David Hildenbrand wrote:
> add_memory() currently does not take the device_hotplug_lock, however
> is aleady called under the lock from
> 	arch/powerpc/platforms/pseries/hotplug-memory.c
> 	drivers/acpi/acpi_memhotplug.c
> to synchronize against CPU hot-remove and similar.
> 
> In general, we should hold the device_hotplug_lock when adding memory
> to synchronize against online/offline request (e.g. from user space) -
> which already resulted in lock inversions due to device_lock() and
> mem_hotplug_lock - see 30467e0b3be ("mm, hotplug: fix concurrent memory
> hot-add deadlock"). add_memory()/add_memory_resource() will create memory
> block devices, so this really feels like the right thing to do.
> 
> Holding the device_hotplug_lock makes sure that a memory block device
> can really only be accessed (e.g. via .online/.state) from user space,
> once the memory has been fully added to the system.
> 
> The lock is not held yet in
> 	drivers/xen/balloon.c
> 	arch/powerpc/platforms/powernv/memtrace.c
> 	drivers/s390/char/sclp_cmd.c
> 	drivers/hv/hv_balloon.c
> So, let's either use the locked variants or take the lock.
> 
> Don't export add_memory_resource(), as it once was exported to be used
> by XEN, which is never built as a module. If somebody requires it, we
> also have to export a locked variant (as device_hotplug_lock is never
> exported).

Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
