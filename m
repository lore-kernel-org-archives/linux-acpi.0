From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
Date: Mon, 1 Oct 2018 11:13:43 +0200
Message-ID: <147d20c7-2a07-2305-9b44-76fdb735173b@redhat.com>
References: <20180928150357.12942-1-david@redhat.com>
 <5dba97a5-5a18-5df1-5493-99987679cf3a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <5dba97a5-5a18-5df1-5493-99987679cf3a@linux.intel.com>
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
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Rashmica Gupta <rashmica.g@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Rob Herring <robh@kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 28/09/2018 19:02, Dave Hansen wrote:
> It's really nice if these kinds of things are broken up.  First, replace
> the old want_memblock parameter, then add the parameter to the
> __add_page() calls.

Definitely, once we agree that is is not nuts, I will split it up for
the next version :)

> 
>> +/*
>> + * NONE:     No memory block is to be created (e.g. device memory).
>> + * NORMAL:   Memory block that represents normal (boot or hotplugged) memory
>> + *           (e.g. ACPI DIMMs) that should be onlined either automatically
>> + *           (memhp_auto_online) or manually by user space to select a
>> + *           specific zone.
>> + *           Applicable to memhp_auto_online.
>> + * STANDBY:  Memory block that represents standby memory that should only
>> + *           be onlined on demand by user space (e.g. standby memory on
>> + *           s390x), but never automatically by the kernel.
>> + *           Not applicable to memhp_auto_online.
>> + * PARAVIRT: Memory block that represents memory added by
>> + *           paravirtualized mechanisms (e.g. hyper-v, xen) that will
>> + *           always automatically get onlined. Memory will be unplugged
>> + *           using ballooning, not by relying on the MOVABLE ZONE.
>> + *           Not applicable to memhp_auto_online.
>> + */
>> +enum {
>> +	MEMORY_BLOCK_NONE,
>> +	MEMORY_BLOCK_NORMAL,
>> +	MEMORY_BLOCK_STANDBY,
>> +	MEMORY_BLOCK_PARAVIRT,
>> +};
> 
> This does not seem like the best way to expose these.
> 
> STANDBY, for instance, seems to be essentially a replacement for a check
> against running on s390 in userspace to implement a _typical_ s390
> policy.  It seems rather weird to try to make the userspace policy
> determination easier by telling userspace about the typical s390 policy
> via the kernel.

Now comes the fun part: I am working on another paravirtualized memory
hotplug way for KVM guests, based on virtio ("virtio-mem").

These devices can potentially be used concurrently with
- s390x standby memory
- DIMMs

How should a policy in user space look like when new memory gets added
- on s390x? Not onlining paravirtualized memory is very wrong.
- on e.g. x86? Onlining memory to the MOVABLE zone is very wrong.

So the type of memory is very important here to have in user space.
Relying on checks like "isS390()", "isKVMGuest()" or "isHyperVGuest()"
to decide whether to online memory and how to online memory is wrong.
Only some specific memory types (which I call "normal") are to be
handled by user space.

For the other ones, we exactly know what to do:
- standby? don't online
- paravirt? always online to normal zone

I will add some more details as reply to Michal.

> 
> As for the OOM issues, that sounds like something we need to fix by
> refusing to do (or delaying) hot-add operations once we consume too much
> ZONE_NORMAL from memmap[]s rather than trying to indirectly tell
> userspace to hurry thing along.

That is a moving target and doing that automatically is basically
impossible. You can add a lot of memory to the movable zone and
everything is fine. Suddenly a lot of processes are started - boom.
MOVABLE should only every be used if you expect an unplug. And for
paravirtualized devices, a "typical" unplug does not exist.

> 
> So, to my eye, we need:
> 
>  +enum {
>  +	MEMORY_BLOCK_NONE,
>  +	MEMORY_BLOCK_STANDBY, /* the default */
>  +	MEMORY_BLOCK_AUTO_ONLINE,
>  +};

auto-online is strongly misleading, that's why I called it "normal", but
I am open for suggestions. The information about devices handles fully
in the kernel - "paravirt" is key for me.

> 
> and we can probably collapse NONE into AUTO_ONLINE because userspace
> ends up doing the same thing for both: nothing.

For external reasons, yes, for internal reasons no (see hmm/device
memory). In user space, we will never end up with MEMORY_BLOCK_NONE,
because there is no memory block.

> 
>>  struct memory_block {
>>  	unsigned long start_section_nr;
>>  	unsigned long end_section_nr;
>> @@ -34,6 +58,7 @@ struct memory_block {
>>  	int (*phys_callback)(struct memory_block *);
>>  	struct device dev;
>>  	int nid;			/* NID for this memory block */
>> +	int type;			/* type of this memory block */
>>  };
> 
> Shouldn't we just be creating and using an actual named enum type?
> 

That makes sense.

Thanks!

-- 

Thanks,

David / dhildenb
