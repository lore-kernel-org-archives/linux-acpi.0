From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / SBS: Fix check in acpi_ac_get_present()
Date: Sun, 28 Sep 2014 01:28:43 +0200
Message-ID: <1539043.bcCaecDElK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54850 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753224AbaI0XIv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Sep 2014 19:08:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, Andreas Noever <andreas.noever@gmail.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Parentheses are missing under an if () statement in
acpi_ac_get_present() which makes the check work differently
from what was intended (at least according to the comment right
above it).  Add the missing parens.

The problem was found by sparse.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/sbs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sbs.c
+++ linux-pm/drivers/acpi/sbs.c
@@ -441,7 +441,7 @@ static int acpi_ac_get_present(struct ac
 	 * The spec requires that bit 4 always be 1. If it's not set, assume
 	 * that the implementation doesn't support an SBS charger
 	 */
-	if (!(status >> 4) & 0x1)
+	if (!((status >> 4) & 0x1))
 		return -ENODEV;
 
 	sbs->charger_present = (status >> 15) & 0x1;

