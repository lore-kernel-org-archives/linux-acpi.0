From: akpm@linux-foundation.org
Subject: [patch 5/6] make drivers/acpi/event.c:acpi_event_seqnum static
Date: Fri, 10 Aug 2007 13:45:18 -0700
Message-ID: <200708102045.l7AKjIqf007833@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54610 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765575AbXHJUqV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Aug 2007 16:46:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, bunk@stusta.de

From: Adrian Bunk <bunk@stusta.de>

This patch makes the needlessly global "acpi_event_seqnum" static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/event.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/event.c~make-drivers-acpi-eventcacpi_event_seqnum-static drivers/acpi/event.c
--- a/drivers/acpi/event.c~make-drivers-acpi-eventcacpi_event_seqnum-static
+++ a/drivers/acpi/event.c
@@ -108,7 +108,7 @@ static const struct file_operations acpi
 };
 
 #ifdef CONFIG_NET
-unsigned int acpi_event_seqnum;
+static unsigned int acpi_event_seqnum;
 struct acpi_genl_event {
 	acpi_device_class device_class;
 	char bus_id[15];
_
