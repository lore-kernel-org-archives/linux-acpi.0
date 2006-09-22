From: Zhang Rui <rui.zhang@intel.com>
Subject: [0/12] acpi: make ACPI use driver model
Date: Fri, 22 Sep 2006 17:14:20 +0800
Message-ID: <1158916460.11985.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37715 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751103AbWIVJMz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 05:12:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

Make ACPI use driver model.

Patrick has posted patches on rewriting ACPI driver model in November 2005.
And recently Shaohua send me a prototype on making ACPI use driver model.
This patch series bases on both Patrick and Shaohua's previous work. 

Two features are gonna to be changed by applying this series of patches.
1.	ACPI driver model. 
	ACPI driver are made to follow Linux driver model.
	The mainly work is to convert the registeration interfaces, so that
	ACPI devices are registered with the global device tree.
	Note the new .uevent method mark ACPI drivers by PNPID 
	instead of by name. Udev script needs to look for "HWID = "
	or "COMPTID = " to load the right ACPI driver.
2.	ACPI sysfs interface. 
	As a result of using driver model, ACPI devices is added in the 
	/sys/device tree. So after _EJ0 is added as a property of 
	ACPI device in device tree, /sys/firm/acpi is deleted.
	Note that the corresponding userspace script needs to be changed 
	for hot removal.

Note that this is only the first step of ACPI sysfs convert project.
The next step is to duplicate /proc/acpi functions in /sys/device tree.
