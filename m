From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/60] ACPICA: Clear PCIEXP_WAKE_STS when clearing ACPI events
Date: Mon, 25 Oct 2010 02:20:41 -0400
Message-ID: <49b3c1e04e1dd3cd9a428b0d8367193b73e472c1.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:38313 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab0JYJLH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 05:11:07 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU004W59ICTPC0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 04:11:07 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Colin Ian King <colin.king@canonical.com>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Colin Ian King <colin.king@canonical.com>

When clearing status bits via acpi_hw_clear_acpi_status, also clear
the PCIEXP_WAKE_STS bit. Original change from Colin King.
ACPICA BZ 880.

http://www.acpica.org/bugzilla/show_bug.cgi?id=880
http://bugs.launchpad.net/bugs/613381

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 1bb18c0..8acf1e8 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -854,6 +854,7 @@ struct acpi_bit_register_info {
 	ACPI_BITMASK_POWER_BUTTON_STATUS   | \
 	ACPI_BITMASK_SLEEP_BUTTON_STATUS   | \
 	ACPI_BITMASK_RT_CLOCK_STATUS       | \
+	ACPI_BITMASK_PCIEXP_WAKE_STATUS    | \
 	ACPI_BITMASK_WAKE_STATUS)
 
 #define ACPI_BITMASK_TIMER_ENABLE               0x0001
-- 
1.7.3.2.90.gd4c43

