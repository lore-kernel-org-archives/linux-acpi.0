From: Agustin Vega-Frias <agustinv@codeaurora.org>
Subject: [PATCH V8 0/3] irqchip: qcom: Add IRQ combiner driver
Date: Tue, 29 Nov 2016 17:57:36 -0500
Message-ID: <1480460259-8585-1-git-send-email-agustinv@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754672AbcK2W5y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Nov 2016 17:57:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: timur@codeaurora.org, cov@codeaurora.org, agross@codeaurora.org, harba@codeaurora.org, jcm@redhat.com, msalter@redhat.com, mlangsdo@redhat.com, ahs3@redhat.com, astone@redhat.com, graeme.gregory@linaro.org, guohanjun@huawei.com, charles.garcia-tobin@arm.com, Agustin Vega-Frias <agustinv@codeaurora.org>

Add support for IRQ combiners in the Top-level Control and Status
Registers (TCSR) hardware block in Qualcomm Technologies chips.

The first patch adds support for ResourceSource/IRQ domain mapping
when using Extended IRQ Resources with a specific ResourceSource.
The patch prevents the ACPI core from attempting to map IRQ resources
with a valid ResourceSource as GSIs.

The second patch fixes IRQ probe deferral by allowing platform_device
IRQ resources to be re-initialized if the ACPI core failed to find
the IRQ domain during ACPI bus scan.

Both changes described above are conditional on the ACPI_GENERIC_GSI config.

The third patch takes advantage of the new capabilities to implement
the driver for the IRQ combiners.

Tested on top of v4.9-rc7.

Changes V7 -> V8:
* Reorder patches to allow all new code to be under drivers/acpi/irq.c.
* Change acpi_irq_get implementation to be more similar to of_irq_get
  to improve maintainability.

Changes V6 -> V7:
* Consolidate changes for ResourceSource/IRQ domain mapping to the same
  source file implementing the generic GSI support, making it conditional
  on CONFIG_ACPI_GENERIC_GSI.
* Eliminate some code duplication by implementing acpi_register_gsi in
  terms of the new acpi_register_irq API.

Changes V5 -> V6:
* Drop probe table and on-demand probing based on resource_source
* Add patch to fix probe deferral
* Change back combiner driver to use the platform_device/platform_driver
  APIs

Agustin Vega-Frias (3):
  ACPI: Add support for ResourceSource/IRQ domain mapping
  ACPI: Retry IRQ conversion if it failed previously
  irqchip: qcom: Add IRQ combiner driver

 drivers/acpi/Makefile               |   2 +-
 drivers/acpi/gsi.c                  |  98 -----------
 drivers/acpi/irq.c                  | 315 +++++++++++++++++++++++++++++++++
 drivers/acpi/resource.c             |  29 ++--
 drivers/base/platform.c             |   9 +-
 drivers/irqchip/Kconfig             |   8 +
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/qcom-irq-combiner.c | 337 ++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h                |  28 +++
 9 files changed, 714 insertions(+), 113 deletions(-)
 delete mode 100644 drivers/acpi/gsi.c
 create mode 100644 drivers/acpi/irq.c
 create mode 100644 drivers/irqchip/qcom-irq-combiner.c

--
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
