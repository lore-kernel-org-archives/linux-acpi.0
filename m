From: Pingfan Liu <kernelfans@gmail.com>
Subject: Re: [RFC PATCH 0/4] x86_64/mm: remove bottom-up allocation style by
 pushing forward the parsing of mem hotplug info
Date: Tue, 8 Jan 2019 13:49:51 +0800
Message-ID: <CAFgQCTtjD-3z52aETURY9YN-_qfy=u=xSYrdcnmMpSWow3kvjg@mail.gmail.com>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com> <7d72567c-2ed8-e2ae-8518-115cd9c8a82a@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7d72567c-2ed8-e2ae-8518-115cd9c8a82a@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 8, 2019 at 1:04 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/7/19 12:24 AM, Pingfan Liu wrote:
> > Background about the defect of the current bottom-up allocation style, take
> > the following scenario:
> >   |  unmovable node |     movable node                           |
> >      | kaslr-kernel |subtree of pgtable for phy<->virt |
> >
> > Although kaslr-kernel can avoid to stain the movable node. But the
> > pgtable can still stain the movable node. That is a probability problem,
> > with low probability, but still exist. This patch tries to eliminate the
> > probability. With the previous patch, at the point of init_mem_mapping(),
> > memblock allocator can work with the knowledge of acpi memory hotmovable
> > info, and avoid to stain the movable node. As a result,
> > memory_map_bottom_up() is not needed any more.
>
> I'm really missing the basic problem statement.  What's the problem this
> is fixing?  What is the end-user-visible impact of this problem?
>
Sorry for the misaligned figure. It should be
   |  kaslr-kernel    |subtree of pgtable for phy<->virt    |
                              |--- boundary between unmovable node and
movable node
Where kaslr kernel can be guaranteed to sit inside unmovable node
after patch: https://lore.kernel.org/patchwork/patch/1029376/. But if
kaslr kernel is located near the end of the movable node, then
bottom-up allocator may create pagetable which crosses the  boundary
between unmovable node and movable node.  It is a probability issue,
the factors include -1. how big the gap between kernel end and
unmovable node's end.  -2. how many memory does the system own.
Alternative way to fix this issue is by increasing the gap by
boot/compressed/kaslr*. But taking the scenario of PB level memory,
the pagetable will take server MB even if using 1GB page, so it is
hard to decide how much should the gap increase.
In a word, this series fix the probability with certainty, by
allocating pagetable on unmovable node, instead of following kernel
end.

> To make memory hot-remove work, we want as much memory as possible to he
> hot-removable, which is basically what movable nodes are used for.  But,
> it sounds like, maybe, that KASLR can place the kernel image inside the
> movable node.  This is somehow related to the bottom-up allocation style
> currently in use.

Yes, currently kaslr kernel can stain the movable node, but it will
not do this soon after the patch:
https://lore.kernel.org/patchwork/patch/1029376/

Thanks,
Pingfan
