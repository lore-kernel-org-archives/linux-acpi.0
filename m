From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/11] pnpacpi: __initdata is not an identifier
Date: Thu, 14 Feb 2008 02:02:30 -0500
Message-ID: <6bf69b5ebf22f8f5b4551bad688979fe29049126.1202972422.git.len.brown@intel.com>
References: <1202972552-17953-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:21951 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756354AbYBNHKo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 02:10:44 -0500
In-Reply-To: <1202972552-17953-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
References: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Roel Kluin <12o3l@tiscali.nl>, Len Brown <len.brown@intel.com>

From: Roel Kluin <12o3l@tiscali.nl>

sparse complains at drivers/pnp/pnpacpi/core.c:39 with the error:
Trying to use reserved word '__attribute__' as identifier
Expected ) in function declarator, got ".init.data"

and at drivers/pnp/pnpacpi/core.c:49:38 with the error:
undefined identifier 'excluded_id_list'

With the patch below these sparse complaints do not occur

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 662b4c2..c283a9a 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -36,7 +36,7 @@ static int num = 0;
  * have irqs (PIC, Timer) because we call acpi_register_gsi.
  * Finally, only devices that have a CRS method need to be in this list.
  */
-static struct __initdata acpi_device_id excluded_id_list[] = {
+static struct acpi_device_id excluded_id_list[] __initdata = {
 	{"PNP0C09", 0},		/* EC */
 	{"PNP0C0F", 0},		/* Link device */
 	{"PNP0000", 0},		/* PIC */
-- 
1.5.4.1.122.gaa8d

