From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: ibm_acpi: allow clean removal
Date: Tue, 19 Dec 2006 23:13:27 -0500
Message-ID: <200612192313.27202.lenb@kernel.org>
References: <20061218175207.8826.25057.stgit@thorin.khazad-dum.debian.net> <20061218175332.8826.95334.stgit@thorin.khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47253 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964871AbWLTEOg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 23:14:36 -0500
In-Reply-To: <20061218175332.8826.95334.stgit@thorin.khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Applied.

thanks,
-Len

On Monday 18 December 2006 12:53, Henrique de Moraes Holschuh wrote:
> From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
> 
> Allow clean removal by setting notify_installed in the right place.
> 
> Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> 
>  drivers/acpi/ibm_acpi.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
> index 003a987..719a320 100644
> --- a/drivers/acpi/ibm_acpi.c
> +++ b/drivers/acpi/ibm_acpi.c
> @@ -1805,7 +1805,7 @@ static int __init setup_notify(struct ibm_struct *ibm)
>  		       ibm->name, status);
>  		return -ENODEV;
>  	}
> -
> +	ibm->notify_installed = 1;
>  	return 0;
>  }
>  
> @@ -1882,7 +1882,6 @@ static int __init ibm_init(struct ibm_struct *ibm)
>  		ret = setup_notify(ibm);
>  		if (ret < 0)
>  			return ret;
> -		ibm->notify_installed = 1;
>  	}
>  
>  	return 0;
> 
> 
> --  
>   "One disk to rule them all, One disk to find them. One disk to bring
>   them all and in the darkness grind them. In the Land of Redmond
>   where the shadows lie." -- The Silicon Valley Tarot
>   Henrique Holschuh
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
