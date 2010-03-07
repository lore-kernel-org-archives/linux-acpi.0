From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 2/3] ACPI / ACPICA: Fix locking in acpi_remove_gpe_handler()
Date: Mon, 8 Mar 2010 00:36:08 +0100
Message-ID: <201003080036.08248.rjw@sisk.pl>
References: <201003080034.11053.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58351 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063Ab0CGXfF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Mar 2010 18:35:05 -0500
In-Reply-To: <201003080034.11053.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

The releasing of ACPI_MTX_EVENTS in the middle of
acpi_remove_gpe_handler() in order to call
acpi_os_wait_events_complete() is a mistake, because it creates a
window for undesirable concurrent changes to be made while
acpi_os_wait_events_complete() is being executed.  At the same
time it doesn't make any difference to call
acpi_os_wait_events_complete() before acquiring ACPI_MTX_EVENTS for
the first time, which allows us to avoid the race condition.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/evxface.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/evxface.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxface.c
+++ linux-2.6/drivers/acpi/acpica/evxface.c
@@ -842,6 +842,10 @@ acpi_remove_gpe_handler(acpi_handle gpe_
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
+	/* Make sure all deferred tasks are completed */
+
+	acpi_os_wait_events_complete(NULL);
+
 	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
@@ -870,15 +874,6 @@ acpi_remove_gpe_handler(acpi_handle gpe_
 		goto unlock_and_exit;
 	}
 
-	/* Make sure all deferred tasks are completed */
-
-	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
-	acpi_os_wait_events_complete(NULL);
-	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	/* Remove the handler */
 
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);

