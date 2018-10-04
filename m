From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
Date: Thu, 4 Oct 2018 09:40:56 +0200
Message-ID: <060bd891-f88e-13e1-2bb3-26d96f6d28cb@redhat.com>
References: <20180928150357.12942-1-david@redhat.com>
 <20181001084038.GD18290@dhcp22.suse.cz>
 <d54a8509-725f-f771-72f0-15a9d93e8a49@redhat.com>
 <20181002134734.GT18290@dhcp22.suse.cz>
 <98fb8d65-b641-2225-f842-8804c6f79a06@redhat.com>
 <20181003135407.GI4714@dhcp22.suse.cz>
 <9fef1f7d-2d7c-03f1-00e3-5fa657eda019@redhat.com>
 <20181004062811.GC22173@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181004062811.GC22173@dhcp22.suse.cz>
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

On 04/10/2018 08:28, Michal Hocko wrote:
> On Wed 03-10-18 19:00:29, David Hildenbrand wrote:
> [...]
>> Let me rephrase: You state that user space has to make the decision and
>> that user should be able to set/reconfigure rules. That is perfectly fine.
>>
>> But then we should give user space access to sufficient information to
>> make a decision. This might be the type of memory as we learned (what
>> some part of this patch proposes), but maybe later more, e.g. to which
>> physical device memory belongs (e.g. to hotplug it all movable or all
>> normal) ...
> 
> I am pretty sure that user knows he/she wants to use ballooning in
> HyperV or Xen, or that the memory hotplug should be used as a "RAS"
> feature to allow add and remove DIMMs for reliability. Why shouldn't we
> have a package to deploy an appropriate set of udev rules for each of
> those usecases? I am pretty sure you need some other plumbing to enable
> them anyway (e.g. RAS would require to have movable_node kernel
> parameters, ballooning a kernel module etc.).
> 
> Really, one udev script to rule them all will simply never work.
> 

I am on your side. We will need multiple ones. But we need sane
defaults. And a default rule will always exist. And users will expect
that the defaults somewhat match their expectation unless they really
have some special use cases.

All I am saying is, again, that if user space is to make decisions, it
should get sufficient information to make sane decision. And in my point
of view, the type of memory allows us to make these decision and to
provide a "single udev script to rule them all" with sane defaults.

I at least think the distinction between "auto-online" and "standby" is
required (what Dave suggested).

The we can make a simple rule

if (auto-online memory) {
	if (virtual environment) {
		"online"
	} else {
		"online_movable"
	}
}
/* standby memory not onlined as default */

We are able to provide sane defaults.

-- 

Thanks,

David / dhildenb
