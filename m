From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: vunmap() on large regions may trigger soft lockup warnings
Date: Mon, 16 Dec 2013 12:56:13 +0000
Message-ID: <52AEF86D.808@citrix.com>
References: <52A899AB.3010506@citrix.com>	<20131211133917.dd10cb2c4360dba65d8e6ce2@linux-foundation.org>	<52A9B127.9010501@citrix.com> <20131214003208.f99bc37c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131214003208.f99bc37c.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, xen-devel <xen-devel@lists.xenproject.org>, Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

On 14/12/13 08:32, Andrew Morton wrote:
> On Thu, 12 Dec 2013 12:50:47 +0000 David Vrabel <david.vrabel@citrix.com> wrote:
> 
>>> each time.  But that would require difficult tuning of N.
>>>
>>> I suppose we could just do
>>>
>>> 	if (!in_interrupt())
>>> 		cond_resched();
>>>
>>> in vunmap_pmd_range(), but that's pretty specific to ghes.c and doesn't
>>> permit unmap-inside-spinlock.
>>>
>>> So I can't immediately think of a suitable fix apart from adding a new
>>> unmap_kernel_range_atomic().  Then add a `bool atomic' arg to
>>> vunmap_page_range() and pass that all the way down.
>>
>> That would work for the unmap, but looking at the GHES driver some more
>> and it looks like it's call to ioremap_page_range() is already unsafe --
>> it may need to allocate a new PTE page with a non-atomic alloc in
>> pte_alloc_one_kernel().
>>
>> Perhaps what's needed here is a pair of ioremap_page_atomic() and
>> iounmap_page_atomic() calls?  With some prep function to sure the PTE
>> pages (etc.) are preallocated.
> 
> Is ghes.c the only problem source here?  If so then a suitable solution
> would be to declare that driver hopelessly busted and proceed as if it
> didn't exist :(

All the other callers do so from non-atomic context.  ghes.c is the only
broken caller.

Shall I resend or are you happy to take the patch off the first email in
this thread?

David
