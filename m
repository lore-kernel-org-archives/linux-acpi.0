From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI: suspend: consolidate handling of Sx states addendum
Date: Fri, 21 Sep 2007 16:47:24 +0200
Message-ID: <200709211647.24861.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43280 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760401AbXIUOes (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Sep 2007 10:34:48 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Frans Pop <elendil@planet.nl>, Andrew Morton <akpm@linux-foundation.org>

From: Frans Pop <elendil@planet.nl>
Date:   Thu Sep 20 22:27:44 2007 +0200

Make the S0 state be always reported as supported

Signed-off: Frans Pop <elendil@planet.nl>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.23-rc7/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.23-rc7.orig/drivers/acpi/sleep/main.c
+++ linux-2.6.23-rc7/drivers/acpi/sleep/main.c
@@ -424,9 +424,11 @@ int __init acpi_sleep_init(void)
 	if (acpi_disabled)
 		return 0;
 
-printk(KERN_INFO PREFIX "(supports");
+	sleep_states[ACPI_STATE_S0] = 1;
+	printk(KERN_INFO PREFIX "(supports S0");
+
 #ifdef CONFIG_SUSPEND
-	for (i = ACPI_STATE_S0; i < ACPI_STATE_S4; i++) {
+	for (i = ACPI_STATE_S1; i < ACPI_STATE_S4; i++) {
 		status = acpi_get_sleep_type_data(i, &type_a, &type_b);
 		if (ACPI_SUCCESS(status)) {
 			sleep_states[i] = 1;
