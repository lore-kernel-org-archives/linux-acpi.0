From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Date: Thu, 6 Dec 2018 11:31:21 -0800
Message-ID: <d6508932-377c-a4d1-d4d8-01d0f55b9190@intel.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <6e2a1dba-80a8-42bf-127c-2f5c2441c248@intel.com>
 <20181205001544.GR2937@redhat.com>
 <42006749-7912-1e97-8ccd-945e82cebdde@intel.com>
 <20181205021334.GB3045@redhat.com>
 <b3122fdf-02c3-2e9c-1da6-fb873b824d59@intel.com>
 <20181205175357.GG3536@redhat.com>
 <b8fab9a7-62ed-5d8d-3cb1-aea6aacf77fe@intel.com>
 <20181206192050.GC3544@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206192050.GC3544@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Matthew Wilcox <willy@infradead.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Keith Busch <keith.busch@intel.com>, Dan Williams <dan.j.williams@intel.com>, Haggai Eran <haggaie@mellanox.com>, Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Paul Blinzer <Paul.Blinzer@amd.com>, Logan Gunthorpe <logang@deltatee.com>, John Hubbard <jhubbard@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>
List-Id: linux-acpi@vger.kernel.org

On 12/6/18 11:20 AM, Jerome Glisse wrote:
>>> For case 1 you can pre-parse stuff but this can be done by helper library
>> How would that work?  Would each user/container/whatever do this once?
>> Where would they keep the pre-parsed stuff?  How do they manage their
>> cache if the topology changes?
> Short answer i don't expect a cache, i expect that each program will have
> a init function that query the topology and update the application codes
> accordingly.

My concern with having folks do per-program parsing, *and* having a huge
amount of data to parse makes it unusable.  The largest systems will
literally have hundreds of thousands of objects in /sysfs, even in a
single directory.  That makes readdir() basically impossible, and makes
even open() (if you already know the path you want somehow) hard to do fast.

I just don't think sysfs (or any filesystem, really) can scale to
express large, complicated topologies in a way that any normal program
can practically parse it.

My suspicion is that we're going to need to have the kernel parse and
cache these things.  We *might* have the data available in sysfs, but we
can't reasonably expect anyone to go parsing it.
