From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V6 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
Date: Tue,  5 Dec 2017 12:04:45 -0500
Message-ID: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbdLERFQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Dec 2017 12:05:16 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine@vger.kernel.org, timur@codeaurora.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>

Introduce new ACPI and OF device ids for thw HW along with the helper
functions.

Changes from v5:
* use struct device as a calling parameter to get_match_data() callback
so that we can reuse the existing OF API.
* revert the change on acpi_get_match_data() to V4.

Sinan Kaya (7):
  Documentation: DT: qcom_hidma: Bump HW revision for the bugfixed HW
  ACPI / bus: Introduce acpi_get_match_data() function
  device property: Introduce a common API to fetch device match data
  OF: properties: Implement get_match_data() callback
  ACPI: properties: Implement get_match_data() callback
  dmaengine: qcom_hidma: Add support for the new revision
  dmaengine: qcom_hidma: Add identity register support

 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  4 +--
 drivers/acpi/bus.c                                 | 12 +++++++
 drivers/acpi/property.c                            |  7 ++++
 drivers/base/property.c                            |  6 ++++
 drivers/dma/qcom/hidma.c                           | 41 ++++++++++------------
 drivers/of/property.c                              |  7 ++++
 include/linux/acpi.h                               |  6 ++++
 include/linux/fwnode.h                             |  4 +++
 include/linux/property.h                           |  2 ++
 9 files changed, 65 insertions(+), 24 deletions(-)

-- 
1.9.1

