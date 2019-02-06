From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv5 00/10] Heterogeneuos memory node attributes
Date: Wed, 6 Feb 2019 10:19:37 -0700
Message-ID: <20190206171935.GJ28064@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190206123100.0000094a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206123100.0000094a@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 06, 2019 at 12:31:00PM +0000, Jonathan Cameron wrote:
> On Thu, 24 Jan 2019 16:07:14 -0700
> Keith Busch <keith.busch@intel.com> wrote:
> 
> 1) It seems this version added a hard dependence on having the memory node
>    listed in the Memory Proximity Domain attribute structures.  I'm not 100%
>    sure there is actually any requirement to have those structures. If you aren't
>    using the hint bit, they don't convey any information.  It could be argued
>    that they provide info on what is found in the other hmat entries, but there
>    is little purpose as those entries are explicit in what the provide.
>    (Given I didn't have any of these structures and things  worked fine with
>     v4 it seems this is a new check).

Right, v4 just used the node(s) with the highest performance. You mentioned
systems having nodes with different performance, but no winner across all
attributes, so there's no clear way to rank these for access class linkage.
Requiring an initiator PXM present clears that up.

Maybe we can fallback to performance if the initiator pxm isn't provided,
but the ranking is going to require an arbitrary decision, like prioritize
latency over bandwidth.
 
>    This is also somewhat inconsistent.
>    a) If a given entry isn't there, we still get for example
>       node4/access0/initiators/[read|write]_* but all values are 0.
>       If we want to do the check you have it needs to not create the files in
>       this case.  Whilst they have no meaning as there are no initiators, it
>       is inconsistent to my mind.
> 
>    b) Having one "Memory Proximity Domain attribute structure" for node 4 linking
>       it to node0 is sufficient to allow
>       node4/access0/initiators/node0
>       node4/access0/initiators/node1
>       node4/access0/initiators/node2
>       node4/access0/initiators/node3
>       I think if we are going to enforce the presence of that structure then only
>       the node0 link should exist.

We'd link the initiator pxm in the Address Range Structure, and also any
other nodes with identical performance access. I think that makes sense.
 
> 2) Error handling could perhaps do to spit out some nasty warnings.
>    If we have an entry for nodes that don't exist we shouldn't just fail silently,
>    that's just one example I managed to trigger with minor table tweaking.
> 
> Personally I would just get rid of enforcing anything based on the presence of
> that structure.
