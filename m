From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 0/4] ACPI / EC: Poll more EC events during suspend/resume
Date: Fri, 11 Aug 2017 14:36:22 +0800
Message-ID: <cover.1502432974.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:30813 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751359AbdHKGgZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 11 Aug 2017 02:36:25 -0400
In-Reply-To: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

EC events are special, required to be handled during suspend/resume. But
there is a problem preventing EC events from being detected during noirq
stages.
This patchset fixes this issue by polling EC IRQs timely during
suspend/resume noirq stages.
With this issue fixed, we should be able to handler EC events earlier
during resume, and have great opportunities to fix some driver order
issues caused by the deferred detected EC events.

v3 of this patch series only contains patch description updates.

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

