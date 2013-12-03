From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 0/4] Convert ACPI fan driver to platform driver
Date: Tue,  3 Dec 2013 16:28:28 +0800
Message-ID: <1386059312-2990-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15183 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645Ab3LCI24 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Dec 2013 03:28:56 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This patchset converts ACPI fan driver to platform driver. Patch 1-3 are
cleanups for existing fan driver and patch 4 does the convertion.

Tested on harris beach.
Apply on top of Rafael's linux-next branch.

Aaron Lu (4):
  ACPI / fan: remove unused macro for debug
  ACPI / fan: remove no need check for device pointer
  ACPI / fan: use acpi_device_xxx_power instead of acpi_bus equivelant
  ACPI / fan: convert to platform driver

 drivers/acpi/acpi_platform.c |  3 ++
 drivers/acpi/device_pm.c     |  1 +
 drivers/acpi/fan.c           | 88 ++++++++++++++++----------------------------
 drivers/acpi/internal.h      |  2 -
 include/acpi/acpi_bus.h      |  1 +
 5 files changed, 36 insertions(+), 59 deletions(-)

-- 
1.8.3.1

