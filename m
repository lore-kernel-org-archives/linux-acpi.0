From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/3] ACPI / debugger: Add kernel flushing support
Date: Thu, 14 Jul 2016 10:52:01 +0800
Message-ID: <cover.1468464391.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:19961 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbcGNCw1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jul 2016 22:52:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

AML debugger is implemented in the kernel as a character device located in
the debugfs. Currently, when its batch mode is used, the userspace tool
needs to flush the logs/prompts remained in the kernel output buffer, this
is implemented in an inefficient way in the userspace by polling the IO and
reading everything out.

This patch introduces a kernel space flushing support, so that userspace
can invoke fsync() to put the driver into a state waiting for new commands,
all kernel space logs/prompts will be automatically discarded by fsync().

Lv Zheng (3):
  debugfs: Add .fsync() callback proxy support
  ACPI / debugger: Add kernel flushing support
  tools/power/acpi/acpidbg: Use new flushing mechanism

 drivers/acpi/acpi_dbg.c                  |   94 ++++++++++++++++++++++++++++--
 fs/debugfs/file.c                        |    6 ++
 tools/power/acpi/tools/acpidbg/acpidbg.c |   49 ++--------------
 3 files changed, 101 insertions(+), 48 deletions(-)

-- 
1.7.10

