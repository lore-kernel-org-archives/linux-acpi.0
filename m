From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI/APEI: fix error status check condition for CPER
Date: Wed, 20 Mar 2013 09:36:56 +0800
Message-ID: <1363743416.11204.14.camel@yhuang-dev>
References: <1363675687-7839-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64447 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258Ab3CTBg6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Mar 2013 21:36:58 -0400
In-Reply-To: <1363675687-7839-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org, rjw@sisk.pl

On Tue, 2013-03-19 at 02:48 -0400, Chen Gong wrote:
> In Table 18-289, ACPI5.0 SPEC, the error data length in CPER
> Generic Error Data Entry can be 0, which means this generic
> error data entry can have only one header. So fix the check
> conditon for it.
> 
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>

Good catch!

Reviewed-by: Huang Ying <ying.huang@intel.com>

> ---
>  drivers/acpi/apei/cper.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/cper.c b/drivers/acpi/apei/cper.c
> index 1e5d8a4..fefc2ca 100644
> --- a/drivers/acpi/apei/cper.c
> +++ b/drivers/acpi/apei/cper.c
> @@ -405,7 +405,7 @@ int apei_estatus_check(const struct acpi_hest_generic_status *estatus)
>  		return rc;
>  	data_len = estatus->data_length;
>  	gdata = (struct acpi_hest_generic_data *)(estatus + 1);
> -	while (data_len > sizeof(*gdata)) {
> +	while (data_len >= sizeof(*gdata)) {
>  		gedata_len = gdata->error_data_length;
>  		if (gedata_len > data_len - sizeof(*gdata))
>  			return -EINVAL;


