From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/3] ACPI: Documentation udpates
Date: Thu, 20 Jun 2013 08:01:39 +0800
Message-ID: <cover.1371619148.git.lv.zheng@intel.com>
References: <1364824711-5193-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:52109 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935056Ab3FTACL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jun 2013 20:02:11 -0400
In-Reply-To: <1364824711-5193-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch set adds 2 ACPI documentation files with MAINTAINERS updated.

Lv Zheng (3):
  ACPI: Update MAINTAINERS file to include Documentation/acpi
  ACPI: Add sysfs ABI documentation
  ACPI: Add ACPI namespace documentation

 Documentation/ABI/testing/sysfs-bus-acpi    |   58 ++++
 Documentation/ABI/testing/sysfs-devices-sun |    2 +-
 Documentation/acpi/namespace.txt            |  395 +++++++++++++++++++++++++++
 MAINTAINERS                                 |    2 +
 4 files changed, 456 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-acpi
 create mode 100644 Documentation/acpi/namespace.txt

-- 
1.7.10

