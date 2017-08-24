From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 0/3] Dollar Cove TI PMIC support for Intel Cherry Trail
Date: Thu, 24 Aug 2017 10:11:38 +0200
Message-ID: <20170824081141.5018-1-tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

this is the revised patch set to add the support for Dollar Cove TI
PMIC found on some Intel Cherry Trail laptops / tablets.  All drivers
are based on the original code from Intel downstream patches, with
lots of rewrites and cleanups.  MFD driver is implemented as a
stand-alone like a few other variants, and the input driver got a diet
in a minimalistic form.

The patch set has been tested on ASUS E100H and E200H, as well as on
HP x210.

v1->v2:
- Minor cleanups in mfd driver code as suggested by Andy
- Move power-button driver to platform/x86, driver renames accordingly
- Add missing wake-irq cleanup to power-button driver
- get_raw_temp cleanup in opregion driver, mention about register
  endianess


thanks,

Takashi

===

Takashi Iwai (3):
  mfd: Add support for Cherry Trail Dollar Cove TI PMIC
  platform/x86: Add support for Dollar Cove TI power button
  ACPI / PMIC: Add opregion driver for Intel Dollar Cove TI PMIC

 drivers/acpi/Kconfig                      |   6 +
 drivers/acpi/Makefile                     |   1 +
 drivers/acpi/pmic/intel_pmic_dc_ti.c      | 139 +++++++++++++++++++++++
 drivers/mfd/Kconfig                       |  13 +++
 drivers/mfd/Makefile                      |   1 +
 drivers/mfd/intel_soc_pmic_dc_ti.c        | 182 ++++++++++++++++++++++++++++++
 drivers/platform/x86/Kconfig              |   8 ++
 drivers/platform/x86/Makefile             |   1 +
 drivers/platform/x86/intel_dc_ti_pwrbtn.c |  96 ++++++++++++++++
 9 files changed, 447 insertions(+)
 create mode 100644 drivers/acpi/pmic/intel_pmic_dc_ti.c
 create mode 100644 drivers/mfd/intel_soc_pmic_dc_ti.c
 create mode 100644 drivers/platform/x86/intel_dc_ti_pwrbtn.c

-- 
2.14.0
