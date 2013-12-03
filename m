From: "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCHv2 0/2] New driver for Intel IOSF MBI access
Date: Tue,  3 Dec 2013 15:59:36 -0800
Message-ID: <1386115178-7559-1-git-send-email-david.e.box@linux.intel.com>
References: <1385100357-5459-1-git-send-email-david.e.box@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58341 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139Ab3LDABN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Dec 2013 19:01:13 -0500
In-Reply-To: <1385100357-5459-1-git-send-email-david.e.box@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>

From: "David E. Box" <david.e.box@linux.intel.com>

David E. Box (2):
  New Driver for IOSF-SB MBI access on Intel SOCs
  ACPI/platform: Add ACPI ID for Intel MBI device

v2: Made modular as reasons for built-in only no longer a concern.
    Moved to x86 platform driver, as suggested by Matthew Garrett <mjg59@srcf.ucam.org>
    Changed initialization sequence to do probe during init, thereby forcing an
        exit if the device does not exist. Module exit does not otherwise occur
        if module_platform_driver() is used and the device doesn't exist.

 drivers/acpi/acpi_platform.c    |    3 +-
 drivers/platform/x86/Kconfig    |    8 ++
 drivers/platform/x86/Makefile   |    2 +
 drivers/platform/x86/iosf_mbi.c |  188 +++++++++++++++++++++++++++++++++++++++
 drivers/platform/x86/iosf_mbi.h |   89 ++++++++++++++++++
 5 files changed, 289 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/iosf_mbi.c
 create mode 100644 drivers/platform/x86/iosf_mbi.h

-- 
1.7.10.4

