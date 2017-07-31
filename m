From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/4] ACPI / EC: Solve EC event handling issues
Date: Mon, 31 Jul 2017 13:47:49 +0800
Message-ID: <cover.1501479412.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:49782 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbdGaFrw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jul 2017 01:47:52 -0400
In-Reply-To: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

There is a known issue in EC event handling. This patchset tries to handle
noirq stage EC event polling to fix this known issue.

In the very early version, the EC event polling mechanism is implemented by
a kernel thread to poll EC events. Now the mechanism is implemented by a
timer ticked in noirq stage to poll EC GPEs. In this newest timer version,
timer running period is shortened and thus is safer for s2idle mode.

After adding such a mechanism, we can try to handle EC events earlier after
resume, this may be able to solve some driver order issues.

Lv Zheng (4):
  ACPI / EC: Cleanup EC GPE mask flag
  ACPI / EC: Add IRQ polling support for noirq stages
  ACPI / EC: Add support to handle EC events earlier
  ACPI / EC: Enable noirq stage GPE polling

 drivers/acpi/ec.c       | 157 ++++++++++++++++++++++++++++++++++++++++++++----
 drivers/acpi/internal.h |   1 +
 2 files changed, 145 insertions(+), 13 deletions(-)

-- 
2.7.4

