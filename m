From: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH] ACPI: configfs: make config_item_type const
Date: Thu, 12 Oct 2017 17:05:08 +0200
Message-ID: <CAOH+1jGPh=T-e_9kX3FYO0D79WMPTLri+27cfiTsunxMw-H04w@mail.gmail.com>
References: <1507802571-4157-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:49631 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdJLPFK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Oct 2017 11:05:10 -0400
In-Reply-To: <1507802571-4157-1-git-send-email-bhumirks@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bhumika Goyal <bhumirks@gmail.com>

On Thu, Oct 12, 2017 at 12:02 PM, Bhumika Goyal <bhumirks@gmail.com> wrote:
> This is a followup patch for: https://lkml.org/lkml/2017/10/11/375 and
> https://patchwork.kernel.org/patch/9999649/
>
> Make these structures const as they are either passed to the functions
> having the argument as const or stored as a reference in the "ci_type"
> const field of a config_item structure.
>
> Done using Coccienlle.
>

Actually, this patch is dependent on the patches in the links
https://lkml.org/lkml/2017/10/11/375 and
https://patchwork.kernel.org/patch/9999649/. Therefore, this patch
won't be correct unless the patches in these links gets applied.

> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/acpi/acpi_configfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index 853bc7f..b588503 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -204,7 +204,7 @@ struct configfs_attribute *acpi_table_attrs[] = {
>         NULL,
>  };
>
> -static struct config_item_type acpi_table_type = {
> +static const struct config_item_type acpi_table_type = {
>         .ct_owner = THIS_MODULE,
>         .ct_bin_attrs = acpi_table_bin_attrs,
>         .ct_attrs = acpi_table_attrs,
> @@ -237,12 +237,12 @@ struct configfs_group_operations acpi_table_group_ops = {
>         .drop_item = acpi_table_drop_item,
>  };
>
> -static struct config_item_type acpi_tables_type = {
> +static const struct config_item_type acpi_tables_type = {
>         .ct_owner = THIS_MODULE,
>         .ct_group_ops = &acpi_table_group_ops,
>  };
>
> -static struct config_item_type acpi_root_group_type = {
> +static const struct config_item_type acpi_root_group_type = {
>         .ct_owner = THIS_MODULE,
>  };
>
> --
> 1.9.1
>
