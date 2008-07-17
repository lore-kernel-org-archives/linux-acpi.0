From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 07/11] fujitsu-laptop: Fix section mismatch
Date: Thu, 17 Jul 2008 19:32:11 +0200
Message-ID: <1216315935-20998-8-git-send-email-trenn@suse.de>
References: <1216315935-20998-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:39667 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757199AbYGQRcR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 13:32:17 -0400
In-Reply-To: <1216315935-20998-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/misc/fujitsu-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/fujitsu-laptop.c b/drivers/misc/fujitsu-laptop.c
index 4f873cb..754ec38 100644
--- a/drivers/misc/fujitsu-laptop.c
+++ b/drivers/misc/fujitsu-laptop.c
@@ -455,7 +455,7 @@ static int dmi_check_cb_s6410(const struct dmi_system_id *id)
 	return 0;
 }
 
-static struct dmi_system_id __initdata fujitsu_dmi_table[] = {
+static struct dmi_system_id fujitsu_dmi_table[] = {
 	{
 	 .ident = "Fujitsu Siemens",
 	 .matches = {
-- 
1.5.4.5

