From: Pingfan Liu <kernelfans@gmail.com>
Subject: Re: [RFC PATCH 0/4] x86_64/mm: remove bottom-up allocation style by
 pushing forward the parsing of mem hotplug info
Date: Tue, 8 Jan 2019 21:27:22 +0800
Message-ID: <CAFgQCTu8C6DFqoUSKyKLZnL1twGr=3k+M4bgwgtcjENm+WHqJg@mail.gmail.com>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com> <20190108100542.GA2216@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108100542.GA2216@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, yinghai@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 8, 2019 at 6:06 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Mon, Jan 07, 2019 at 04:24:41PM +0800, Pingfan Liu wrote:
> >Background about the defect of the current bottom-up allocation style, take
> >the following scenario:
> >  |  unmovable node |     movable node                           |
> >     | kaslr-kernel |subtree of pgtable for phy<->virt |
> >
> >Although kaslr-kernel can avoid to stain the movable node. But the
> >pgtable can still stain the movable node. That is a probability problem,
> >with low probability, but still exist. This patch tries to eliminate the
> >probability. With the previous patch, at the point of init_mem_mapping(),
> >memblock allocator can work with the knowledge of acpi memory hotmovable
> >info, and avoid to stain the movable node. As a result,
> >memory_map_bottom_up() is not needed any more.
> >
>
> Hi Pingfan,
>
> Tang Chen ever tried to do this before adding 'movable_node':
> commit e8d1955258091e4c92d5a975ebd7fd8a98f5d30f
> Author: Tang Chen <tangchen@cn.fujitsu.com>
> Date:   Fri Feb 22 16:33:44 2013 -0800
>
>     acpi, memory-hotplug: parse SRAT before memblock is ready
>
> Then, Lu Yinghai tried to do the similar job, you can see:
> https://lwn.net/Articles/554854/
> for more information. Hope that can help you.
>
Thanks, It is a long thread, as my understanding, Tejun concerned
about the early parsing of ACPI consumes memory from memblock
allocator. If it is, then this should not happen in my series.
Cc Tejun and Yinghai.

Regards,
Pingfan
> Thanks,
> Chao Fan
>
> >
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@redhat.com>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >Cc: Andy Lutomirski <luto@kernel.org>
> >Cc: Peter Zijlstra <peterz@infradead.org>
> >Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >Cc: Len Brown <lenb@kernel.org>
> >Cc: linux-kernel@vger.kernel.org
> >
> >Pingfan Liu (4):
> >  acpi: change the topo of acpi_table_upgrade()
> >  x86/setup: parse acpi to get hotplug info before init_mem_mapping()
> >  x86/mm: set allowed range for memblock allocator
> >  x86/mm: remove bottom-up allocation style for x86_64
> >
> > arch/arm64/kernel/setup.c |   2 +-
> > arch/x86/kernel/setup.c   |  17 ++++-
> > arch/x86/mm/init.c        | 154 +++++++---------------------------------------
> > arch/x86/mm/init_32.c     | 123 ++++++++++++++++++++++++++++++++++++
> > arch/x86/mm/mm_internal.h |   7 +++
> > drivers/acpi/tables.c     |   4 +-
> > include/linux/acpi.h      |   5 +-
> > 7 files changed, 172 insertions(+), 140 deletions(-)
> >
> >--
> >2.7.4
> >
> >
> >
>
>
