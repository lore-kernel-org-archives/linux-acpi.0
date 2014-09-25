From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Update acpi_check_dsm() comments
Date: Fri, 26 Sep 2014 01:46:48 +0200
Message-ID: <1874259.SO0gRfFCMH@vostro.rjw.lan>
References: <1410781013-16673-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49583 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752598AbaIYX06 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2014 19:26:58 -0400
In-Reply-To: <1410781013-16673-1-git-send-email-wangyijing@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-acpi@vger.kernel.org

On Monday, September 15, 2014 07:36:53 PM Yijing Wang wrote:
> Update function comments.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Queued up for 3.18, thanks!

> ---
>  drivers/acpi/utils.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 07c8c5a..834f35c 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -661,7 +661,6 @@ EXPORT_SYMBOL(acpi_evaluate_dsm);
>   * @uuid: UUID of requested functions, should be 16 bytes at least
>   * @rev: revision number of requested functions
>   * @funcs: bitmap of requested functions
> - * @exclude: excluding special value, used to support i915 and nouveau
>   *
>   * Evaluate device's _DSM method to check whether it supports requested
>   * functions. Currently only support 64 functions at maximum, should be
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
