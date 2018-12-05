From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Date: Wed, 5 Dec 2018 16:57:17 +0530
Message-ID: <d90b88f6-b414-a0f9-d572-35c4d2bb1579@linux.ibm.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <9d745b99-22e3-c1b5-bf4f-d3e83113f57b@intel.com>
 <20181204184919.GD2937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204184919.GD2937@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>, Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Matthew Wilcox <willy@infradead.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Keith Busch <keith.busch@intel.com>, Dan Williams <dan.j.williams@intel.com>, Haggai Eran <haggaie@mellanox.com>, Balbir Singh <bsingharora@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Paul Blinzer <Paul.Blinzer@amd.com>, Logan Gunthorpe <logang@deltatee.com>, John Hubbard <jhubbard@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>, Michal Hocko <mhocko@kernel.org>, Jonathan
List-Id: linux-acpi@vger.kernel.org

On 12/5/18 12:19 AM, Jerome Glisse wrote:

> Above example is for migrate. Here is an example for how the
> topology is use today:
> 
>      Application knows that the platform is running on have 16
>      GPU split into 2 group of 8 GPUs each. GPU in each group can
>      access each other memory with dedicated mesh links between
>      each others. Full speed no traffic bottleneck.
> 
>      Application splits its GPU computation in 2 so that each
>      partition runs on a group of interconnected GPU allowing
>      them to share the dataset.
> 
> With HMS:
>      Application can query the kernel to discover the topology of
>      system it is running on and use it to partition and balance
>      its workload accordingly. Same application should now be able
>      to run on new platform without having to adapt it to it.
> 

Will the kernel be ever involved in decision making here? Like the 
scheduler will we ever want to control how there computation units get 
scheduled onto GPU groups or GPU?

> This is kind of naive i expect topology to be hard to use but maybe
> it is just me being pesimistics. In any case today we have a chicken
> and egg problem. We do not have a standard way to expose topology so
> program that can leverage topology are only done for HPC where the
> platform is standard for few years. If we had a standard way to expose
> the topology then maybe we would see more program using it. At very
> least we could convert existing user.
> 
> 

I am wondering whether we should consider HMAT as a subset of the ideas
mentioned in this thread and see whether we can first achieve HMAT 
representation with your patch series?

-aneesh
