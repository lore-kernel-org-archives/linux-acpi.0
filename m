From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [RFC 0/4] Introduce a mechanism to allocate PCI IRQ on demand
Date: Wed, 20 May 2015 11:21:51 +0800
Message-ID: <555BFDCF.4020303@linux.intel.com>
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505191535190.4225@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1505191535190.4225@nanos>
Sender: linux-pci-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 2015/5/19 21:35, Thomas Gleixner wrote:
> On Thu, 7 May 2015, Jiang Liu wrote:
> 
>> This patch set introduces a mechanism to allocate PCI IRQ on demand and
>> free it when not used anymore by hooking pci_device_probe() and
>> pci_device_remove().
>>
>> It will be used to track IOAPIC pin usage on x86 so we could support
>> IOAPIC hot-removal.
> 
> Bjorn, any opinion on this?
Hi Bjorn,
	With this patch applied, how about removing this workaround
from arch/x86/pci/irq.c?
-------------------------------------------------------------------
        if (io_apic_assign_pci_irqs && pci_routeirq) {
                struct pci_dev *dev = NULL;
                /*
                 * PCI IRQ routing is set up by pci_enable_device(), but we
                 * also do it here in case there are still broken
drivers that
                 * don't use pci_enable_device().
                 */
                printk(KERN_INFO "PCI: Routing PCI interrupts for all
devices because \"pci=routeirq\" specified\n");
                for_each_pci_dev(dev)
                        pirq_enable_irq(dev);
        }
-------------------------------------------------------
Thanks!
Gerry

> 
> Thanks,
> 
> 	tglx
> 
