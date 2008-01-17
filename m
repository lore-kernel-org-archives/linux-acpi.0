From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/10] generic thermal management
Date: Thu, 17 Jan 2008 15:50:38 +0800
Message-ID: <1200556238.2935.115.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65382 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbYAQHpT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jan 2008 02:45:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com, sujith.thomas@intel.com

Hi, all,

This patch series introduces a new generic thermal sysfs driver
which provides a set of interfaces for thermal zone devices (sensors)
and thermal cooling devices (fan, processor...) to register with the
thermal management solution and to be a part of it.

And it also includes the implementation for ACPI thermal zone.
Standard sysfs I/F should be available for all ACPI thermal zones
with this patch series applied.

Patch 01 creates the new generic thermal sysfs driver.
	 It defines two kinds of devices, thermal zone device and
	 thermal cooling device.
	 A thermal zone device usually contains a sensor to monitor the
	 temperature, several trip points and a bunch of cooling devices
	 associated with them.
	 A thermal cooling device is a device that can be throttled
	 to cool the system.
	 The generic thermal sysfs driver creates the standard sysfs I/F
	 for any registered thermal zone and thermal cooling device.
	 And binds the cooling devices to thermal zones if possible.

Patch 02 registers ACPI thermal zone as thermal zone device.

Patch 03 is a fix of violations of ACPI spec in ACPI thermal driver.

Patch 04 registers ACPI Fan as thermal cooling device.

Patch 05 registers ACPI Processor as thermal cooling device.

Patch 06 registers ACPI Video LCD as thermal cooling device.
	 Because throttling the backlight of LCD can cool the system as well.

Patch 09 creates a new platform specific driver, intel_menlow.
	 which is the thermal enhancement driver for intel menlow platform.
	 It programs the sensor of each thermal zone and registers the
	 intel memory controller (hardware id INT0002) as thermal cooling device.

Patch 07 08 and 10 are minor fixes, please refer to the changelog of each patch.

I've tested them and they work well on several systems.
I'd like to get some feedbacks from the list. Any comments are appreciated. :)

Thanks,
Rui


