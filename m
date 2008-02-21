From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/26] ACPI: remove is_processor_present prototype
Date: Thu, 21 Feb 2008 04:25:33 -0500
Message-ID: <e85ff4b53eb4252d967922bd75cb6d10863955f3.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36627 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756990AbYBUJ3T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:19 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Glauber Costa <gcosta@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Glauber Costa <gcosta@redhat.com>

The function itself is defined just below, so this prototype is not really
useful.

Signed-off-by: Glauber Costa <gcosta@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 75ccf5d..923fddb 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -826,8 +826,6 @@ static int acpi_processor_remove(struct acpi_device *device, int type)
  * 	Acpi processor hotplug support 				       	    *
  ****************************************************************************/
 
-static int is_processor_present(acpi_handle handle);
-
 static int is_processor_present(acpi_handle handle)
 {
 	acpi_status status;
-- 
1.5.4.2

