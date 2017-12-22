From: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 0/3] create sysfs representation of ACPI HMAT
Date: Fri, 22 Dec 2017 15:13:30 -0700
Message-ID: <20171222221330.GB25711@linux.intel.com>
References: <20171214021019.13579-1-ross.zwisler@linux.intel.com>
 <2d6420f7-0a95-adfe-7390-a2aea4385ab2@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2d6420f7-0a95-adfe-7390-a2aea4385ab2-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Anshuman Khandual <khandual-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: "Box, David E" <david.e.box-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Anaczkowski,
 Lukasz" <lukasz.anaczkowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore,
 Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Odzioba,
 Lukasz" <lukasz.odzioba-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Schmauss, Erik" <erik.schmauss-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, "Kogut,
 Jaroslaw" <Jaroslaw.Kogut-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, "Koss,
 Marcin" <marcin.koss-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Brice Goglin <brice.goglin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Nachimuthu, Murugasamy" <murugasamy.nachimuthu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Koziej,
 Artur" <artur.koziej-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Lahtinen,
 Joonas" <joonas.lahtinen-ral2JQCrhuE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 22, 2017 at 08:39:41AM +0530, Anshuman Khandual wrote:
> On 12/14/2017 07:40 AM, Ross Zwisler wrote:
> > ==== Quick Summary ====
> > 
> > Platforms exist today which have multiple types of memory attached to a
> > single CPU.  These disparate memory ranges have some characteristics in
> > common, such as CPU cache coherence, but they can have wide ranges of
> > performance both in terms of latency and bandwidth.
> 
> Right.
> 
> > 
> > For example, consider a system that contains persistent memory, standard
> > DDR memory and High Bandwidth Memory (HBM), all attached to the same CPU.
> > There could potentially be an order of magnitude or more difference in
> > performance between the slowest and fastest memory attached to that CPU.
> 
> Right.
> 
> > 
> > With the current Linux code NUMA nodes are CPU-centric, so all the memory
> > attached to a given CPU will be lumped into the same NUMA node.  This makes
> > it very difficult for userspace applications to understand the performance
> > of different memory ranges on a given CPU.
> 
> Right but that might require fundamental changes to the NUMA representation.
> Plugging those memory as separate NUMA nodes, identify them through sysfs
> and try allocating from it through mbind() seems like a short term solution.
> 
> Though if we decide to go in this direction, sysfs interface or something
> similar is required to enumerate memory properties.

Yep, and this patch series is trying to be the sysfs interface that is
required to the memory properties.  :)  It's a certainty that we will have
memory-only NUMA nodes, at least on platforms that support ACPI.  Supporting
memory-only proximity domains (which Linux turns in to memory-only NUMA nodes)
is explicitly supported with the introduction of the HMAT in ACPI 6.2.

It also turns out that the existing memory management code already deals with
them just fine - you see this with my hmat_examples setup:

https://github.com/rzwisler/hmat_examples

Both configurations created by this repo create memory-only NUMA nodes, even
with upstream kernels.  My patches don't change that, they just provide a
sysfs representation of the HMAT so users can discover the memory that exists
in the system.

> > We solve this issue by providing userspace with performance information on
> > individual memory ranges.  This performance information is exposed via
> > sysfs:
> > 
> >   # grep . mem_tgt2/* mem_tgt2/local_init/* 2>/dev/null
> >   mem_tgt2/firmware_id:1
> >   mem_tgt2/is_cached:0
> >   mem_tgt2/local_init/read_bw_MBps:40960
> >   mem_tgt2/local_init/read_lat_nsec:50
> >   mem_tgt2/local_init/write_bw_MBps:40960
> >   mem_tgt2/local_init/write_lat_nsec:50
> 
> I might have missed discussions from earlier versions, why we have this
> kind of a "source --> target" model ? We will enlist properties for all
> possible "source --> target" on the system ? Right now it shows only
> bandwidth and latency properties, can it accommodate other properties
> as well in future ?

The initiator/target model is useful in preventing us from needing a
MAX_NUMA_NODES x MAX_NUMA_NODES sized table for each performance attribute.  I
talked about it a little more here:

https://lists.01.org/pipermail/linux-nvdimm/2017-December/013654.html

> > This allows applications to easily find the memory that they want to use.
> > We expect that the existing NUMA APIs will be enhanced to use this new
> > information so that applications can continue to use them to select their
> > desired memory.
> 
> I had presented a proposal for NUMA redesign in the Plumbers Conference this
> year where various memory devices with different kind of memory attributes
> can be represented in the kernel and be used explicitly from the user space.
> Here is the link to the proposal if you feel interested. The proposal is
> very intrusive and also I dont have a RFC for it yet for discussion here.
> 
> https://linuxplumbersconf.org/2017/ocw//system/presentations/4656/original/Hierarchical_NUMA_Design_Plumbers_2017.pdf

I'll take a look, but my first reaction is that I agree with Dave that it
seems hard to re-teach systems a new NUMA scheme.  This patch series doesn't
attempt to do that - it is very unintrusive and only informs users about the
memory-only NUMA nodes that will already exist in their ACPI-based systems.

> Problem is, designing the sysfs interface for memory attribute detection
> from user space without first thinking about redesigning the NUMA for
> heterogeneous memory may not be a good idea. Will look into this further.
