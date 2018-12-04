From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Date: Tue, 4 Dec 2018 15:58:23 -0800
Message-ID: <ed96fdb0-d8b6-e19b-fe45-532042b712c6@intel.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <9d745b99-22e3-c1b5-bf4f-d3e83113f57b@intel.com>
 <20181204184919.GD2937@redhat.com>
 <20163c1e-00f1-7e02-82c0-7730ceabb9f2@intel.com>
 <20181204215711.GP2937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204215711.GP2937@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Matthew Wilcox <willy@infradead.org>, Keith Busch <keith.busch@intel.com>, Dan Williams <dan.j.williams@intel.com>, Haggai Eran <haggaie@mellanox.com>, Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Paul Blinzer <Paul.Blinzer@amd.com>, Logan Gunthorpe <logang@deltatee.com>, John Hubbard <jhubbard@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>, Michal Hocko <mhocko@kernel.org>, Jon
List-Id: linux-acpi@vger.kernel.org

On 12/4/18 1:57 PM, Jerome Glisse wrote:
> Fully correct mind if i steal that perfect summary description next time
> i post ? I am so bad at explaining thing :)

Go for it!

> Intention is to allow program to do everything they do with mbind() today
> and tomorrow with the HMAT patchset and on top of that to also be able to
> do what they do today through API like OpenCL, ROCm, CUDA ... So it is one
> kernel API to rule them all ;)

While I appreciate the exhaustive scope of such a project, I'm really
worried that if we decided to use this for our "HMAT" use cases, we'll
be bottlenecked behind this project while *it* goes through 25 revisions
over 4 or 5 years like HMM did.

So, should we just "park" the enhancements to the existing NUMA
interfaces and infrastructure (think /sys/devices/system/node) and wait
for this to go in?  Do we try to develop them in parallel and make them
consistent?  Or, do we just ignore each other and make Andrew sort it
out in a few years? :)
