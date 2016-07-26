From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 0/3] ACPI / debugger: Add kernel flushing support
Date: Tue, 26 Jul 2016 19:01:23 +0800
Message-ID: <cover.1469528979.git.lv.zheng@intel.com>
References: <cover.1468464391.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56641 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbcGZLBb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jul 2016 07:01:31 -0400
In-Reply-To: <cover.1468464391.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The AML debugger can be used to dump the runtime value of a named object,
which is useful for remote debugging issues. The batch mode of the AML
debugger allows the debugger functionalities to be integrated into the
scripts.

Currently, when the batch mode is used, the userspace tool needs to flush
the output (logs/prompts) remained in the kernel output buffer in order not
to mess up the result of the executed batch mode command, this is
implemented in an inefficient way in the userspace by polling the IO and
reading everything out.
However, the input needn't be flushed as the command input should have
already been flushed by the signals and won't be passed to
acpi_os_get_line() due to an error return value.

This patch introduces a kernel space flushing support, so that userspace
can invoke ioctl() to request the driver to drop old outputs.

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

