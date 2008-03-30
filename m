From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI: Be more careful about returning errors from acpi_power_resume()
Date: Sun, 30 Mar 2008 16:15:06 +0200
Message-ID: <200803301615.06972.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34683 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbYC3OPN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Mar 2008 10:15:13 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

Hi,

I have a problem with acpi_power_resume() and the patch introducing the new
callbacks for suspend/hibernation:

http://marc.info/?l=linux-kernel&m=120684588424639&w=4

Namely, this patch also changes the behavior of the PM core wrt errors returned
by drivers' ->resume() callbacks in such a way that if an error is returned by
one of them, the devices is regarded as "invalid" by the PM core and won't be
suspended etc.

OTOH, acpi_power_resume() apparently returns errors in situations which are
perfectly recoverable.  Namely, it may return an error if it attempts to turn a
power resource on, which appears to be successful (ie.
acpi_evaluate_object(resource->device->handle, "_ON", NULL, NULL) returns 0),
but the state of the resource returned by acpi_power_get_state() called
subsequently is not ACPI_POWER_RESOURCE_STATE_ON.  However, on
my nx6325 this only means that the platform firmware's idea about the state
the power resource should be in is different than ours.  Thus, apparently,
acpi_power_resume() shouldn't return errors in such cases.

Moreover, having looked at acpi_power_resume() I understand that it's supposed
to try to turn the power resource on, if it references any device.  If that is
correct, acpi_power_resume() doesn't really need to call acpi_power_on()
and it may use acpi_evaluate_object() on a power resource directly if that
resource references at least one device.  This makes it possible to handle
errors in acpi_power_resume() more carefully, which is implemented by the
appended patch.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

Modify acpi_power_resume() so that it doesn't return errors unnecessarily.

This doesn't make a real difference with the current PM core code (the errors
returned by acpi_power_resume() are ignored anyway), but in the future it may
cause problems if acpi_power_resume() returns an error code that it shouldn't
return.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/power.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/acpi/power.c
===================================================================
--- linux-2.6.orig/drivers/acpi/power.c
+++ linux-2.6/drivers/acpi/power.c
@@ -665,7 +665,7 @@ static int acpi_power_resume(struct acpi
 {
 	int result = 0, state;
 	struct acpi_power_resource *resource = NULL;
-	struct acpi_power_reference *ref;
+	acpi_status status = AE_UNKNOWN_STATUS;
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
@@ -679,13 +679,28 @@ static int acpi_power_resume(struct acpi
 	mutex_lock(&resource->resource_lock);
 	if (state == ACPI_POWER_RESOURCE_STATE_OFF &&
 	    !list_empty(&resource->reference)) {
-		ref = container_of(resource->reference.next, struct acpi_power_reference, node);
-		mutex_unlock(&resource->resource_lock);
-		result = acpi_power_on(device->handle, ref->device);
-		return result;
+		/* Try to turn the power resource on. */
+		status = acpi_evaluate_object(resource->device->handle,
+						"_ON", NULL, NULL);
+		if (ACPI_FAILURE(status))
+			printk(KERN_WARNING PREFIX
+				"Failed to turn power resource %s [%s] on\n",
+				acpi_device_name(device),
+				acpi_device_bid(device));
 	}
-
 	mutex_unlock(&resource->resource_lock);
+	if (ACPI_SUCCESS(status)) {
+		result = acpi_power_get_state(resource, &state);
+		if (!result && state == ACPI_POWER_RESOURCE_STATE_ON) {
+			/* Update the power resource's _device_ power state */
+			resource->device->power.state = ACPI_STATE_D0;
+
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					"Resource [%s] turned on\n",
+					resource->name));
+		}
+	}
+
 	return 0;
 }
 

