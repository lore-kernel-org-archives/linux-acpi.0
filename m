From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Infer parent power state from child if unknown
Date: Mon, 10 Sep 2012 21:50:22 +0200
Message-ID: <201209102150.22738.rjw@sisk.pl>
References: <1346053126-7646-1-git-send-email-aaron.lu@intel.com> <201209072032.55469.rjw@sisk.pl> <20120910003805.GA1590@mint-spring.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120910003805.GA1590@mint-spring.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, LKML <linux-kernel@vger.kernel.org>
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
Reviewed-by: Aaron Lu <aaron.lu@intel.com>
---

Hi Len,

I suppose we can put this one into -stable.

Thanks,
Rafael

---
 drivers/acpi/bus.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux/drivers/acpi/bus.c
===================================================================
--- linux.orig/drivers/acpi/bus.c
+++ linux/drivers/acpi/bus.c
@@ -228,7 +228,16 @@ static int __acpi_bus_get_power(struct a
 		result = psc;
 	}
 	/* The test below covers ACPI_STATE_UNKNOWN too. */
-	if (result <= ACPI_STATE_D2) {
+	if (result == ACPI_STATE_D0) {
+		/*
+		 * If we were unsure about the device parent's power state up to
+		 * this point, the fact that the device is in D0 implies that
+		 * the parent has to be in D0 too.
+		 */
+		if (device->parent
+		    && device->parent->power.state == ACPI_STATE_UNKNOWN)
+			device->parent->power.state = ACPI_STATE_D0;
+	} else if (result <= ACPI_STATE_D2) {
 	  ; /* Do nothing. */
 	} else if (device->power.flags.power_resources) {
 		int error = acpi_power_get_inferred_state(device, &result);
