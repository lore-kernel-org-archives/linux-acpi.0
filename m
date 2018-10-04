From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
Date: Thu, 4 Oct 2018 09:48:32 +0200
Message-ID: <746a61c2-ebc7-abff-3bcd-7e307ef449bd@redhat.com>
References: <20180928150357.12942-1-david@redhat.com>
 <5dba97a5-5a18-5df1-5493-99987679cf3a@linux.intel.com>
 <147d20c7-2a07-2305-9b44-76fdb735173b@redhat.com>
 <05493150-5e4e-30bd-f772-0c6d88240030@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <05493150-5e4e-30bd-f772-0c6d88240030@linux.intel.com>
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

On 01/10/2018 18:24, Dave Hansen wrote:
>> How should a policy in user space look like when new memory gets added
>> - on s390x? Not onlining paravirtualized memory is very wrong.
> 
> Because we're going to balloon it away in a moment anyway?

No, rether somebody wanted this VM to have more memory, so it should use
it - basically what HyperV or XEN also do. (in contrast to the concept
of standby memory on s390).

> > We have auto-onlining.  Why isn't that being used on s390?

Do you mean the sys parameter? How would that help?

> 
> 
>> So the type of memory is very important here to have in user space.
>> Relying on checks like "isS390()", "isKVMGuest()" or "isHyperVGuest()"
>> to decide whether to online memory and how to online memory is wrong.
>> Only some specific memory types (which I call "normal") are to be
>> handled by user space.
>>
>> For the other ones, we exactly know what to do:
>> - standby? don't online
> 
> I think you're horribly conflating the software desire for what the stae
> should be and the hardware itself.

Agreed, user space should be able to configure it.

> 
>>> As for the OOM issues, that sounds like something we need to fix by
>>> refusing to do (or delaying) hot-add operations once we consume too much
>>> ZONE_NORMAL from memmap[]s rather than trying to indirectly tell
>>> userspace to hurry thing along.
>>
>> That is a moving target and doing that automatically is basically
>> impossible.
> 
> Nah.  We know how much metadata we've allocated.  We know how much
> ZONE_NORMAL we are eating.  We can *easily* add something to
> add_memory() that just sleeps until the ratio is not out-of-whack.
> 
>> You can add a lot of memory to the movable zone and
>> everything is fine. Suddenly a lot of processes are started - boom.
>> MOVABLE should only every be used if you expect an unplug. And for
>> paravirtualized devices, a "typical" unplug does not exist.
> 
> No, it's more complicated than that.  People use MOVABLE, for instance,
> to allow more consistent huge page allocations.  It's certainly not just
> hot-remove.
> 

As noted in the other thread, that's a good point. We have to allow to
make a decision in user space.

I agree to your initial proposal to distinguish "standby" from
"auto-online". It would allow to have sane defaults in user space.

-- 

Thanks,

David / dhildenb
