From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/5] ACPI: EC: clean up tmp variable before reuse
Date: Mon, 10 Nov 2008 15:53:28 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811101551590.23090@localhost.localdomain>
References: <20081109155847.13635.15244.stgit@thinkpad>
 <20081109160036.13635.34455.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:48168 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbYKJUzq (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 10 Nov 2008 15:55:46 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA400AJIY165EJ6@vms173003.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Mon, 10 Nov 2008 14:53:31 -0600 (CST)
In-reply-to: <20081109160036.13635.34455.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

please don't re-send send me patches that i've already acked
as checked in.

thanks,
-len

On Sun, 9 Nov 2008, Alexey Starikovskiy wrote:

> Fix breakage introduced by following patch
> 27663c5855b10af9ec67bc7dfba001426ba21222 is first bad commit
> commit 27663c5855b10af9ec67bc7dfba001426ba21222
> Author: Matthew Wilcox <willy@linux.intel.com>
> Date:   Fri Oct 10 02:22:59 2008 -0400
> 
> acpi_evaluate_integer() does not clear passed variable if
> there is an error at evaluation.
> So if we ignore error, we must supply initialized variable.
> 
> References: http://bugzilla.kernel.org/show_bug.cgi?id=11917
> 	    http://bugzilla.kernel.org/show_bug.cgi?id=11896
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> Tested-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> ---
> 
>  drivers/acpi/ec.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index ef42316..523ac5b 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -736,7 +736,7 @@ static acpi_status
>  ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
>  {
>  	acpi_status status;
> -	unsigned long long tmp;
> +	unsigned long long tmp = 0;
>  
>  	struct acpi_ec *ec = context;
>  	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> @@ -751,6 +751,7 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
>  		return status;
>  	ec->gpe = tmp;
>  	/* Use the global lock for all EC transactions? */
> +	tmp = 0;
>  	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
>  	ec->global_lock = tmp;
>  	ec->handle = handle;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
