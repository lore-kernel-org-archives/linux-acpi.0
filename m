From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 2/2] ACPI: Make bay depend on dock
Date: Mon, 8 Jan 2007 16:21:16 -0800
Message-ID: <20070108162116.6736afc2.kristen.c.accardi@intel.com>
References: <20070108233740.155026806@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28825 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbXAIAVc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jan 2007 19:21:32 -0500
In-Reply-To: <20070108233740.155026806@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@jikos.cz, akpm@osdl.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Since the bay driver depends on the dock driver for proper notification,
make this driver depend on the dock driver. 

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/acpi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- 2.6-mm.orig/drivers/acpi/Kconfig
+++ 2.6-mm/drivers/acpi/Kconfig
@@ -133,6 +133,7 @@ config ACPI_DOCK
 config ACPI_BAY
 	tristate "Removable Drive Bay"
 	depends on EXPERIMENTAL
+	depends on ACPI_DOCK
 	help
 	  This driver adds support for ACPI controlled removable drive
 	  bays such as the IBM ultrabay or the Dell Module Bay.

--
