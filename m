From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 2/2] acpi/pmic: Add opregion driver for Intel BXT
 WhiskeyCove PMIC
Date: Sun, 12 Jun 2016 10:13:33 +0800
Message-ID: <54020215-86ac-77be-ea4f-19941ed3a176@intel.com>
References: <20160611072531.GB90940@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65095 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752359AbcFLCNg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Jun 2016 22:13:36 -0400
In-Reply-To: <20160611072531.GB90940@worksta>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>

On 06/11/2016 03:25 PM, Bin Gao wrote:
> This patch adds operation region driver for Intel BXT WhiskeyCove
> PMIC. The register mapping is done as per the BXT WC data sheet.
> 
> Signed-off-by: Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>
> Signed-off-by: Bin Gao <bin.gao@intel.com>
> ---
> +static int __init intel_bxtwc_pmic_opregion_driver_init(void)
> +{
> +	return platform_driver_register(&intel_bxtwc_pmic_opregion_driver);
> +}
> +
> +module_init(intel_bxtwc_pmic_opregion_driver_init);

Last time Paul suggests device_initcall instead of module_init here:

commit 75829dcf10862966f52716f2d67ac1c1b1eb486b
Author: Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Mon Feb 15 00:27:51 2016 -0500

    drivers/acpi: make pmic/intel_pmic_crc.c explicitly non-modular

Perhaps you should do the same.

Thanks,
Aaron

> +
> +MODULE_DESCRIPTION("BXT WhiskeyCove ACPI opregion driver");
> +MODULE_LICENSE("GPL");
> 

