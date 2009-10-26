From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v2] PCI hotplug: move IOAPIC support from acpiphp to ioapic
	driver
Date: Mon, 26 Oct 2009 11:20:42 -0600
Message-ID: <20091026172015.22955.77484.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Changes from v1 to v2:
    - add Fujitsu copyright

---

Bjorn Helgaas (1):
      PCI hotplug: move IOAPIC support from acpiphp to ioapic driver


 drivers/pci/Kconfig                |    7 +
 drivers/pci/Makefile               |    2 
 drivers/pci/hotplug/acpiphp.h      |    6 -
 drivers/pci/hotplug/acpiphp_glue.c |  190 ------------------------------------
 drivers/pci/ioapic.c               |  127 ++++++++++++++++++++++++
 5 files changed, 136 insertions(+), 196 deletions(-)
 create mode 100644 drivers/pci/ioapic.c

-- 
Bjorn
