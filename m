From: Len Brown <lenb@kernel.org>
Subject: [PATCH 076/122] ACPI: Fix possible null ptr dereference
Date: Thu, 23 Oct 2008 02:38:50 -0400
Message-ID: <383d7a11c9989205db44c7f1be339e5097062f03.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:62933 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbYJWGkV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:21 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172071.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K960072AIIX8LC1@vms172071.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:10 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "donald.d.dugger@intel.com" <donald.d.dugger@intel.com>, Len Brown <len.brown@intel.com>

From: donald.d.dugger@intel.com <donald.d.dugger@intel.com>

Code in `pci_link.c' is calling the internal routine `acpi_ut_evaluate_object'
which is dangerous given that it is passing a NULL pointer when it should
be passing a pointer to a real object.  The patch corrects the issue by
having the code call the external routine `acpi_evaluate_object', which
correctly handles a NULL pointer.

Signed-off-by: Don Dugger <donald.d.dugger@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_link.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index cf47805..65bf4fa 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -709,7 +709,7 @@ int acpi_pci_link_free_irq(acpi_handle handle)
 			  acpi_device_bid(link->device)));
 
 	if (link->refcnt == 0) {
-		acpi_ut_evaluate_object(link->device->handle, "_DIS", 0, NULL);
+		acpi_evaluate_object(link->device->handle, "_DIS", NULL, NULL);
 	}
 	mutex_unlock(&acpi_link_lock);
 	return (link->irq.active);
@@ -773,7 +773,7 @@ static int acpi_pci_link_add(struct acpi_device *device)
 
       end:
 	/* disable all links -- to be activated on use */
-	acpi_ut_evaluate_object(device->handle, "_DIS", 0, NULL);
+	acpi_evaluate_object(device->handle, "_DIS", NULL, NULL);
 	mutex_unlock(&acpi_link_lock);
 
 	if (result)
-- 
1.5.5.1

