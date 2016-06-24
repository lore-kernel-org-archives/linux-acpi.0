From: Bin Gao <bin.gao@linux.intel.com>
Subject: [PATCH v4 0/3] acpi/pmic: add opregion driver for Intel BXT
 WhiskeyCove PMIC
Date: Thu, 23 Jun 2016 17:43:06 -0700
Message-ID: <20160624004305.GC83592@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4810 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbcFXAjL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jun 2016 20:39:11 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>

This series modifies the pen function signature to take bit field
and adds a new opregion driver for Intel BXT WhiskeyCove PMIC. It
also adds support for PMIC regs operation region.

Yegnesh Iyer (1):
  acpi: pmic: Modifying the pen function signature to take bit field

Ajay Thomas (1):
  acpi: pmic: Add opregion driver for Intel BXT WhiskeyCove PMIC

Chandra Sekhar Anagani (1):
 acpi: pmic: Add support for Intel BXT PMIC regs operation region

 drivers/acpi/pmic/intel_pmic.c       | 87  +++++++------
 drivers/acpi/pmic/intel_pmic.h       | 11  ++--
 drivers/acpi/pmic/intel_pmic_crc.c   |  5  +++--
 drivers/acpi/Kconfig                 |  6  +
 drivers/acpi/Makefile                |  1  +
 drivers/acpi/pmic/intel_pmic_bxtwc.c |449  +++++++++++++++++++++++++++++++++++
 6 files changed, 559 insertions(+), 10 deletions(-)
 create mode 100644 drivers/acpi/pmic/intel_pmic_bxtwc.c
--
1.9.1

