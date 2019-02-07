From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv5 00/10] Heterogeneuos memory node attributes
Date: Thu, 7 Feb 2019 08:08:17 -0700
Message-ID: <20190207150817.GC30221@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190207095336.0000529f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190207095336.0000529f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 07, 2019 at 01:53:36AM -0800, Jonathan Cameron wrote:
> As a general heads up, ACPI 6.3 is out and makes some changes.
> Discussions I've had in the past suggested there were few systems
> shipping with 6.2 HMAT and that many firmwares would start at 6.3.
> Of course, that might not be true, but there was fairly wide participation
> in the meeting so fingers crossed it's accurate.
> 
> https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> 
> Particular points to note:
> 1. Most of the Memory Proximity Domain Attributes Structure was deprecated.
>    This includes the reservation hint which has been replaced
>    with a new mechanism (not used in this patch set)

Yes, and duplicating all the address ranges with SRAT never made any
sense. No need to define the same thing in multiple places; that's just
another opprotunity to get it wrong.
 
> 2. Base units for latency changed to picoseconds.  There is a lot more
>    explanatory text around how those work.
>
> 3. The measurements of latency and bandwidth no longer have an
>    'aggregate performance' version.  Given the work load was not described
>    this never made any sense.  Better for a knowledgeable bit of software
>    to work out it's own estimate.

Nice. Though they shifted 1st level cached to occupy the same value that
the aggregate used. They could have just deprecated the old value so we
could maintain compatibility, but that's okay!
 
> 4. There are now Generic Initiator Domains that have neither memory nor
>    processors.  I'll come back with proposals on handling those soon if
>    no one beats me to it. (I think it's really easy but may be wrong ;)
>    I've not really thought out how this series applies to GI only domains
>    yet.  Probably not useful to know you have an accelerator near to
>    particular memory if you are deciding where to pin your host processor
>    task ;)

I haven't any particular use for these at the moment either, though it
shouldn't change what this is going to export.

Thanks for the heads up! I'll incorporate 6.3 into v6.
