From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH v1 3/5] ipmi: remove unused PCI probe coded
Date: Tue, 01 Dec 2009 17:18:41 -0600
Message-ID: <20091201231841.GA7903@minyard.local>
References: <20091118000427.14214.14043.stgit@bob.kio>
 <20091118000524.14214.41587.stgit@bob.kio>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:37877 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbZLAXSq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2009 18:18:46 -0500
Received: from wf-rch.minyard.local ([173.57.145.237])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KTZ00HTUY3648U0@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 01 Dec 2009 17:18:43 -0600 (CST)
Content-disposition: inline
In-reply-to: <20091118000524.14214.41587.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Bela Lubkin <blubkin@vmware.com>, linux-acpi@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>, openipmi-developer@lists.sourceforge.net, Len Brown <lenb@kernel.org>

On Tue, Nov 17, 2009 at 05:05:24PM -0700, Bjorn Helgaas wrote:
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2202,7 +2202,6 @@ static int __devinit ipmi_pci_probe(struct pci_dev *pdev,
>  	int rv;
>  	int class_type = pdev->class & PCI_ERMC_CLASSCODE_TYPE_MASK;
>  	struct smi_info *info;
> -	int first_reg_offset = 0;
>  
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
> @@ -2241,9 +2240,6 @@ static int __devinit ipmi_pci_probe(struct pci_dev *pdev,
>  	info->addr_source_cleanup = ipmi_pci_cleanup;
>  	info->addr_source_data = pdev;
>  
> -	if (pdev->subsystem_vendor == PCI_HP_VENDOR_ID)
> -		first_reg_offset = 1;
> -
>  	if (pci_resource_flags(pdev, 0) & IORESOURCE_IO) {
>  		info->io_setup = port_setup;
>  		info->io.addr_type = IPMI_IO_ADDR_SPACE;
> 

Unfortunately, the above patch points to some missing code later, not dead
code.  The patch that follows will set it back to the original function.
Since no one has noticed, it may be best to remove the code, but as far
as I know, that HP system is the only one that uses PCI.

I looked over the other patches in this series and they look fine.


On a PCI update, the offset for HP PCI interfaces to the IPMI controller
was left off.  Add the offset back in.

Signed-off-by: Corey Minyard <cminyard@mvista.com>

Index: linux-2.6.30/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.30.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.30/drivers/char/ipmi/ipmi_si_intf.c
@@ -2293,7 +2293,7 @@ static int __devinit ipmi_pci_probe(stru
 		info->io_setup = mem_setup;
 		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
 	}
-	info->io.addr_data = pci_resource_start(pdev, 0);
+	info->io.addr_data = pci_resource_start(pdev, 0) + first_reg_offset;
 
 	info->io.regspacing = DEFAULT_REGSPACING;
 	info->io.regsize = DEFAULT_REGSPACING;
