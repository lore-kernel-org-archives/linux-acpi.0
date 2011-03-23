From: Len Brown <lenb@kernel.org>
Subject: [PATCH 36/42] ACPICA: Fix access width for reset vector
Date: Wed, 23 Mar 2011 02:42:49 -0400
Message-ID: <f17d9cbf20c4734c4199caa6dee87047f2f8278f.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37008 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab1CWHHh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:37 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:36 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg@redhat.com>

Section 4.7.3.6 of the ACPI specification requires that the register width
of the reset vector be 8 bits. Windows simply hardcodes the access to be
a byte and ignores the width provided in the FADT, so make sure that we
do the same.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwxface.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 6f98d21..f75f81a 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -80,14 +80,14 @@ acpi_status acpi_reset(void)
 
 	if (reset_reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		/*
-		 * For I/O space, write directly to the OSL. This bypasses the port
-		 * validation mechanism, which may block a valid write to the reset
-		 * register.
+		 * For I/O space, write directly to the OSL. This
+		 * bypasses the port validation mechanism, which may
+		 * block a valid write to the reset register. Spec
+		 * section 4.7.3.6 requires register width to be 8.
 		 */
 		status =
 		    acpi_os_write_port((acpi_io_address) reset_reg->address,
-				       acpi_gbl_FADT.reset_value,
-				       reset_reg->bit_width);
+				       acpi_gbl_FADT.reset_value, 8);
 	} else {
 		/* Write the reset value to the reset register */
 
-- 
1.7.4.1.343.ga91df

