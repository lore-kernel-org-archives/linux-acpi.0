From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18
 and later
Date: Wed, 03 Jan 2007 23:45:09 +0300
Message-ID: <459C15D5.2000404@linux.intel.com>
References: <1e2af89e0612280914n62a192e2kdb7e2677b55d2670@mail.gmail.com> <1e2af89e0612281536y769323a7l62c9df334d1e8a06@mail.gmail.com> <1e2af89e0701030340q7a01520cm831b6064af8f7881@mail.gmail.com> <200701031329.34665.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:34303 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932102AbXACUpK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jan 2007 15:45:10 -0500
In-Reply-To: <200701031329.34665.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Matthew Brett <matthew.brett@gmail.com>, linux-acpi@vger.kernel.org, konstantin.a.karasyov@intel.com

Bjorn Helgaas wrote:
> There weren't many interesting changes in fan.c between 2.6.17 and
> 2.6.18.  The problem you found is probably related to this:
>   http://bugzilla.kernel.org/show_bug.cgi?id=5000
>
> The patch in comment #24 looks like this for add and resume:
>
>         result = acpi_bus_get_power(device->handle, &state);
>
> +	if (state == ACPI_STATE_D0)
> +		acpi_bus_set_power(fan->handle, ACPI_STATE_D3);
> +	else if (state == ACPI_STATE_D3)
> +		acpi_bus_set_power(fan->handle, ACPI_STATE_D0);
> +	acpi_bus_set_power(fan->handle, state);
>
> whereas the code in 2.6.18 is this:
>
>         result = acpi_bus_get_power(device->handle, &state);
>
> +       device->flags.force_power_state = 1;
> +       acpi_bus_set_power(device->handle, state);
> +       device->flags.force_power_state = 0;
>
> It's interesting that the bugzilla patch inverts the fan power state
> while the 2.6.18 code does not.
>
> Konstantin can probably give you more useful help.  I don't know
> the details of how the fan state is controlled.
>
> Bjorn
>   
I talked to Konstantin some time ago about this problem and he said that 
2.6.18 contains some debug patch used in very beginning of 5000,
which was picked up by someone else. Konstantin already sent a patch to 
convert to correct behavior, but its got stuck in ACPI pipeline...

Regards,
    Alex.
