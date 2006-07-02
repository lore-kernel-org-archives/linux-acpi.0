From: Johan Vromans <jvromans@squirrel.nl>
Subject: RFC [PATCH] acpi: allow SMBus access
Date: Sun, 2 Jul 2006 23:12:21 +0200
Message-ID: <17576.14005.767262.868190@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:52239 "EHLO
	smtp-vbr3.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750843AbWGBVMX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 2 Jul 2006 17:12:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

From: Johan Vromans <jvromans@squirrel.nl>

To get battery readings on some laptops it is necessary to interface
with the SMBus that hangs of the EC. However, the current
implementation of the EC driver does not permit other modules
read/write access.

A trivial solution is to change acpi_ec_read/write from static to
nonstatic, and export the symbols so other modules can use them.

This patch is based on the current 2.6.17 kernel sources.

Signed-off-by: Johan Vromans <jvromans@squirrel.nl>
---

--- linux-2.6.17.i686/drivers/acpi/ec.c.orig	2006-07-02 22:46:35.000000000 +0200
+++ linux-2.6.17.i686/drivers/acpi/ec.c	2006-06-27 10:03:19.000000000 +0200
@@ -305,20 +305,22 @@ end:
 }
 #endif /* ACPI_FUTURE_USAGE */
 
-static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
+int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
 {
 	if (acpi_ec_poll_mode)
 		return acpi_ec_poll_read(ec, address, data);
 	else
 		return acpi_ec_intr_read(ec, address, data);
 }
-static int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
+EXPORT_SYMBOL(acpi_ec_read);
+int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
 {
 	if (acpi_ec_poll_mode)
 		return acpi_ec_poll_write(ec, address, data);
 	else
 		return acpi_ec_intr_write(ec, address, data);
 }
+EXPORT_SYMBOL(acpi_ec_write);
 static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, u32 * data)
 {
 	acpi_status status = AE_OK;

-- 
Johan
