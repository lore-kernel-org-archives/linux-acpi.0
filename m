From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / resources: Change pr_info() to pr_debug() for debug information
Date: Wed, 18 Feb 2015 07:20:46 +0100
Message-ID: <7237946.IUPQ258J4L@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57933 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750783AbbBRF5d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Feb 2015 00:57:33 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Jiang Liu <jiang.liu@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Annoying and noisy ACPI debug messages are printed with pr_info()
after the recent ACPI resources handling rework.  Replace the
pr_info() with pr_debug() to reduce to noise level.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/resource.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/resource.c
===================================================================
--- linux-pm.orig/drivers/acpi/resource.c
+++ linux-pm/drivers/acpi/resource.c
@@ -46,7 +46,7 @@ static bool acpi_dev_resource_len_valid(
 	if (len && reslen && reslen == len && start <= end)
 		return true;
 
-	pr_info("ACPI: invalid or unassigned resource %s [%016llx - %016llx] length [%016llx]\n",
+	pr_debug("ACPI: invalid or unassigned resource %s [%016llx - %016llx] length [%016llx]\n",
 		io ? "io" : "mem", start, end, len);
 
 	return false;

