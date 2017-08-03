From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / dock: constify attribute_group structures.
Date: Fri, 4 Aug 2017 00:17:06 +0200
Message-ID: <CAJZ5v0id1-i-ECriwqDtqLHNw4xc4HRjnaZsYA6SUHm_6z5zbw@mail.gmail.com>
References: <f0871f6dc12ea0d90a6acf9d5156f9daaa3ee87a.1501764361.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34537 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdHCWRH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2017 18:17:07 -0400
In-Reply-To: <f0871f6dc12ea0d90a6acf9d5156f9daaa3ee87a.1501764361.git.arvind.yadav.cs@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Aug 3, 2017 at 3:18 PM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> attribute_group are not supposed to change at runtime. All functions
> working with attribute_group provided by <linux/sysfs.h> work with
> const attribute_group. So mark the non-const structs as const.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Somebody else sent an analogous patch earlier, so I'm going to take that one.

> ---
>  drivers/acpi/dock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index 0c00208..2305e1a 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -585,7 +585,7 @@ static ssize_t show_dock_type(struct device *dev,
>         NULL
>  };
>
> -static struct attribute_group dock_attribute_group = {
> +static const struct attribute_group dock_attribute_group = {
>         .attrs = dock_attributes
>  };
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
