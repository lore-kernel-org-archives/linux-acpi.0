From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] acpi: handle ACPI0007 Device in acpi_early_set_pdc
Date: Fri, 10 Sep 2010 12:10:31 -0600
Message-ID: <201009101210.31942.bjorn.helgaas@hp.com>
References: <4C89906B.1050406@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:20716 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab0IJSLH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Sep 2010 14:11:07 -0400
In-Reply-To: <4C89906B.1050406@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, September 09, 2010 07:56:59 pm Yinghai Lu wrote:
> 
> When bios switch to use Device object instead of Processor statement.
> 
> the SSDT for Pstate/Cstate/Tstate can not be loaded dynamically.
> 
> So try to scan ACPI0007 in addition to Processor.
> 
> this fix regression: 2.6.32 is ok.

Can you include the URL of the regression bug report?  And maybe
the commit that introduced the regression?

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/acpi/processor_core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/processor_core.c
> +++ linux-2.6/drivers/acpi/processor_core.c
> @@ -352,4 +352,5 @@ void __init acpi_early_processor_set_pdc
>  	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
>  			    ACPI_UINT32_MAX,
>  			    early_init_pdc, NULL, NULL, NULL);
> +	acpi_get_devices("ACPI0007", early_init_pdc, NULL, NULL);

I hate having to walk the namespace.  Usually that's a clue that
there's something wrong with our ACPI device model, because it'd
be better to handle everything in a driver .add() method.  But
maybe this early _PDC thing is so special that it can't be helped
in this case.

But I do think you could probably fix this to walk the namespace
once rather than twice.  Maybe you could use something like
acpi_walk_namespace(ACPI_TYPE_ANY, ...) with a callback that
recognizes both ACPI_TYPE_PROCESSOR and "ACPI_TYPE_DEVICE with
HID ACPI0007".

Bjorn
