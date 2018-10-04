From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
Date: Thu, 4 Oct 2018 08:19:38 +0200
Message-ID: <20181004061938.GB22173@dhcp22.suse.cz>
References: <20181001084038.GD18290@dhcp22.suse.cz>
 <d54a8509-725f-f771-72f0-15a9d93e8a49@redhat.com>
 <20181002134734.GT18290@dhcp22.suse.cz>
 <98fb8d65-b641-2225-f842-8804c6f79a06@redhat.com>
 <8736tndubn.fsf@vitty.brq.redhat.com>
 <20181003134444.GH4714@dhcp22.suse.cz>
 <87zhvvcf3b.fsf@vitty.brq.redhat.com>
 <49456818-238e-2d95-9df6-d1934e9c8b53@linux.intel.com>
 <87tvm3cd5w.fsf@vitty.brq.redhat.com>
 <06a35970-e478-18f8-eae6-4022925a5192@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <06a35970-e478-18f8-eae6-4022925a5192@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: David Hildenbrand <david@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Rashmica Gupta <rashmica.g@gmail.com>, Dan Williams <dan.j.williams@intel.com>, linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, Pavel
List-Id: linux-acpi@vger.kernel.org

On Wed 03-10-18 19:14:05, David Hildenbrand wrote:
> On 03/10/2018 16:34, Vitaly Kuznetsov wrote:
> > Dave Hansen <dave.hansen@linux.intel.com> writes:
> > 
> >> On 10/03/2018 06:52 AM, Vitaly Kuznetsov wrote:
> >>> It is more than just memmaps (e.g. forking udev process doing memory
> >>> onlining also needs memory) but yes, the main idea is to make the
> >>> onlining synchronous with hotplug.
> >>
> >> That's a good theoretical concern.
> >>
> >> But, is it a problem we need to solve in practice?
> > 
> > Yes, unfortunately. It was previously discovered that when we try to
> > hotplug tons of memory to a low memory system (this is a common scenario
> > with VMs) we end up with OOM because for all new memory blocks we need
> > to allocate page tables, struct pages, ... and we need memory to do
> > that. The userspace program doing memory onlining also needs memory to
> > run and in case it prefers to fork to handle hundreds of notfifications
> > ... well, it may get OOMkilled before it manages to online anything.
> > 
> > Allocating all kernel objects from the newly hotplugged blocks would
> > definitely help to manage the situation but as I said this won't solve
> > the 'forking udev' problem completely (it will likely remain in
> > 'extreme' cases only. We can probably work around it by onlining with a
> > dedicated process which doesn't do memory allocation).
> > 
> 
> I guess the problem is even worse. We always have two phases
> 
> 1. add memory - requires memory allocation
> 2. online memory - might require memory allocations e.g. for slab/slub
> 
> So if we just added memory but don't have sufficient memory to start a
> user space process to trigger onlining, then we most likely also don't
> have sufficient memory to online the memory right away (in some scenarios).
> 
> We would have to allocate all new memory for 1 and 2 from the memory to
> be onlined. I guess the latter part is less trivial.
> 
> So while onlining the memory from the kernel might make things a little
> more robust, we would still have the chance for OOM / onlining failing.

Yes, _theoretically_. Is this a practical problem for reasonable
configurations though? I mean, this will never be perfect and we simply
cannot support all possible configurations. We should focus on
reasonable subset of them. From my practical experience the vast
majority of memory is consumed by memmaps (roughly 1.5%). That is not a
lot but I agree that allocating that from the zone normal and off node
is not great. Especially the second part which is noticeable for whole
node hotplug.

I have a feeling that arguing about fork not able to proceed or OOMing
for the memory hotplug is a bit of a stretch and a sign a of
misconfiguration.
-- 
Michal Hocko
SUSE Labs
