From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch 11/11] acpi: use memory_read_from_buffer()
Date: Thu, 12 Jun 2008 02:07:29 +0800
Message-ID: <1213207649.3130.0.camel@rzhang-dt.sh.intel.com>
References: <200806092322.m59NMQld013985@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38009 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754144AbYFKCHg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Jun 2008 22:07:36 -0400
In-Reply-To: <200806092322.m59NMQld013985@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, akinobu.mita@gmail.com, "Moore, Robert" <robert.moore@intel.com>, trenn@suse.de

Acked-by: Zhang Rui <rui.zhang@intel.com>

On Tue, 2008-06-10 at 07:22 +0800, akpm@linux-foundation.org wrote:
> From: Akinobu Mita <akinobu.mita@gmail.com>
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Bob Moore <robert.moore@intel.com>
> Cc: Thomas Renninger <trenn@suse.de>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/system.c |   15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff -puN drivers/acpi/system.c~acpi-use-memory_read_from_buffer
> drivers/acpi/system.c
> --- a/drivers/acpi/system.c~acpi-use-memory_read_from_buffer
> +++ a/drivers/acpi/system.c
> @@ -77,7 +77,6 @@ static ssize_t acpi_table_show(struct ko
>             container_of(bin_attr, struct acpi_table_attr, attr);
>         struct acpi_table_header *table_header = NULL;
>         acpi_status status;
> -       ssize_t ret_count = count;
> 
>         status =
>             acpi_get_table(table_attr->name, table_attr->instance,
> @@ -85,18 +84,8 @@ static ssize_t acpi_table_show(struct ko
>         if (ACPI_FAILURE(status))
>                 return -ENODEV;
> 
> -       if (offset >= table_header->length) {
> -               ret_count = 0;
> -               goto end;
> -       }
> -
> -       if (offset + ret_count > table_header->length)
> -               ret_count = table_header->length - offset;
> -
> -       memcpy(buf, ((char *)table_header) + offset, ret_count);
> -
> -      end:
> -       return ret_count;
> +       return memory_read_from_buffer(buf, count, &offset,
> +                                       table_header,
> table_header->length);
>  }
> 
>  static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
> _
> 
> 

