From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/2] ACPI: Add userland visibility for identification objects.
Date: Fri, 28 Sep 2012 08:39:52 +0800
Message-ID: <cover.1348791925.git.lv.zheng@intel.com>
References: <3f02ff942122d086c4d6e44a9ffa9269300675b3.1348736272.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13892 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754317Ab2I1AkU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Sep 2012 20:40:20 -0400
In-Reply-To: <3f02ff942122d086c4d6e44a9ffa9269300675b3.1348736272.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

There are four important device identification objects currently used in
the ACPI bus implementation:

_HID/_CID: traditional enumerated devicess use this object for ACPI device
           matching.
_ADR: the ACPI device/physical device binding codes will use this to find
      non-bridge devices.
_UID: the ACPI enumerated devices require this object to identify itself.

This patch set add the missing stuff useful for _UID in the ACPI devices.
Tow sysfs interfaces are also introduced to allow developers monitor _ADR
and _UID from the user space.

Version 2 of this patch set fixed CodingStyle issues.  The two patches are
also combined to form a single patch set.


Lv Zheng (2):
  ACPI: Add _UID support for ACPI devices.
  ACPI: Add identification objects' user interface.

 drivers/acpi/scan.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

-- 
1.7.10

