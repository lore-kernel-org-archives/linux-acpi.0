From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv4 10/13] node: Add memory caching attributes
Date: Mon, 11 Feb 2019 08:23:04 -0700
Message-ID: <20190211152303.GA4525@localhost.localdomain>
References: <20190116175804.30196-1-keith.busch@intel.com>
 <20190116175804.30196-11-keith.busch@intel.com>
 <4a7d1c0c-c269-d7b2-11cb-88ad62b70a06@inria.fr>
 <20190210171958.00003ab2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190210171958.00003ab2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Sun, Feb 10, 2019 at 09:19:58AM -0800, Jonathan Cameron wrote:
> On Sat, 9 Feb 2019 09:20:53 +0100
> Brice Goglin <Brice.Goglin@inria.fr> wrote:
> 
> > Hello Keith
> > 
> > Could we ever have a single side cache in front of two NUMA nodes ? I
> > don't see a way to find that out in the current implementation. Would we
> > have an "id" and/or "nodemap" bitmask in the sidecache structure ?
> 
> This is certainly a possible thing for hardware to do.
>
> ACPI IIRC doesn't provide any means of representing that - your best
> option is to represent it as two different entries, one for each of the
> memory nodes.  Interesting question of whether you would then claim
> they were half as big each, or the full size.  Of course, there are
> other possible ways to get this info beyond HMAT, so perhaps the interface
> should allow it to be exposed if available?

HMAT doesn't do this, but I want this interface abstracted enough from
HMAT to express whatever is necessary.

The CPU cache is the closest existing exported attributes to this,
and they provide "shared_cpu_list". To that end, I can export a
"shared_node_list", though previous reviews strongly disliked multi-value
sysfs entries. :(

Would shared-node symlinks capture the need, and more acceptable?
 
> Also, don't know if it's just me, but calling these sidecaches is
> downright confusing.  In ACPI at least they are always
> specifically referred to as Memory Side Caches.
> I'd argue there should even by a hyphen Memory-Side Caches, the point
> being that that they are on the memory side of the interconnected
> rather than the processor side.  Of course an implementation
> choice might be to put them off to the side (as implied by sidecaches)
> in some sense, but it's not the only one.
> 
> </terminology rant> :)

Now that you mention it, I agree "side" is ambiguous.  Maybe call it
"numa_cache" or "node_cache"?
