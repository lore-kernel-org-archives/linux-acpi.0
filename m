From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] APEI: Fix WHEA _OSC call
Date: Thu, 11 Aug 2011 12:06:28 -0400
Message-ID: <1313078788-9085-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29703 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178Ab1HKQGj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Aug 2011 12:06:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, Stuart_Hayes@Dell.com, dzickus@redhat.com, Matthew Garrett <mjg@redhat.com>

Bit 0 of the support parameter to the OSC call should be set in order to
indicate that the OS supports the WHEA mechanism. Stuart Hayes tracked
an APEI issue on some Dell platforms down to this.

Reported-by: Stuart Hayes <Stuart_Hayes@Dell.com>
Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/apei/apei-base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 8041248..6154036 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -618,7 +618,7 @@ int apei_osc_setup(void)
 	};
 
 	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	capbuf[OSC_SUPPORT_TYPE] = 0;
+	capbuf[OSC_SUPPORT_TYPE] = 1;
 	capbuf[OSC_CONTROL_TYPE] = 0;
 
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle))
-- 
1.7.6

