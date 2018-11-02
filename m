From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 1/3] PCI/AER: Option to leave System Error Interrupts
 as-is
Date: Fri, 2 Nov 2018 10:17:30 -0600
Message-ID: <20181102161730.GA26392@localhost.localdomain>
References: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
 <20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com>
 <20181102095300.GB14602@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181102095300.GB14602@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Christoph Hellwig <hch@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 02, 2018 at 10:53:00AM +0100, Borislav Petkov wrote:
> On Mon, Oct 29, 2018 at 04:06:51PM -0500, Bjorn Helgaas wrote:
> > If I squint hard enough this sort of makes sense, but it also makes me
> > confused about the normal APEI firmware-first model works.
> > 
> > In the NON-firmare-first case, firmware isn't involved in handling AER
> > errors.  The Linux AER driver fields an interrupt from a Root Port,
> > reads AER log registers, etc.
> > 
> > In the normal APEI firmware-first case, when the hardware reports an
> > AER event, I think firmware gets control first, and *it* reads the AER
> > log registers, packages them up, and generates an interrupt to the OS,
> > which reads the packaged error state from the firmware via the HEST.
> > 
> > If I understand this special Intel VMD firmware-first case correctly,
> > firmware gets control first, reads the AER log registers, and
> > synthesizes what looks to the OS like a normal AER interrupt.  The
> 
> Why?
> 
> Why the faking?
> 
> If firmware needs to get control, why doesn't it then *retain* control
> and report the error through HEST, like others do?
> 
> AFAIUC, fw wants to do something underneath. What's wrong with making it
> a normal firmware-first case?

VMD acts a bit like a host-bus adapter. The firmware knows about the
adapter, but not about anything on the bus that it attaches to.

This "hybrid" approach is basically saying that the firmware knows about
the HBA, and it wants a chance to be notified of errors on the bus it
attaches to, but the firmware can't do anything about such errors.

The bus in this case is PCIe, where we have capable error handling in the
kernel driver, so we ultimately want the AER driver handling the errors.
