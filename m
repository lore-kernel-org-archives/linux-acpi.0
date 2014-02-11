From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/2] ACPICA: Preparations of acpidump release automation.
Date: Tue, 11 Feb 2014 10:51:21 +0800
Message-ID: <cover.1392086457.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15796 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbaBKCvc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Feb 2014 21:51:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This series includes required changes for acpidump release automation.

Since these commits actually are no-op for ACPICA and there are side
effects for Linux kernel after applying the linuxized ones, it is better to
post them in Linux community rather than in ACPICA community for review and
back port them to ACPICA upstream after merging them first into Linux.

Lv Zheng (2):
  ACPICA: acpidump: Add sparse declarators support.
  ACPICA: acpidump: Remove translation protection on integer types.

 include/acpi/actypes.h          |   64 +++++++++++++++++++--------------------
 include/acpi/platform/aclinux.h |   12 ++++++++
 2 files changed, 44 insertions(+), 32 deletions(-)

-- 
1.7.10

