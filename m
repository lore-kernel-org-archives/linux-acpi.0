From: Agustin Vega-Frias <agustinv@codeaurora.org>
Subject: [PATCH V5 0/2] irqchip: qcom: Add IRQ combiner driver
Date: Tue, 18 Oct 2016 13:41:47 -0400
Message-ID: <1476812509-2760-1-git-send-email-agustinv@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44663 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbcJRRmO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Oct 2016 13:42:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: timur@codeaurora.org, cov@codeaurora.org, agross@codeaurora.org, harba@codeaurora.org, jcm@redhat.com, msalter@redhat.com, mlangsdo@redhat.com, ahs3@redhat.com, astone@redhat.com, graeme.gregory@linaro.org, guohanjun@huawei.com, charles.garcia-tobin@arm.com, Agustin Vega-Frias <agustinv@codeaurora.org>

Add support for IRQ combiners in the Top-level Control and Status
Registers (TCSR) hardware block in Qualcomm Technologies chips.

The first patch adds support for ResourceSource/IRQ domain mapping
when using Extended IRQ Resources with a specific ResourceSource.
The core ACPI resource management code has been changed to lookup
the IRQ domain when an IRQ resource indicates a ResourceSource,
and register the IRQ on that domain, instead of a GSI.

The second patch takes advantage of the new capabilities to implement
the driver for the IRQ combiners.

Changes V1 -> V2:
* Remove use of GPIO library for the combiner
* Refactor to use fwnode/ResourceSource to IRQ domain mapping
  introduced in ACPI core

Changes V2 -> V3:
* Removed parsing of _PRS to find IRQs
* Removed acpi_irq_domain_create and acpi_irq_domain_remove

Changes V3 -> V4:
* Add a DSDT device probe table that is used to probe DSDT IRQ chips
  as necessary when converting HW IRQs to Linux IRQs
* Describe IRQ combiner registers as ACPI Register resources

Changes V4 -> V5:
* Fix issues flagged by the 0-DAY build bot
* Fix some minor style issues raised by Timur

Agustin Vega-Frias (2):
  ACPI: Add support for ResourceSource/IRQ domain mapping
  irqchip: qcom: Add IRQ combiner driver

 drivers/acpi/Makefile               |   1 +
 drivers/acpi/irqdomain.c            | 141 +++++++++++++++
 drivers/acpi/resource.c             |  21 ++-
 drivers/irqchip/Kconfig             |   8 +
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/qcom-irq-combiner.c | 332 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h   |   1 +
 include/linux/acpi.h                |  71 ++++++++
 include/linux/irqchip.h             |  17 +-
 9 files changed, 581 insertions(+), 12 deletions(-)
 create mode 100644 drivers/acpi/irqdomain.c
 create mode 100644 drivers/irqchip/qcom-irq-combiner.c

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

