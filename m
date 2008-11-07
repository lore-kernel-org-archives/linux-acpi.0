From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 07/21] ACPI EC: Fix regression due to use of
	uninitialized variable
Date: Fri, 07 Nov 2008 14:13:42 +0800
Message-ID: <1226038422.3989.244.camel@yakui_zhao.sh.intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
	 <29086e19e9149aadd17ece7112d7d2cf3a8b82f3.1226032677.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44686 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755295AbYKGGGa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Nov 2008 01:06:30 -0500
In-Reply-To: <29086e19e9149aadd17ece7112d7d2cf3a8b82f3.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, "Brown, Len" <len.brown@intel.com>

On Fri, 2008-11-07 at 12:39 +0800, Len Brown wrote:
> From: Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> breakage introduced by following patch
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
The bug references for 11896 should be deleted.
    The bug for 11896 can't be resolved by this patch.
Thanks.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> Tested-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/ec.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
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

