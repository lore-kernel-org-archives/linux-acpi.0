From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] PCI: Add information about describing PCI in ACPI
Date: Tue, 29 Nov 2016 15:39:48 -0600
Message-ID: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751537AbcK2Vjw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Nov 2016 16:39:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Duc Dang <dhdang@apm.com>, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Lv Zheng <lv.zheng@intel.com>, linux-arm-kernel@lists.infradead.org

Here's another stab at this writeup.  I'd appreciate any comments!

Changes from v1 to v2:
  - Consumer/Producer is defined for Extended Address Space descriptors;
    should be ignored for QWord/DWord/Word Address Space descriptors
  - New arches may use Extended Address Space descriptors in PNP0A03 for
    bridge registers, including ECAM (if the arch adds support for this)
  - Add more details about MCFG and _CBA (Lv's suggestion)
  - Incorporate Rafael's suggestions

---

Bjorn Helgaas (1):
      PCI: Add information about describing PCI in ACPI


 Documentation/PCI/00-INDEX      |    2 
 Documentation/PCI/acpi-info.txt |  180 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)
 create mode 100644 Documentation/PCI/acpi-info.txt
