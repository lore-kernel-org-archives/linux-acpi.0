From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
Date: Wed, 3 Oct 2018 19:00:29 +0200
Message-ID: <9fef1f7d-2d7c-03f1-00e3-5fa657eda019@redhat.com>
References: <20180928150357.12942-1-david@redhat.com>
 <20181001084038.GD18290@dhcp22.suse.cz>
 <d54a8509-725f-f771-72f0-15a9d93e8a49@redhat.com>
 <20181002134734.GT18290@dhcp22.suse.cz>
 <98fb8d65-b641-2225-f842-8804c6f79a06@redhat.com>
 <20181003135407.GI4714@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181003135407.GI4714@dhcp22.suse.cz>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Pavel Tatashin <pavel.tatashin@microsoft.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Rashmica Gupta <rashmica.g@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 03/10/2018 15:54, Michal Hocko wrote:
> On Tue 02-10-18 17:25:19, David Hildenbrand wrote:
>> On 02/10/2018 15:47, Michal Hocko wrote:
> [...]
>>> Zone imbalance is an inherent problem of the highmem zone. It is
>>> essentially the highmem zone we all loved so much back in 32b days.
>>> Yes the movable zone doesn't have any addressing limitations so it is a
>>> bit more relaxed but considering the hotplug scenarios I have seen so
>>> far people just want to have full NUMA nodes movable to allow replacing
>>> DIMMs. And then we are back to square one and the zone imbalance issue.
>>> You have those regardless where memmaps are allocated from.
>>
>> Unfortunately yes. And things get more complicated as you are adding a
>> whole DIMMs and get notifications in the granularity of memory blocks.
>> Usually you are not interested in onlining any memory block of that DIMM
>> as MOVABLE as soon as you would have to online one memory block of that
>> DIMM as NORMAL - because that can already block the whole DIMM.
> 
> For the purpose of the hotremove, yes. But as Dave has noted people are
> (ab)using zone movable for other purposes - e.g. large pages.

That might be right for some very special use cases. For most of users
this is not the case (meaning it should be the default but if the user
wants to change it, he should be allowed to change it).

>  
> [...]
>>> Then the immediate question would be why to use memory hotplug for that
>>> at all? Why don't you simply start with a huge pre-allocated physical
>>> address space and balloon memory in an out per demand. Why do you want
>>> to inject new memory during the runtime?
>>
>> Let's assume you have a guest with 20GB size and eventually want to
>> allow to grow it to 4TB. You would have to allocate metadata for 4TB
>> right from the beginning. That's definitely now what we want. That is
>> why memory hotplug is used by e.g. XEN or Hyper-V. With Hyper-V, the
>> hypervisor even tells you at which places additional memory has been
>> made available.
> 
> Then you have to live with the fact that your hot added memory will be
> self hosted and find a way for ballooning to work with that. The price
> would be that some part of the memory is not really balloonable in the
> end.
> 
>>>> 1. is a reason why distributions usually don't configure
>>>> "MEMORY_HOTPLUG_DEFAULT_ONLINE", because you really want the option for
>>>> MOVABLE zone. That however implies, that e.g. for x86, you have to
>>>> handle all new memory in user space, especially also HyperV memory.
>>>> There, you then have to check for things like "isHyperV()" to decide
>>>> "oh, yes, this should definitely not go to the MOVABLE zone".
>>>
>>> Why do you need a generic hotplug rule in the first place? Why don't you
>>> simply provide different set of rules for different usecases? Let users
>>> decide which usecase they prefer rather than try to be clever which
>>> almost always hits weird corner cases.
>>>
>>
>> Memory hotplug has to work as reliable as we can out of the box. Letting
>> the user make simple decisions like "oh, I am on hyper-V, I want to
>> online memory to the normal zone" does not feel right.
> 
> Users usually know what is their usecase and then it is just a matter of
> plumbing (e.g. distribution can provide proper tools to deploy those
> usecases) to chose the right and for user obscure way to make it work.

I disagree. If we can ship sane defaults, we should do that and allow to
make changes later on. This is how distributions have been working for
ever. But yes, allowing to make modifications is always a good idea to
tailor it to some special case user scenarios. (tuned or whatever we
have in place).

> 
>> But yes, we
>> should definitely allow to make modifications. So some sane default rule
>> + possible modification is usually a good idea.
>>
>> I think Dave has a point with using MOVABLE for huge page use cases. And
>> there might be other corner cases as you correctly state.
>>
>> I wonder if this patch itself minus modifying online/offline might make
>> sense. We can then implement simple rules in user space
>>
>> if (normal) {
>> 	/* customers expect hotplugged DIMMs to be unpluggable */
>> 	online_movable();
>> } else if (paravirt) {
>> 	/* paravirt memory should as default always go to the NORMAL */
>> 	online();
>> } else {
>> 	/* standby memory will never get onlined automatically */
>> }
>>
>> Compared to having to guess what is to be done (isKVM(), isHyperV,
>> isS390 ...) and failing once this is no longer unique (e.g. virtio-mem
>> and ACPI support for x86 KVM).
> 
> I am worried that exporing a type will just push us even further to the
> corner. The current design is really simple and 2 stage and that is good
> because it allows for very different usecases. The more specific the API
> be the more likely we are going to hit "I haven't even dreamed somebody
> would be using hotplug for this thing". And I would bet this will happen
> sooner or later.

Exposing the type of memory is in my point of view just forwarding facts
to user space. We should not export arbitrary information, that is true.

> 
> Just look at how the whole auto onlining screwed the API to workaround
> an implementation detail. It has created a one purpose behavior that
> doesn't suite many usecases. Yet we have to live with that because
> somebody really relies on it. Let's not repeat same errors.
> 

Let me rephrase: You state that user space has to make the decision and
that user should be able to set/reconfigure rules. That is perfectly fine.

But then we should give user space access to sufficient information to
make a decision. This might be the type of memory as we learned (what
some part of this patch proposes), but maybe later more, e.g. to which
physical device memory belongs (e.g. to hotplug it all movable or all
normal) ...

-- 

Thanks,

David / dhildenb
