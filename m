From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
Date: Tue, 4 Dec 2018 14:11:31 -0500
Message-ID: <20181204191130.GF2937@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <9d745b99-22e3-c1b5-bf4f-d3e83113f57b@intel.com>
 <20181204184919.GD2937@redhat.com>
 <64cf873c-9e1e-f3b0-4869-7e0ebab10452@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <64cf873c-9e1e-f3b0-4869-7e0ebab10452@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Matthew Wilcox <willy@infradead.org>, Keith Busch <keith.busch@intel.com>, Dan Williams <dan.j.williams@intel.com>, Haggai Eran <haggaie@mellanox.com>, Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Paul Blinzer <Paul.Blinzer@amd.com>, Logan Gunthorpe <logang@deltatee.com>, John Hubbard <jhubbard@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>, Michal Hocko <mhocko@kernel.org>J
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 04, 2018 at 10:54:10AM -0800, Dave Hansen wrote:
> On 12/4/18 10:49 AM, Jerome Glisse wrote:
> > Policy is same kind of story, this email is long enough now :) But
> > i can write one down if you want.
> 
> Yes, please.  I'd love to see the code.
> 
> We'll do the same on the "HMAT" side and we can compare notes.

Example use case ? Example use are:
    Application create a range of virtual address with mmap() for the
    input dataset. Application knows it will use GPU on it directly so
    it calls hbind() to set a policy for the range to use GPU memory
    for any new allocation for the range.

    Application directly stream the dataset to GPU memory through the
    virtual address range thanks to the policy.


    Application create a range of virtual address with mmap() to store
    the output result of GPU jobs its about to launch. It binds the
    range of virtual address to GPU memory so that allocation use GPU
    memory for the range.


    Application can also use policy binding as a slow migration path
    ie set a policy to a new target memory so that new allocation are
    directed to this new target.

Or do you want example userspace program like the one in the last
patch of this serie ?

Cheers,
Jérôme
