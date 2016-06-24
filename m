From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v4 0/3] acpi/pmic: add opregion driver for Intel BXT
 WhiskeyCove PMIC
Date: Fri, 24 Jun 2016 10:25:21 +0800
Message-ID: <6e25fae9-99a8-bc6b-258d-6cfd08f2b0e1@intel.com>
References: <20160624004305.GC83592@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29683 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbcFXCZY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jun 2016 22:25:24 -0400
In-Reply-To: <20160624004305.GC83592@worksta>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>

On 06/24/2016 08:43 AM, Bin Gao wrote:
> This series modifies the pen function signature to take bit field
> and adds a new opregion driver for Intel BXT WhiskeyCove PMIC. It
> also adds support for PMIC regs operation region.

Reviewed-by: Aaron Lu <aaron.lu@intel.com>

Thanks,
Aaron

> 
> Yegnesh Iyer (1):
>   acpi: pmic: Modifying the pen function signature to take bit field
> 
> Ajay Thomas (1):
>   acpi: pmic: Add opregion driver for Intel BXT WhiskeyCove PMIC
> 
> Chandra Sekhar Anagani (1):
>  acpi: pmic: Add support for Intel BXT PMIC regs operation region
> 
>  drivers/acpi/pmic/intel_pmic.c       | 87  +++++++------
>  drivers/acpi/pmic/intel_pmic.h       | 11  ++--
>  drivers/acpi/pmic/intel_pmic_crc.c   |  5  +++--
>  drivers/acpi/Kconfig                 |  6  +
>  drivers/acpi/Makefile                |  1  +
>  drivers/acpi/pmic/intel_pmic_bxtwc.c |449  +++++++++++++++++++++++++++++++++++
>  6 files changed, 559 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/acpi/pmic/intel_pmic_bxtwc.c
> --
> 1.9.1
> 

