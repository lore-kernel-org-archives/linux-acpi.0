From: G Gregory <graeme.gregory@linaro.org>
Subject: Re: [PATCH] ACPI / amba: Remove CLK_IS_ROOT
Date: Wed, 20 Apr 2016 08:28:38 +0100
Message-ID: <CAGCh1+kxsWTaYpR=qt4FCR3RxO2E7iE4j7_Prcus1CRAbGkGTA@mail.gmail.com>
References: <1461115718-31151-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36121 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbcDTH2j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Apr 2016 03:28:39 -0400
Received: by mail-oi0-f43.google.com with SMTP id x201so32485897oif.3
        for <linux-acpi@vger.kernel.org>; Wed, 20 Apr 2016 00:28:38 -0700 (PDT)
In-Reply-To: <1461115718-31151-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@linaro.org>

On 20 April 2016 at 02:28, Stephen Boyd <sboyd@codeaurora.org> wrote:
> This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
> CLK_IS_ROOT", 2016-02-02) so remove it.
>
> Cc: Graeme Gregory <graeme.gregory@linaro.org>
> Cc: Aleksey Makarov <aleksey.makarov@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/acpi/acpi_amba.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
> index 2a61b54ab968..7f77c071709a 100644
> --- a/drivers/acpi/acpi_amba.c
> +++ b/drivers/acpi/acpi_amba.c
> @@ -35,8 +35,7 @@ static void amba_register_dummy_clk(void)
>         if (amba_dummy_clk)
>                 return;
>
> -       amba_dummy_clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL,
> -                                               CLK_IS_ROOT, 0);
> +       amba_dummy_clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, 0, 0);
>         clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);
>  }
>
Looks good to me.

Acked-by: Graeme Gregory <graeme.gregory@linaro.org>
