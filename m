From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
Date: Wed, 03 Oct 2018 16:34:03 +0200
Message-ID: <87tvm3cd5w.fsf@vitty.brq.redhat.com>
References: <20180928150357.12942-1-david@redhat.com>
 <20181001084038.GD18290@dhcp22.suse.cz>
 <d54a8509-725f-f771-72f0-15a9d93e8a49@redhat.com>
 <20181002134734.GT18290@dhcp22.suse.cz>
 <98fb8d65-b641-2225-f842-8804c6f79a06@redhat.com>
 <8736tndubn.fsf@vitty.brq.redhat.com> <20181003134444.GH4714@dhcp22.suse.cz>
 <87zhvvcf3b.fsf@vitty.brq.redhat.com>
 <49456818-238e-2d95-9df6-d1934e9c8b53@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <49456818-238e-2d95-9df6-d1934e9c8b53@linux.intel.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, "H.
 Peter Anvin" <hpa@zytor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Rashmica Gupta <rashmica.g@gmail.com>, Dan Williams <dan.j.williams@intel.com>, linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, David Hildenbrand <david@redhat.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>Pavel Tatashin <p>
List-Id: linux-acpi@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> On 10/03/2018 06:52 AM, Vitaly Kuznetsov wrote:
>> It is more than just memmaps (e.g. forking udev process doing memory
>> onlining also needs memory) but yes, the main idea is to make the
>> onlining synchronous with hotplug.
>
> That's a good theoretical concern.
>
> But, is it a problem we need to solve in practice?

Yes, unfortunately. It was previously discovered that when we try to
hotplug tons of memory to a low memory system (this is a common scenario
with VMs) we end up with OOM because for all new memory blocks we need
to allocate page tables, struct pages, ... and we need memory to do
that. The userspace program doing memory onlining also needs memory to
run and in case it prefers to fork to handle hundreds of notfifications
... well, it may get OOMkilled before it manages to online anything.

Allocating all kernel objects from the newly hotplugged blocks would
definitely help to manage the situation but as I said this won't solve
the 'forking udev' problem completely (it will likely remain in
'extreme' cases only. We can probably work around it by onlining with a
dedicated process which doesn't do memory allocation).

-- 
Vitaly
