From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 0/4] x86_64/mm: remove bottom-up allocation style by
 pushing forward the parsing of mem hotplug info
Date: Mon, 7 Jan 2019 09:03:51 -0800
Message-ID: <7d72567c-2ed8-e2ae-8518-115cd9c8a82a@intel.com>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pingfan Liu <kernelfans@gmail.com>, x86@kernel.org, linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 1/7/19 12:24 AM, Pingfan Liu wrote:
> Background about the defect of the current bottom-up allocation style, take
> the following scenario:
>   |  unmovable node |     movable node                           |
>      | kaslr-kernel |subtree of pgtable for phy<->virt |
> 
> Although kaslr-kernel can avoid to stain the movable node. But the
> pgtable can still stain the movable node. That is a probability problem,
> with low probability, but still exist. This patch tries to eliminate the
> probability. With the previous patch, at the point of init_mem_mapping(),
> memblock allocator can work with the knowledge of acpi memory hotmovable
> info, and avoid to stain the movable node. As a result,
> memory_map_bottom_up() is not needed any more.

I'm really missing the basic problem statement.  What's the problem this
is fixing?  What is the end-user-visible impact of this problem?

To make memory hot-remove work, we want as much memory as possible to he
hot-removable, which is basically what movable nodes are used for.  But,
it sounds like, maybe, that KASLR can place the kernel image inside the
movable node.  This is somehow related to the bottom-up allocation style
currently in use.
