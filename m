From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Bugfix 3/3] x86/PCI: Refine the way to release PCI IRQ resources
Date: Mon, 19 Jan 2015 14:24:13 +0000
Message-ID: <54BD138D.3090403@citrix.com>
References: <1421643344-17092-1-git-send-email-jiang.liu@linux.intel.com> <1421643344-17092-4-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1421643344-17092-4-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sander Eikelenboom <linux@eikelenboom.it>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 19/01/15 04:55, Jiang Liu wrote:
> Some PCI device drivers assume that pci_dev->irq won't change after
> calling pci_disable_device() and pci_enable_device() during suspend and
> resume.
> 
> Commit c03b3b0738a56cf283b0d05256988d5e3c8bd719 ("x86, irq, mpparse:
> Release IOAPIC pin when PCI device is disabled") frees PCI IRQ
> resources when pci_disable_device() is called and reallocate IRQ
> resources when pci_enable_device() is called again. This breaks
> above assumption. So commit 3eec595235c1 ("x86, irq, PCI: Keep IRQ
> assignment for PCI devices during suspend/hibernation") and
> 9eabc99a635a ("x86, irq, PCI: Keep IRQ assignment for runtime power
> management") fix the issue by avoiding freeing/reallocating IRQ
> resources during PCI device suspend/resume. They achieve this by
> checking dev.power.is_prepared and dev.power.runtime_status.
> PM maintainer, Rafael, then pointed out that it's really an ugly fix
> which leaking PM internal state information to IRQ subsystem.

If this only affects pciback, perhaps it would be best to just fix it there?

> Recently David Vrabel <david.vrabel@citrix.com> also reports an
> regression in pciback driver caused by commit cffe0a2b5a34 ("x86, irq:
> Keep balance of IOAPIC pin reference count"). Please refer to:

Sander reported this regression.

> So this patch refine the way to release PCI IRQ resources. Instead of
> releasing PCI IRQ resources in pci_disable_device()/
> pcibios_disable_device(), we now release it at driver unbinding
> notification BUS_NOTIFY_UNBOUND_DRIVER. In other word, we only release
> PCI IRQ resources when there's no driver bound to the PCI device, and
> it keeps the assumption that pci_dev->irq won't through multiple
> invocation of pci_enable_device()/pci_disable_device().

David
