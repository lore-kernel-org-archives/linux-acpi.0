From: Kees Cook <keescook@google.com>
Subject: Re: [RESEND PATCH] acpi/apei/erst: Remove "Error" from initialization
 and disable output
Date: Wed, 24 May 2017 09:27:23 -0700
Message-ID: <CAGXu5jJ4qrfKA9wb8kaCAyVct7dPzcuqBW+bv-6XRZTSp3g=Sw@mail.gmail.com>
References: <1495639838-28099-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:36205 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031123AbdEXQ1Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 May 2017 12:27:24 -0400
Received: by mail-it0-f54.google.com with SMTP id o5so41702718ith.1
        for <linux-acpi@vger.kernel.org>; Wed, 24 May 2017 09:27:24 -0700 (PDT)
In-Reply-To: <1495639838-28099-1-git-send-email-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, Huang Ying <ying.huang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Wed, May 24, 2017 at 8:30 AM, Prarit Bhargava <prarit@redhat.com> wrote:
> Sent a few weeks back ... no reply.

I've added Huang Ying to CC, as the original author of this code. It
looks fine to me, FWIW.

-Kees

>
> P.
>
> ---8<---
>
> The word "Error" is used by many QA groups and users as a keyword to
> indicate that there is a critical failure during system bootup. The ESRT
> code would interact better with these scripts if the word "Error" was
> dropped from non-error messages.  Other ACPI features only use the acronym
> for initialization and disable messages so the ESRT code should do the
> same.
>
> Remove "Error Record Serialization Table" and replace it with "ACPI ESRT"
> in the messages.
>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>

This is fine by me.

> ---
>  drivers/acpi/apei/erst.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index ec4f507b524f..a796b9d91e20 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -1129,8 +1129,7 @@ static int __init erst_init(void)
>                 goto err;
>
>         if (erst_disable) {
> -               pr_info(
> -       "Error Record Serialization Table (ERST) support is disabled.\n");
> +               pr_info("ACPI ERST support is disabled.\n");
>                 goto err;
>         }
>
> @@ -1187,8 +1186,7 @@ static int __init erst_init(void)
>         if (!erst_erange.vaddr)
>                 goto err_release_erange;
>
> -       pr_info(
> -       "Error Record Serialization Table (ERST) support is initialized.\n");
> +       pr_info("ACPI ERST support is initialized.\n");
>
>         buf = kmalloc(erst_erange.size, GFP_KERNEL);
>         spin_lock_init(&erst_info.buf_lock);
> --
> 1.7.9.3
>



-- 
Kees Cook
Pixel Security
