From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: [PATCH] PNPACPI: Enable PNPACPI _PSx Support, v3
Date: Mon, 30 Mar 2009 19:31:06 +0200
Message-ID: <49D101DA.50201@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753897AbZC3Rbc@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com, abelay@mit.edu, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Subject: Enable PNPACPI _PSx Support, v3


(This is an update to the patch presented earlier in
http://lkml.org/lkml/2008/12/8/284, with new error handling.)

This patch sets the power of PnP ACPI devices to D0 when they
are activated and to D3 when they are disabled.  The latter is
in correspondence with the ACPI 3.0 specification, whereas the
former is added in order to be able to power up a device after
it has been previously disabled (or when booting up a system).
(As a consequence, the patch makes the PnP ACPI code more ACPI
compliant.)

Section 6.2.2 of the ACPI Specification (at least versions 1.0b
and 3.0a) states: "Prior to running this control method [_DIS],
the OS[PM] will have already put the device in the D3 state."
Unfortunately, there is no clear statement as to when to put
a device in the D0 state. :-( Therefore, the patch executes the
method calls as _PS3/_DIS and _SRS/_PS0. What is clear: "If the
device is disabled, _SRS enables the device at the specified
resources." (From the ACPI 3.0a Specification.)

The patch fixes a problem with some IBM ThinkPads (at least the
600E and the 600X) where the serial ports have a dedicated
power source that needs to be brought up before the serial port
can be used.  Without this patch, the serial port is enabled
but has no power. (In the past, the tpctl utility had to be
utilized to turn on the power, but support for this feature
stopped with version 5.9 as it did not support the more recent
kernel versions.)

The error handlers that handle any errors that can occur during
the power up/power down phases return the error codes to the
caller directly.  Comments welcome! :-)

No regressions were observed on hardware that does not require
this patch.

The patch is applied against 2.6.27.x.


Signed-off-by: Witold Szczeponik <Witold.Szczeponik@gmx.net>


Index: linux/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux.orig/drivers/pnp/pnpacpi/core.c
+++ linux/drivers/pnp/pnpacpi/core.c
@@ -84,7 +84,6 @@ static int pnpacpi_set_resources(struct
  	acpi_handle handle = dev->data;
  	struct acpi_buffer buffer;
  	int ret;
-	acpi_status status;

  	dev_dbg(&dev->dev, "set resources\n");
  	ret = pnpacpi_build_resource_template(dev, &buffer);
@@ -95,21 +94,30 @@ static int pnpacpi_set_resources(struct
  		kfree(buffer.pointer);
  		return ret;
  	}
-	status = acpi_set_current_resources(handle, &buffer);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(acpi_set_current_resources(handle, &buffer)))
  		ret = -EINVAL;
+	else if (acpi_bus_power_manageable(handle))
+		ret = acpi_bus_set_power(handle, ACPI_STATE_D0);
  	kfree(buffer.pointer);
  	return ret;
  }

  static int pnpacpi_disable_resources(struct pnp_dev *dev)
  {
-	acpi_status status;
+	acpi_handle handle = dev->data;
+	int ret;

+	dev_dbg(&dev->dev, "disable resources\n");
  	/* acpi_unregister_gsi(pnp_irq(dev, 0)); */
-	status = acpi_evaluate_object((acpi_handle) dev->data,
-				      "_DIS", NULL, NULL);
-	return ACPI_FAILURE(status) ? -ENODEV : 0;
+	ret = 0;
+	if (acpi_bus_power_manageable(handle)) {
+		ret = acpi_bus_set_power(handle, ACPI_STATE_D3);
+		if (ret)
+			return ret;
+	}
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_DIS", NULL, NULL)))
+		ret = -ENODEV;
+	return ret;
  }

  #ifdef CONFIG_ACPI_SLEEP
