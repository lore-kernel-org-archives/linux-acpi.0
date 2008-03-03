From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH]  ACPI:  Unneccessary to scan the PCI bus already
	scanned.
Date: Mon, 03 Mar 2008 16:18:42 +0800
Message-ID: <1204532322.4080.22.camel@yakui_zhao.sh.intel.com>
References: <1204525186.4080.11.camel@yakui_zhao.sh.intel.com>
	 <20080303073214.GA5934@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9263 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753185AbYCCIam (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Mar 2008 03:30:42 -0500
In-Reply-To: <20080303073214.GA5934@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Mon, 2008-03-03 at 08:32 +0100, Ingo Molnar wrote:
> small typo:
> 
> > +		 * If the desired bus exits, the content of bus->sysdata will
>                                         ^--- exists
> > +		 * be replaced by sd.
> 
> also, it's not clear to me why the patch helps. Why does "double 
> scanning" cause problems? We register devices twice? Shouldnt that just 
> work? (except for a few "device already exists" type of messages)
> 
If the desired pci bus(domain,busnum) is already scanned, the call to
pci_scan_bus_parented will return NULL pointer. The function of
pci_bios_acpi_scan_root will also return NULL pointer subsequently. In
such case it will bring that acpi_pci_root driver can't be loaded.  

When the system works in acpi mode, there will be some potential problem
if acpi_pci_root driver can't be loaded. For example:
    http://bugzilla.kernel.org/show_bug.cgi?id=10124

Thanks.
   Yakui



> 	Ingo

