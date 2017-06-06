From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Subject: [PATCH 0/2] acpi, gicv3-its, numa: Adding numa node mapping for its
Date: Tue,  6 Jun 2017 18:26:25 +0530
Message-ID: <1496753787-27735-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2nam02on0066.outbound.protection.outlook.com ([104.47.38.66]:2224
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751305AbdFFM5O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Jun 2017 08:57:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lv.zheng@intel.com, robert.moore@intel.com, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, jnair@caviumnetworks.com, gpkulkarni@gmail.com

ACPI 6.2 have added SRAT subtable to define proximity domain for ITS
devices. This patchset Updates acpi header file from acpica repo and
adds numa node mapping for its devices.

Ganapatrao Kulkarni (2):
  ACPICA: ACPI 6.2: Add support for new SRAT subtable
  acpi, gicv3-its, numa: Adding numa node mapping for gic-its devices

 arch/arm64/include/asm/acpi.h    |  2 ++
 arch/arm64/kernel/acpi_numa.c    | 59 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/numa.c              | 32 +++++++++++++++++++++-
 drivers/irqchip/irq-gic-v3-its.c |  3 +-
 include/acpi/actbl1.h            | 12 +++++++-
 include/linux/acpi.h             |  3 ++
 6 files changed, 108 insertions(+), 3 deletions(-)

-- 
1.8.1.4

