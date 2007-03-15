From: Chris Wedgwood <cw@f00f.org>
Subject: [PATCH] ACPI_IBM_BAY can not coexist with ACPI_BAY
Date: Thu, 15 Mar 2007 00:10:19 -0700
Message-ID: <20070315071019.GA22613@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:47513 "HELO
	smtp108.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750934AbXCOHRB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 03:17:01 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, ibm-acpi@hmh.eng.br
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

ACPI_IBM_BAY cannot coexist with ACPI_BAY --- it causes the IBM ACPI
code to fail to initialize so all the IBM ACPI functionality is
missing.  The simplest fix is to just make sure the Kconfig magic
disallows ACPI_IBM_BAY when ACPI_BAY is enabled.

Signed-off-by: Chris Wedgwood <cw@f00f.org>

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e2ce4a9..1a83fc6 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -246,7 +246,7 @@ config ACPI_IBM_DOCK
 
 config ACPI_IBM_BAY
 	bool "Legacy Removable Bay Support"
-	depends on ACPI_IBM
+	depends on ACPI_IBM && !ACPI_BAY
 	default y
 	---help---
 	  Allows the ibm_acpi driver to handle removable bays.  It will allow

