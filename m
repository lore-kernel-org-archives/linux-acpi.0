From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v5 0/3] Dollar Cove TI PMIC support for Intel Cherry Trail
Date: Mon,  4 Sep 2017 16:43:37 +0200
Message-ID: <20170904144340.27693-1-tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

this is the revised v5 patch set to add the support for Dollar Cove TI
PMIC found on some Intel Cherry Trail laptops / tablets.  All drivers
are based on the original code from Intel downstream patches, with
lots of rewrites and cleanups.  MFD driver is implemented as a
stand-alone driver like a few other variants, and the input driver got
a diet in a minimalistic form.

The patch set has been tested on ASUS E100H and E200H, as well as on
HP x210.


thanks,

Takashi

===

v4->5:
* Minor coding-style fixes in MFD driver suggested by Lee
* Put GPL text to MFD driver

v3->v4:
- Correct Kconfig / Makefile for ACPI opregion driver
- Minor fixes of powerbutton driver suggested by Dmitry
- Rephrase Kconfig help text for powerbutton driver

v2->v3:
- Rename dc_ti with chtdc_ti in all places
- Driver/kconfig renames accordingly
- A few constifications
- Added acks by Andy and Mika

v1->v2:
- Minor cleanups in mfd driver code as suggested by Andy
- Move power-button driver to platform/x86, driver renames accordingly
- Add missing wake-irq cleanup to power-button driver
- get_raw_temp cleanup in opregion driver, mention about register
  endianess


Takashi Iwai (3):
  mfd: Add support for Cherry Trail Dollar Cove TI PMIC
  platform/x86: Add support for Dollar Cove TI power button
  ACPI / PMIC: Add opregion driver for Intel Dollar Cove TI PMIC

 drivers/acpi/Kconfig                         |   6 +
 drivers/acpi/Makefile                        |   1 +
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c      | 137 ++++++++++++++++++++
 drivers/mfd/Kconfig                          |  13 ++
 drivers/mfd/Makefile                         |   1 +
 drivers/mfd/intel_soc_pmic_chtdc_ti.c        | 184 +++++++++++++++++++++++++++
 drivers/platform/x86/Kconfig                 |  11 ++
 drivers/platform/x86/Makefile                |   1 +
 drivers/platform/x86/intel_chtdc_ti_pwrbtn.c |  94 ++++++++++++++
 9 files changed, 448 insertions(+)
 create mode 100644 drivers/acpi/pmic/intel_pmic_chtdc_ti.c
 create mode 100644 drivers/mfd/intel_soc_pmic_chtdc_ti.c
 create mode 100644 drivers/platform/x86/intel_chtdc_ti_pwrbtn.c

-- 
2.14.1
