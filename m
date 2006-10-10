From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [patch 02/12] ACPI: fix printk format warnings
Date: Tue, 10 Oct 2006 14:47:02 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4011C5505@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3143 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1030496AbWJJVrR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 17:47:17 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, rdunlap@xenotime.net

A few things:

1) is the "z" modifier ANSI C?
2) in attempting to make this code go both 32/64, and given that we know
that the sizeof this struct is tiny (36 bytes), would it not make more
sense to just cast the sizeof to unsigned int or u32? Same argument for
any use of sizeof in a printf.
3) both of these messages are gone in the new table manager, but the
basic problem remains, I would like to solve it once and for all.

Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of akpm@osdl.org
> Sent: Tuesday, October 10, 2006 2:21 PM
> To: Brown, Len
> Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; rdunlap@xenotime.net
> Subject: [patch 02/12] ACPI: fix printk format warnings
> 
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Fix printk format warnings in drivers/acpi:
> drivers/acpi/tables/tbget.c:326: warning: format '%X' expects type
> 'unsigned int', but argument 5 has type 'long unsigned int'
> drivers/acpi/tables/tbrsdt.c:189: warning: format '%X' expects type
> 'unsigned int', but argument 5 has type 'long unsigned int'
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
> diff -puN drivers/acpi/tables/tbget.c~acpi-fix-printk-format-warnings
> drivers/acpi/tables/tbget.c
> --- a/drivers/acpi/tables/tbget.c~acpi-fix-printk-format-warnings
> +++ a/drivers/acpi/tables/tbget.c
> @@ -324,7 +324,7 @@ acpi_tb_get_this_table(struct acpi_point
> 
>  	if (header->length < sizeof(struct acpi_table_header)) {
>  		ACPI_ERROR((AE_INFO,
> -			    "Table length (%X) is smaller than minimum
(%X)",
> +			    "Table length (%X) is smaller than minimum
(%zX)",
>  			    header->length, sizeof(struct
acpi_table_header)));
> 
>  		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
> diff -puN drivers/acpi/tables/tbrsdt.c~acpi-fix-printk-format-warnings
> drivers/acpi/tables/tbrsdt.c
> --- a/drivers/acpi/tables/tbrsdt.c~acpi-fix-printk-format-warnings
> +++ a/drivers/acpi/tables/tbrsdt.c
> @@ -187,7 +187,7 @@ acpi_status acpi_tb_validate_rsdt(struct
> 
>  	if (table_ptr->length < sizeof(struct acpi_table_header)) {
>  		ACPI_ERROR((AE_INFO,
> -			    "RSDT/XSDT length (%X) is smaller than
minimum
> (%X)",
> +			    "RSDT/XSDT length (%X) is smaller than
minimum
> (%zX)",
>  			    table_ptr->length,
>  			    sizeof(struct acpi_table_header)));
> 
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
