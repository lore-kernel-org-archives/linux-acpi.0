From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [RFC 2/4] PCI, MSI: Optionally free legacy PCI IRQ when enabling
 MSI/MSI-X
Date: Wed, 20 May 2015 11:12:21 +0800
Message-ID: <555BFB95.30208@linux.intel.com>
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com> <1430968374-29286-3-git-send-email-jiang.liu@linux.intel.com> <20150519213937.GR31666@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17023 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbbETDMk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 May 2015 23:12:40 -0400
In-Reply-To: <20150519213937.GR31666@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>

On 2015/5/20 5:39, Bjorn Helgaas wrote:
> On Thu, May 07, 2015 at 11:12:52AM +0800, Jiang Liu wrote:
>> Once PCI MSI/MSI-X is enabled by the device driver, PCI device won't
>> make use of legacy PCI IRQ until PCI MSI/MSI-X is disabled again.
>> So optionally free legacy PCI IRQ when enabling MSI/MSI-X and reallocate
>> when disabling MSI/MSI-X.
> 
> The rest of this series makes sense to me.  If you want to remove an
> IOAPIC, you want to make sure all of the IRQs using that IOAPIC have been
> freed.
> 
> But I'm trying to figure out this patch.  Do you want to free the IRQ when
> enabling MSI because it enables you to remove the IOAPIC without removing
> the device?  That wouldn't really make sense to me because then the device
> has no possibility of using INTx.
Hi Bjorn
	Sorry for the confusion. This patch is not for IOAPIC
hot-removal, but it's an effort to use IRQ resource precisely.
The idea is to allocate IRQ resource on demand and release it
when not used. We could skip this patch if it's not worth the
cost.
Thanks!
Gerry
