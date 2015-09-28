From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Bugfix 1/2] ACPI, PCI, irq: Do not share PCI IRQ with ISA IRQ
Date: Mon, 28 Sep 2015 15:57:03 +0200
Message-ID: <3135859.72R7vY9K7x@vostro.rjw.lan>
References: <1442469766-31264-1-git-send-email-jiang.liu@linux.intel.com> <20150925234040.GB23134@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46994 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933643AbbI1N2p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Sep 2015 09:28:45 -0400
In-Reply-To: <20150925234040.GB23134@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, wfg@linux.intel.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

On Friday, September 25, 2015 06:40:40 PM Bjorn Helgaas wrote:
> On Thu, Sep 17, 2015 at 02:02:45PM +0800, Jiang Liu wrote:
> > Avoid IRQs occupied by ISA IRQs when allocating IRQs for PCI link devices,
> > otherwise it may cause interrupt storm due to incompatible pin attributes.
> > 
> > This issue was triggered on a KVM virtual machine, which
> > 1) uses IRQ9 for SCI in high level mode.
> > 2) defines an PCI interrupt link device (LNKS) with IRQ9 as the only
> >    possible irq.
> > 3) has an PCI device referring to link device LNKS.
> > So it causes interrupt storm when enabling the PCI device because PCI IRQ
> > works in low level mode.
> > 
> > Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

Queued up both this and the [2/2] for 4.3-rc4.

Thanks,
Rafael

