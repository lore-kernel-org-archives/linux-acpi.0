From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH 0/3] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
Date: Tue, 17 May 2016 15:06:00 +0300
Message-ID: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34352 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbcEQMHd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2016 08:07:33 -0400
Received: by mail-lf0-f43.google.com with SMTP id m64so5855570lfd.1
        for <linux-acpi@vger.kernel.org>; Tue, 17 May 2016 05:07:32 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Jon Masters <jcm@redhat.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Rutland <mark.rutland@arm.com>

This patchset adds support for ACPI_TABLE_UPGRADE for ARM64

It refactors the code introduced by the patches by Lv Zheng [1], fixes access to
the destination of new ACPI tables as suggested by Mark Rutland [2] and enables
the feature for ARM64

It was first sent by Jon Masters [3] to linaro-acpi in December 2015

Tested on QEMU (arm64 and x86) and ThunderX
Should be applied to next-20160517

[1] https://lkml.kernel.org/g/cover.1460340514.git.lv.zheng@intel.com
[2] https://lists.linaro.org/pipermail/linaro-acpi/2015-December/006101.html
[3] https://lists.linaro.org/pipermail/linaro-acpi/2015-December/006099.html

Aleksey Makarov (2):
  ACPI: table upgrade: use cacheable map for tables
  ACPI: table upgrade: move early_initrd_acpi_init() to header file

Jon Masters (1):
  ACPI: ARM64: support for ACPI_TABLE_UPGRADE

 arch/arm64/kernel/setup.c |  6 ++++--
 arch/x86/kernel/setup.c   |  7 -------
 drivers/acpi/Kconfig      |  2 +-
 drivers/acpi/tables.c     | 21 ++++++++++++++++-----
 include/linux/acpi.h      |  4 ++--
 5 files changed, 23 insertions(+), 17 deletions(-)

-- 
2.8.2

