From: Holger Macht <hmacht@suse.de>
Subject: [PATCH] ACPI: Set flag DOCK_UNDOCKING when triggered via sysfs
Date: Wed, 12 Mar 2008 01:07:27 +0100
Message-ID: <20080312000727.GB4089@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:44793 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbYCLAFy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 20:05:54 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>

begin_undock() is only called when triggered via a acpi notify handler
(pressing the undock button on the dock station), but complete_undock() is
always called after the eject. So if a undock is triggered through a sysfs
write, the flag DOCK_UNDOCKING has to be set for the dock station,
too. Otherwise this will freeze the system hard.

Signed-off-by: Holger Macht <hmacht@suse.de>
---

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 307cef6..fa44fb9 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -710,6 +710,7 @@ static ssize_t write_undock(struct device *dev, struct device_attribute *attr,
 	if (!count)
 		return -EINVAL;
 
+	begin_undock(dock_station);
 	ret = handle_eject_request(dock_station, ACPI_NOTIFY_EJECT_REQUEST);
 	return ret ? ret: count;
 }

