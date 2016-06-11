From: Bin Gao <bin.gao@linux.intel.com>
Subject: [PATCH 0/2] acpi/pmic: add opregion driver for Intel BXT WhiskeyCove
 PMIC
Date: Sat, 11 Jun 2016 00:14:44 -0700
Message-ID: <20160611071444.GA89987@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47192 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbcFKHLJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Jun 2016 03:11:09 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>

This series modifies the pen function signature to take bit field
and adds a new opregion driver for Intel BXT WhiskeyCove PMIC.

Yegnesh Iyer (1):
  acpi/pmic: Modifying the pen function signature to take bit field

Ajay Thomas (1):
  acpi/pmic: Add opregion driver for Intel BXT WhiskeyCove PMIC

 drivers/acpi/pmic/intel_pmic.c       | 13 +++++++------
 drivers/acpi/pmic/intel_pmic.h       |  4 ++--
 drivers/acpi/pmic/intel_pmic_crc.c   |  5 +++--
 drivers/acpi/Kconfig                 |   6 +
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/pmic/intel_pmic_bxtwc.c | 424 +++++++++++++++++++++++++++++++++++
 6 files changed, 443 insertions(+), 10 deletions(-)
 create mode 100644 drivers/acpi/pmic/intel_pmic_bxtwc.c
--
1.9.1

