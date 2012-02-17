From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v3 2/2] Fix a copy & paste error in erst.c.
Date: Fri, 17 Feb 2012 13:28:27 +0800
Message-ID: <1329456507.6449.54.camel@yhuang-dev>
References: <1329235305-780-1-git-send-email-jiang.liu@huawei.com>
	 <1329235305-780-2-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64334 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab2BQF23 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Feb 2012 00:28:29 -0500
In-Reply-To: <1329235305-780-2-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Jiang Liu <jiang.liu@huawei.com>, linux-acpi@vger.kernel.org

On Wed, 2012-02-15 at 00:01 +0800, Jiang Liu wrote:
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>

Acked-by: Huang Ying <ying.huang@intel.com>

> ---
>  drivers/acpi/apei/erst.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
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


