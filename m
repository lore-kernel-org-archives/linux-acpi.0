From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: SCSI behind PCIE bridge only detected using pci=noacpi
Date: Thu, 09 Mar 2006 09:09:53 +0800
Message-ID: <440F8061.7030502@intel.com>
References: <200603081954.44195.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr22.intel.com ([143.183.121.14]:26319 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751539AbWCIBJ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Mar 2006 20:09:59 -0500
In-Reply-To: <200603081954.44195.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org

Thomas Renninger wrote:
> Should this work or is this really not supported via ACPI?
> 
> I expect this is the relevant output:
> 
> ACPI: PCI Root Bridge [PCI1] (0001:40)
> PCI: Multiple domains not supported
> ACPI Error (pci_root-0279): Bus 0001:40 not present in PCI 
> namespace<7>Losing some ticks... checking if CPU frequency changed.
> 
>  [20060127]
> ACPI Exception (pci_bind-0156): AE_NOT_FOUND, Invalid ACPI-PCI context 
> for parent device PCI1 [20060127]
> ACPI Exception (pci_bind-0156): AE_NOT_FOUND, Invalid ACPI-PCI context 
> for parent device PCI1 [20060127]
> ACPI: PCI Root Bridge [PCI2] (0002:80)
> PCI: Multiple domains not supported
> ACPI Error (pci_root-0279): Bus 0002:80 not present in PCI namespace 
> [20060127]
> ACPI Exception (pci_bind-0156): AE_NOT_FOUND, Invalid ACPI-PCI context 
> for parent device PCI2 [20060127]
> ACPI Exception (pci_bind-0156): AE_NOT_FOUND, Invalid ACPI-PCI context 
> for parent device PCI2 [20060127]
> 
> With pci=noacpi the SCSI disk/controller works fine.
> Without even the controller is not recognised.
IIRC, -mm tree has the x86 multiple domains support patch. Without that
patch all pci devices of non-zero domains can't be found.

Thanks,
Shaohua
