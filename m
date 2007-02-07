From: malattia@linux.it
Subject: [PATCH 0/4] sony_acpi-0.4: morph into sony-laptop
Date: Wed,  7 Feb 2007 20:01:52 +0100
Message-ID: <11708749163025-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:47491 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422702AbXBGTDT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 14:03:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Hello,

the following patches are my current work to move sony_acpi away from
drivers/acpi and avoid using /proc to expose the userspace interface in
to order to finally see the driver included mainline.
(Aaargh! Len, I missed your first batch...)

1/4: will move drivers/acpi/sony_acpi.c to drivers/misc/sony-laptop.c
2/4 to 4/4: implement platform_device and clean up the code

Those patches apply on top of the sony-acpi series akpm sent earlier[1]
and are developed on the acpi test branch.

Thanks
-- 
mattia

[1]:
  [patch 07/13] sony acpi driver
  [patch 08/13] sony_apci: add resume handling
  [patch 09/13] acpi: add backlight support to the sony_acpi driver
  [patch 10/13] sony_acpi: add acpi_bus_generate event
  [patch 11/13] sony_acpi: add lanpower and audiopower controls
  [patch 12/13] sony_acpi: allow multiple sony_acpi_values for the same
  [patch 13/13] sony_acpi: fix sony_acpi backlight registration and unregistration

---
 b/drivers/acpi/Kconfig       |   15 -
 b/drivers/acpi/Makefile      |    1 
 b/drivers/misc/Kconfig       |   15 +
 b/drivers/misc/Makefile      |    1 
 b/drivers/misc/sony-laptop.c |  514 +++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/sony_acpi.c     |  504 ------------------------------------------
 6 files changed, 530 insertions(+), 520 deletions(-)
