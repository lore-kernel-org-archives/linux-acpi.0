From: Bob Paauwe <bob.j.paauwe@intel.com>
Subject: [PATCH 0/2] dynamic table unload fixes
Date: Fri,  3 Apr 2015 09:07:47 -0700
Message-ID: <1428077269-12764-1-git-send-email-bob.j.paauwe@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5396 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbbDCQGC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Apr 2015 12:06:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Bob Paauwe <bob.j.paauwe@intel.com>

While trying to make use of dynamic tables as a way to provide driver
initialization properties, I've encountered a couple of issues with the
way dynamic tables are being handled.

The first patch appears to be a bug. There is a mutex release without
a corresponding aquire. This extra release causes a mutex error message
when a table is re-loaded after being unloaded.

The second patch actually unloads a table when table unload is called. 
When a table is being dynamically loaded by a driver module and that
driver module is unloaded, the memory for the table would typically be
freed resulting in a table that is marked as unloaded but still pointing
to that freed memory.  If the driver module is then re-loaded, the
ACPI table reload function will attempt to access that freed memory when
it does a table compare and results in a oops.

These patches solve the problems I've encountered but may not be the 
proper way to solve.

Bob Paauwe (2):
  Remove extra release mutex call.
  Acutally unload a table.

 drivers/acpi/acpica/tbinstal.c | 1 -
 drivers/acpi/acpica/tbxfload.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.1.0

