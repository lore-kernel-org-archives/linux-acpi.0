From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] Fix two minor bugs in cper.c.
Date: Mon, 13 Feb 2012 16:43:04 +0800
Message-ID: <1329122584.9146.90.camel@yhuang-dev>
References: <1329064426-26178-1-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19590 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052Ab2BMInG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Feb 2012 03:43:06 -0500
In-Reply-To: <1329064426-26178-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Matthew Garrett <mjg@redhat.com>, Jiang Liu <jiang.liu@huawei.com>, linux-acpi@vger.kernel.org

Hi, Jiang Liu,

On Mon, 2012-02-13 at 00:33 +0800, Jiang Liu wrote:
> The function apei_estatus_print() and apei_estatus_check() forget to move ahead
> the gdata pointer when dealing with multiple generic error data sections.
> Also fix another copy & paste error in erst.c
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
>  drivers/acpi/apei/cper.c |    2 ++
>  drivers/acpi/apei/erst.c |    2 +-
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/apei/cper.c b/drivers/acpi/apei/cper.c
> index 5d41894..e6defd8 100644
> --- a/drivers/acpi/apei/cper.c
> +++ b/drivers/acpi/apei/cper.c
> @@ -362,6 +362,7 @@ void apei_estatus_print(const char *pfx,
>  		gedata_len = gdata->error_data_length;
>  		apei_estatus_print_section(pfx, gdata, sec_no);
>  		data_len -= gedata_len + sizeof(*gdata);
> +		gdata = (void *)(gdata + 1) + gedata_len;
>  		sec_no++;
>  	}
>  }
> @@ -396,6 +397,7 @@ int apei_estatus_check(const struct acpi_hest_generic_status *estatus)
>  		if (gedata_len > data_len - sizeof(*gdata))
>  			return -EINVAL;
>  		data_len -= gedata_len + sizeof(*gdata);
> +		gdata = (void *)(gdata + 1) + gedata_len;
>  	}
>  	if (data_len)
>  		return -EINVAL;
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index eb9fab5..e4d9d24 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -917,7 +917,7 @@ static int erst_check_table(struct acpi_table_erst *erst_tab)
>  {
>  	if ((erst_tab->header_length !=
>  	     (sizeof(struct acpi_table_erst) - sizeof(erst_tab->header)))
> -	    && (erst_tab->header_length != sizeof(struct acpi_table_einj)))
> +	    && (erst_tab->header_length != sizeof(struct acpi_table_erst)))
>  		return -EINVAL;
>  	if (erst_tab->header.length < sizeof(struct acpi_table_erst))
>  		return -EINVAL;

Good catch!  Thanks.

But please separate fixes for cper.c and erst.c to 2 patches.  They are
two bugs.

Best Regards,
Huang Ying

