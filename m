From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/4] ACPI 2.0 / ECDT: Enable ECDT support
Date: Thu, 24 Mar 2016 10:42:38 +0800
Message-ID: <cover.1458786874.git.lv.zheng@intel.com>
References: <c87e72bebfbfbb35c4f14100c0a0a5e19a6ec5ed>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55736 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbcCXCmm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Mar 2016 22:42:42 -0400
In-Reply-To: <c87e72bebfbfbb35c4f14100c0a0a5e19a6ec5ed>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

ECDT support in Linux is broken.

In fact, the original EC driver was correct, but devlopers started to use
the namespace EC instead of ECDT just because several broken ECDT tables
were reported on the bugzilla. They trusted the namespace EC settings
rather than the ECDT ones, this led to the evaluation of _REG/_GPE/_CRS
and namespace walk before executing the module level AML opcodes. And the
fixes in fact finally disable early EC usages (used during table loading
and early device enumeration processes).

Lv Zheng (4):
  ACPI 2.0 / ECDT: Split EC_FLAGS_HANDLERS_INSTALLED
  ACPI 2.0 / ECDT: Remove early namespace reference from EC
  ACPI 2.0 / ECDT: Enable correct ECDT initialization order
  ACPI 2.0 / AML: Improve module level execution by moving the
    If/Else/While execution to per-table basis

 drivers/acpi/bus.c    |   39 +++++---
 drivers/acpi/ec.c     |  241 ++++++++++++++++++++++---------------------------
 include/acpi/acpixf.h |    2 +-
 3 files changed, 135 insertions(+), 147 deletions(-)

-- 
1.7.10

