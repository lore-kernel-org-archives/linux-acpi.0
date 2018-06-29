From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v1 0/2] PCI: Add patch submission and ACPI FW/OS info
Date: Fri, 29 Jun 2018 15:27:33 -0500
Message-ID: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Add hints about my patch idiosyncrasies and and ACPI firmware/OS interface
usage.  I posted the latter 18 months ago or so, but never followed up on
it.

---

Bjorn Helgaas (2):
      PCI: Document patch submission hints
      PCI: Document ACPI description of PCI host bridges


 Documentation/PCI/00-INDEX               |    4 +
 Documentation/PCI/acpi-info.txt          |  183 ++++++++++++++++++++++++++++++
 Documentation/PCI/submitting-patches.txt |  153 +++++++++++++++++++++++++
 3 files changed, 340 insertions(+)
 create mode 100644 Documentation/PCI/acpi-info.txt
 create mode 100644 Documentation/PCI/submitting-patches.txt
