From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 0/2] PCI/ACPI: move _OSC code to pci_root.c (v.3)
Date: Mon, 09 Feb 2009 15:58:40 +0900
Message-ID: <498FD420.9000204@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Andrew Patterson <andrew.patterson@hp.com>, Alex Chiang <achiang@hp.com>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

Here are updated version (v.3) of "PCI/ACPI: move _OSC code to
pci_root.c" patches. Patches are

  - [PATCH 1/2] PCI/ACPI: move _OSC code to pci_root.c
  - [PATCH 2/2] PCI/ACPI: rename pci_osc_control_set()

ChangeLog
---------
[v.2 -> v.3]
  - More debug message cleanups
    (Based on the feedback from Alex Chiang)
  - Added Reviewed-by: and Tested-by: from Andrew Patterson

[v.1 -> v.2]
  - Change the debug message.
    [old]: "_OSC FW not grant req. control."
    [new]: "Firmware did not grant requested _OSC control"
    (Based on the feedback from Andrew Patterson and Alex Chiang)

  - Rename pci_osc_control_set() to acpi_pci_osc_control_set() and
    move _OSC related definitions from include/linux/pci-acpi.h to
    include/linux/acpi.h.
    (Based on the feedback from Andrew Patterson)

Thanks,
Kenji Kaneshige
