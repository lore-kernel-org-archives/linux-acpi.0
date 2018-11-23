From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
Date: Fri, 23 Nov 2018 19:06:53 +0100
Message-ID: <20181123190653.6da91461@kitsune.suse.cz>
References: <20180928150357.12942-1-david@redhat.com>
 <b01a956b-080c-c643-6473-eb132b9f7200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <b01a956b-080c-c643-6473-eb132b9f7200@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: David Hildenbrand <david@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>, "H.
 Peter Anvin" <hpa@zytor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Rashmica Gupta <rashmica.g@gmail.com>, Dan Williams <dan.j.williams@intel.com>, linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Rob Herring <robh@kernel.org>, "mike.travis@hpe.com" <mike.trav>
List-Id: linux-acpi@vger.kernel.org

On Fri, 23 Nov 2018 12:13:58 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 28.09.18 17:03, David Hildenbrand wrote:
> > How to/when to online hotplugged memory is hard to manage for
> > distributions because different memory types are to be treated differently.
> > Right now, we need complicated udev rules that e.g. check if we are
> > running on s390x, on a physical system or on a virtualized system. But
> > there is also sometimes the demand to really online memory immediately
> > while adding in the kernel and not to wait for user space to make a
> > decision. And on virtualized systems there might be different
> > requirements, depending on "how" the memory was added (and if it will
> > eventually get unplugged again - DIMM vs. paravirtualized mechanisms).
> > 
> > On the one hand, we have physical systems where we sometimes
> > want to be able to unplug memory again - e.g. a DIMM - so we have to online
> > it to the MOVABLE zone optionally. That decision is usually made in user
> > space.
> > 
> > On the other hand, we have memory that should never be onlined
> > automatically, only when asked for by an administrator. Such memory only
> > applies to virtualized environments like s390x, where the concept of
> > "standby" memory exists. Memory is detected and added during boot, so it
> > can be onlined when requested by the admininistrator or some tooling.
> > Only when onlining, memory will be allocated in the hypervisor.
> > 
> > But then, we also have paravirtualized devices (namely xen and hyper-v
> > balloons), that hotplug memory that will never ever be removed from a
> > system right now using offline_pages/remove_memory. If at all, this memory
> > is logically unplugged and handed back to the hypervisor via ballooning.
> > 
> > For paravirtualized devices it is relevant that memory is onlined as
> > quickly as possible after adding - and that it is added to the NORMAL
> > zone. Otherwise, it could happen that too much memory in a row is added
> > (but not onlined), resulting in out-of-memory conditions due to the
> > additional memory for "struct pages" and friends. MOVABLE zone as well
> > as delays might be very problematic and lead to crashes (e.g. zone
> > imbalance).
> > 
> > Therefore, introduce memory block types and online memory depending on
> > it when adding the memory. Expose the memory type to user space, so user
> > space handlers can start to process only "normal" memory. Other memory
> > block types can be ignored. One thing less to worry about in user space.
> >   
> 
> So I was looking into alternatives.
> 
> 1. Provide only "normal" and "standby" memory types to user space. This
> way user space can make smarter decisions about how to online memory.
> Not really sure if this is the right way to go.
> 
> 
> 2. Use device driver information (as mentioned by Michal S.).
> 
> The problem right now is that there are no drivers for memory block
> devices. The "memory" subsystem has no drivers, so the KOBJ_ADD uevent
> will not contain a "DRIVER" information and we ave no idea what kind of
> memory block device we hold in our hands.
> 
> $ udevadm info -q all -a /sys/devices/system/memory/memory0
> 
>   looking at device '/devices/system/memory/memory0':
>     KERNEL=="memory0"
>     SUBSYSTEM=="memory"
>     DRIVER==""
>     ATTR{online}=="1"
>     ATTR{phys_device}=="0"
>     ATTR{phys_index}=="00000000"
>     ATTR{removable}=="0"
>     ATTR{state}=="online"
>     ATTR{valid_zones}=="none"
> 
> 
> If we would provide "fake" drivers for the memory block devices we want
> to treat in a special way in user space (e.g. standby memory on s390x),
> user space could use that information to make smarter decisions.
> 
> Adding such drivers might work. My suggestion would be to let ordinary
> DIMMs be without a driver for now and only special case standby memory
> and eventually paravirtualized memory devices (XEN and Hyper-V).
> 
> Any thoughts?

If we are going to fake the driver information we may as well add the
type attribute and be done with it.

I think the problem with the patch was more with the semantic than the
attribute itself.

What is normal, paravirtualized, and standby memory?

I can understand DIMM device, baloon device, or whatever mechanism for
adding memory you might have.

I can understand "memory designated as standby by the cluster
administrator".

However, DIMM vs baloon is orthogonal to standby and should not be
conflated into one property.

paravirtualized means nothing at all in relationship to memory type and
the desired online policy to me.

Lastly I would suggest if you add any property you add it to *all*
memory that is hotplugged. That way the userspace can detect if it can
rely on the information from your patch or not. Leaving some memory
untagged makes things needlessly vague.

Thanks

Michal
