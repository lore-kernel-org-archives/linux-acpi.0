From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Date: Thu, 6 Dec 2018 14:04:46 -0800
Message-ID: <f7eb9939-d550-706a-946d-acbb7383172e@intel.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <6e2a1dba-80a8-42bf-127c-2f5c2441c248@intel.com>
 <20181205001544.GR2937@redhat.com>
 <42006749-7912-1e97-8ccd-945e82cebdde@intel.com>
 <20181205021334.GB3045@redhat.com>
 <b3122fdf-02c3-2e9c-1da6-fb873b824d59@intel.com>
 <20181205175357.GG3536@redhat.com>
 <b8fab9a7-62ed-5d8d-3cb1-aea6aacf77fe@intel.com>
 <20181206192050.GC3544@redhat.com>
 <d6508932-377c-a4d1-d4d8-01d0f55b9190@intel.com>
 <c583be1b-17db-1ed3-0f5a-bd119edc8bfe@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c583be1b-17db-1ed3-0f5a-bd119edc8bfe@deltatee.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>, Jerome Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Matthew Wilcox <willy@infradead.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Keith Busch <keith.busch@intel.com>, Dan Williams <dan.j.williams@intel.com>, Haggai Eran <haggaie@mellanox.com>, Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Paul Blinzer <Paul.Blinzer@amd.com>, John Hubbard <jhubbard@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>, Michal Hocko <mhocko@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/6/18 12:11 PM, Logan Gunthorpe wrote:
>> My concern with having folks do per-program parsing, *and* having a huge
>> amount of data to parse makes it unusable.  The largest systems will
>> literally have hundreds of thousands of objects in /sysfs, even in a
>> single directory.  That makes readdir() basically impossible, and makes
>> even open() (if you already know the path you want somehow) hard to do fast.
> Is this actually realistic? I find it hard to imagine an actual hardware
> bus that can have even thousands of devices under a single node, let
> alone hundreds of thousands.

Jerome's proposal, as I understand it, would have generic "links".
They're not an instance of bus, but characterize a class of "link".  For
instance, a "link" might characterize the characteristics of the QPI bus
between two CPU sockets. The link directory would enumerate the list of
all *instances* of that link

So, a "link" directory for QPI would say Socket0<->Socket1,
Socket1<->Socket2, Socket1<->Socket2, Socket2<->PCIe-1.2.3.4 etc...  It
would have to enumerate the connections between every entity that shared
those link properties.

While there might not be millions of buses, there could be millions of
*paths* across all those buses, and that's what the HMAT describes, at
least: the net result of all those paths.
