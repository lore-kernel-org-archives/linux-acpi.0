From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 0/4] IORT SMMUv3 MSI support
Date: Wed, 27 Sep 2017 09:20:11 +0800
Message-ID: <1506475215-2731-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:49191 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965519AbdI0BUd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Sep 2017 21:20:33 -0400
Received: by mail-pf0-f172.google.com with SMTP id l188so6420679pfc.6
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2017 18:20:33 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

IORT revision C introduced SMMUv3 MSI support for control interrupts,
which introduced a device ID mapping index to retrieve the dev ID
and ITS parent, adding its support in this patch set, please refer
to each patch for detail commit message.

RFC v2 -> v1:
 - Drop RFC tag;
 - return the index value directly from iort_get_id_mapping_index()
   then make the logic simple in iort_node_map_id();
 - To make sure ID mapping index is only ignored if all interrupts are
   GSIV based
 - Sqursh part of the patch 4 to patch 3

RFC v1 -> RFC v2:
 - Introduce a new API iort_set_device_domain() to find the MSI domain
   for an SMMUv3 (or any other IORT table node) to reduce the complex
   of doing that via acpi_configure_pmsi_domain().

Hanjun Guo (3):
  ACPICA: Add SMMUv3 device ID mapping index support
  ACPI: IORT: lookup iort node via fwnode
  ACPI: IORT: Skip SMMUv3 device ID map for two steps mappings

Lorenzo Pieralisi (1):
  ACPI: IORT: SMMUv3 nodes MSI support

 drivers/acpi/arm64/iort.c | 152 ++++++++++++++++++++++++++++++++++++++++++++--
 include/acpi/actbl2.h     |   1 +
 2 files changed, 147 insertions(+), 6 deletions(-)

-- 
1.9.1

