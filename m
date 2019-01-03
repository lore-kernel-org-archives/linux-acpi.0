From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 2/2] PCI/portdrv Hisilicon PCIe transport layer Port
 PMU driver.
Date: Thu, 3 Jan 2019 15:44:40 +0000
Message-ID: <20190103154439.GC16311@edgewater-inn.cambridge.arm.com>
References: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
 <20181214131055.52253-3-Jonathan.Cameron@huawei.com>
 <20181214235505.GI20725@google.com>
 <20181217110906.0000003f@huawei.com>
 <20181217181915.GL20725@google.com>
 <20181218102127.0000018e@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218102127.0000018e@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>, linuxarm@huawei.com, Keith Busch <keith.busch@intel.com>, Zhou Wang <wangzhou1@hisilicon.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, alex.umansky@huawei.com, Eric.Wehage@huawei.com, Logan Gunthorpe <logang@deltatee.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 18, 2018 at 10:21:27AM +0000, Jonathan Cameron wrote:
> On Mon, 17 Dec 2018 12:19:15 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Agreed.  I could imagine a drivers/pci/pmu/ directory sort of like
> > drivers/pci/switch/.
> 
> That might work.  Mark, Will what do you think? As long as you and Bjorn
> agree I don't think it'll really matter which one is chosen.
> 
> driver/pci/pmu/ or drivers/perf/pci ?

I have a slight preference for the latter since the perf interface for
PMU drivers is notoriously subtle and error-prone. Keeping PMU drivers
together can be helpful to spot emerging patterns and makes cross-driver
changes easier to co-ordinate.

However, I'll defer to Bjorn since it's only a minor preference. We'd
obviously loop in linux-pci + Bjorn on any new submissions.

Will
