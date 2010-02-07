From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 2/3] ACPI: Modify GPE consumers to use GPE refcounting
Date: Sun, 7 Feb 2010 03:23:53 +0100
Message-ID: <201002070323.53144.rjw@sisk.pl>
References: <4911F71203A09E4D9981D27F9D83085855AF782E@orsmsx503.amr.corp.intel.com> <201002070031.54680.rjw@sisk.pl> <201002070317.47029.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53138 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884Ab0BGCYx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 6 Feb 2010 21:24:53 -0500
In-Reply-To: <201002070317.47029.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Add GPE refcounting support to the existing GPE users.  This will
currently do little until the core is changed over to use the new
behaviour.

Based on a patch from Matthew Garrett <mjg@redhat.com>.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
drivers/acpi/button.c |   12 ++++++++++++
 drivers/acpi/button.c |   10 ++++++++++
 drivers/acpi/ec.c     |    4 +++-
 drivers/acpi/wakeup.c |   10 ++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/button.c
===================================================================
--- linux-2.6.orig/drivers/acpi/button.c
+++ linux-2.6/drivers/acpi/button.c
@@ -427,6 +427,9 @@ static int acpi_button_add(struct acpi_d
 				  ACPI_GPE_TYPE_WAKE_RUN);
 		acpi_enable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
+		acpi_get_gpe(device->wakeup.gpe_device,
+				device->wakeup.gpe_number,
+				ACPI_GPE_TYPE_WAKE_RUN);
 		device->wakeup.state.enabled = 1;
 	}
 
@@ -446,6 +449,13 @@ static int acpi_button_remove(struct acp
 {
 	struct acpi_button *button = acpi_driver_data(device);
 
+	if (device->wakeup.flags.valid) {
+		acpi_put_gpe(device->wakeup.gpe_device,
+				device->wakeup.gpe_number,
+				ACPI_GPE_TYPE_WAKE_RUN);
+		device->wakeup.state.enabled = 0;
+	}
+
 	acpi_button_remove_fs(device);
 	input_unregister_device(button->input);
 	kfree(button);
Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -789,7 +789,7 @@ static int ec_install_handlers(struct ac
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
-	acpi_enable_gpe(NULL, ec->gpe);
+	acpi_get_gpe(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
 	status = acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
@@ -806,6 +806,7 @@ static int ec_install_handlers(struct ac
 		} else {
 			acpi_remove_gpe_handler(NULL, ec->gpe,
 				&acpi_ec_gpe_handler);
+			acpi_put_gpe(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
 			return -ENODEV;
 		}
 	}
@@ -816,6 +817,7 @@ static int ec_install_handlers(struct ac
 
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
+	acpi_put_gpe(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err(PREFIX "failed to remove space handler\n");
Index: linux-2.6/drivers/acpi/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/acpi/wakeup.c
+++ linux-2.6/drivers/acpi/wakeup.c
@@ -78,9 +78,15 @@ void acpi_enable_wakeup_device(u8 sleep_
 			}
 			continue;
 		}
+		/*
+		 * If the device is run_wake, the GPE is supposed to be enabled,
+		 * so we don't need to enable it once again.
+		 */
 		if (!dev->wakeup.flags.run_wake)
 			acpi_enable_gpe(dev->wakeup.gpe_device,
 					dev->wakeup.gpe_number);
+		acpi_get_gpe(dev->wakeup.gpe_device,
+				dev->wakeup.gpe_number, ACPI_GPE_TYPE_WAKE);
 	}
 }
 
@@ -121,6 +127,8 @@ void acpi_disable_wakeup_device(u8 sleep
 			acpi_clear_gpe(dev->wakeup.gpe_device,
 				       dev->wakeup.gpe_number, ACPI_NOT_ISR);
 		}
+		acpi_put_gpe(dev->wakeup.gpe_device,
+				dev->wakeup.gpe_number, ACPI_GPE_TYPE_WAKE);
 	}
 }
 
@@ -141,6 +149,8 @@ int __init acpi_wakeup_device_init(void)
 				  ACPI_GPE_TYPE_WAKE_RUN);
 		acpi_enable_gpe(dev->wakeup.gpe_device,
 				dev->wakeup.gpe_number);
+		acpi_get_gpe(dev->wakeup.gpe_device,
+				dev->wakeup.gpe_number, ACPI_GPE_TYPE_WAKE);
 		dev->wakeup.state.enabled = 1;
 	}
 	mutex_unlock(&acpi_device_lock);

