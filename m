From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/2] ACPICA: Events: Fix GPE enabling issues related to edge-triggered GPEs
Date: Fri, 11 Aug 2017 13:57:23 +0800
Message-ID: <cover.1502430636.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53819 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbdHKF5a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 11 Aug 2017 01:57:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org

There are 2 issues related to the enabling of GPEs:
1. Currently, our code clears GPE before enabling it. In case of edge
   triggered GPEs, doing this risks GPE losses.
2. For edge-triggered GPEs, enabling it is not sufficiently to trigger an
   already triggered GPE, we need to poll the GPE once it is enabled.
This patchset fixes these 2 problems.

Lv Zheng (2):
  ACPICA: Events: Stop unconditionally clearing ACPI IRQs during
    suspend/resume
  ACPICA: Events: Dispatch GPEs after enabling for the first time

 drivers/acpi/acpica/evgpe.c     |  7 -------
 drivers/acpi/acpica/evxfgpe.c   | 22 ++++++++++++++++++++++
 drivers/acpi/acpica/hwgpe.c     |  1 -
 drivers/acpi/acpica/hwsleep.c   | 11 ++---------
 drivers/acpi/acpica/hwxfsleep.c |  2 +-
 5 files changed, 25 insertions(+), 18 deletions(-)

-- 
2.7.4

