From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: [PATCH] Change ACPI IPMI support to "default y"
Date: Tue, 18 Feb 2014 11:20:49 -0500
Message-ID: <1392740449-843-1-git-send-email-matthew.garrett@nebula.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49373 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755710AbaBRQVL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Feb 2014 11:21:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@acm.org
Cc: lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Garrett <matthew.garrett@nebula.com>

The ACPI IPMI driver implements IPMI operation region support for the ACPI
core. Systems that declare ACPI operation regions may reference them at any
time, including during kernel initialisation. These accesses will fail
unless the ACPI IPMI driver is present, and undesirable system behaviour
may result. Set the default to Y in order to encourage distributions and
users to configure kernels to avoid awkward surprises.

Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
---
 drivers/acpi/Kconfig      | 2 +-
 drivers/char/ipmi/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 4770de5..0e6aab9 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -162,7 +162,7 @@ config ACPI_PROCESSOR
 config ACPI_IPMI
 	tristate "IPMI"
 	depends on IPMI_SI
-	default n
+	default y
 	help
 	  This driver enables the ACPI to access the BMC controller. And it
 	  uses the IPMI request/response message to communicate with BMC
diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index 0baa8fa..a125610 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -45,6 +45,7 @@ config IPMI_DEVICE_INTERFACE
 
 config IPMI_SI
        tristate 'IPMI System Interface handler'
+       default y if ACPI
        help
          Provides a driver for System Interfaces (KCS, SMIC, BT).
 	 Currently, only KCS and SMIC are supported.  If
-- 
1.8.5.3

