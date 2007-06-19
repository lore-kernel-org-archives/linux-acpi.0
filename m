From: "Andreas Herrmann" <andreas.herrmann3@amd.com>
Subject: [PATCH 7/12] acpi: fix another compile warning
Date: Wed, 20 Jun 2007 00:50:35 +0200
Message-ID: <20070619225035.GI5193@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:5757 "EHLO
	outbound2-dub-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754430AbXFSWuJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2007 18:50:09 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Avoid compile warning if !ACPI_BLACKLIST_YEAR

  CC      drivers/acpi/blacklist.o
  drivers/acpi/blacklist.c:76:5: warning: "CONFIG_ACPI_BLACKLIST_YEAR" is not defined

Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/acpi/blacklist.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 3ec110c..ac96c47 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -73,7 +73,7 @@ static struct acpi_blacklist_item acpi_blacklist[] __initdata = {
 	{""}
 };
 
-#if	CONFIG_ACPI_BLACKLIST_YEAR
+#if	defined(CONFIG_ACPI_BLACKLIST_YEAR) && CONFIG_ACPI_BLACKLIST_YEAR
 
 static int __init blacklist_by_year(void)
 {
-- 
1.5.0.7




