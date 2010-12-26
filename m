From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / ACPICA: Disable GPEs during initialization
Date: Sun, 26 Dec 2010 12:47:06 +0100
Message-ID: <201012261247.06858.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52375 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004Ab0LZLrc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Dec 2010 06:47:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

GPEs with corresponding _Lxx/_Exx control methods need to be disabled
during initialization in case they have been enabled by the BIOS, so
that they don't fire up until they are enabled by acpi_update_gpes().

References: https://bugzilla.kernel.org/show_bug.cgi?id=25412
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/evgpeinit.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/acpi/acpica/evgpeinit.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeinit.c
+++ linux-2.6/drivers/acpi/acpica/evgpeinit.c
@@ -408,6 +408,9 @@ acpi_ev_match_gpe_method(acpi_handle obj
 		return_ACPI_STATUS(AE_OK);
 	}
 
+	/* Disable the GPE in case it's been enabled already. */
+	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
+
 	/*
 	 * Add the GPE information from above to the gpe_event_info block for
 	 * use during dispatch of this GPE.
