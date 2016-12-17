From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPICA: use designated initializers
Date: Sat, 17 Dec 2016 03:17:47 +0100
Message-ID: <CAJZ5v0iKpFoUa-wtbNRQc4jShK9F03Kkp-ob16bZiz=WZS67gQ@mail.gmail.com>
References: <20161217010425.GA140581@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35861 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbcLQCRt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Dec 2016 21:17:49 -0500
In-Reply-To: <20161217010425.GA140581@beast>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Sat, Dec 17, 2016 at 2:04 AM, Kees Cook <keescook@chromium.org> wrote:
> Prepare to mark sensitive kernel structures for randomization by making
> sure they're using designated initializers. These were identified during
> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
> extracted from grsecurity.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/acpi/acpica/hwxfsleep.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
> index f76e0eab32b8..25cd5c66e102 100644
> --- a/drivers/acpi/acpica/hwxfsleep.c
> +++ b/drivers/acpi/acpica/hwxfsleep.c
> @@ -70,11 +70,12 @@ static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id);
>  /* Legacy functions are optional, based upon ACPI_REDUCED_HARDWARE */
>
>  static struct acpi_sleep_functions acpi_sleep_dispatch[] = {
> -       {ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
> -        acpi_hw_extended_sleep},
> -       {ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep),
> -        acpi_hw_extended_wake_prep},
> -       {ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake), acpi_hw_extended_wake}
> +       { .legacy_function = ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
> +         .extended_function = acpi_hw_extended_sleep },
> +       { .legacy_function = ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep),
> +         .extended_function = acpi_hw_extended_wake_prep },
> +       { .legacy_function = ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake),
> +         .extended_function = acpi_hw_extended_wake }
>  };
>
>  /*
> --

The problem here is like in the other patch sent earlier today.  If we
change that here, it will diverge from the upstream file it has been
generated from.

Thanks,
Rafael
