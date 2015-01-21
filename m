From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC Patch 17/19] resources: Move struct resource_list_entry
 from ACPI into resource core
Date: Wed, 21 Jan 2015 10:43:56 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1501211043170.5526@nanos>
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com> <1420684386-5975-18-git-send-email-jiang.liu@linux.intel.com> <3428063.tN1BxOoXSN@vostro.rjw.lan> <54BF4911.7030906@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <54BF4911.7030906@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Vivek Goyal <vgoyal@redhat.com>, Thierry Reding <treding@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Travis <travis@sgi.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 21 Jan 2015, Jiang Liu wrote:
> On 2015/1/21 9:10, Rafael J. Wysocki wrote:
> >> +
> >> +void resource_list_insert(struct list_head *head,
> >> +			  struct resource_list_entry *entry, bool tail)
> > 
> > I would call this resource_list_add() if anything.
> > 
> > Also it may be better to have two helpers, one for "add" and one for "add_tail"
> > (and perhaps define them as static inline?).
> We can't use inline functions here because that needs pulling list.h
> into ioport.h, then causing building issues to header inclusion order.

Create a new header file to avoid the circular dependencies then.

Thanks,

	tglx
