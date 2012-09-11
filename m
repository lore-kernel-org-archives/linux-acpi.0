From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Infer parent power state from child if unknown, v2
Date: Tue, 11 Sep 2012 22:38:06 +0200
Message-ID: <201209112238.06658.rjw@sisk.pl>
References: <1346053126-7646-1-git-send-email-aaron.lu@intel.com> <201209102150.22738.rjw@sisk.pl> <20120911053305.GA2130@mint-spring.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120911053305.GA2130@mint-spring.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

It turns out that there are ACPI BIOSes defining device objects with
_PSx and without either _PSC or _PRx.  For devices corresponding to
those ACPI objetcs __acpi_bus_get_power() returns ACPI_STATE_UNKNOWN
and their initial power states are regarded as unknown as a result.
If such a device is a parent of another power-manageable device, the
child cannot be put into a low-power state through ACPI, because
__acpi_bus_set_power() refuses to change power states of devices
whose parents' power states are unknown.

To work around this problem, observe that the ACPI power state of
a device cannot be higher-power (lower-number) than the power state
of its parent.  Thus, if the device's _PSC method or the
configuration of its power resources indicates that the device is
in D0, the device's parent has to be in D0 as well.  Consequently,
if the parent's power state is unknown when we've just learned that
its child's power state is D0, we can safely set the parent's
power.state field to ACPI_STATE_D0.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux/drivers/acpi/bus.c
===================================================================
--- linux.orig/drivers/acpi/bus.c
+++ linux/drivers/acpi/bus.c
@@ -237,6 +237,16 @@ static int __acpi_bus_get_power(struct a
 	} else if (result == ACPI_STATE_D3_HOT) {
 		result = ACPI_STATE_D3;
 	}
+
+	/*
+	 * If we were unsure about the device parent's power state up to this
+	 * point, the fact that the device is in D0 implies that the parent has
+	 * to be in D0 too.
+	 */
+	if (device->parent && device->parent->power.state == ACPI_STATE_UNKNOWN
+	    && result == ACPI_STATE_D0)
+		device->parent->power.state = ACPI_STATE_D0;
+
 	*state = result;
 
  out:
