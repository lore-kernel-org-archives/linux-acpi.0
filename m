From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] acpi: update struct acpi_table_tpm2
Date: Mon, 8 Jun 2015 20:52:02 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F28EC@ORSMSX112.amr.corp.intel.com>
References: <1433770706-3332-1-git-send-email-jarkko.sakkinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12613 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752239AbbFHUwH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jun 2015 16:52:07 -0400
In-Reply-To: <1433770706-3332-1-git-send-email-jarkko.sakkinen@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "open list:ACPI COMPONENT AR..." <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT AR..." <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>

It looks like there is a change to the TCPA table also.


> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Monday, June 08, 2015 6:38 AM
> To: Moore, Robert
> Cc: Jarkko Sakkinen; Zheng, Lv; Wysocki, Rafael J; Len Brown; open
> list:ACPI COMPONENT AR...; open list:ACPI COMPONENT AR...; open list
> Subject: [PATCH] acpi: update struct acpi_table_tpm2
> 
> Updated struct acpi_table_tpm2 to conform to the official TCG ACPI spec.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  include/acpi/actbl3.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h index
> 440ca81..33df1dd 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -688,13 +688,14 @@ enum acpi_rasf_status {
>   * TPM2 - Trusted Platform Module (TPM) 2.0 Hardware Interface Table
>   *        Version 3
>   *
> - * Conforms to "TPM 2.0 Hardware Interface Table (TPM2)" 29 November 2011
> + * Conforms to "TCG ACPI Specification for Family 1.2 and 2.0" 19
> + December 2014
>   *
> 
> **************************************************************************
> ****/
> 
>  struct acpi_table_tpm2 {
>  	struct acpi_table_header header;	/* Common ACPI table header */
> -	u32 flags;
> +	u16 platform_class;
> +	u16 reserved;
>  	u64 control_address;
>  	u32 start_method;
>  };
> --
> 2.1.4

