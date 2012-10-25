From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] acpi: compare of array
Date: Thu, 25 Oct 2012 15:57:50 +0100
Message-ID: <20121025145746.17558.59853.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53826 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933068Ab2JYO4Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Oct 2012 10:56:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@linux.intel.com, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

This serves no purpose as it's an array not a pointer

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/acpi/event.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 1442737..f84df83 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -67,8 +67,7 @@ acpi_system_read_event(struct file *file, char __user * buffer, size_t count,
 			return result;
 
 		chars_remaining = sprintf(str, "%s %s %08x %08x\n",
-					  event.device_class ? event.
-					  device_class : "<unknown>",
+					  event.device_class : "<unknown>",
 					  event.bus_id ? event.
 					  bus_id : "<unknown>", event.type,
 					  event.data);

