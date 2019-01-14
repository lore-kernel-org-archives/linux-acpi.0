From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv2 0/7] x86_64/mm: remove bottom-up allocation style by
 pushing forward the parsing of mem hotplug info
Date: Mon, 14 Jan 2019 15:02:20 -0800
Message-ID: <fe88d6ff-00e1-b65d-f411-64b03227bd17@intel.com>
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>, Tejun Heo <tj@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>, Baoquan He <bhe@redhat.com>, Juergen Gross <jgross@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, x86@kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org

On 1/10/19 9:12 PM, Pingfan Liu wrote:
> Background
> When kaslr kernel can be guaranteed to sit inside unmovable node
> after [1].

What does this "[1]" refer to?

Also, can you clarify your terminology here a bit.  By "kaslr kernel",
do you mean the base address?

> But if kaslr kernel is located near the end of the movable node,
> then bottom-up allocator may create pagetable which crosses the boundary
> between unmovable node and movable node.

Again, I'm confused.  Do you literally mean a single page table page?  I
think you mean the page tables, but it would be nice to clarify this,
and also explicitly state which page tables these are.

>  It is a probability issue,
> two factors include -1. how big the gap between kernel end and
> unmovable node's end.  -2. how many memory does the system own.
> Alternative way to fix this issue is by increasing the gap by
> boot/compressed/kaslr*.

Oh, you mean the KASLR code in arch/x86/boot/compressed/kaslr*.[ch]?

It took me a minute to figure out you were talking about filenames.

> But taking the scenario of PB level memory, the pagetable will take
> server MB even if using 1GB page, different page attr and fragment
> will make things worse. So it is hard to decide how much should the
> gap increase.
I'm not following this.  If we move the image around, we leave holes.
Why do we need page table pages allocated to cover these holes?

> The following figure show the defection of current bottom-up style:
>   [startA, endA][startB, "kaslr kernel verly close to" endB][startC, endC]

"defection"?

> If nodeA,B is unmovable, while nodeC is movable, then init_mem_mapping()
> can generate pgtable on nodeC, which stain movable node.

Let me see if I can summarize this:
1. The kernel ASLR decompression code picks a spot to place the kernel
   image in physical memory.
2. Some page tables are dynamically allocated near (after) this spot.
3. Sometimes, based on the random ASLR location, these page tables fall
   over into the "movable node" area.  Being unmovable allocations, this
   is not cool.
4. To fix this (on 64-bit at least), we stop allocating page tables
   based on the location of the kernel image.  Instead, we allocate
   using the memblock allocator itself, which knows how to avoid the
   movable node.

> This patch makes it certainty instead of a probablity problem. It achieves
> this by pushing forward the parsing of mem hotplug info ahead of init_mem_mapping().

What does memory hotplug have to do with this?  I thought this was all
about early boot.
