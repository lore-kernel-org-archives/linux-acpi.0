From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv4 00/13] Heterogeneuos memory node attributes
Date: Thu, 17 Jan 2019 08:44:37 -0700
Message-ID: <20190117154436.GB31543@localhost.localdomain>
References: <20190116175804.30196-1-keith.busch@intel.com>
 <20190117125821.GF26056@350D>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117125821.GF26056@350D>
Sender: linux-kernel-owner@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 17, 2019 at 11:58:21PM +1100, Balbir Singh wrote:
> On Wed, Jan 16, 2019 at 10:57:51AM -0700, Keith Busch wrote:
> > It had previously been difficult to describe these setups as memory
> > rangers were generally lumped into the NUMA node of the CPUs. New
> > platform attributes have been created and in use today that describe
> > the more complex memory hierarchies that can be created.
> > 
> 
> Could you please expand on this text -- how are these attributes
> exposed/consumed by both the kernel and user space?
> 
> > This series' objective is to provide the attributes from such systems
> > that are useful for applications to know about, and readily usable with
> > existing tools and libraries.
> 
> I presume these tools and libraries are numactl and mbind()?

Yes, and numactl is used the examples provided in both changelogs and
documentation in this series. Do you want to see those in the cover
letter as well?
