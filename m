From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/2] ACPI / PMIC: constify platform_device_id
Date: Tue, 28 Nov 2017 15:31:49 +0530
Message-ID: <cover.1511863076.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, andy@infradead.org, mika.westerberg@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

platform_device_id are not supposed to change at runtime. All functions
working with platform_device_id provided by <linux/platform_device.h>
work with const platform_device_id. So mark the non-const structs as
const.

Arvind Yadav (2):
  [PATCH 1/2] ACPI / PMIC: constify platform_device_id
  [PATCH 2/2] ACPI / PMIC: Constify platform_device_id

 drivers/acpi/pmic/intel_pmic_bxtwc.c | 2 +-
 drivers/acpi/pmic/intel_pmic_chtwc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1
