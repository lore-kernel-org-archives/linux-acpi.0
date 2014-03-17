From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 0/2] ACPICA: Updates for auto-serialization mechanism.
Date: Mon, 17 Mar 2014 12:13:52 +0800
Message-ID: <cover.1395028738.git.lv.zheng@intel.com>
References: <14866.1394813101@turing-police.cc.vt.edu>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1821 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbaCQEOv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Mar 2014 00:14:51 -0400
In-Reply-To: <14866.1394813101@turing-police.cc.vt.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

It is reported that the auto-serialization mechanism has broken some
machine.  A patch in this series tries to fix the reported issue, it is
sent to the reporter for verification, thus marked as RFC.

Since this feature may still need to be validated, we can disable it
temporarily in order not to break users.  The patch to make it default
disabled is also marked as RFC.  We can determine if it is needed according
to the verification result.

References: https://bugzilla.kernel.org/show_bug.cgi?id=52191
References: http://www.spinics.net/lists/linux-acpi/msg49496.html

Lv Zheng (1):
  ACPI: Default disable auto-serialization.

Robert Moore (1):
  ACPICA: Dispatcher: Add sync_level support for auto-serialization
    mechanism.

 Documentation/kernel-parameters.txt |    8 ++++----
 drivers/acpi/acpica/acglobal.h      |    2 +-
 drivers/acpi/acpica/acobject.h      |    3 ++-
 drivers/acpi/acpica/dsmethod.c      |   24 +++++++++++++++++++-----
 drivers/acpi/osl.c                  |   12 ++++++------
 5 files changed, 32 insertions(+), 17 deletions(-)

-- 
1.7.10

