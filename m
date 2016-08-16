From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 1/2] ACPI/tables: Correct the wrong count increasing
Date: Tue, 16 Aug 2016 02:26:46 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC0E417@SHSMSX101.ccr.corp.intel.com>
References: <1470697311-1292-1-git-send-email-bhe@redhat.com>
 <20160809003006.GF16660@x1.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29863 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075AbcHPC1h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Aug 2016 22:27:37 -0400
In-Reply-To: <20160809003006.GF16660@x1.redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Baoquan He <bhe@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Baoquan
> He
> Subject: [PATCH v2 1/2] ACPI/tables: Correct the wrong count increasing
> 
> The current code always increases the count in the 1st element of
> array proc[].
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
> 
> v1->v2:
>     V1 is a wrong post because I didn't update the tested code to my
>     local laptop. Repost with a correct v2.
> 
>  drivers/acpi/tables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 9f0ad6e..34d45bb 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -281,7 +281,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>  			     proc[i].handler(entry, table_end))
>  				return -EINVAL;
> 
> -			proc->count++;
> +			proc[i].count++;

Do we have code using acpi_subtable_proce.count?
I think the answer is yes because of:
[Patch] x86, ACPI: Fix the wrong assignment when Handle apic/x2apic entries

So why don't you put these 2 patches together into a single series?
And help to validate if there are problems in other acpi_subtable_proce.count users.

Thanks
Lv

>  			break;
>  		}
>  		if (i != proc_num)
> --
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
