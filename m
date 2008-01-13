From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/6] sony-laptop for 2.6.25
Date: Sun, 13 Jan 2008 13:12:28 +0900
Message-ID: <1200197554-9598-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mfbichi11.ns.itscom.net ([219.110.2.189]:64133 "EHLO
	mfbichi11.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYAMG7f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Jan 2008 01:59:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi Len,

finally had some time to update the sony-laptop driver.
Apologies for not removing acpi_bus_generate_genetlink_event from
the irq handler... but I didn't forget about that at least.

 drivers/misc/sony-laptop.c |  485 ++++++++++++++++++++++++++-------------------
 include/linux/sonypi.h     |    2 
 2 files changed, 286 insertions(+), 201 deletions(-)

-- 
mattia
