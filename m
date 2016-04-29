From: Betty Dall <betty.dall@hpe.com>
Subject: [PATCH v2 0/3] ACPI/device_sysfs: Add sysfs support for _HRV hardware revision
Date: Fri, 29 Apr 2016 13:21:18 -0600
Message-ID: <1461957681-6163-1-git-send-email-betty.dall@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:34106 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbcD2TWn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Apr 2016 15:22:43 -0400
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

Betty Dall (3):
  ACPI/device_sysfs: Add sysfs support for _HRV hardware revision    
  Change _SUN and _STA show functions error return to EIO
  Clean up checkpatch errors

 drivers/acpi/device_sysfs.c | 50 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 10 deletions(-)

-- 
1.9.1

