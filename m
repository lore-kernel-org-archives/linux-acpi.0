From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/5] ACPI: procfs/sysfs/debugfs code cleanup
Date: Fri, 11 Jun 2010 13:47:49 +0800
Message-ID: <1276235269.19052.15870.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38866 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab0FKFr1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jun 2010 01:47:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


This patch set mainly cleans up the ACPI procfs/sysfs/debugfs code.

1. removes the deprecated ACPI procfs I/F, including
   /proc/acpi/debug_layer
   /proc/acpi/debug_level
   /proc/acpi/info
   /proc/acpi/dsdt
   /proc/acpi/fadt
   because the sysfs I/F have been working for years without any problems.

2. introduce drivers/acpi/debugfs.c, code for ACPI debugfs I/F, i.e.
   /sys/kernel/debug/acpi/custom_method,
   are moved to this file.

3. introduce drivers/acpi/sysfs.c, code for ACPI sysfs I/F, including
   /sys/module/acpi/parameters/debug_layer,
   /sys/module/acpi/parameters/debug_level,
   /sys/module/acpi/parameters/acpica_version,
   /sys/firmware/acpi/interrupts/*,
   /sys/firmware/acpi/tables/*,
   are moved to this file.

4. introduce module parameter acpi.aml_debug, which is an enhancement of
   the runtime custom method overriding mechanism.

any comments are welcome.

thanks,
rui


