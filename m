From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] ACPI header length printk format warning
Date: Thu, 12 Oct 2006 13:40:40 -0700
Message-ID: <20061012134040.a64eda8a.rdunlap@xenotime.net>
References: <20061012110345.1d9da93a@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:13010 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750755AbWJLUjS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Oct 2006 16:39:18 -0400
Received: from midway.site ([71.117.236.95]) by xenotime.net for <linux-acpi@vger.kernel.org>; Thu, 12 Oct 2006 13:39:13 -0700
In-Reply-To: <20061012110345.1d9da93a@dxpl.pdx.osdl.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Thu, 12 Oct 2006 11:03:45 -0700 Stephen Hemminger wrote:

> Get rid of warning from printk arguments on 64 bit platforms.

size_t (sizeof) should use %zd or %zu or %zx or %zX.

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/broken-out/acpi-fix-printk-format-warnings.patch

Yes, it would be nice if some patch could be merged for this.

> --- orig/drivers/acpi/tables/tbget.c
> +++ new/drivers/acpi/tables/tbget.c
> @@ -324,8 +324,9 @@ acpi_tb_get_this_table(struct acpi_point
>  
>  	if (header->length < sizeof(struct acpi_table_header)) {
>  		ACPI_ERROR((AE_INFO,
> -			    "Table length (%X) is smaller than minimum (%X)",
> -			    header->length, sizeof(struct acpi_table_header)));
> +			    "Table length (%lx) is smaller than minimum (%zx)",
> +			    (unsigned long) header->length,
> +			    sizeof(struct acpi_table_header)));
>  
>  		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
>  	}
> @@ -343,8 +344,8 @@ acpi_tb_get_this_table(struct acpi_point
>  		full_table = ACPI_ALLOCATE(header->length);
>  		if (!full_table) {
>  			ACPI_ERROR((AE_INFO,
> -				    "Could not allocate table memory for [%4.4s] length %X",
> -				    header->signature, header->length));
> +				    "Could not allocate table memory for [%4.4s] length %lx",
> +				    header->signature, (unsigned long) header->length));
>  			return_ACPI_STATUS(AE_NO_MEMORY);
>  		}

---
~Randy
