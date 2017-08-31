From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 0/3] ACPI / EC: Fix EC event handling issues
Date: Thu, 31 Aug 2017 16:10:20 +0800
Message-ID: <cover.1504166863.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

EC events are special, required to be handled during suspend/resume. But
there are special logics in Linux causing several issues related to the EC
event handling:
1. During noirq stage, Linux cannot detect EC events which are target
   driven.
2. When EC event handling is enabled later than the other drivers, order
   problem could be observed.
When fixing these problems, care should be taken to not to trigger
regressions to the following problem which has alredy been fixed using
different approach):
3. When EC event handling is enabled before the end of the noirq stage,
   EC event handling may stuck.
This patchset fixes these issues.

v4 of this patch series re-orders the fixes so that the fix of the problem
2 could be independent against the fix of the problem 1, this is done by
refining the fix of the problem 2, making it immune to the problem 3.

Lv Zheng (3):
  ACPI / EC: Fix possible driver order issue by moving EC event handling
    earlier
  ACPI / EC: Add event detection support for noirq stages
  ACPI / EC: Enable noirq stage event detection

 drivers/acpi/ec.c       | 116 +++++++++++++++++++++++++++++++++++++++++++++---
 drivers/acpi/internal.h |   1 +
 2 files changed, 111 insertions(+), 6 deletions(-)

-- 
2.7.4
