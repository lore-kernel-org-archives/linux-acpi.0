From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Subject: [PATCH v2 0/2] acpi, gicv3-its, numa: Adding numa node mapping for ITS
Date: Tue, 20 Jun 2017 12:37:15 +0530
Message-ID: <1497942437-1390-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn3nam01on0076.outbound.protection.outlook.com ([104.47.33.76]:47424
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751135AbdFTHHy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Jun 2017 03:07:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lv.zheng@intel.com, robert.moore@intel.com, marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, jnair@caviumnetworks.com, gpkulkarni@gmail.com

ACPI 6.2 have added SRAT subtable to define proximity domain for ITS
devices. This patchset updates acpi header file from acpica repo and
adds numa node mapping for ITS devices.

v2:
 - Incorporated comments from Lorenzo Pieralisi and Marc Zyngier.

v1: first patch

Ganapatrao Kulkarni (2):
  ACPICA: ACPI 6.2: Add support for new SRAT subtable
  acpi, gicv3-its, numa: Adding numa node mapping for gic-its units

 drivers/irqchip/irq-gic-v3-its.c | 76 +++++++++++++++++++++++++++++++++++++++-
 include/acpi/actbl1.h            | 12 ++++++-
 2 files changed, 86 insertions(+), 2 deletions(-)

-- 
1.8.1.4

