From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Date: Wed, 5 Dec 2018 09:27:09 -0800
Message-ID: <b3122fdf-02c3-2e9c-1da6-fb873b824d59@intel.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <6e2a1dba-80a8-42bf-127c-2f5c2441c248@intel.com>
 <20181205001544.GR2937@redhat.com>
 <42006749-7912-1e97-8ccd-945e82cebdde@intel.com>
 <20181205021334.GB3045@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205021334.GB3045@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Matthew Wilcox <willy@infradead.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Keith Busch <keith.busch@intel.com>, Dan Williams <dan.j.williams@intel.com>, Haggai Eran <haggaie@mellanox.com>, Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Paul Blinzer <Paul.Blinzer@amd.com>, Logan Gunthorpe <logang@deltatee.com>, John Hubbard <jhubbard@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>
List-Id: linux-acpi@vger.kernel.org

On 12/4/18 6:13 PM, Jerome Glisse wrote:
> On Tue, Dec 04, 2018 at 05:06:49PM -0800, Dave Hansen wrote:
>> OK, but there are 1024*1024 matrix cells on a systems with 1024
>> proximity domains (ACPI term for NUMA node).  So it sounds like you are
>> proposing a million-directory approach.
> 
> No, pseudo code:
>     struct list links;
> 
>     for (unsigned r = 0; r < nrows; r++) {
>         for (unsigned c = 0; c < ncolumns; c++) {
>             if (!link_find(links, hmat[r][c].bandwidth,
>                            hmat[r][c].latency)) {
>                 link = link_new(hmat[r][c].bandwidth,
>                                 hmat[r][c].latency);
>                 // add initiator and target correspond to that row
>                 // and columns to this new link
>                 list_add(&link, links);
>             }
>         }
>     }
> 
> So all cells that have same property are under the same link. 

OK, so the "link" here is like a cable.  It's like saying, "we have a
network and everything is connected with an ethernet cable that can do
1gbit/sec".

But, what actually connects an initiator to a target?  I assume we still
need to know which link is used for each target/initiator pair.  Where
is that enumerated?

I think this just means we need a million symlinks to a "link" instead
of a million link directories.  Still not great.

> Note that userspace can parse all this once during its initialization
> and create pools of target to use.

It sounds like you're agreeing that there is too much data in this
interface for applications to _regularly_ parse it.  We need some
central thing that parses it all and caches the results.
