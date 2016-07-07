From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/4] ACPI: ACPI documentation
Date: Thu,  7 Jul 2016 15:10:21 +0800
Message-ID: <cover.1467875142.git.lv.zheng@intel.com>
References: <cover.1467717304.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:25150 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243AbcGGHKi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Jul 2016 03:10:38 -0400
In-Reply-To: <cover.1467717304.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch adds new ACPI documents related to:
1. ACPICA release process
2. AML debugger
3. ACPI control method lid device
This patch also contains an update of the ACPI LID input event in order to
support the new usage model defined by the documentation change.

History:
1. Remove the upstreamed trivial fixes;
2. Split lid device code and documents;
3. Fix grammar issues in the documents.

Lv Zheng (4):
  ACPI: Add documentation describing ACPICA release automation
  ACPI / debugger: Add AML debugger documentation
  ACPI / button: Add SW_ACPI_LID for new usage model
  ACPI / button: Add document for ACPI control method lid device
    restrictions

 Documentation/acpi/acpi-lid.txt         |   62 ++++++++
 Documentation/acpi/aml-debugger.txt     |   56 +++++++
 Documentation/acpi/linuxized-acpica.txt |  253 +++++++++++++++++++++++++++++++
 drivers/acpi/button.c                   |   20 ++-
 include/linux/mod_devicetable.h         |    2 +-
 include/uapi/linux/input-event-codes.h  |    3 +-
 6 files changed, 388 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/acpi/acpi-lid.txt
 create mode 100644 Documentation/acpi/aml-debugger.txt
 create mode 100644 Documentation/acpi/linuxized-acpica.txt

-- 
1.7.10

