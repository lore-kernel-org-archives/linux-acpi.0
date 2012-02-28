From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI, APEI, EINJ, limit the range of einj_param
Date: Tue, 28 Feb 2012 16:54:15 +0800
Message-ID: <1330419255.7432.11.camel@yhuang-dev>
References: <1330418695-8005-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63225 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252Ab2B1IyQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Feb 2012 03:54:16 -0500
In-Reply-To: <1330418695-8005-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org

On Tue, 2012-02-28 at 16:44 +0800, Chen Gong wrote:
> On the platforms with ACPI4.x support, parameter extension
> is not always doable, which means only parameter extension
> is enabled, einj_param can take effect.
> 
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> ---
>  drivers/acpi/apei/einj.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 4ca087d..0323684 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -466,7 +466,7 @@ static int __einj_error_inject(u32 type, u64 param1, u64 param2)
>  		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
>  		if (rc)
>  			return rc;
> -		if (einj_param) {
> +		if (param_extension && einj_param) {
>  			struct einj_parameter *v4param = einj_param;
>  			v4param->param1 = param1;
>  			v4param->param2 = param2;

Good catch!  It appears that is introduced when adding ACPI 5.0
parameter support.  Or we can fix einj_get_parameter_address() to return
NULL if param_extension is 0 and paddrv5 is 0.

Best Regards,
Huang Ying

