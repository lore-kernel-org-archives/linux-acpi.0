From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] acpi: fix acpi_get_table() leak / acpi-sysfs denial of service
Date: Thu, 27 Apr 2017 00:25:01 +0200
Message-ID: <CAJZ5v0h4hOeRfBgK=ARbw8dmML56v0xnvPjsY9wZ0fv7EXCeQw@mail.gmail.com>
References: <149315024459.9151.4555045488194999231.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35217 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031498AbdDZWZC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2017 18:25:02 -0400
In-Reply-To: <149315024459.9151.4555045488194999231.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Anush Seetharaman <anush.seetharaman@intel.com>, Tiffany Kasanicky <tiffany.j.kasanicky@intel.com>, Ryon Jensen <ryon.jensen@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stable <stable@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristin Jacque <kristin.jacque@intel.com>, Zhang Rui <rui.zhang@intel.com>

On Tue, Apr 25, 2017 at 9:58 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> Reading an ACPI table through the /sys/firmware/acpi/tables interface
> more than 65,536 times leads to the following log message:
>
>  ACPI Error: Table ffff88033595eaa8, Validation count is zero after increment
>   (20170119/tbutils-423)
>
> ...and the table being unavailable until the next reboot. Add the
> missing acpi_put_table() so the table ->validation_count is decremented
> after each read.
>
> Cc: <stable@vger.kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>
> Cc: Kristin Jacque <kristin.jacque@intel.com>
> Cc: Tiffany Kasanicky <tiffany.j.kasanicky@intel.com>
> Cc: Ryon Jensen <ryon.jensen@intel.com>
> Reported-by: Anush Seetharaman <anush.seetharaman@intel.com>
> Fixes: 1c8fce27e275 ("ACPI: introduce drivers/acpi/sysfs.c")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'm going to apply this, but your Fixes tag is not correct.

validation_count was added to struct acpi_table_desc by commit

commit 174cc7187e6f088942c8e74daa7baff7b44b33c9
Author: Lv Zheng <lv.zheng@intel.com>
Date:   Wed Dec 14 15:04:25 2016 +0800

    ACPICA: Tables: Back port acpi_get_table_with_size() and
early_acpi_os_unmap_memory()
from Linux kernel

from the 4.10 time frame, so IMO it should be

Fixes: 174cc7187e6f (ACPICA: Tables: Back port
acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
kernel)

> ---
>
> Changes in v2:
> * compile fix s/table/table_header/. Sorry, I forgot to do 'stg refresh'
>   before 'stg mail'
>
>  drivers/acpi/sysfs.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index cf05ae973381..5180fef9eb49 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -333,14 +333,17 @@ static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
>             container_of(bin_attr, struct acpi_table_attr, attr);
>         struct acpi_table_header *table_header = NULL;
>         acpi_status status;
> +       ssize_t rc;
>
>         status = acpi_get_table(table_attr->name, table_attr->instance,
>                                 &table_header);
>         if (ACPI_FAILURE(status))
>                 return -ENODEV;
>
> -       return memory_read_from_buffer(buf, count, &offset,
> -                                      table_header, table_header->length);
> +       rc = memory_read_from_buffer(buf, count, &offset, table_header,
> +                       table_header->length);
> +       acpi_put_table(table_header);
> +       return rc;
>  }
>
>  static int acpi_table_attr_init(struct kobject *tables_obj,
>
> --

Thanks,
Rafael
