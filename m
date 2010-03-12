From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Fri, 12 Mar 2010 14:01:54 +0100
Message-ID: <201003121401.54675.trenn@suse.de>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com> <4B979E63.1070806@redhat.com> <1268268915.3606.101.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40625 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932689Ab0CLNB5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Mar 2010 08:01:57 -0500
In-Reply-To: <1268268915.3606.101.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thursday 11 March 2010 01:55:15 ykzhao wrote:
> On Wed, 2010-03-10 at 21:28 +0800, Prarit Bhargava wrote:
> > >
> > > Why do we need to see whether the memory is onlined before bringi=
ng cpu
> > > to online state? It seems that there is no dependency between cpu=
 online
> > > and memory online.
> > >
> > >  =20
> >=20
> > Yakui,
> >=20
>=20
> =EF=BB=BFThanks for the explanation.
>=20
> > Here's a deeper look into the issue.  New Intel processors have an=20
> > on-die memory controller and this means that as the socket comes an=
d=20
> > goes, so does the memory "behind" the socket.
>=20
> Yes. The nehalem processor has the integrated memory controller. But =
it
> is not required that the hot-added memory should be onlined before
> bringing up CPU.
>     I do the following memory-hotplug test on one Machine.
>     a. Before hot plugging memory, four CPUs socket are installed and
> all the logical CPU are brought up. (Only one node has the memory)
>     b. The memory is hot-plugged and then the memory is onlined so th=
at
> it can be accessed by the system.
>=20
> In the above testing case the CPU is brought up before onlining the
> hot-added memory. And the test shows that it can work well.
>=20
> >=20
> > ie) with new processors it is possible that an entire node which=20
> > consists of memory and cpus comes and goes with the socket enable a=
nd=20
> > disable.
> >=20
> > The cpu bringup code does local node allocations for the cpu.  If t=
he=20
> > memory connected to the node (which is "behind" the socket) isn't=20
> > online, then these allocations fail, and then the cpu bringup fails=
=2E
>=20
> If the CPU can't allocate the memory from its own node, it can turn t=
o
> other node and see whether the memory can be allocated. And this depe=
nds
> on the NUMA allocation policy.
Yes and this is broken and needs fixing.
Yakui, I expect you miss this patch and wrongly online the cpus to exis=
ting
nodes, therefore you do not run into "out of memory" conditions:
0271f91003d3703675be13b8865618359a6caa1f

I know for sure that slab is broken.
slub behaves different, but I am not sure whether this is due to wrong =
CPU
hotadd code (processor_core.c is also broken and you get wrong C-state =
info
from BIOS tables on hotadded CPUs)

Prarit: Can you retest with slub and processor.max_cstate=3D1, this cou=
ld/should
work.

AFAIK vmware injects memory in the same way into clients, so you may ha=
ve
different behavior of virtualized Linux clients.

This is a work around for current memory management not being able
to allocate from foreign nodes. That should not mean that I generally
vote against this to get added. If it works reliably why not add a work
around until the more complicated stuff works.

One question: You also want to automatically add the CPUs, once a CPU h=
otplug
event got fired, right?
The fact that the memory hotplug driver adds the memory immediately onc=
e notified,
does not ensure that the HW/BIOS fires this event first.
Theoretically you need a logic to not add CPUs to memoryless nodes, pol=
l/wait
until memory got added, etc.

   Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
