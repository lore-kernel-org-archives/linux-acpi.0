From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 01/13] ACPI: thinkpad-acpi: update documents for the new location
Date: Sun, 11 Jan 2009 03:00:58 -0200
Message-ID: <1231650070-21722-2-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44604 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750749AbZAKFBP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Jan 2009 00:01:15 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update documentation to reflect the new location of the
thinkpad-acpi driver.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 898b498..ddc371e 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -16,7 +16,8 @@ supported by the generic Linux ACPI drivers.
 This driver used to be named ibm-acpi until kernel 2.6.21 and release
 0.13-20070314.  It used to be in the drivers/acpi tree, but it was
 moved to the drivers/misc tree and renamed to thinkpad-acpi for kernel
-2.6.22, and release 0.14.
+2.6.22, and release 0.14.  It was moved to drivers/platform/x86 for
+kernel 2.6.29.
 
 The driver is named "thinkpad-acpi".  In some places, like module
 names, "thinkpad_acpi" is used because of userspace issues.
-- 
1.5.6.5

