From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/8] [-mm] ACPI: add ACPI device sysfs interface
Date: Tue, 20 Mar 2007 17:21:11 +0800
Message-ID: <1174382471.8833.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20126 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932514AbXCTJVu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 05:21:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Add sysfs interface for ACPI devices.

This patch set adds sysfs interface for ACPI EC, Fan,
Power_resource, Processor and Thermal_zone devices.

Patch 01 add some helper macros and functions.

Patch 02/03/04 add sysfs interface for ACPI EC, Fan
and Power_resource devices.

Patch 05/06/07 are for ACPI Porcessor (core/throttling/thermal).
Sysfs interfaces for ACPI Processor Power/Performance state
control are already available via cpu_freq and cpu_idle driver.

Sysfs interface for ACPI thermal_zone device is added in Patch 08.

More details are offered in each patch.
Any comments are appreciated. :)

Thanks,
Rui.
