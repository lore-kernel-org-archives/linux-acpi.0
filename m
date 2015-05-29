From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Add MADT generic distributor version values for
 ACPI 6.0
Date: Fri, 29 May 2015 12:54:31 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F07D1@ORSMSX112.amr.corp.intel.com>
References: <1432885567-5924-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61365 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233AbbE2Myd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2015 08:54:33 -0400
In-Reply-To: <1432885567-5924-1-git-send-email-hanjun.guo@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Al Stone <al.stone@linaro.org>, "devel@acpica.org" <devel@acpica.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Usually, we ACPICA just #defines the individual values so that it is very easy to see the values at a glance. We only enum internal things.



> -----Original Message-----
> From: Hanjun Guo [mailto:hanjun.guo@linaro.org]
> Sent: Friday, May 29, 2015 12:46 AM
> To: Zheng, Lv
> Cc: Moore, Robert; Rafael J. Wysocki; Al Stone; devel@acpica.org; linux-
> acpi@vger.kernel.org; Hanjun Guo
> Subject: [PATCH] ACPICA: Add MADT generic distributor version values for
> ACPI 6.0
> 
> ACPI 6.0 specified MADT generic distributor version values, but the detail
> definition is missing in ACPICA version 20150515, add its support in this
> patch.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
> 
> This is the linux version of GIC version patch, please help to handle it,
> thanks!
> 
>  include/acpi/actbl1.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h index
> 06b61f0..a53530d1 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -835,6 +835,17 @@ struct acpi_madt_generic_distributor {
>  	u8 reserved2[3];	/* reserved - must be zero */
>  };
> 
> +/* Values for version in Generic Distributor  (ACPI 6.0) */
> +
> +enum acpi_madt_gic_version_type {
> +	ACPI_MADT_GIC_VER_UNKNOWN	= 0,
> +	ACPI_MADT_GIC_VER_V1		= 1,
> +	ACPI_MADT_GIC_VER_V2		= 2,
> +	ACPI_MADT_GIC_VER_V3		= 3,
> +	ACPI_MADT_GIC_VER_V4		= 4,
> +	ACPI_MADT_GIC_VER_RESERVED	= 5	/* 5 and greater are reserved */
> +};
> +
>  /* 13: Generic MSI Frame (ACPI 5.1) */
> 
>  struct acpi_madt_generic_msi_frame {
> --
> 1.9.1

