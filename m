From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH ?] ACPI: pr->id is unsigned
Date: Wed, 17 Sep 2008 09:34:20 +0200
Message-ID: <200809170934.22172.trenn@suse.de>
References: <48CF0CA4.3090701@gmail.com> <200809161045.35078.trenn@suse.de> <48D06FF3.6010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41477 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbYIQHeY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Sep 2008 03:34:24 -0400
In-Reply-To: <48D06FF3.6010406@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: roel kluin <roel.kluin@gmail.com>
Cc: Valdis.Kletnieks@vt.edu, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

Thanks!

Len can you take this one, pls.

On Wednesday 17 September 2008 04:48:19 roel kluin wrote:
> Thomas Renninger wrote:
> > On Monday 15 September 2008 22:26:45 Valdis.Kletnieks@vt.edu wrote:
> >> On Mon, 15 Sep 2008 21:32:20 EDT, roel kluin said:
...
>
> pr->id is unsigned
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Thomas Renninger <trenn@suse.de>

> ---
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index ee68ac5..9f203d3 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -667,7 +667,7 @@ static int __cpuinit acpi_processor_start(struct
> acpi_device *device) return 0;
>  	}
>
> -	BUG_ON((pr->id >= nr_cpu_ids) || (pr->id < 0));
> +	BUG_ON(pr->id >= nr_cpu_ids);
>
>  	/*
>  	 * Buggy BIOS check


