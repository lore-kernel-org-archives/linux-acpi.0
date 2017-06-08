From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v2 0/2] NVDIMM memory error notification support
Date: Thu,  8 Jun 2017 12:36:56 -0600
Message-ID: <20170608183658.24731-1-toshi.kani@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:52822 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdFHShZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jun 2017 14:37:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dan.j.williams@intel.com
Cc: rjw@rjwysocki.net, vishal.l.verma@intel.com, linda.knippers@hpe.com, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

ACPI 6.2 defines a new ACPI notification value to NVDIMM Root Device.
This allows BIOS to inform the OS that new uncorrectable memory error
is detected during run-time.

This patch-set adds support of this notification, which starts ARS and
updates badblocks information to prevent the OS from consuming the new
error.

v2:
 - Set flags Bit[1] for Start ARS. (Dan Williams)

Link: http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
---
Toshi Kani (2):
  1/2 acpi/nfit: Add support of NVDIMM memory error notification in ACPI 6.2
  2/2 acpi/nfit: Issue Start ARS to retrieve existing records

---
 drivers/acpi/nfit/core.c   | 40 ++++++++++++++++++++++++++++++++--------
 drivers/acpi/nfit/mce.c    |  2 +-
 drivers/acpi/nfit/nfit.h   |  4 +++-
 include/uapi/linux/ndctl.h |  1 +
 4 files changed, 37 insertions(+), 10 deletions(-)
