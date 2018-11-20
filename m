From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 3/7] doc/vm: New documentation for memory performance
Date: Tue, 20 Nov 2018 08:31:15 -0700
Message-ID: <20181120153115.GD26707@localhost.localdomain>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-4-keith.busch@intel.com>
 <20181120135149.GA24627@rapoport-lnx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181120135149.GA24627@rapoport-lnx>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 20, 2018 at 02:51:50PM +0100, Mike Rapoport wrote:
> On Wed, Nov 14, 2018 at 03:49:16PM -0700, Keith Busch wrote:
> > Platforms may provide system memory where some physical address ranges
> > perform differently than others. These heterogeneous memory attributes are
> > common to the node that provides the memory and exported by the kernel.
> > 
> > Add new documentation providing a brief overview of such systems and
> > the attributes the kernel makes available to aid applications wishing
> > to query this information.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  Documentation/vm/numaperf.rst | 71 +++++++++++++++++++++++++++++++++++++++++++
> 
> As this document describes user-space interfaces it belongs to
> Documentation/admin-guide/mm.

Thanks for the feedback. I'll move this and combine with the memory
cache doc in the v2.
