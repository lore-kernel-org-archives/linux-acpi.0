From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v2 00/13] Introduce ACPI _DSM helper functions to simplify code
Date: Thu, 19 Dec 2013 20:38:09 +0800
Message-ID: <1387456702-4709-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Leonidas Da Silva Barbosa <leosilva@linux.vnet.ibm.com>, Ashley Lai <ashley@ashleylai.com>, Peter Huewe <peterhuewe@gmx.de>, Rajiv Andrade <mail@srajiv.net>, Marcel Selhorst <tpmdd@selhorst.net>, Sirrix AG <tpmdd@sirrix.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Jiri Kosina <jkosina@suse.cz>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

There are several drivers making use of ACPI _DSM method to detect
and invoke device specific methods. Currently every driver has
implemented its private version to support ACPI _DSM method.
So this patch introduces three helper functions to support ACPI _DSM
method, which will be used to replace open-coded versions.  It helps
to simplify code and improve code readability.

It also includes some bugfixes for TPM/nouveau drivers.

It applies to the mainstream kernel on top of
b0031f2 Merge tag 's2mps11-build' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator

Due to lacking of hardware platform, I have only tested the ACPI _DSM
helper functions and TPM related changes, but haven't tested changes to
other drivers yet. So appreciate help to review and test these patches.

V1->V2
1) fix an issue in initializing acpi_object structure

Jiang Liu (13):
  ACPI: introduce helper interfaces to support ACPI _DSM method
  ACPI, extlog: replace open-coded _DSM specific code with helper
    functions
  PCI, pci-label: release allocated ACPI object on error recovery path
  ACPI, PCI: replace open-coded _DSM specific code with helper
    functions
  PCI, pci-label: treat PCI label with index 0 as valid label
  ACPI, TPM: fix memory leak when walking ACPI namespace
  ACPI, TPM: matching node name instead of full path when searching for
    TPM device
  ACPI, TPM: replace open-coded _DSM specific code with helper
    functions
  ACPI, TPM: detecting PPI features by checking availability of _DSM
    functions
  ACPI, i2c-hid: replace open-coded _DSM specific code with helper
    functions
  ACPI, i915: replace open-coded _DSM specific code with helper
    functions
  nouveau: fix memory leak in ACPI _DSM related code
  ACPI, nouveau: replace open-coded _DSM specific code with helper
    functions

 drivers/acpi/acpi_extlog.c                     |   61 +---
 drivers/acpi/utils.c                           |   98 ++++++
 drivers/char/tpm/tpm_ppi.c                     |  406 +++++++++---------------
 drivers/gpu/drm/i915/intel_acpi.c              |  144 ++-------
 drivers/gpu/drm/nouveau/core/subdev/mxm/base.c |   48 +--
 drivers/gpu/drm/nouveau/nouveau_acpi.c         |  134 +++-----
 drivers/hid/i2c-hid/i2c-hid.c                  |   26 +-
 drivers/pci/pci-label.c                        |  129 +++-----
 include/acpi/acpi_bus.h                        |   26 ++
 9 files changed, 406 insertions(+), 666 deletions(-)

-- 
1.7.10.4
