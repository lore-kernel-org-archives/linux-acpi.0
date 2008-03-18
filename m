From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/6] thermal: delete "default y"
Date: Tue, 18 Mar 2008 02:02:11 -0400
Message-ID: <ece54e2ff45062852e4647e85b2bb5f6aee8211c.1205819948.git.len.brown@intel.com>
References: <1205820132-21689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:55486 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751828AbYCRGGb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Mar 2008 02:06:31 -0400
In-Reply-To: <1205820132-21689-1-git-send-email-lenb@kernel.org>
In-Reply-To: <71e93d15612c61c2e26a169567becf088e71b8ff.1205819948.git.len.brown@intel.com>
References: <71e93d15612c61c2e26a169567becf088e71b8ff.1205819948.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

The generic thermal I/F gets selected by ACPI_THERMAL --
its only current customer.
it doesn't need to clutter other configs by default.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 69f19f2..17e71d5 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -4,7 +4,6 @@
 
 menuconfig THERMAL
 	bool "Generic Thermal sysfs driver"
-	default y
 	help
 	  Generic Thermal Sysfs driver offers a generic mechanism for
 	  thermal management. Usually it's made up of one or more thermal
-- 
1.5.5.rc0.6.gdeda

