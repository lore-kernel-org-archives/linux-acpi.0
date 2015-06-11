From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH v2] ACPICA: Add values for MADT GIC version field for
 ACPI 6.0
Date: Thu, 11 Jun 2015 17:28:34 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2F35A5@ORSMSX112.amr.corp.intel.com>
References: <1434016264-4801-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36258 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426AbbFKR2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2015 13:28:55 -0400
In-Reply-To: <1434016264-4801-1-git-send-email-hanjun.guo@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

It will make it into next weeks acpica release.


> -----Original Message-----
> From: Hanjun Guo [mailto:hanjun.guo@linaro.org]
> Sent: Thursday, June 11, 2015 2:51 AM
> To: Zheng, Lv; Rafael J. Wysocki
> Cc: Moore, Robert; linux-acpi@vger.kernel.org; Hanjun Guo
> Subject: [PATCH v2] ACPICA: Add values for MADT GIC version field for ACPI
> 6.0
> 
> ACPI 6.0 specified MADT generic distributor version values, but the detail
> definition is missing in ACPICA version 20150515, add its support in this
> patch which is needed for ARM64 ACPI based GIC init.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> ---
> Hi Lv, Rafael,
>    Could you help merge this patch for 4.2? It should be in the ACPICA
> release of 20150515, but we missed that chance. This patch will be needed
> for ARM64 GIC init and I prepare to upstream those patches in 4.3, so if
> this patch accpeted in 4.2, it will have less dedenpence for ACPICA core
> and ARM64 GIC code in next kernel version.
> 
> This patch was accepted by Bob and merged into ACPICA tree, I reworked it
> on top of linux ACPICA.
> 
> Thanks
> Hanjun
> 
>  include/acpi/actbl1.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h index
> cadf21c..d382de8 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -834,6 +834,17 @@ struct acpi_madt_generic_distributor {
>  	u8 reserved2[3];	/* reserved - must be zero */
>  };
> 
> +/* Values for Version field above */
> +
> +enum acpi_madt_gic_version {
> +	ACPI_MADT_GIC_VERSION_NONE	= 0,
> +	ACPI_MADT_GIC_VERSION_V1	= 1,
> +	ACPI_MADT_GIC_VERSION_V2	= 2,
> +	ACPI_MADT_GIC_VERSION_V3	= 3,
> +	ACPI_MADT_GIC_VERSION_V4	= 4,
> +	ACPI_MADT_GIC_VERSION_RESERVED	= 5	/* 5 and greater are
> reserved */
> +};
> +
>  /* 13: Generic MSI Frame (ACPI 5.1) */
> 
>  struct acpi_madt_generic_msi_frame {
> --
> 1.9.1

