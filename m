From: Len Brown <lenb@kernel.org>
Subject: [PATCH 38/42] ACPI: Make sure the FADT is at least rev 2 before using
 the reset register
Date: Wed, 23 Mar 2011 02:42:51 -0400
Message-ID: <95cf3e12e7f659e536215b37c67d46f3e2ce95cc.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37003 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab1CWHHf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:35 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:35 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg@redhat.com>

The reset register was only introduced with version 2 of the FADT, so we
should check that the FADT revision before trusting its contents.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/reboot.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index 4870aaa..a6c77e8b 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -15,6 +15,11 @@ void acpi_reboot(void)
 
 	rr = &acpi_gbl_FADT.reset_register;
 
+	/* ACPI reset register was only introduced with v2 of the FADT */
+
+	if (acpi_gbl_FADT.header.revision < 2)
+		return;
+
 	/* Is the reset register supported? The spec says we should be
 	 * checking the bit width and bit offset, but Windows ignores
 	 * these fields */
-- 
1.7.4.1.343.ga91df

