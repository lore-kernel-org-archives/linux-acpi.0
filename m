From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 0/3] ACPICA: Events: Fix notify handler atomicity
Date: Fri, 11 Sep 2015 10:05:09 +0800
Message-ID: <cover.1441935832.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64529 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbbIKCFc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Sep 2015 22:05:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Lee@vger.kernel.org, Chun-Yi <jlee@suse.com>, Hanjun Guo <hanjun.guo@linaro.org>

This patchset tries to fix atomicity issue in the notify handler.

Lv Zheng (3):
  ACPICA: Utilities: Add deferred lock free contexts for deleting
    operand objects
  ACPI / osl: Add OSL_GC_HANDLER/OSL_GC_THREAD support
  ACPICA: Events: Fix reference counting code for per-object notify
    handlers

 drivers/acpi/acpica/acevents.h |    4 +
 drivers/acpi/acpica/acglobal.h |    5 ++
 drivers/acpi/acpica/acobject.h |    2 +-
 drivers/acpi/acpica/evmisc.c   |  134 +++++++++++++++++++++++++++-
 drivers/acpi/acpica/evxface.c  |   66 ++------------
 drivers/acpi/acpica/utdelete.c |  191 +++++++++++++++++++++++++++++++++-------
 drivers/acpi/acpica/utstate.c  |   22 ++++-
 drivers/acpi/bus.c             |    4 +-
 drivers/acpi/osl.c             |   52 ++++++++++-
 include/acpi/acpiosxf.h        |    2 +
 10 files changed, 381 insertions(+), 101 deletions(-)

-- 
1.7.10

