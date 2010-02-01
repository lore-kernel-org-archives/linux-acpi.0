From: Matthew Garrett <mjg@redhat.com>
Subject: Re: Recent GPE patches - some questions.
Date: Mon, 1 Feb 2010 22:36:19 +0000
Message-ID: <20100201223619.GB15766@srcf.ucam.org>
References: <4911F71203A09E4D9981D27F9D83085855AF782E@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47989 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279Ab0BAWgY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2010 17:36:24 -0500
Content-Disposition: inline
In-Reply-To: <4911F71203A09E4D9981D27F9D83085855AF782E@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>

On Fri, Jan 29, 2010 at 12:30:25PM -0800, Moore, Robert wrote:

> [PATCH 0/3] acpica: Rewrite GPE handling
> 
> Overall, can we say that this change to the GPE code is primarily 
> intended to add better support for shared GPEs?

Yes, that's probably the easiest way to look at it.

> [PATCH 1/3] ACPI: Add infrastructure for refcounting GPE consumers:
> 
> >Add an API to allow devices to indicate whether or not
> >they want their device's GPE to be enabled for both runtime
> >and wakeup events.
> 
> I'm not sure which interface you are referring to, please explain

This is simply the ref/unref functions.


> [PATCH 2/3] ACPI: Add support for new refcounted GPE API to drivers:
> 
> Reference count mechanism is meant to:
>     1) Enable GPE only on the first added reference
>     2) Disable GPE only on the last removed reference
> 
> Then I don't understand why the code below needs to call acpi_enable_gpe:
> 
> 		acpi_enable_gpe(dev->wakeup.gpe_device,
>  				dev->wakeup.gpe_number);
> +		acpi_ref_wakeup_gpe(dev->wakeup.gpe_device,
> +				    dev->wakeup.gpe_number);
> 
> Because the GPE will be "enabled" (mask bit set for wakeup GPE) by 
> acpi_ref_wakeup_gpe. There are several examples of this type of code. 
> If it is true that the call to acpi_enable_gpe is unnecessary, then is 
> acpi_enable_gpe interface needed at all? (same with disable_gpe).

That's simply to make it easier to bisect through the changes - 3/3 
removes the explicit enable_gpe call.

> [PATCH 1/3] acpi: Provide default GPE handler if the firmware doesn't
> 
> >Firmware may support using GPEs for system wakeup without
> >providing any runtime GPE handlers.
> 
> Do you mean by "runtime GPE handlers" to mean the _Lxx/_Exx GPE methods? If so, this should be clarified in the comments.

Ok. I'm not sure that we'll be pushing this aspect of it yet, we'll have 
to wait and see what the hardware support situation ends up being.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
