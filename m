From: Alex Chiang <achiang@hp.com>
Subject: [PATCH v2 0/2] ACPI/PCI: export acpi_pci_root to find pci_bus
	correctly
Date: Tue, 14 Jul 2009 14:53:23 -0600
Message-ID: <20090714204823.18933.40768.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: jbarnes@virtuousgeek.org, lenb@kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is v2 of a patch series that:

	a) exports struct acpi_pci_root
	b) fixes an assumption in acpiphp about finding struct pci_bus

It's a minimal fix that's aimed at -rc4, as (b) fixes an assumption
introduced in -rc1.

I'll send the rest of the cleanups for linux-next later, after doing
some more testing.

Original thread here:
	http://thread.gmane.org/gmane.linux.kernel.pci/5080

v1 -> v2:
	- fixed build error in acpi_pci_root
	- reduced patch series in scope to be much smaller

---

Alex Chiang (2):
      ACPI: export acpi_pci_root and friends
      PCI Hotplug: acpiphp: get pci_bus from acpi handle correctly

 drivers/acpi/pci_root.c            |   17 ++---------------
 drivers/pci/hotplug/acpiphp_glue.c |   27 ++++++++++++++++-----------
 include/acpi/acpi_bus.h            |   16 ++++++++++++++++
 3 files changed, 34 insertions(+), 26 deletions(-)
