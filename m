From: Len Brown <lenb@kernel.org>
Subject: Re: Oops in ACPI with git latest
Date: Fri, 24 Oct 2008 16:42:29 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810241642240.3056@localhost.localdomain>
References: <1224791103.3330.37.camel@localhost.localdomain>
 <200810242043.04078.rjw@sisk.pl> <200810241222.32979.jbarnes@virtuousgeek.org>
 <200810242150.31809.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:53605 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbYJXUms (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Oct 2008 16:42:48 -0400
In-reply-to: <200810242150.31809.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "Moore, Robert" <robert.moore@intel.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

applied.

thanks,
-len

On Fri, 24 Oct 2008, Rafael J. Wysocki wrote:

> On Friday, 24 of October 2008, Jesse Barnes wrote:
> > On Friday, October 24, 2008 11:43 am Rafael J. Wysocki wrote:
> > > On Friday, 24 of October 2008, Jesse Barnes wrote:
> > > > So who wants to send me a final patch for this?
> > >
> > > I already did: http://marc.info/?l=linux-kernel&m=122484871717023&w=4
> > > but I can remove the "!output.pointer || " if you prefer. :-)
> > 
> > Yeah Bob said it would likely contain garbage anyway, so we should just remove 
> > it.
> 
> OK, here you go.
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: Prevent acpi_run_osc from using NULL objects
> 
> Check if the object returned by acpi_evaluate_object() in
> acpi_run_osc() is not NULL before using it.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pci-acpi.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-2.6/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci-acpi.c
> +++ linux-2.6/drivers/pci/pci-acpi.c
> @@ -83,6 +83,9 @@ static acpi_status acpi_run_osc(acpi_han
>  	if (ACPI_FAILURE(status))
>  		return status;
>  
> +	if (!output.length)
> +		return AE_NULL_OBJECT;
> +
>  	out_obj = output.pointer;
>  	if (out_obj->type != ACPI_TYPE_BUFFER) {
>  		printk(KERN_DEBUG "Evaluate _OSC returns wrong type\n");
> 
