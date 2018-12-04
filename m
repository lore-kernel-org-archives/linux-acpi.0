From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Date: Tue, 4 Dec 2018 15:54:22 -0800
Message-ID: <6e2a1dba-80a8-42bf-127c-2f5c2441c248@intel.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203233509.20671-1-jglisse@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: jglisse@redhat.com, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Matthew Wilcox <willy@infradead.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Keith Busch <keith.busch@intel.com>, Dan Williams <dan.j.williams@intel.com>, Haggai Eran <haggaie@mellanox.com>, Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Paul Blinzer <Paul.Blinzer@amd.com>, Logan Gunthorpe <logang@deltatee.com>, John Hubbard <jhubbard@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>, Michal
List-Id: linux-acpi@vger.kernel.org

On 12/3/18 3:34 PM, jglisse@redhat.com wrote:
> This patchset use the above scheme to expose system topology through
> sysfs under /sys/bus/hms/ with:
>     - /sys/bus/hms/devices/v%version-%id-target/ : a target memory,
>       each has a UID and you can usual value in that folder (node id,
>       size, ...)
> 
>     - /sys/bus/hms/devices/v%version-%id-initiator/ : an initiator
>       (CPU or device), each has a HMS UID but also a CPU id for CPU
>       (which match CPU id in (/sys/bus/cpu/). For device you have a
>       path that can be PCIE BUS ID for instance)
> 
>     - /sys/bus/hms/devices/v%version-%id-link : an link, each has a
>       UID and a file per property (bandwidth, latency, ...) you also
>       find a symlink to every target and initiator connected to that
>       link.
> 
>     - /sys/bus/hms/devices/v%version-%id-bridge : a bridge, each has
>       a UID and a file per property (bandwidth, latency, ...) you
>       also find a symlink to all initiators that can use that bridge.

We support 1024 NUMA nodes on x86.  The ACPI HMAT expresses the
connections between each node.  Let's suppose that each node has some
CPUs and some memory.

That means we'll have 1024 target directories in sysfs, 1024 initiator
directories in sysfs, and 1024*1024 link directories.  Or, would the
kernel be responsible for "compiling" the firmware-provided information
down into a more manageable number of links?

Some idiot made the mistake of having one sysfs directory per 128MB of
memory way back when, and now we have hundreds of thousands of
/sys/devices/system/memory/memoryX directories.  That sucks to manage.
Isn't this potentially repeating that mistake?

Basically, is sysfs the right place to even expose this much data?
