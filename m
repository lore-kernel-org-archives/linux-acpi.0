From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH 0/3] Add trace event for ghes memory error
Date: Thu,  8 Aug 2013 23:57:48 +0530
Message-ID: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com, rostedt@goodmis.org, rjw@sisk.pl, lance.ortiz@hp.com, m.chehab@samsung.com
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-acpi@vger.kernel.org

This patch series adds a new trace event for memory errors reported via APEI
generic hardware error source.

- Naveen

Naveen N. Rao (3):
  mce: acpi/apei: trace: Include PCIe AER trace event conditionally
  mce: acpi/apei: trace: Add trace event for ghes memory error
  mce: acpi/apei: trace: Enable ghes memory error trace event

 drivers/acpi/apei/cper.c               |  21 +++--
 drivers/pci/pcie/aer/aerdrv_errprint.c |   1 +
 include/trace/events/ras.h             | 159 ++++++++++++++++++++++++++++++++-
 3 files changed, 175 insertions(+), 6 deletions(-)

-- 
1.8.3.4
