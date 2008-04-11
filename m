From: akpm@linux-foundation.org
Subject: [patch for 2.6.25? 2/3] acpi: bus: check once more for an empty list after locking it
Date: Thu, 10 Apr 2008 21:30:15 -0700
Message-ID: <200804110430.m3B4UFLb000417@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60668 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750729AbYDKEas (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Apr 2008 00:30:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, cebbert@redhat.com, stable@kernel.org

From: Chuck Ebbert <cebbert@redhat.com>

List could have become empty after the unlocked check that was made earlier,
so check again inside the lock.

Should fix https://bugzilla.redhat.com/show_bug.cgi?id=427765

Signed-off-by: Chuck Ebbert <cebbert@redhat.com>
Cc: <stable@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/bus.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/bus.c~acpi-bus-check-once-more-for-an-empty-list-after-locking-it drivers/acpi/bus.c
--- a/drivers/acpi/bus.c~acpi-bus-check-once-more-for-an-empty-list-after-locking-it
+++ a/drivers/acpi/bus.c
@@ -373,10 +373,11 @@ int acpi_bus_receive_event(struct acpi_b
 	}
 
 	spin_lock_irqsave(&acpi_bus_event_lock, flags);
-	entry =
-	    list_entry(acpi_bus_event_list.next, struct acpi_bus_event, node);
-	if (entry)
+	if (!list_empty(&acpi_bus_event_list)) {
+		entry = list_entry(acpi_bus_event_list.next,
+				   struct acpi_bus_event, node);
 		list_del(&entry->node);
+	}
 	spin_unlock_irqrestore(&acpi_bus_event_lock, flags);
 
 	if (!entry)
_
