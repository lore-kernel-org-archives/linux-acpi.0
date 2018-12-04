From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Date: Tue, 4 Dec 2018 13:37:56 -0800
Message-ID: <20163c1e-00f1-7e02-82c0-7730ceabb9f2@intel.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <9d745b99-22e3-c1b5-bf4f-d3e83113f57b@intel.com>
 <20181204184919.GD2937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204184919.GD2937@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Matthew Wilcox <willy@infradead.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Keith Busch <keith.busch@intel.com>, Dan Williams <dan.j.williams@intel.com>, Haggai Eran <haggaie@mellanox.com>, Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Paul Blinzer <Paul.Blinzer@amd.com>, Logan Gunthorpe <logang@deltatee.com>, John Hubbard <jhubbard@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>
List-Id: linux-acpi@vger.kernel.org

On 12/4/18 10:49 AM, Jerome Glisse wrote:
>> Also, could you add a simple, example program for how someone might use
>> this?  I got lost in all the new sysfs and ioctl gunk.  Can you
>> characterize how this would work with the *exiting* NUMA interfaces that
>> we have?
> That is the issue i can not expose device memory as NUMA node as
> device memory is not cache coherent on AMD and Intel platform today.
> 
> More over in some case that memory is not visible at all by the CPU
> which is not something you can express in the current NUMA node.

Yeah, our NUMA mechanisms are for managing memory that the kernel itself
manages in the "normal" allocator and supports a full feature set on.
That has a bunch of implications, like that the memory is cache coherent
and accessible from everywhere.

The HMAT patches only comprehend this "normal" memory, which is why
we're extending the existing /sys/devices/system/node infrastructure.

This series has a much more aggressive goal, which is comprehending the
connections of every memory-target to every memory-initiator, no matter
who is managing the memory, who can access it, or what it can be used for.

Theoretically, HMS could be used for everything that we're doing with
/sys/devices/system/node, as long as it's tied back into the existing
NUMA infrastructure _somehow_.

Right?
