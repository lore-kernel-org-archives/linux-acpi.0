From: Betty Dall <betty.dall@hpe.com>
Subject: [PATCH v3 0/3] ACPI/device_sysfs: Add sysfs support for _HRV hardware revision
Date: Sat, 30 Apr 2016 10:03:36 -0600
Message-ID: <1462032219-12590-1-git-send-email-betty.dall@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t5425.austin.hp.com ([15.216.225.55]:45585 "EHLO
	g1t5425.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbcD3QFF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Apr 2016 12:05:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

The ACPI _HRV object on the device is used to supply Linux with the
device's hardware revision. This is an optional object. Add sysfs support
for the _HRV object if it exists on the device.

This change allows users to easily find the hardware version of non-PCI
hardware by looking at the sysfs 'hrv' file. It is most useful for
non-PCI devices because lspci can list the hardware version for PCI
devices.

v1->v2
	Changed hrv_show error return to -EIO.
	Changed sun_show and status_show error return to -EIO.
	Cleaned up checkpatch errors and warnings.

v2->v3
	Left some of the checkpatch warnings in place.

Betty Dall (3):
  ACPI/device_sysfs: Add sysfs support for _HRV hardware revision    
  ACPI/device_sysfs: Change _SUN and _STA show functions error return to EIO
  ACPI/device_sysfs: Clean up checkpatch errors

 drivers/acpi/device_sysfs.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

-- 
1.9.1

