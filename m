From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [RFC v2 0/5] surface heterogeneous memory performance information
Date: Fri, 7 Jul 2017 10:25:12 -0600
Message-ID: <20170707162512.GA22856@linux.intel.com>
References: <20170706215233.11329-1-ross.zwisler@linux.intel.com>
 <1499408836.23251.3.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:39396 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750892AbdGGQZP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 Jul 2017 12:25:15 -0400
Content-Disposition: inline
In-Reply-To: <1499408836.23251.3.camel@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, linux-kernel@vger.kernel.org, "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>, "Box, David E" <david.e.box@intel.com>, "Kogut, Jaroslaw" <Jaroslaw.Kogut@intel.com>, "Lahtinen, Joonas" <joonas.lahtinen@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Nachimuthu, Murugasamy" <murugasamy.nachimuthu@intel.com>, "Odzioba, Lukasz" <lukasz.odzioba@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Schmauss, Erik" <erik.schmauss@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@intel.com>, Greg

On Fri, Jul 07, 2017 at 04:27:16PM +1000, Balbir Singh wrote:
> On Thu, 2017-07-06 at 15:52 -0600, Ross Zwisler wrote:
> > ==== Quick Summary ====
> > 
> > Platforms in the very near future will have multiple types of memory
> > attached to a single CPU.  These disparate memory ranges will have some
> > characteristics in common, such as CPU cache coherence, but they can have
> > wide ranges of performance both in terms of latency and bandwidth.
> > 
> > For example, consider a system that contains persistent memory, standard
> > DDR memory and High Bandwidth Memory (HBM), all attached to the same CPU.
> > There could potentially be an order of magnitude or more difference in
> > performance between the slowest and fastest memory attached to that CPU.
> > 
> > With the current Linux code NUMA nodes are CPU-centric, so all the memory
> > attached to a given CPU will be lumped into the same NUMA node.  This makes
> > it very difficult for userspace applications to understand the performance
> > of different memory ranges on a given CPU.
> > 
> > We solve this issue by providing userspace with performance information on
> > individual memory ranges.  This performance information is exposed via
> > sysfs:
> > 
> >   # grep . mem_tgt2/* mem_tgt2/local_init/* 2>/dev/null
> >   mem_tgt2/firmware_id:1
> >   mem_tgt2/is_cached:0
> >   mem_tgt2/is_enabled:1
> >   mem_tgt2/is_isolated:0
> 
> Could you please explain these charactersitics, are they in the patches
> to follow?

Yea, sorry, these do need more explanation.  These values are derived from the
ACPI SRAT/HMAT tables:

> >   mem_tgt2/firmware_id:1

This is the proximity domain, as defined in the SRAT and HMAT.  Basically
every ACPI proximity domain will end up being a unique NUMA node in Linux, but
the numbers may get reordered and Linux can create extra NUMA nodes that don't
map back to ACPI proximity domains.  So, this value is needed if anyone ever
wants to look at the ACPI HMAT and SRAT tables directly and make sense of how
they map to NUMA nodes in Linux.

> >   mem_tgt2/is_cached:0

The HMAT provides lots of detailed information when a memory region has
caching layers.  For each layer of memory caching it has the ability to
provide latency and bandwidth information for both reads and writes,
information about the caching associativity (direct mapped, something more
complex), the writeback policy (WB, WT), the cache line size, etc.

For simplicity this sysfs interface doesn't expose that level of detail to the
user, and this flag just lets the user know whether the memory region they are
looking at has caching layers or not.  Right now the additional details, if
desired, can be gathered by looking at the raw tables.

> >   mem_tgt2/is_enabled:1

Tells whether the memory region is enabled, as defined by the flags in the
SRAT.  Actually, though, in this version of the patch series we don't create
entries for CPUs or memory regions that aren't enabled, so this isn't needed.
I'll remove for v3.

> >   mem_tgt2/is_isolated:0

This surfaces a flag in the HMAT's Memory Subsystem Address Range Structure:

  Bit [2]: Reservation hint—if set to 1, it is recommended
  that the operating system avoid placing allocations in
  this region if it cannot relocate (e.g. OS core memory
  management structures, OS core executable). Any
  allocations placed here should be able to be relocated
  (e.g. disk cache) if the memory is needed for another
  purpose.

Adding kernel support for this hint (i.e. actually reserving the memory region
during boot so it isn't used by the kernel or userspace, and is fully
available for explicit allocation) is part of the future work that we'd do in
follow-on patch series.

> >   mem_tgt2/phys_addr_base:0x0
> >   mem_tgt2/phys_length_bytes:0x800000000
> >   mem_tgt2/local_init/read_bw_MBps:30720
> >   mem_tgt2/local_init/read_lat_nsec:100
> >   mem_tgt2/local_init/write_bw_MBps:30720
> >   mem_tgt2/local_init/write_lat_nsec:100
> 
> How to these numbers compare to normal system memory?

These are garbage numbers that I made up in my hacked-up QEMU target. :)  

> > This allows applications to easily find the memory that they want to use.
> > We expect that the existing NUMA APIs will be enhanced to use this new
> > information so that applications can continue to use them to select their
> > desired memory.
> > 
> > This series is built upon acpica-1705:
> > 
> > https://github.com/zetalog/linux/commits/acpica-1705
> > 
> > And you can find a working tree here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/zwisler/linux.git/log/?h=hmem_sysfs
> > 
> > ==== Lots of Details ====
> > 
> > This patch set is only concerned with CPU-addressable memory types, not
> > on-device memory like what we have with Jerome Glisse's HMM series:
> > 
> > https://lwn.net/Articles/726691/
> > 
> > This patch set works by enabling the new Heterogeneous Memory Attribute
> > Table (HMAT) table, newly defined in ACPI 6.2. One major conceptual change
> > in ACPI 6.2 related to this work is that proximity domains no longer need
> > to contain a processor.  We can now have memory-only proximity domains,
> > which means that we can now have memory-only Linux NUMA nodes.
> > 
> > Here is an example configuration where we have a single processor, one
> > range of regular memory and one range of HBM:
> > 
> >   +---------------+   +----------------+
> >   | Processor     |   | Memory         |
> >   | prox domain 0 +---+ prox domain 1  |
> >   | NUMA node 1   |   | NUMA node 2    |
> >   +-------+-------+   +----------------+
> >           |
> >   +-------+----------+
> >   | HBM              |
> >   | prox domain 2    |
> >   | NUMA node 0      |
> >   +------------------+
> > 
> > This gives us one initiator (the processor) and two targets (the two memory
> > ranges).  Each of these three has its own ACPI proximity domain and
> > associated Linux NUMA node.  Note also that while there is a 1:1 mapping
> > from each proximity domain to each NUMA node, the numbers don't necessarily
> > match up.  Additionally we can have extra NUMA nodes that don't map back to
> > ACPI proximity domains.
> 
> Could you expand on proximity domains, are they the same as node distance
> or is this ACPI terminology for something more?

I think I answered this above in my explanation of the "firmware_id" field,
but please let me know if you have any more questions.  Basically, a proximity
domain is an ACPI concept that is very similar to a Linux NUMA node, and every
ACPI proximity domain generates and can be mapped to a unique Linux NUMA node.
