From: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [Openipmi-developer] [PATCH 0/5] ia64 ioremap, DMI, EFI system table
Date: Mon, 30 Jan 2006 11:11:31 -0600
Message-ID: <20060130171131.GA24947@lists.us.dell.com>
References: <20060104221627.GA26064@lists.us.dell.com> <200601181029.46352.bjorn.helgaas@hp.com> <20060118181116.GA5537@lists.us.dell.com> <200601191310.57303.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:51320 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S964797AbWA3RLb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Jan 2006 12:11:31 -0500
Content-Disposition: inline
In-Reply-To: <200601191310.57303.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-ia64@vger.kernel.org, ak@suse.de, openipmi-developer@lists.sourceforge.net, akpm@osdl.org, "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Jan 19, 2006 at 01:10:57PM -0700, Bjorn Helgaas wrote:
> OK, here's a set of patches to (hopefully) clean up this area
> a bit:
> 
> 1  Simplify efi_mem_attribute_range() so I can use it both for
>    /dev/mem validation and ioremap() attribute checking.
> 
> 2  Make ia64 ioremap() check memory attributes, so it works for
>    plain memory that only supports write-back access, as well as
>    for MMIO space that only supports uncacheable access.
> 
> 3  DMI ioremaps too much space, which makes it fail on machines
>    where the SMBIOS table is near the end of a memory region.
> 
> 4  Keep EFI table addresses as physical, not virtual.  The SMBIOS
>    address was physical on x86 but virtual on ia64, which broke
>    dmi_scan_machine().
> 
> 5  Use smarter ioremap() implementation to remove some cruft in
>    acpi_os_{read,write,map}_memory().  This one's just an optional
>    cleanup; I don't think it fixes any bugs.


This set of patches works for me on my IA64 Tiger4 (Dell PowerEdge
7250) in kernel 2.6.16-rc1-mm4.  modprobe ipmi_si successfully
automatically finds the IPMI controller now.

Thanks Bjorn for doing a more complete cleanup in support of this!

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
