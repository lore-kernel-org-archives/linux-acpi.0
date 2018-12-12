From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv2 12/12] doc/mm: New documentation for memory performance
Date: Wed, 12 Dec 2018 07:45:53 -0700
Message-ID: <20181212144553.GB10780@localhost.localdomain>
References: <20181211010310.8551-1-keith.busch@intel.com>
 <20181211010310.8551-13-keith.busch@intel.com>
 <681f14eb-def4-bf40-fdfd-b5fb89045132@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <681f14eb-def4-bf40-fdfd-b5fb89045132@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 12, 2018 at 10:23:24AM +0530, Aneesh Kumar K.V wrote:
> On 12/11/18 6:33 AM, Keith Busch wrote:
> > +When multiple memory initiators exist, they may not all have the same
> > +performance when accessing a given memory target. The highest performing
> > +initiator to a given target is considered to be one of that target's
> > +local initiators. Any given target may have one or more local initiators,
> > +and any given initiator may have multiple local memory targets.
> > +
> 
> Can you also add summary here suggesting node X is compute and Node y is
> memory target

Sure thing.
 
> > +To aid applications matching memory targets with their initiators,
> > +the kernel provide symlinks to each other like the following example::
> > +
> > +	# ls -l /sys/devices/system/node/nodeX/local_target*
> > +	/sys/devices/system/node/nodeX/local_targetY -> ../nodeY
> > +
> > +	# ls -l /sys/devices/system/node/nodeY/local_initiator*
> > +	/sys/devices/system/node/nodeY/local_initiatorX -> ../nodeX
> > +
> 
> the patch series had primary_target and primary_initiator

Yeah, I noticed that mistake too. I went through several iterations of
naming this, and I think it will yet be named something else in the
final revision to accomodate different access levels since it sounds
like some people may wish to show more than just the best.

> > +When the kernel first registers a memory cache with a node, the kernel
> > +will create the following directory::
> > +
> > +	/sys/devices/system/node/nodeX/side_cache/
> > +
> 
> This is something even the patch commit message didn't explain we create
> side_cache directory in memory target nodes or initiator nodes? I assume it
> is part of memory target nodes. If so to be consistent can you use nodeY?

Right, only memory targets may have memory side caches. Will use more
consistent symbols.
