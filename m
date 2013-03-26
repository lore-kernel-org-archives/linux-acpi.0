From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] drivers: acpi: Used PTR_RET function
Date: Tue, 26 Mar 2013 14:28:34 +0100
Message-ID: <1860843.rMdcvsu2GA@vostro.rjw.lan>
References: <1363077171-30141-1-git-send-email-gheorghiuandru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43036 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933848Ab3CZNVI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Mar 2013 09:21:08 -0400
In-Reply-To: <1363077171-30141-1-git-send-email-gheorghiuandru@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, March 12, 2013 10:32:51 AM Alexandru Gheorghiu wrote:
> Used PTR_RET function instead of explicit checking with IS_ERR.
> 
> Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>

Applied to linux-pm.git/linux-next.

Thanks,
Rafael


> ---
>  drivers/acpi/acpi_pad.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 31de104..27bb6a9 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -236,7 +236,7 @@ static int create_power_saving_task(void)
>  	ps_tsks[ps_tsk_num] = kthread_run(power_saving_thread,
>  		(void *)(unsigned long)ps_tsk_num,
>  		"acpi_pad/%d", ps_tsk_num);
> -	rc = IS_ERR(ps_tsks[ps_tsk_num]) ? PTR_ERR(ps_tsks[ps_tsk_num]) : 0;
> +	rc = PTR_RET(ps_tsks[ps_tsk_num]);
>  	if (!rc)
>  		ps_tsk_num++;
>  	else
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
