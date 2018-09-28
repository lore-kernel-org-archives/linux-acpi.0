From: Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
Date: Fri, 28 Sep 2018 10:02:48 -0700
Message-ID: <5dba97a5-5a18-5df1-5493-99987679cf3a@linux.intel.com>
References: <20180928150357.12942-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180928150357.12942-1-david@redhat.com>
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
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Rashmica Gupta <rashmica.g@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Rob Herring <robh@kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

It's really nice if these kinds of things are broken up.  First, replace
the old want_memblock parameter, then add the parameter to the
__add_page() calls.

> +/*
> + * NONE:     No memory block is to be created (e.g. device memory).
> + * NORMAL:   Memory block that represents normal (boot or hotplugged) memory
> + *           (e.g. ACPI DIMMs) that should be onlined either automatically
> + *           (memhp_auto_online) or manually by user space to select a
> + *           specific zone.
> + *           Applicable to memhp_auto_online.
> + * STANDBY:  Memory block that represents standby memory that should only
> + *           be onlined on demand by user space (e.g. standby memory on
> + *           s390x), but never automatically by the kernel.
> + *           Not applicable to memhp_auto_online.
> + * PARAVIRT: Memory block that represents memory added by
> + *           paravirtualized mechanisms (e.g. hyper-v, xen) that will
> + *           always automatically get onlined. Memory will be unplugged
> + *           using ballooning, not by relying on the MOVABLE ZONE.
> + *           Not applicable to memhp_auto_online.
> + */
> +enum {
> +	MEMORY_BLOCK_NONE,
> +	MEMORY_BLOCK_NORMAL,
> +	MEMORY_BLOCK_STANDBY,
> +	MEMORY_BLOCK_PARAVIRT,
> +};

This does not seem like the best way to expose these.

STANDBY, for instance, seems to be essentially a replacement for a check
against running on s390 in userspace to implement a _typical_ s390
policy.  It seems rather weird to try to make the userspace policy
determination easier by telling userspace about the typical s390 policy
via the kernel.

As for the OOM issues, that sounds like something we need to fix by
refusing to do (or delaying) hot-add operations once we consume too much
ZONE_NORMAL from memmap[]s rather than trying to indirectly tell
userspace to hurry thing along.

So, to my eye, we need:

 +enum {
 +	MEMORY_BLOCK_NONE,
 +	MEMORY_BLOCK_STANDBY, /* the default */
 +	MEMORY_BLOCK_AUTO_ONLINE,
 +};

and we can probably collapse NONE into AUTO_ONLINE because userspace
ends up doing the same thing for both: nothing.

>  struct memory_block {
>  	unsigned long start_section_nr;
>  	unsigned long end_section_nr;
> @@ -34,6 +58,7 @@ struct memory_block {
>  	int (*phys_callback)(struct memory_block *);
>  	struct device dev;
>  	int nid;			/* NID for this memory block */
> +	int type;			/* type of this memory block */
>  };

Shouldn't we just be creating and using an actual named enum type?
