From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/2] [PATCH] ACPI / button: Change default behavior to avoid lid bug reports
Date: Thu, 12 Jan 2017 15:47:23 +0800
Message-ID: <cover.1484206801.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:18777 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbdALHrc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Jan 2017 02:47:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

There are still many users reporting LID issues to the kernel bugzilla as
there is no change from systemd and we don't have correct default behavior
for now or for the future. It's a headache to teach the reporters to use
button.lid_init_state=open report by report to correctly work the problems
around.

This patchset changes the default behavior of ACPI button driver in order
to reduce such bug reports.

Lv Zheng (2):
  ACPI / button: Change default behavior to lid_init_state=open
  ACPI / button: Remove lid_init_state=method mode

 Documentation/acpi/acpi-lid.txt | 16 ++++------------
 drivers/acpi/button.c           | 11 +----------
 2 files changed, 5 insertions(+), 22 deletions(-)

-- 
2.7.4

