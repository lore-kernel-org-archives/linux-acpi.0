From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH] libnvdimm, nfit: Use ACPI_SIG_NFIT instead of hard coded
 string
Date: Thu, 21 Jan 2016 09:08:41 -0700
Message-ID: <20160121160841.GA625@linux.intel.com>
References: <1453379530-21727-1-git-send-email-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29918 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964802AbcAUQJa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jan 2016 11:09:30 -0500
Content-Disposition: inline
In-Reply-To: <1453379530-21727-1-git-send-email-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Len Brown <lenb@kernel.org>

On Thu, Jan 21, 2016 at 08:32:10PM +0800, Lee, Chun-Yi wrote:
> It's minor but that's still better to use ACPI_SIG_NFIT instead of hard
> coded string.
> 
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Lee, Chun-Yi <jlee@suse.com>

Acked-by: Ross Zwisler <ross.zwisler@linux.intel.com>

>  drivers/acpi/nfit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index aa45d48..9fb1a6a 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -1739,7 +1739,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
>  	acpi_size sz;
>  	int rc;
>  
> -	status = acpi_get_table_with_size("NFIT", 0, &tbl, &sz);
> +	status = acpi_get_table_with_size(ACPI_SIG_NFIT, 0, &tbl, &sz);
>  	if (ACPI_FAILURE(status)) {
>  		/* This is ok, we could have an nvdimm hotplugged later */
>  		dev_dbg(dev, "failed to find NFIT at startup\n");
> -- 
> 2.1.4
> 
