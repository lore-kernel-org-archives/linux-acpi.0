From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/15] ACPI / PM: Do not refcount power resources that can't be
 turned on
Date: Sat, 11 Dec 2010 02:06:27 -0500
Message-ID: <12b3b5afed67e08aa641d30e57df20dab2e33432.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:42799 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab0LKHGy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:06:54 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD900IKN53E7OK4@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:06:51 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

If turning on a power resource fails, do not reference count it,
since it cannot be in use in that case.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 792a830..4c9c2fb 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -213,11 +213,13 @@ static int acpi_power_on(acpi_handle handle)
 				  resource->name));
 	} else {
 		result = __acpi_power_on(resource);
+		if (result)
+			resource->ref_count--;
 	}
 
 	mutex_unlock(&resource->resource_lock);
 
-	return 0;
+	return result;
 }
 
 static int acpi_power_off_device(acpi_handle handle)
-- 
1.7.3.3.480.g2f76a

