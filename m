From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Exit ACPI drivers immediately if acpi is disabled
Date: Fri, 21 Apr 2006 09:18:47 -0600
Message-ID: <200604210918.47337.bjorn.helgaas@hp.com>
References: <200604211243.32276.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:4740 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932353AbWDUPSx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Apr 2006 11:18:53 -0400
In-Reply-To: <200604211243.32276.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

On Friday 21 April 2006 04:43, Thomas Renninger wrote:
> If booting with acpi=off and loading the processor module, it
> may happen that the kernel oopses when trying to unload the module again.
> Better exit all ACPI modules immediately if booted with acpi=off.
> ... 
> @@ -289,31 +289,28 @@ static int __init acpi_ac_init(void)
>  {
>  	int result = 0;
>  
> -	ACPI_FUNCTION_TRACE("acpi_ac_init");
> +	if (acpi_disabled)
> +		return -ENODEV;

This doesn't feel like the right solution to me.
acpi_bus_register_driver() already returns -ENODEV
if acpi_disabled, and that ought to be enough so the
drivers can handle this correctly.

I don't think we should clutter every ACPI driver with
the same check for acpi_disabled.

Did you investigate the oops when unloading the processor module?
I wonder if that driver has a bug there.  It has a mysterious
comment that "we keep the driver loaded even when ACPI is not
running" for powernow-k8.   I don't understand that at all, but
it sounds like it requires extra care to make sure everything
works right.
