From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] ACPI: fix incorrect counts returned by acpi_parse_entries_array()
Date: Fri, 1 Jul 2016 23:25:22 +0200
Message-ID: <CAJZ5v0h2_uRYNC-+naQuycNUS86fNy0zO_vAXarfM006sMWEwQ@mail.gmail.com>
References: <1467408081-7418-1-git-send-email-ahs3@redhat.com> <1467408081-7418-2-git-send-email-ahs3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34222 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbcGAV0P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2016 17:26:15 -0400
In-Reply-To: <1467408081-7418-2-git-send-email-ahs3@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Fri, Jul 1, 2016 at 11:21 PM, Al Stone <ahs3@redhat.com> wrote:
> The static function acpi_parse_entries_array() is provided an array of
> type struct acpi_subtable_proc that has a callback function and a count.
> The count should reflect how many times the callback has been successfully
> called.  However, the current code only increments the 0th element of the
> array, regardless of the number of entries in the array, or which callback
> has been invoked.  The fix is to use the index into the array, instead of
> a pointer to the beginning of the array.

OK, so it would be good to say what the consequences of the problem are too.

> Signed-off-by: Al Stone <ahs3@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> ---
>  drivers/acpi/tables.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 9f0ad6e..3e167b4 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -281,7 +281,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>                              proc[i].handler(entry, table_end))
>                                 return -EINVAL;
>
> -                       proc->count++;
> +                       proc[i].count++;
>                         break;
>                 }
>                 if (i != proc_num)
> @@ -416,7 +416,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
>                 return -ENODEV;
>  }
>
> -/*
> +/*
>   * The BIOS is supposed to supply a single APIC/MADT,
>   * but some report two.  Provide a knob to use either.
>   * (don't you wish instance 0 and 1 were not the same?)
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
