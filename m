From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] PCI/AER: Option to leave System Error Interrupts
 as-is
Date: Fri, 2 Nov 2018 17:26:23 +0100
Message-ID: <20181102162623.GH14602@zn.tnic>
References: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
 <20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com>
 <20181102095300.GB14602@zn.tnic>
 <20181102161730.GA26392@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181102161730.GA26392@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Christoph Hellwig <hch@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 02, 2018 at 10:17:30AM -0600, Keith Busch wrote:
> VMD acts a bit like a host-bus adapter. The firmware knows about the
> adapter, but not about anything on the bus that it attaches to.
> 
> This "hybrid" approach is basically saying that the firmware knows about
> the HBA, and it wants a chance to be notified of errors on the bus it
> attaches to, but the firmware can't do anything about such errors.
> 
> The bus in this case is PCIe, where we have capable error handling in the
> kernel driver, so we ultimately want the AER driver handling the errors.

Not a problem - GHES already knows about AER and calls into it for
CPER_SEC_PCIE errors:

ghes_do_proc
-> ghes_handle_aer
  |-> aer_recover_queue

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
