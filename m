From: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.18-rc4-mm2
Date: Mon, 21 Aug 2006 18:54:45 -0400
Message-ID: <200608211854.46030.len.brown@intel.com>
References: <20060819220008.843d2f64.akpm@osdl.org> <44E97AF9.2040009@gmail.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:14568 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751272AbWHUWxA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 18:53:00 -0400
In-Reply-To: <44E97AF9.2040009@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>, linux-acpi@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org

On Monday 21 August 2006 05:20, Maciej Rutecki wrote:

> I have this entry in dmesg:
> 
> [   23.701949] ACPI Error (utglobal-0125): Unknown exception code:
> 0xFFFFFFEA [20060707]
> [   23.702181] ACPI Error (utglobal-0125): Unknown exception code:
> 0xFFFFFFEA [20060707]
> [   23.705646]   got res [dd000000:dd00ffff] bus [dd000000:dd00ffff]
> flags 7202 for BAR 6 of 0000:01:00.0

Apparently the "got res" part is normal -- or normal for pr_debug():

pci_update_resource(struct pci_dev *dev, struct resource *res, int resno)
{
        struct pci_bus_region region;
        u32 new, check, mask;
        int reg;

        /* Ignore resources for unimplemented BARs and unused resource slots
           for 64 bit BARs. */
        if (!res->flags)
                return;

        pcibios_resource_to_bus(dev, &region, res);

        pr_debug("  got res [%llx:%llx] bus [%lx:%lx] flags %lx for "
                 "BAR %d of %s\n", (unsigned long long)res->start,
                 (unsigned long long)res->end,
                 region.start, region.end, res->flags, resno, pci_name(dev));
