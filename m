From: Holger Macht <hmacht@suse.de>
Subject: [PATCH] bay: Exit if notify handler cannot be installed
Date: Mon, 5 May 2008 22:25:08 +0200
Message-ID: <20080505202508.GA3690@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59364 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978AbYEEUW7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 May 2008 16:22:59 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com

If acpi_install_notify_handler() for a bay device fails, the bay driver is
superfluous. Most likely, another driver (like libata) is already caring
about this device anyway. Furthermore,
register_hotplug_dock_device(acpi_handle) from the dock driver must not be
called twice with the same handler. So clean up and exit.

Signed-off-by: Holger Macht <hmacht@suse.de>
---

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index d2fc941..ce9038f 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -311,6 +311,7 @@ static int bay_add(acpi_handle handle, int id)
 			bay_notify, new_bay);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Error installing bay notify handler\n");
+		goto bay_add_err;
 	}
 
 	/* if we are on a dock station, we should register for dock

