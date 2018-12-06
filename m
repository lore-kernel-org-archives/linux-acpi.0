From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Date: Thu, 6 Dec 2018 16:48:57 -0700
Message-ID: <cd5cf2a6-7415-eae7-0305-004cc7db994b@deltatee.com>
References: <20181205001544.GR2937@redhat.com>
 <42006749-7912-1e97-8ccd-945e82cebdde@intel.com>
 <20181205021334.GB3045@redhat.com>
 <b3122fdf-02c3-2e9c-1da6-fb873b824d59@intel.com>
 <20181205175357.GG3536@redhat.com>
 <b8fab9a7-62ed-5d8d-3cb1-aea6aacf77fe@intel.com>
 <20181206192050.GC3544@redhat.com>
 <d6508932-377c-a4d1-d4d8-01d0f55b9190@intel.com>
 <c583be1b-17db-1ed3-0f5a-bd119edc8bfe@deltatee.com>
 <f7eb9939-d550-706a-946d-acbb7383172e@intel.com>
 <20181206223935.GG3544@redhat.com>
 <c1126d60-95c0-ed34-6314-fcec17ac1c29@intel.com>
 <935fc14d-91f2-bc2a-f8b5-665e4145e148@deltatee.com>
 <5e6c87d5-e4ef-12e7-32bf-c163f7ff58d7@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5e6c87d5-e4ef-12e7-32bf-c163f7ff58d7@intel.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>, Jerome Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Matthew Wilcox <willy@infradead.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Keith Busch <keith.busch@intel.com>, Dan Williams <dan.j.williams@intel.com>, Haggai Eran <haggaie@mellanox.com>, Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Paul Blinzer <Paul.Blinzer@amd.com>, John Hubbard <jhubbard@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>, Michal Hocko <mhocko@kernel.org>
List-Id: linux-acpi@vger.kernel.org



On 2018-12-06 4:38 p.m., Dave Hansen wrote:
> On 12/6/18 3:28 PM, Logan Gunthorpe wrote:
>> I didn't think this was meant to describe actual real world performance
>> between all of the links. If that's the case all of this seems like a
>> pipe dream to me.
> 
> The HMAT discussions (that I was a part of at least) settled on just
> trying to describe what we called "sticker speed".  Nobody had an
> expectation that you *really* had to measure everything.
> 
> The best we can do for any of these approaches is approximate things.

Yes, though there's a lot of caveats in this assumption alone.
Specifically with PCI: the bus may run at however many GB/s but P2P
through a CPU's root complexes can slow down significantly (like down to
MB/s).

I've seen similar things across QPI: I can sometimes do P2P from
PCI->QPI->PCI but the performance doesn't even come close to the sticker
speed of any of those buses.

I'm not sure how anyone is going to deal with those issues, but it does
firmly place us in world view #2 instead of #1. But, yes, I agree
exposing information like in #2 full out to userspace, especially
through sysfs, seems like a nightmare and I don't see anything in HMS to
help with that. Providing an API to ask for memory (or another resource)
that's accessible by a set of initiators and with a set of requirements
for capabilities seems more manageable.

Logan
