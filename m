From: Dave Jones <davej@redhat.com>
Subject: remove P2B-S from blacklist.
Date: Wed, 6 Jun 2007 03:34:07 -0400
Message-ID: <20070606073407.GA1010@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48708 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725AbXFFHeU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Jun 2007 03:34:20 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l567YJUc012647
	for <linux-acpi@vger.kernel.org>; Wed, 6 Jun 2007 03:34:19 -0400
Received: from gelk.kernelslacker.org (vpn-248-11.boston.redhat.com [10.13.248.11])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l567YEIv009871
	for <linux-acpi@vger.kernel.org>; Wed, 6 Jun 2007 03:34:17 -0400
Received: from gelk.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by gelk.kernelslacker.org (8.14.1/8.13.8) with ESMTP id l567Y9Gb001024
	for <linux-acpi@vger.kernel.org>; Wed, 6 Jun 2007 03:34:09 -0400
Received: (from davej@localhost)
	by gelk.kernelslacker.org (8.14.1/8.14.1/Submit) id l567Y7b1001023
	for linux-acpi@vger.kernel.org; Wed, 6 Jun 2007 03:34:07 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

According to http://bugzilla.kernel.org/show_bug.cgi?id=6933
The latest BIOS for the P2B-S works fine.
Remove it from the blacklist.

Signed-off-by: Dave Jones <davej@redhat.com>

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 3ec110c..7c24a8d 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -67,8 +67,6 @@ static struct acpi_blacklist_item acpi_blacklist[] __initdata = {
 	/* IBM 600E - _ADR should return 7, but it returns 1 */
 	{"IBM   ", "TP600E  ", 0x00000105, ACPI_SIG_DSDT, less_than_or_equal,
 	 "Incorrect _ADR", 1},
-	{"ASUS\0\0", "P2B-S   ", 0, ACPI_SIG_DSDT, all_versions,
-	 "Bogus PCI routing", 1},
 
 	{""}
 };
-- 
http://www.codemonkey.org.uk
