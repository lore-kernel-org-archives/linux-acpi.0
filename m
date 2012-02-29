From: Huang Ying <ying.huang@intel.com>
Subject: RE: [PATCH] ACPI, APEI, EINJ, limit the range of einj_param
Date: Wed, 29 Feb 2012 13:38:20 +0800
Message-ID: <1330493900.7432.15.camel@yhuang-dev>
References: <1330418695-8005-1-git-send-email-gong.chen@linux.intel.com>
	 <1330419255.7432.11.camel@yhuang-dev>
	 <3908561D78D1C84285E8C5FCA982C28F03F983@ORSMSX104.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7016 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab2B2FjW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Feb 2012 00:39:22 -0500
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F03F983@ORSMSX104.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Chen Gong <gong.chen@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2012-02-28 at 11:33 -0700, Luck, Tony wrote:
> > parameter support.  Or we can fix einj_get_parameter_address() to return
> > NULL if param_extension is 0 and paddrv5 is 0.
> 
> That was my intent ... but it looks like I managed to lose that in
> some code re-arrangement.
> 
> Perhaps (Outlook will white-space mangle, but it is only one line):
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 4ca087d..3d3816f 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -238,7 +238,7 @@ static void *einj_get_parameter_address(void)
>  			return v5param;
>  		}
>  	}
> -	if (paddrv4) {
> +	if (param_extension && paddrv4) {
>  		struct einj_parameter *v4param;
>  
>  		v4param = acpi_os_map_memory(paddrv4, sizeof(*v4param));
> 

Good for me.  Thanks!

Best Regards,
Huang Ying

