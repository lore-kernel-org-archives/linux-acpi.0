From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH v1 0/5] IPMI devices from ACPI namespace
Date: Wed, 18 Nov 2009 10:29:49 +0800
Message-ID: <1258511389.3813.54.camel@localhost.localdomain>
References: <20091118000427.14214.14043.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64557 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbZKRCcf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 21:32:35 -0500
In-Reply-To: <20091118000427.14214.14043.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Corey Minyard <minyard@acm.org>, Bela Lubkin <blubkin@vmware.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Myron Stowe <myron.stowe@hp.com>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, Len Brown <lenb@kernel.org>

On Wed, 2009-11-18 at 08:05 +0800, Bjorn Helgaas wrote:
> Here's a sample of how I think the ACPI namespace device detection should
> be done.  I think this is almost functionally equivalent to your "Locate
> the IPMI system interface in ACPI namespace" patch.
> 
> The difference I'm aware of is that your patch doesn't call acpi_register_gsi()
> for IRQs from the device _CRS, so I don't think those interrupts would work.
> (I can't test this because I don't have a box that reports an IRQ in _CRS.)
> PNPACPI takes care of this GSI registration for us.
> 
> Patches 3 & 4 are not really related to the main point here, but I left
> them in because without 4, we'll report both SPMI and ACPI namespace
> devices as being from "ACPI".
Hi, Bjorn
    Thanks for your work.
    In this patch set the IPMI system interface will be detected by
using pnp device driver. In theory it is ok to detect the IPMI system
interface by using pnp device driver.
   But we will have to consider the following two problems:
   a. how to detect the IPMI system interface defined in ACPI table if
the pnp subsystem is disabled? For example: by adding the boot option of
"pnpacpi=off". Why does this need to depend on two subsystems(ACPI and
pnp)? 
   b. There exist several exceptions about the _CRS for the IPMI system
interface defined in ACPI table. Maybe there exist two IO/memory address
definition for the IPMI system interface and the memory type is declared
before IO type. In such case we can't know which should be selected.
    
At the same time in order to enable the communication between the ACPI
AML code and IPMI subsystem, too strict dependency is added.
   In such case if the ACPI IPMI driver is not selected, the IPMI
subsystem can't be compiled correctly.

thanks.
   Yakui
    
> 
> ---
> 
> Bjorn Helgaas (5):
>       PNPACPI: save struct acpi_device, not just acpi_handle
>       PNP: add interface to retrieve ACPI device from a PNPACPI device
>       ipmi: remove unused PCI probe code
>       ipmi: refer to table as "SPMI", not "ACPI"
>       ipmi: add PNP discovery (ACPI namespace via PNPACPI)
> 
> 
>  drivers/char/ipmi/ipmi_si_intf.c |  118 +++++++++++++++++++++++++++++++++++---
>  drivers/pnp/pnpacpi/core.c       |   19 ++++--
>  drivers/pnp/pnpacpi/rsparser.c   |    9 ++-
>  include/linux/pnp.h              |   13 ++++
>  4 files changed, 141 insertions(+), 18 deletions(-)
> 

