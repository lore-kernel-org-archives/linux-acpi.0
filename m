From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/7] ACPI / PCI / PCIe: Rework _OSC handling
Date: Sat, 31 Jul 2010 00:20:56 +0200
Message-ID: <201007310020.56546.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

The following patchset is based on
https://patchwork.kernel.org/patch/114917/ and the comments I received on that
patch.  Hopefully, I took all of the comments into account.

[1/7] - Remove the last argument of acpi_pci_osc_run(); this is a cleanup, but
        IMO it makes sense.

[2/7] - Introduce acpi_pci_root_osc_query() allowing the caller to get a
        mask of _OSC control bits the BIOS allows the kernel to control
        for a given PCI root bridge.

[3/7] - Rework the PCIe port driver to request _OSC control for all serives at
        once.

[4/7] - Disable PCIe port services (that might be enabled by the BIOS) during
        initialization.

[5/7] - Remove the PCIe port driver modules exit function.

[6/7] - Rework acpi_pci_osc_control_set() so that it doesn't use cached
        result of a query and remove the fields of struct acpi_pci_root that
       aren't used any more.

[7/7] - Reorder checks in acpi_pci_osc_control_set()

Comments (and testing :-)) welcome.

Thanks,
Rafael
