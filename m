From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v3 0/2] ACPI, APEI, use general HEST tabling parsing in AER firmware_first setup
Date: Mon, 15 Mar 2010 14:57:39 +0800
Message-ID: <1268636261-31554-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, ying.huang@intel.com
List-Id: linux-acpi@vger.kernel.org


Changelog:

v3:

- Move pcie_aer_get_firmware_first into aerdrv_acpi.c, and make
  aer_set_firmware_first static in aerdrv_acpi.c. This makes external
  interface simple and clear.

v2:

- Setup firmware_first for every PCIE end point instead of just root point.

- Wrap firmware_first accessing in a function, because HEST parsing involved.
