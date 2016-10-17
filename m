From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH 0/7] ACPICA: 20160930 Release
Date: Tue, 18 Oct 2016 03:01:48 +0800
Message-ID: <cover.1476725675.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34778 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932533AbcJQTCV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Oct 2016 15:02:21 -0400
Received: by mail-qk0-f193.google.com with SMTP id n189so14969772qke.1
        for <linux-acpi@vger.kernel.org>; Mon, 17 Oct 2016 12:02:21 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: linux-acpi@vger.kernel.org

The 20160930 ACPICA kernel-resident subsystem updates are linuxized based
on the linux-pm/linux-next branch.

The patchset has passed the following build/boot tests.
Build tests are performed as follows:
1. i386 + allyes
2. i386 + allno
3. i386 + default + ACPI_DEBUGGER=y
4. i386 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
5. i386 + default + ACPI_DEBUG=n + ACPI=y
6. i386 + default + ACPI=n
7. x86_64 + allyes
8. x86_64 + allno
9. x86_64 + default + ACPI_DEBUGGER=y
10.x86_64 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
11.x86_64 + default + ACPI_DEBUG=n + ACPI=y
12.x86_64 + default + ACPI=n
Boot tests are performed as follows:
1. x86_64 + default + ACPI_DEBUGGER=y
Where:
1. i386: machine named as "Dell Inspiron Mini 1010"
2. x86_64: machine named as "Microsoft Surface Pro 3"
3. default: kernel configuration with following items enabled:
   All hardware drivers related to the machines of i386/x86_64
   All "drivers/acpi" configurations
   All "drivers/platform" drivers
   All other drivers that link the APIs provided by ACPICA subsystem

The divergences checking result:
Before applying (20160831 Release):
  508 lines
After applying (20160930 Release):
  508 lines

Bob Moore (5):
  ACPICA: Update an info message during table load phase.
  ACPICA: Increase loop limit for AE_AML_INFINITE_LOOP exception
  ACPICA: Disassembler: Fix for Divide() support, new support for test
    suite
  ACPICA: Move acpi_gbl_max_loop_iterations to the public globals file
  ACPICA: Update version to 20160930

Lv Zheng (2):
  ACPICA: MacOSX: Fix anonymous semaphore implementation
  ACPICA: MacOSX: Fix wrong sem_destroy definition

 drivers/acpi/acpica/acglobal.h                        |  5 +----
 drivers/acpi/acpica/aclocal.h                         | 19 ++++++++++---------
 drivers/acpi/acpica/tbxfload.c                        |  6 +++++-
 include/acpi/acconfig.h                               |  2 +-
 include/acpi/acpixf.h                                 |  9 ++++++++-
 .../power/acpi/os_specific/service_layers/osunixxf.c  | 13 +++++++++++--
 6 files changed, 36 insertions(+), 18 deletions(-)

-- 
2.7.4

