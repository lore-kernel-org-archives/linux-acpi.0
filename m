From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 1/3] PCI/AER: Option to leave System Error Interrupts
 as-is
Date: Fri, 2 Nov 2018 10:34:46 -0600
Message-ID: <20181102163446.GA26410@localhost.localdomain>
References: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
 <20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com>
 <20181102095300.GB14602@zn.tnic>
 <20181102161730.GA26392@localhost.localdomain>
 <20181102162623.GH14602@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181102162623.GH14602@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Christoph Hellwig <hch@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 02, 2018 at 05:26:23PM +0100, Borislav Petkov wrote:
> On Fri, Nov 02, 2018 at 10:17:30AM -0600, Keith Busch wrote:
> > VMD acts a bit like a host-bus adapter. The firmware knows about the
> > adapter, but not about anything on the bus that it attaches to.
> > 
> > This "hybrid" approach is basically saying that the firmware knows about
> > the HBA, and it wants a chance to be notified of errors on the bus it
> > attaches to, but the firmware can't do anything about such errors.
> > 
> > The bus in this case is PCIe, where we have capable error handling in the
> > kernel driver, so we ultimately want the AER driver handling the errors.
> 
> Not a problem - GHES already knows about AER and calls into it for
> CPER_SEC_PCIE errors:
> 
> ghes_do_proc
> -> ghes_handle_aer
>   |-> aer_recover_queue

That requires firmware know about the PCIe domain that experienced an
error so that it can provide an appropriate CPER. That wouldn't be
possible for errors occuring within a VMD domain.
