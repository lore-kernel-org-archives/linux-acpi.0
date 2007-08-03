From: Len Brown <len.brown@intel.com>
Subject: [PATCH 03/12] sony-laptop: sony_nc_ids[] can become static.
Date: Fri,  3 Aug 2007 18:33:36 -0400
Message-ID: <11861804274061-git-send-email-len.brown@intel.com>
References: <11861804251625-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26189 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763673AbXHCWdt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 18:33:49 -0400
In-Reply-To: <11861804251625-git-send-email-len.brown@intel.com>
Message-Id: <11604ecf6fb9c2ab0152fbddb7ea2724438ef76e.1186180370.git.len.brown@intel.com>
In-Reply-To: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
References: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@stusta.de>

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 9a803e1..91da688 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -845,7 +845,7 @@ static struct sony_nc_event sony_C_events[] = {
 };
 
 /* SNC-only model map */
-struct dmi_system_id sony_nc_ids[] = {
+static struct dmi_system_id sony_nc_ids[] = {
 		{
 			.ident = "Sony Vaio FE Series",
 			.callback = sony_nc_C_enable,
-- 
1.5.3.rc3.7.gd58e
