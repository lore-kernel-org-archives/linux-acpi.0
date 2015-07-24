From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2756/2756] Staging: acpi: Merge lines for immediate return
Date: Fri, 24 Jul 2015 15:07:00 -0700
Message-ID: <CAGXu5jJAWcfA63CtZULYTzTUu2Gyx1pMbV0g45PhfDq+k9PtSQ@mail.gmail.com>
References: <1437757256-10228-1-git-send-email-shraddha.6596@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34356 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbbGXWHB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2015 18:07:01 -0400
Received: by iecrl10 with SMTP id rl10so24574358iec.1
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2015 15:07:00 -0700 (PDT)
In-Reply-To: <1437757256-10228-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shraddha Barke <shraddha.6596@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, Jul 24, 2015 at 10:00 AM, Shraddha Barke
<shraddha.6596@gmail.com> wrote:
> This patch merges two lines in a single line if immediate return is found.
> This is done using Coccinelle.Semantic patch used for this is as follows:
>
> @@
> expression ret;
> identifier f;
> @@
>
> -ret =
> +return
>      f(...);
> -return ret;
>
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
> ---
>  drivers/acpi/apei/erst.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index 3670bba..58e1bdd 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -162,8 +162,7 @@ static int erst_exec_add_value(struct apei_exec_context *ctx,
>         if (rc)
>                 return rc;
>         val += ctx->value;
> -       rc = __apei_exec_write_register(entry, val);
> -       return rc;
> +       return __apei_exec_write_register(entry, val);
>  }
>
>  static int erst_exec_subtract_value(struct apei_exec_context *ctx,
> @@ -176,8 +175,7 @@ static int erst_exec_subtract_value(struct apei_exec_context *ctx,
>         if (rc)
>                 return rc;
>         val -= ctx->value;
> -       rc = __apei_exec_write_register(entry, val);
> -       return rc;
> +       return __apei_exec_write_register(entry, val);
>  }
>
>  static int erst_exec_stall(struct apei_exec_context *ctx,
> @@ -979,9 +977,7 @@ static int erst_open_pstore(struct pstore_info *psi)
>         if (erst_disable)
>                 return -ENODEV;
>
> -       rc = erst_get_record_id_begin(&reader_pos);
> -
> -       return rc;
> +       return erst_get_record_id_begin(&reader_pos);
>  }
>
>  static int erst_close_pstore(struct pstore_info *psi)
> --
> 2.1.0
>

Personally I prefer the readability of continuing to use the rest of a
function's rc = ..., if (rc) ... semantics. If "rc" could be entirely
removed from the function, then switching to immediate returns seems
like a reasonable cleanup. Otherwise, I think it reduces readability
for no effect (the compiler, for example, is already optimizing these
kinds of things at build-time).

-Kees

-- 
Kees Cook
Chrome OS Security
