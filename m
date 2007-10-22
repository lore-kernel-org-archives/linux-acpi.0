From: Frans Pop <elendil@planet.nl>
Subject: [PATCH] Remove double mention of Support for ACPI option
Date: Mon, 22 Oct 2007 16:47:07 +0200
Message-ID: <200710221647.07911.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rfLHHUrjGI1i44L"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml19.KPNXCHANGE.COM ([213.75.38.84]:9094 "EHLO
	hpsmtp-eml19.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751937AbXJVOrL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Oct 2007 10:47:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

--Boundary-00=_rfLHHUrjGI1i44L
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Frans Pop <elendil@planet.nl>

Current description for CONFIG_ACPI includes the word "Support" twice.
One effect of this is that in menuconfig the "--->" that indicates the 
presence of sub-options will not show up unless you have a very wide 
console.

Signed-off-by: Frans Pop <elendil@planet.nl>
---

--Boundary-00=_rfLHHUrjGI1i44L
Content-Type: text/x-diff;
  charset="us-ascii";
  name="remove_double_mention_of_support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="remove_double_mention_of_support.patch"

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5d0e26a..92422a3 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig ACPI
-	bool "ACPI Support (Advanced Configuration and Power Interface) Support"
+	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !X86_NUMAQ
 	depends on !X86_VISWS
 	depends on !IA64_HP_SIM

--Boundary-00=_rfLHHUrjGI1i44L--
