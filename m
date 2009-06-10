From: Alex Chiang <achiang@hp.com>
Subject: [PATCH v3 00/12] Dynamic ACPI-PCI binding
Date: Wed, 10 Jun 2009 13:55:04 -0600
Message-ID: <20090610194714.28982.51363.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Len,

Bjorn suggested I respin this series one more time, so here it is.

Previous cover patches for rationale:

	v1 - http://lkml.org/lkml/2009/6/2/282
	v2 - http://lkml.org/lkml/2009/6/4/31

Thanks.

/ac

Changelog:
v2 -> v3
	- incorporate Kenji's comment re: acpi_pci_unbind
	- add an extra code movement patch to make evisceration easier to read

v1 -> v2
	- rearrange series into a more logical order
	- much simpler acpi_is_root_bridge() implementation
	- no longer export acpi_pci_find_root()
	- no longer leak memory in acpi_get_pci_dev()
	- no longer leak references in acpi_pci_unbind/acpi_pci_bind
	- convert video driver to use acpi_get_pci_dev()
	- kill off acpi_get_physical_pci_device()
	- incorporate Bjorn's other comments. :)

---

Alex Chiang (12):
      ACPI: kill acpi_get_physical_pci_device()
      ACPI: video: convert to acpi_get_pci_dev
      ACPI: kill acpi_get_pci_id
      PCI Hotplug: acpiphp: convert to acpi_get_pci_dev
      ACPI: acpi_pci_unbind should clean up properly after acpi_pci_bind
      ACPI: simplify acpi_pci_irq_del_prt() API
      ACPI: simplify acpi_pci_irq_add_prt() API
      ACPI: eviscerate pci_bind.c
      ACPI: rearrange acpi_pci_bind/acpi_pci_unbind in pci_bind.c
      ACPI: Introduce acpi_get_pci_dev()
      ACPI: Introduce acpi_is_root_bridge()
      ACPI: make acpi_pci_bind() static


 drivers/acpi/glue.c                |   40 -----
 drivers/acpi/pci_bind.c            |  313 ++++--------------------------------
 drivers/acpi/pci_irq.c             |   17 +-
 drivers/acpi/pci_root.c            |  112 ++++++++++++-
 drivers/acpi/video.c               |    6 -
 drivers/acpi/video_detect.c        |    9 +
 drivers/pci/hotplug/acpi_pcihp.c   |   40 -----
 drivers/pci/hotplug/acpiphp_glue.c |   27 +--
 include/acpi/acpi_bus.h            |    2 
 include/acpi/acpi_drivers.h        |   10 -
 include/linux/pci_hotplug.h        |    1 
 11 files changed, 176 insertions(+), 401 deletions(-)
