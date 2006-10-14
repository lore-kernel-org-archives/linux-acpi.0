From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 02/12] ACPI: fix printk format warnings
Date: Sat, 14 Oct 2006 04:07:33 -0400
Message-ID: <200610140407.33934.len.brown@intel.com>
References: <200610102120.k9ALKWWE024269@shell0.pdx.osdl.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54215 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1160998AbWJNIFK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:05:10 -0400
In-Reply-To: <200610102120.k9ALKWWE024269@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, rdunlap@xenotime.net

Applied.

thanks,
-Len

On Tuesday 10 October 2006 17:20, akpm@osdl.org wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Fix printk format warnings in drivers/acpi:
> drivers/acpi/tables/tbget.c:326: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'
> drivers/acpi/tables/tbrsdt.c:189: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/tables/tbget.c  |    2 +-
>  drivers/acpi/tables/tbrsdt.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/acpi/tables/tbget.c~acpi-fix-printk-format-warnings drivers/acpi/tables/tbget.c
> --- a/drivers/acpi/tables/tbget.c~acpi-fix-printk-format-warnings
> +++ a/drivers/acpi/tables/tbget.c
> @@ -324,7 +324,7 @@ acpi_tb_get_this_table(struct acpi_point
>  
>  	if (header->length < sizeof(struct acpi_table_header)) {
>  		ACPI_ERROR((AE_INFO,
> -			    "Table length (%X) is smaller than minimum (%X)",
> +			    "Table length (%X) is smaller than minimum (%zX)",
>  			    header->length, sizeof(struct acpi_table_header)));
>  
>  		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
> diff -puN drivers/acpi/tables/tbrsdt.c~acpi-fix-printk-format-warnings drivers/acpi/tables/tbrsdt.c
> --- a/drivers/acpi/tables/tbrsdt.c~acpi-fix-printk-format-warnings
> +++ a/drivers/acpi/tables/tbrsdt.c
> @@ -187,7 +187,7 @@ acpi_status acpi_tb_validate_rsdt(struct
>  
>  	if (table_ptr->length < sizeof(struct acpi_table_header)) {
>  		ACPI_ERROR((AE_INFO,
> -			    "RSDT/XSDT length (%X) is smaller than minimum (%X)",
> +			    "RSDT/XSDT length (%X) is smaller than minimum (%zX)",
>  			    table_ptr->length,
>  			    sizeof(struct acpi_table_header)));
>  
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
