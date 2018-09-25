From: Rashmica Gupta <rashmica.g@gmail.com>
Subject: Re: [PATCH RFCv2 3/6] mm/memory_hotplug: fix online/offline_pages
 called w.o. mem_hotplug_lock
Date: Tue, 25 Sep 2018 11:26:51 +1000
Message-ID: <1537838811.10753.2.camel@gmail.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-4-david@redhat.com>
 <70372ef5-e332-6c07-f08c-50f8808bde6d@gmail.com>
 <5f80ca56-9f34-4e6e-bc83-8f8b3c888163@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <5f80ca56-9f34-4e6e-bc83-8f8b3c888163@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>, linux-doc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Michael Ellerman <mpe@ellerman.id.au>, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Dan Williams <dan.j.williams@intel.com>, YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>, Mathieu Malaterre <malat@debian.org>, Greg
List-Id: linux-acpi@vger.kernel.org

On Mon, 2018-09-17 at 09:32 +0200, David Hildenbrand wrote:
> Am 03.09.18 um 02:36 schrieb Rashmica:
> > Hi David,
> > 
> > 
> > On 21/08/18 20:44, David Hildenbrand wrote:
> > 
> > > There seem to be some problems as result of 30467e0b3be ("mm,
> > > hotplug:
> > > fix concurrent memory hot-add deadlock"), which tried to fix a
> > > possible
> > > lock inversion reported and discussed in [1] due to the two locks
> > > 	a) device_lock()
> > > 	b) mem_hotplug_lock
> > > 
> > > While add_memory() first takes b), followed by a) during
> > > bus_probe_device(), onlining of memory from user space first took
> > > b),
> > > followed by a), exposing a possible deadlock.
> > 
> > Do you mean "onlining of memory from user space first took a),
> > followed by b)"? 
> 
> Very right, thanks.
> 
> > 
> > > In [1], and it was decided to not make use of
> > > device_hotplug_lock, but
> > > rather to enforce a locking order.
> > > 
> > > The problems I spotted related to this:
> > > 
> > > 1. Memory block device attributes: While .state first calls
> > >    mem_hotplug_begin() and the calls device_online() - which
> > > takes
> > >    device_lock() - .online does no longer call
> > > mem_hotplug_begin(), so
> > >    effectively calls online_pages() without mem_hotplug_lock.
> > > 
> > > 2. device_online() should be called under device_hotplug_lock,
> > > however
> > >    onlining memory during add_memory() does not take care of
> > > that.
> > > 
> > > In addition, I think there is also something wrong about the
> > > locking in
> > > 
> > > 3. arch/powerpc/platforms/powernv/memtrace.c calls
> > > offline_pages()
> > >    without locks. This was introduced after 30467e0b3be. And
> > > skimming over
> > >    the code, I assume it could need some more care in regards to
> > > locking
> > >    (e.g. device_online() called without device_hotplug_lock - but
> > > I'll
> > >    not touch that for now).
> > 
> > Can you mention that you fixed this in later patches?
> 
> Sure!
> 
> > 
> > 
> > The series looks good to me. Feel free to add my reviewed-by:
> > 
> > Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> > 
> 
> Thanks, r-b only for this patch or all of the series?

Sorry, I somehow missed this. To all of the series.
> 
