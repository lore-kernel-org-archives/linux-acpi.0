From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 0/6]: ACPI D3 state cleanup
Date: Tue, 17 Apr 2012 13:47:50 +0800
Message-ID: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:49201 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab2DQFsJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2012 01:48:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.og>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Huang Ying <huang.ying.caritas@gmail.com>, Aaron Lu <aaron.lu@amd.com>

Hi,

Currently there are 2 ACPI D3 states defined:
ACPI_STATE_D3 and ACPI_STATE_D3_COLD.

But the uses of these 2 states are not clear/correct in some code.
For example, some code refer ACPI_STATE_D3 as D3hot and others refer
it as D3cold.

This patch set try to clean it up.

[PATCH 1/6] ACPI: D3cold state is always valid
[PATCH 2/6] ACPI: Set D3cold state as default device sleep state
[PATCH 3/6] ACPI: Set D3cold state as default inferred state
[PATCH 4/6] ACPI: Fix power resource's device power state when it's off
[PATCH 5/6] PCI/ACPI: Map PCI D3cold state to ACPI D3cold state
[PATCH 6/6] ACPI: Rename ACPI_STATE_D3 to ACPI_STATE_D3_HOT

 drivers/acpi/fan.c         |    4 ++--
 drivers/acpi/power.c       |   10 +++++-----
 drivers/acpi/scan.c        |   13 +++----------
 drivers/acpi/sleep.c       |    2 +-
 drivers/ata/libata-acpi.c  |    4 ++--
 drivers/ide/ide-acpi.c     |    4 ++--
 drivers/pci/pci-acpi.c     |    6 +++---
 drivers/pnp/pnpacpi/core.c |    4 ++--
 include/acpi/acpi_bus.h    |    2 +-
 include/acpi/actypes.h     |    2 +-
 10 files changed, 22 insertions(+), 29 deletions(-)

Thanks,
Lin Ming
