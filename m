From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More ACPI updates for v4.10-rc1
Date: Thu, 22 Dec 2016 15:18:22 +0100
Message-ID: <CAJZ5v0iq8z-cdja46o2z__Pfs9M+j2q4SXFu=7cS4LHY3XqL4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35502 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761980AbcLVOSX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Dec 2016 09:18:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-extra-4.10-rc1

with top-most commit c8e008e2a6f9ec007a0e22e18eeb5bace5bf16c8

 Merge branches 'acpica' and 'acpi-scan'

on top of commit 7ae123edd37a47e178eb9a6631fe4a7108262c10

 Merge tag 'acpi-urgent-4.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for v4.10-rc1.

They are new versions of two ACPICA changes that were deferred previously
due to a problem they had introduced, two cleanups on top of them and
the removal of a useless warning message from the ACPI core.

Specifics:

 - Move some Linux-specific functionality to upstream ACPICA and
   update the in-kernel users of it accordingly (Lv Zheng).

 - Drop a useless warning (triggered by the lack of an optional
   object) from the ACPI namespace scanning code (Zhang Rui).

Thanks!

---------------

Lv Zheng (4):
      ACPICA: Tables: Back port acpi_get_table_with_size() and
early_acpi_os_unmap_memory() from Linux kernel
      ACPICA: Tables: Allow FADT to be customized with virtual address
      ACPI / osl: Remove
acpi_get_table_with_size()/early_acpi_os_unmap_memory() users
      ACPI / osl: Remove deprecated
acpi_get_table_with_size()/early_acpi_os_unmap_memory()

Zhang Rui (1):
      ACPI: do not warn if _BQC does not exist

---------------

 arch/arm64/include/asm/acpi.h            |   2 +-
 arch/arm64/kernel/acpi.c                 |   7 +-
 drivers/acpi/acpica/actables.h           |   6 ++
 drivers/acpi/acpica/tbfadt.c             |  14 ++--
 drivers/acpi/acpica/tbutils.c            |  85 ++++++++++++++++++++
 drivers/acpi/acpica/tbxface.c            | 130 +++++++++++++++++++------------
 drivers/acpi/bus.c                       |   2 +-
 drivers/acpi/nfit/core.c                 |   3 +-
 drivers/acpi/osl.c                       |  15 ++--
 drivers/acpi/processor_core.c            |   8 +-
 drivers/acpi/scan.c                      |   3 -
 drivers/acpi/spcr.c                      |   8 +-
 drivers/acpi/tables.c                    |  17 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c |   3 +-
 drivers/gpu/drm/radeon/radeon_bios.c     |   3 +-
 drivers/iommu/amd_iommu_init.c           |  10 +--
 drivers/iommu/dmar.c                     |   7 +-
 drivers/mailbox/pcc.c                    |   5 +-
 include/acpi/acpi_io.h                   |   2 +
 include/acpi/acpixf.h                    |  17 ++--
 include/acpi/actbl.h                     |   1 +
 include/acpi/platform/aclinuxex.h        |   1 -
 22 files changed, 224 insertions(+), 125 deletions(-)
