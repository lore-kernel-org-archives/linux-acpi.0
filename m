From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv4 10/13] node: Add memory caching attributes
Date: Tue, 12 Feb 2019 10:31:20 -0700
Message-ID: <20190212173120.GD6176@localhost.localdomain>
References: <20190116175804.30196-1-keith.busch@intel.com>
 <20190116175804.30196-11-keith.busch@intel.com>
 <4a7d1c0c-c269-d7b2-11cb-88ad62b70a06@inria.fr>
 <20190210171958.00003ab2@huawei.com>
 <20190211152303.GA4525@localhost.localdomain>
 <20190212084903.00003ff5@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212084903.00003ff5@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 12, 2019 at 08:49:03AM +0000, Jonathan Cameron wrote:
> On Mon, 11 Feb 2019 08:23:04 -0700
> Keith Busch <keith.busch@intel.com> wrote:
> 
> > On Sun, Feb 10, 2019 at 09:19:58AM -0800, Jonathan Cameron wrote:
> > > On Sat, 9 Feb 2019 09:20:53 +0100
> > > Brice Goglin <Brice.Goglin@inria.fr> wrote:
> > >   
> > > > Hello Keith
> > > > 
> > > > Could we ever have a single side cache in front of two NUMA nodes ? I
> > > > don't see a way to find that out in the current implementation. Would we
> > > > have an "id" and/or "nodemap" bitmask in the sidecache structure ?  
> > > 
> > > This is certainly a possible thing for hardware to do.
> > >
> > > ACPI IIRC doesn't provide any means of representing that - your best
> > > option is to represent it as two different entries, one for each of the
> > > memory nodes.  Interesting question of whether you would then claim
> > > they were half as big each, or the full size.  Of course, there are
> > > other possible ways to get this info beyond HMAT, so perhaps the interface
> > > should allow it to be exposed if available?  
> > 
> > HMAT doesn't do this, but I want this interface abstracted enough from
> > HMAT to express whatever is necessary.
> > 
> > The CPU cache is the closest existing exported attributes to this,
> > and they provide "shared_cpu_list". To that end, I can export a
> > "shared_node_list", though previous reviews strongly disliked multi-value
> > sysfs entries. :(
> > 
> > Would shared-node symlinks capture the need, and more acceptable?
> 
> My inclination is that it's better to follow an existing pattern than
> invent a new one that breaks people's expectations.
> 
> However, don't feel that strongly about it as long as the interface
> is functional and intuitive.

Okay, considering I'd have a difficult time testing such an interface
since it doesn't apply to HMAT, and I've received only conflicting
feedback on list attributes, I would prefer to leave this feature out
of this series for now. I'm certainly not against adding it later.
