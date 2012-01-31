From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 1/2] ACPI: export acpi_kobj
Date: Tue, 31 Jan 2012 11:39:49 -0500
Message-ID: <1328027990-3437-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63818 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627Ab2AaQk2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Jan 2012 11:40:28 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Matthew Garrett <mjg@redhat.com>

Drivers may wish to add entries to /sys/firmware/acpi, so export acpi_kobj
in order to let them do that.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/bus.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9ecec98..3263b68 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1010,6 +1010,7 @@ static int __init acpi_bus_init(void)
 }
 
 struct kobject *acpi_kobj;
+EXPORT_SYMBOL_GPL(acpi_kobj);
 
 static int __init acpi_init(void)
 {
-- 
1.7.1

