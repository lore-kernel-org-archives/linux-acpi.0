From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: [PATCH] PNPACPI: Enable Power Support
Date: Mon, 08 Dec 2008 21:57:03 +0100
Message-ID: <493D8A1F.2090907@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60304 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753020AbYLHU5Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Dec 2008 15:57:24 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <abelay@mit.edu>, rjw@sisk.pl

Subject: Enable PNPACPI _PSx Support


(This is an updated patch of http://lkml.org/lkml/2008/11/23/211)

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

No regressions were observed on hardware that does not require
this patch.

The patch is applied against 2.6.27.8 (vanilla).


Signed-off-by: Witold Szczeponik <Witold.Szczeponik@gmx.net>


Index: linux/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux.orig/drivers/pnp/pnpacpi/core.c
+++ linux/drivers/pnp/pnpacpi/core.c
@@ -98,17 +98,20 @@ static int pnpacpi_set_resources(struct
  	status = acpi_set_current_resources(handle, &buffer);
  	if (ACPI_FAILURE(status))
  		ret = -EINVAL;
+	else
+		acpi_bus_set_power(handle, ACPI_STATE_D0);
  	kfree(buffer.pointer);
  	return ret;
  }

  static int pnpacpi_disable_resources(struct pnp_dev *dev)
  {
+	acpi_handle handle = dev->data;
  	acpi_status status;

  	/* acpi_unregister_gsi(pnp_irq(dev, 0)); */
-	status = acpi_evaluate_object((acpi_handle) dev->data,
-				      "_DIS", NULL, NULL);
+	acpi_bus_set_power(handle, ACPI_STATE_D3);
+	status = acpi_evaluate_object(handle, "_DIS", NULL, NULL);
  	return ACPI_FAILURE(status) ? -ENODEV : 0;
  }

