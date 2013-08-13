From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] ACPI / dock: Fix __init attribute locations
Date: Tue, 13 Aug 2013 13:32:50 +0200
Message-ID: <1451811.DUiLZmfEVo@vostro.rjw.lan>
References: <1376389876-11791-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40901 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757287Ab3HMLWa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Aug 2013 07:22:30 -0400
In-Reply-To: <1376389876-11791-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-acpi@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org

On Tuesday, August 13, 2013 06:31:13 PM Hanjun Guo wrote:
> __init belongs after the return type on functions, not before it.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

All 3 patches in this series queued up for 3.12.

Thanks,
Rafael


> ---
>  drivers/acpi/dock.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index 8265607..c90112c 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -1055,7 +1055,7 @@ err_unregister:
>   *
>   * This is called by acpi_walk_namespace to look for dock stations and bays.
>   */
> -static __init acpi_status
> +static acpi_status __init
>  find_dock_and_bay(acpi_handle handle, u32 lvl, void *context, void **rv)
>  {
>  	if (is_dock(handle) || is_ejectable_bay(handle))
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
