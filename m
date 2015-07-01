From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 0/10] Fixes and API additions for firmware nodes
Date: Wed,  1 Jul 2015 08:47:53 +0200
Message-ID: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33552 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbbGAGsX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 02:48:23 -0400
Received: by wgck11 with SMTP id k11so27912838wgc.0
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2015 23:48:22 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.160])
        by mx.google.com with ESMTPSA id r9sm1319220wjo.26.2015.06.30.23.48.20
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 23:48:21 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

this series makes it possible to extract device dependencies from firmware data
with fwnode, thus not depending on the particular format of that data.

The first patches are about making sure that we can reach the fwnode
handle of the firmware data associated with a given device, and the rest
add API that makes dependency extraction possible.

Thanks,

Tomeu


Tomeu Vizoso (10):
  of/platform: Set fwnode field for new devices
  i2c: core: Have clients point to their firmware nodes
  mfd: Have child devices point to their firmware nodes
  device property: add fwnode_get_parent()
  device property: add fwnode_get_name()
  ACPI / scan: Add acpi_dev_get_next_child()
  device property: Add fwnode_get_next_child_node()
  device property: add fwnode_is_compatible()
  device: property: add fwnode_driver_match_device()
  core: platform: use fwnode_driver_match_device()

 drivers/acpi/scan.c      |  5 +--
 drivers/base/platform.c  |  8 +---
 drivers/base/property.c  | 95 ++++++++++++++++++++++++++++++++++++++++++++----
 drivers/i2c/i2c-core.c   |  1 +
 drivers/mfd/mfd-core.c   |  1 +
 drivers/of/platform.c    |  1 +
 include/acpi/acpi_bus.h  |  5 +++
 include/linux/acpi.h     | 22 ++++++++++-
 include/linux/property.h | 17 +++++++++
 9 files changed, 136 insertions(+), 19 deletions(-)

-- 
2.4.1

