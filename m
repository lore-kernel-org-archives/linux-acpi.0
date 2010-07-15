From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/9] ACPI: debugfs/sysfs/procfs cleanup
Date: Thu, 15 Jul 2010 10:46:09 +0800
Message-ID: <1279161969.4537.8513.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41410 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129Ab0GOCoF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jul 2010 22:44:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

This patch set mainly cleans up the ACPI procfs/sysfs/debugfs code.

Patch 01 introduces drivers/acpi/debugfs.c, code for ACPI debugfs I/F,
         i.e. /sys/kernel/debug/acpi/custom_method, is moved to this
         file. And also make the ACPI debugfs I/F always built in,
         even when CONFIG_ACPI_DEBUG is cleared.

Patch 02 introduces module parameter acpi.aml_debug_output, so that
         we can get the ACPI Debug Object output even with
         CONFIG_ACPI_DEBUG cleared.         

Patch 03 introduces drivers/acpi/sysfs.c, code for ACPI sysfs I/F,
         including:
         /sys/module/acpi/parameters/debug_layer,
         /sys/module/acpi/parameters/debug_level,
         /sys/module/acpi/parameters/trace_method_name
         /sys/module/acpi/parameters/trace_debug_layer
         /sys/module/acpi/parameters/trace_debug_level
         /sys/module/acpi/parameters/trace_state
         /sys/module/acpi/parameters/acpica_version,
         /sys/firmware/acpi/interrupts/*,
         /sys/firmware/acpi/tables/*,
         is moved to this file.

Patch 04 removes the deprecated ACPI procfs I/F, including
         /proc/acpi/debug_layer
         /proc/acpi/debug_level
         /proc/acpi/info
         /proc/acpi/dsdt
         /proc/acpi/fadt
         /proc/acpi/sleep
         because the sysfs I/F has been working well for years.

Patch 05, 06 and 07 remove the deprecated procfs I/F for ACPI
         processor, power_resource and EC driver.

Patch 08 make the ACPI video procfs I/F depends on CONFIG_ACPI_PROCFS,
         because we already have the sysfs I/F for backlight control,
         and the other procfs I/F of this driver is not used by anyone.

Patch 09 make the ACPI thermal procfs I/F depends on CONFIG_ACPI_PROCFS
         because the sysfs I/F, i.e. /sys/class/thermal, is available now.

Generally speaking, this patch set does the following things,
1. introduce new files for ACPI sysfs/debugfs I/F.
2. remove the deprecate ACPI procfs I/F.
3. make other ACPI procfs I/F that already has sysfs duplicate configurable,
   so that we can remove them in the near future.

any comments are welcome.

thanks,
rui




