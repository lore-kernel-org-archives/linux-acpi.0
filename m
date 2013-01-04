From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPICA: Add newlines to hwvalid debug output
Date: Sat, 05 Jan 2013 00:42:39 +0100
Message-ID: <1553024.9jVC34qo6B@vostro.rjw.lan>
References: <20130104222428.10275.2683.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:60542 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749Ab3ADXhC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Jan 2013 18:37:02 -0500
In-Reply-To: <20130104222428.10275.2683.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Bob Moore <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

On Friday, January 04, 2013 03:24:28 PM Bjorn Helgaas wrote:
> Add newlines to avoid run-on debug output.

This has to go through ACPICA upstream.

Bob, can you take it, please?

Rafael


> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/acpi/acpica/hwvalid.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
> index b6aae58..04ab4a2 100644
> --- a/drivers/acpi/acpica/hwvalid.c
> +++ b/drivers/acpi/acpica/hwvalid.c
> @@ -142,7 +142,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
>  	byte_width = ACPI_DIV_8(bit_width);
>  	last_address = address + byte_width - 1;
>  
> -	ACPI_DEBUG_PRINT((ACPI_DB_IO, "Address %p LastAddress %p Length %X",
> +	ACPI_DEBUG_PRINT((ACPI_DB_IO, "Address %p LastAddress %p Length %X\n",
>  			  ACPI_CAST_PTR(void, address), ACPI_CAST_PTR(void,
>  								      last_address),
>  			  byte_width));
> @@ -181,7 +181,7 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
>  
>  			if (acpi_gbl_osi_data >= port_info->osi_dependency) {
>  				ACPI_DEBUG_PRINT((ACPI_DB_IO,
> -						  "Denied AML access to port 0x%p/%X (%s 0x%.4X-0x%.4X)",
> +						  "Denied AML access to port 0x%p/%X (%s 0x%.4X-0x%.4X)\n",
>  						  ACPI_CAST_PTR(void, address),
>  						  byte_width, port_info->name,
>  						  port_info->start,
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
