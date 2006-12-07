From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/14] ACPI: make ACPI use driver model
Date: Thu, 07 Dec 2006 20:56:10 +0800
Message-ID: <1165496170.11485.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13048 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032136AbWLGMwE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 07:52:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

The main purpose of this patch series is to make ACPI use driver model
And these are updated patches against 2.6.19.

Patrick has posted patches on rewriting ACPI driver model in November 2005. 
And recently Shaohua send me a prototype on making ACPI use driver model. 
This patch series bases on both Patrick and Shaohua's previous work. 

Two features are gonna be changed by applying this series of patches. 
1. ACPI driver model.  
ACPI driver are made to follow Linux driver model. 
The main work is to convert the registration interfaces,so that
ACPI devices are registered with the global device tree. 
        Note the new .uevent method mark ACPI drivers by PNPID  
instead of by name. Udev script needs to look for "HWID = " 
or "COMPTID = " to load the right ACPI driver. 
2.      ACPI sysfs interface.  
As a result of using driver model, ACPI devices is added in the
/sys/device tree. So _EJ0 is added as a property of ACPI device
in device tree. ACPI namespace nodes that used to  be shown 
under /sys/firm/acpi is deleted. 
The corresponding userspace script needs to be changed for
hot removal.

Note that this is only the first step of ACPI sysfs conversion work 
The next step is to duplicate ACPI procfs functions in sysfs. 
