From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH 0/3] ACPI: Provide consistent PNPID match handling
Date: Mon,  4 Mar 2013 14:30:40 -0700
Message-ID: <1362432643-25636-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, yinghai@kernel.org, jiang.liu@huawei.com, isimatu.yasuaki@jp.fujitsu.com, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

When installing/removing a notify handler to/from an ACPI device
object, ACPI core tries to match its associated scan handler to
see if it supports hotplug.  However, the matching logic of the
notify handler is different from the matching logic of attaching
a scan handler to an ACPI device object.  This inconsistency can
lead a mismatch and prevents ACPI scan handlers from supporting
non-HID devices, such as processor objects.

This patchset first updates PNPID setup interfaces to be independent
from acpi_device, and then updates the matching logic of the notify
handlers to be consistent with the attach handling.

This patchset is based on linux-pm.git/bleeding-edge.

---
Toshi Kani (3):
  ACPI: Remove acpi_device dependency in acpi_device_set_id()
  ACPI: Update PNPID set/free interfaces
  ACPI: Update PNPID match handling for notify

---
 drivers/acpi/internal.h               |   2 +-
 drivers/acpi/power.c                  |   2 +-
 drivers/acpi/scan.c                   | 203 +++++++++++++++++++---------------
 drivers/acpi/video_detect.c           |  25 ++---
 drivers/gpu/drm/i915/intel_opregion.c |   4 +-
 include/acpi/acpi_bus.h               |  14 ++-
 include/linux/acpi.h                  |   4 +-
 7 files changed, 138 insertions(+), 116 deletions(-)
