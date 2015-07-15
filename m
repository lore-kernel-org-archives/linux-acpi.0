From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Fix indent for variable declaration
Date: Thu, 16 Jul 2015 01:55:20 +0200
Message-ID: <3463574.aXbUcK511Q@vostro.rjw.lan>
References: <193d032.5dbd.14e8f95121f.Coremail.yizhouzhou@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62532 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752693AbbGOX2p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2015 19:28:45 -0400
In-Reply-To: <193d032.5dbd.14e8f95121f.Coremail.yizhouzhou@ict.ac.cn>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
Cc: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org

On Wednesday, July 15, 2015 10:39:48 AM Zhouyi Zhou wrote:
> In function acpi_ns_one_complete_parse, the variable declaration
> aml_length is not correctly indented.
> 
> Signed-off-by: Zhouyi Zhou <yizhouzhou@ict.ac.cn>

Please send ACPICA patches to the ACPICA maintainers as per MAINTAINERS.

Thanks!

> ---
>  drivers/acpi/acpica/nsparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
> index 57a4cfe..802afdc 100644
> --- a/drivers/acpi/acpica/nsparse.c
> +++ b/drivers/acpi/acpica/nsparse.c
> @@ -70,7 +70,7 @@ acpi_ns_one_complete_parse(u32 pass_number,
>  {
>         union acpi_parse_object *parse_root;
>         acpi_status status;
> -       u32 aml_length;
> +       u32 aml_length;
>         u8 *aml_start;
>         struct acpi_walk_state *walk_state;
>         struct acpi_table_header *table;
> --
> 2.4.5
> 
> 
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
