From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch 1/5] ACPI: move FADT resource reservations from
	motherboard driver to osl
Date: Wed, 17 Jan 2007 09:59:36 +0800
Message-ID: <1168999176.26449.4.camel@sli10-conroe.sh.intel.com>
References: <200701161028.10109.bjorn.helgaas@hp.com>
	 <200701161033.34276.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10782 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbXAQCBT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jan 2007 21:01:19 -0500
In-Reply-To: <200701161033.34276.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>

On Tue, 2007-01-16 at 10:33 -0700, Bjorn Helgaas wrote:
> Resources described by the FADT aren't really a good fit for the
> ACPI motherboard driver.
> 
> The motherboard driver cares about PNP0C01 and PNP0C02 devices and
> their resources.
> 
> The FADT describes some resources used by the ACPI core.  Often, they
> are also described by by the _CRS of a motherboard device, but I think
> it's better to reserve them specifically in the ACPI osl.c because
> (a) the motherboard driver is optional and ACPI uses the resources even
> if the driver is absent, and (b) I want to remove the ACPI motherboard
> driver because it's mostly redundant with the PNP system.c driver.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Thanks for the patch set, this is in the wish list for a long time.

> +
>  acpi_status acpi_os_initialize(void)
>  {
>  	return AE_OK;
> @@ -82,6 +127,8 @@
>  
>  acpi_status acpi_os_initialize1(void)
>  {
> +	acpi_reserve_resources();
This sounds a little earlier. motherboard device usually returns a super
set of the acpi io ports. reserving acpi io ports first might make some
motherboard io port isn't reserved as there might be conflict.

Thanks,
Shaohua
