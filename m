From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
Date: Tue, 2 Oct 2018 15:47:34 +0200
Message-ID: <20181002134734.GT18290@dhcp22.suse.cz>
References: <20180928150357.12942-1-david@redhat.com>
 <20181001084038.GD18290@dhcp22.suse.cz>
 <d54a8509-725f-f771-72f0-15a9d93e8a49@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <d54a8509-725f-f771-72f0-15a9d93e8a49@redhat.com>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Pavel Tatashin <pavel.tatashin@microsoft.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Rashmica Gupta <rashmica.g@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon 01-10-18 11:34:25, David Hildenbrand wrote:
> On 01/10/2018 10:40, Michal Hocko wrote:
> > On Fri 28-09-18 17:03:57, David Hildenbrand wrote:
> > [...]
> > 
> > I haven't read the patch itself but I just wanted to note one thing
> > about this part
> > 
> >> For paravirtualized devices it is relevant that memory is onlined as
> >> quickly as possible after adding - and that it is added to the NORMAL
> >> zone. Otherwise, it could happen that too much memory in a row is added
> >> (but not onlined), resulting in out-of-memory conditions due to the
> >> additional memory for "struct pages" and friends. MOVABLE zone as well
> >> as delays might be very problematic and lead to crashes (e.g. zone
> >> imbalance).
> > 
> > I have proposed (but haven't finished this due to other stuff) a
> > solution for this. Newly added memory can host memmaps itself and then
> > you do not have the problem in the first place. For vmemmap it would
> > have an advantage that you do not really have to beg for 2MB pages to
> > back the whole section but you would get it for free because the initial
> > part of the section is by definition properly aligned and unused.
> 
> So the plan is to "host metadata for new memory on the memory itself".
> Just want to note that this is basically impossible for s390x with the
> current mechanisms. (added memory is dead, until onlining notifies the
> hypervisor and memory is allocated). It will also be problematic for
> paravirtualized memory devices (e.g. XEN's "not backed by the
> hypervisor" hacks).

OK, I understand that not all usecases can use self memmap hosting
others do not have much choice left though. You have to allocate from
somewhere. Well and alternative would be to have no memmap until
onlining but I am not sure how much work that would be.

> This would only be possible for memory DIMMs, memory that is completely
> accessible as far as I can see. Or at least, some specified "first part"
> is accessible.
> 
> Other problems are other metadata like extended struct pages and friends.

I wouldn't really worry about extended struct pages. Those should be
used for debugging purposes mostly. Ot at least that was the case last
time I've checked.

> (I really like the idea of adding memory without allocating memory in
> the hypervisor in the first place, please keep me tuned).
> 
> And please note: This solves some problematic part ("adding too much
> memory to the movable zone or not onlining it"), but not the issue of
> zone imbalance in the first place. And not one issue I try to tackle
> here: don't add paravirtualized memory to the movable zone.

Zone imbalance is an inherent problem of the highmem zone. It is
essentially the highmem zone we all loved so much back in 32b days.
Yes the movable zone doesn't have any addressing limitations so it is a
bit more relaxed but considering the hotplug scenarios I have seen so
far people just want to have full NUMA nodes movable to allow replacing
DIMMs. And then we are back to square one and the zone imbalance issue.
You have those regardless where memmaps are allocated from.

> > I yet have to think about the whole proposal but I am missing the most
> > important part. _Who_ is going to use the new exported information and
> > for what purpose. You said that distributions have hard time to
> > distinguish different types of onlinining policies but isn't this
> > something that is inherently usecase specific?
> > 
> 
> Let's think about a distribution. We have a clash of use cases here
> (just what you describe). What I propose solves one part of it ("handle
> what you know how to handle right in the kernel").
> 
> 1. Users of DIMMs usually expect that they can be unplugged again. That
> is why you want to control how to online memory in user space (== add it
> to the movable zone).

Which is only true if you really want to hotremove them. I am not going
to tell how much I believe in this usecase but movable policy is not
generally applicable here.

> 2. Users of standby memory (s390) expect that memory will never be
> onlined automatically. It will be onlined manually.

yeah

> 3. Users of paravirtualized devices (esp. Hyper-V) don't care about
> memory unplug in the sense of MOVABLE at all. They (or Hyper-V!) will
> add a whole bunch of memory and expect that everything works fine. So
> that memory is onlined immediately and that memory is added to the
> NORMAL zone. Users never want the MOVABLE zone.

Then the immediate question would be why to use memory hotplug for that
at all? Why don't you simply start with a huge pre-allocated physical
address space and balloon memory in an out per demand. Why do you want
to inject new memory during the runtime?

> 1. is a reason why distributions usually don't configure
> "MEMORY_HOTPLUG_DEFAULT_ONLINE", because you really want the option for
> MOVABLE zone. That however implies, that e.g. for x86, you have to
> handle all new memory in user space, especially also HyperV memory.
> There, you then have to check for things like "isHyperV()" to decide
> "oh, yes, this should definitely not go to the MOVABLE zone".

Why do you need a generic hotplug rule in the first place? Why don't you
simply provide different set of rules for different usecases? Let users
decide which usecase they prefer rather than try to be clever which
almost always hits weird corner cases.
-- 
Michal Hocko
SUSE Labs
