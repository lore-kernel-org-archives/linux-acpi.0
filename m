From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/3] ACPI / EC: Fix several code coverity issues
Date: Thu, 24 Sep 2015 14:54:26 +0800
Message-ID: <cover.1443076693.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch fixes several code coverity issues in the EC driver.
One serious issue that can cause memory leak is marked as stable material.

Lv Zheng (3):
  ACPI / EC: Fix a memory leak issue in acpi_ec_query()
  ACPI / EC: Fix query handler related issues
  ACPI / EC: Fix a race issue in acpi_ec_guard_event()

 drivers/acpi/ec.c |  113 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 74 insertions(+), 39 deletions(-)

-- 
1.7.10
