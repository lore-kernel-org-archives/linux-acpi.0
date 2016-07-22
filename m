From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 0/3] ACPI / debugger: Add kernel flushing support
Date: Fri, 22 Jul 2016 12:16:49 +0800
Message-ID: <cover.1469155242.git.lv.zheng@intel.com>
References: <cover.1468464391.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:40108 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbcGVEQ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Jul 2016 00:16:56 -0400
In-Reply-To: <cover.1468464391.git.lv.zheng@intel.com>
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
can invoke ioctl() to put the driver into a state waiting for new commands,
all kernel space logs/prompts will be automatically discarded by ioctl().

Lv Zheng (3):
  ACPI / debugger: Add kernel flushing support
  tools/power/acpi/acpidbg: Use new flushing mechanism
  tools/power/acpi/acpidbg: Add multi-commands support in batch mode

 drivers/acpi/acpi_dbg.c                  |   85 +++++++++++++++++++++--
 include/linux/acpi.h                     |    1 +
 include/uapi/linux/acpi-ioctls.h         |   21 ++++++
 tools/power/acpi/tools/acpidbg/acpidbg.c |  110 +++++++++++++++++-------------
 4 files changed, 165 insertions(+), 52 deletions(-)
 create mode 100644 include/uapi/linux/acpi-ioctls.h

-- 
1.7.10

