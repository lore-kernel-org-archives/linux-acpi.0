From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/3] ACPI: Add support for new refcounted GPE API to drivers
Date: Mon,  9 Nov 2009 17:29:15 -0500
Message-ID: <1257805756-6490-2-git-send-email-mjg@redhat.com>
References: <20091109222003.GA3424@srcf.ucam.org>
 <1257805756-6490-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50745 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbZKIW3f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2009 17:29:35 -0500
In-Reply-To: <1257805756-6490-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com
Cc: ming.m.lin@intel.com, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>

Add GPE refcounting support to ACPI drivers that need it. This will
currently do little until the core is changed over to use the new
behaviour.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/button.c |   12 ++++++++++++
 drivers/acpi/ec.c     |    4 +++-
 drivers/acpi/wakeup.c |    6 ++++++
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 0c9c6a9..a9c7b1f 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -420,6 +420,10 @@ static int acpi_button_add(struct acpi_device *device)
 				  ACPI_GPE_TYPE_WAKE_RUN);
 		acpi_enable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
+		acpi_ref_runtime_gpe(device->wakeup.gpe_device,
+				     device->wakeup.gpe_number);
+		acpi_ref_wakeup_gpe(device->wakeup.gpe_device,
+				    device->wakeup.gpe_number);
 		device->wakeup.state.enabled = 1;
 	}
 
@@ -439,6 +443,14 @@ static int acpi_button_remove(struct acpi_device *device, int type)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 
+	if (device->wakeup.flags.valid) {
+		acpi_unref_runtime_gpe(device->wakeup.gpe_device,
+			     device->wakeup.gpe_number);
+		acpi_unref_wakeup_gpe(device->wakeup.gpe_device,
+				      device->wakeup.gpe_number);
+		device->wakeup.state.enabled = 0;
+	}
+
 	acpi_button_remove_fs(device);
 	input_unregister_device(button->input);
 	kfree(button);
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index baef28c..d56d1ea 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -755,7 +755,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
-	acpi_enable_gpe(NULL, ec->gpe);
+	acpi_ref_runtime_gpe(NULL, ec->gpe);
 	status = acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
@@ -772,6 +772,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 		} else {
 			acpi_remove_gpe_handler(NULL, ec->gpe,
 				&acpi_ec_gpe_handler);
+                        acpi_unref_runtime_gpe(NULL, ec->gpe);
 			return -ENODEV;
 		}
 	}
@@ -782,6 +783,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
+	acpi_unref_runtime_gpe(NULL, ec->gpe);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err(PREFIX "failed to remove space handler\n");
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index e0ee0c0..aaff08b 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -81,6 +81,8 @@ void acpi_enable_wakeup_device(u8 sleep_state)
 		if (!dev->wakeup.flags.run_wake)
 			acpi_enable_gpe(dev->wakeup.gpe_device,
 					dev->wakeup.gpe_number);
+		acpi_ref_wakeup_gpe(dev->wakeup.gpe_device,
+				    dev->wakeup.gpe_number);
 	}
 }
 
@@ -121,6 +123,8 @@ void acpi_disable_wakeup_device(u8 sleep_state)
 			acpi_clear_gpe(dev->wakeup.gpe_device,
 				       dev->wakeup.gpe_number, ACPI_NOT_ISR);
 		}
+		acpi_unref_wakeup_gpe(dev->wakeup.gpe_device,
+				    dev->wakeup.gpe_number);
 	}
 }
 
@@ -141,6 +145,8 @@ int __init acpi_wakeup_device_init(void)
 				  ACPI_GPE_TYPE_WAKE_RUN);
 		acpi_enable_gpe(dev->wakeup.gpe_device,
 				dev->wakeup.gpe_number);
+		acpi_ref_wakeup_gpe(dev->wakeup.gpe_device,
+				    dev->wakeup.gpe_number);
 		dev->wakeup.state.enabled = 1;
 	}
 	mutex_unlock(&acpi_device_lock);
-- 
1.6.5.2

