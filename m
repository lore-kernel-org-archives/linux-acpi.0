From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA branch - first try Core revision 20080321
Date: Tue, 15 Apr 2008 03:51:04 -0400
Message-ID: <200804150351.04752.lenb@kernel.org>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <200804120041.31583.lenb@kernel.org> <48011F93.2000102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33679 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984AbYDOHvX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Apr 2008 03:51:23 -0400
In-Reply-To: <48011F93.2000102@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>, "Lin, Ming M" <ming.m.lin@intel.com>
Cc: linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Saturday 12 April 2008, Alexey Starikovskiy wrote:
> Len Brown wrote:
> > The acpica branch is based on 2.6.25-rc9.
> > Below is a dmesg diff of an HP nx6325 booting that baseline
> > vs. booting the acpica branch.
> >
> > Two things jump out:
> >
> > 1. ACPI: Expecting a [Reference] package element, found type 14
> >
> >   
> Add this to #67
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 44ea60c..1009261 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -398,7 +398,7 @@ acpi_evaluate_reference(acpi_handle handle,
>  
>          element = &(package->package.elements[i]);
>  
> -        if (element->type != ACPI_TYPE_ANY) {
> +        if (element->type != ACPI_TYPE_LOCAL_REFERENCE) {
>              status = AE_BAD_DATA;
>              printk(KERN_ERR PREFIX
>                      "Expecting a [Reference] package element, found 
> type %X\n",
> 
> > 2. memory coorruption:
> >
> > slab error in verify_redzone_free(): cache `size-1024': memory outside object was overwritten
> >
> >   
> drop #60


done, and the nx6325 now looks happy, so I've updated
the acpica branch and pulled it into the test branch.

but expanding testing to the t61, the latest ACPICA gives me these:


> ACPI Exception (scan-0716): AE_BAD_DATA, Extracting _PRW package [20080321]
> ACPI Exception (scan-0716): AE_BAD_DATA, Extracting _PRW package [20080321]
> ACPI Exception (scan-0716): AE_BAD_DATA, Extracting _PRW package [20080321]
> ACPI Exception (scan-0716): AE_BAD_DATA, Extracting _PRW package [20080321]
> ACPI Exception (scan-0716): AE_BAD_DATA, Extracting _PRW package [20080321]
