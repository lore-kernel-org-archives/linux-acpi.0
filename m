From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH 0/5] ACPI: Add _OST support for ACPI hotplug
Date: Tue, 10 Apr 2012 16:21:46 -0600
Message-ID: <1334096510-17319-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

This series of patches supports ACPI _OST (OSPM Status Indication)
method for ACPI-based CPU and memory hotplug operations.  After
ACPI-based hotplug operation completed, OSPM calls _OST to convey
the completion status to ACPI firmware.  If _OST is not present,
this change has no effect on the platform.

The _OST definition can be found in section 6.3.5 of ACPI 5.0 spec.
The HPPF spec below also describes hotplug flows with _OST.

  DIG64 Hot-Plug & Partitioning Flow (HPPF) Specification R1.0
  http://www.dig64.org/home/DIG64_HPPF_R1_0.pdf

The change was tested by overriding DSDT with fake _OST methods.

---
Toshi Kani (4):
 ACPI: Set hotplug _OST support bit to _OSC
 ACPI: Add acpi_evaluate_ost() for calling _OST
 ACPI: Add _OST support for ACPI CPU hotplug
 ACPI: Add _OST support for ACPI memory hotplug

 drivers/acpi/acpi_memhotplug.c  |   43 +++++++++++++++++++++++++++++----------
 drivers/acpi/bus.c              |    5 ++++
 drivers/acpi/processor_driver.c |   28 ++++++++++++++++++-------
 drivers/acpi/utils.c            |   34 ++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h         |    3 ++
 include/linux/acpi.h            |   26 ++++++++++++++++++++++-
 6 files changed, 119 insertions(+), 20 deletions(-)
