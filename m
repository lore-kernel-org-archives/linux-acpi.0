From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/5] ACPI / PM: Make suspend_nvs_save() use
 acpi_os_map_memory()
Date: Fri, 07 Jan 2011 01:02:31 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101070100160.20858@x980>
References: <201101070141.02951.rjw@sisk.pl> <201101070145.58907.rjw@sisk.pl>
 <alpine.LFD.2.02.1101070045150.20858@x980>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:52620 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab1AGGCg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Jan 2011 01:02:36 -0500
In-reply-to: <alpine.LFD.2.02.1101070045150.20858@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jirislaby@gmail.com>

> my arrandale laptop took multiple OOPS on resume after this patch.

This bit makes my laptop happy, so I'll add it to this patch.

thanks,
-Len

diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
index 8e7ab5e..54b6ab8 100644
--- a/drivers/acpi/nvs.c
+++ b/drivers/acpi/nvs.c
@@ -80,7 +80,7 @@ void suspend_nvs_free(void)
 			free_page((unsigned long)entry->data);
 			entry->data = NULL;
 			if (entry->kaddr) {
-				iounmap(entry->kaddr);
+				acpi_os_unmap_memory(entry->kaddr, entry->size);
 				entry->kaddr = NULL;
 			}
 		}


