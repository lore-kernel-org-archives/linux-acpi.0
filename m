From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv5 10/10] doc/mm: New documentation for memory performance
Date: Wed, 6 Feb 2019 09:25:53 -0700
Message-ID: <20190206162553.GI28064@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190124230724.10022-11-keith.busch@intel.com>
 <20190206104552.00003bad@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206104552.00003bad@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 06, 2019 at 10:45:52AM +0000, Jonathan Cameron wrote:
> On Thu, 24 Jan 2019 16:07:24 -0700
> Keith Busch <keith.busch@intel.com> wrote:
> > +	# tree -P "read*|write*" /sys/devices/system/node/nodeY/access0/
> > +	/sys/devices/system/node/nodeY/access0/
> > +	|-- read_bandwidth
> > +	|-- read_latency
> > +	|-- write_bandwidth
> > +	`-- write_latency
> 
> These seem to be under
> /sys/devices/system/node/nodeY/access0/initiators/
> (so one directory deeper).

You're right, I used data from the previous series to generate that.
 
> > +	# tree sys/devices/system/node/node0/side_cache/
> > +	/sys/devices/system/node/node0/side_cache/
> > +	|-- index1
> > +	|   |-- associativity
> > +	|   |-- level
> 
> What is the purpose of having level in here?  Isn't it the same as the A..C
> in the index naming?

Yes, it is redundant with the name. I will remove it.
 
> > +	|   |-- line_size
> > +	|   |-- size
> > +	|   `-- write_policy
> > +
> > +The "associativity" will be 0 if it is a direct-mapped cache, and non-zero
> > +for any other indexed based, multi-way associativity.
> 
> Is it worth providing the ACPI mapping in this doc?  We have None, Direct and
> 'complex'.   Fun question of what None means?  Not specified?

Yeah, my take on "none" was that it's unreported and we don't know what
is actually happening..

> > +
> > +The "level" is the distance from the far memory, and matches the number
> > +appended to its "index" directory.
> > +
> > +The "line_size" is the number of bytes accessed on a cache miss.
> 
> Maybe "number of bytes accessed from next cache level" ?

Sounds good.
