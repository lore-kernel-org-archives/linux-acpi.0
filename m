From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] efi_pstore: add missing iounmap() on error in erst_exec_move_data()
Date: Tue, 2 Jul 2013 11:50:15 -0700
Message-ID: <CAGXu5j+YYp_xm+hwaRt5HBpKMEb_gcepOm8Q0kyJSrGtKZMgfg@mail.gmail.com>
References: <CAPgLHd-x4N6NVJUWz9Tr4onnBgEwLW6CNQqS1_upSQzPKSoX2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:58220 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab3GBSuQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Jul 2013 14:50:16 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so13456952ieb.30
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jul 2013 11:50:15 -0700 (PDT)
In-Reply-To: <CAPgLHd-x4N6NVJUWz9Tr4onnBgEwLW6CNQqS1_upSQzPKSoX2Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, lenb@kernel.org, rjw@sisk.pl, yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org

On Mon, Jul 1, 2013 at 6:02 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Add the missing iounmap() before return from erst_exec_move_data()
> in the error handling case.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/acpi/apei/erst.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index f7b3b39..7af21ed 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -284,8 +284,10 @@ static int erst_exec_move_data(struct apei_exec_context *ctx,
>         if (!src)
>                 return -ENOMEM;
>         dst = ioremap(ctx->dst_base + offset, ctx->var2);
> -       if (!dst)
> +       if (!dst) {
> +               iounmap(src);
>                 return -ENOMEM;
> +       }
>
>         memmove(dst, src, ctx->var2);

Good catch!

Acked-by: Kees Cook <keescook@chromium.org>

Thanks,

-Kees

--
Kees Cook
Chrome OS Security
