From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PM: Add check preventing transitioning to non-D0 state from D3.
Date: Thu, 31 Jan 2013 01:58:18 +0100
Message-ID: <4159184.RqsslRMqMo@vostro.rjw.lan>
References: <e4ec829902580af84cddbba6e98ef54b33052b85.1352953283.git.lv.zheng@intel.com> <12389653.2bKflhlsko@vostro.rjw.lan> <4852069.tOyaDAodDO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34899 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515Ab3AaAwI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jan 2013 19:52:08 -0500
In-Reply-To: <4852069.tOyaDAodDO@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Wu <lekensteyn@gmail.com>, linux-acpi@vger.kernel.org
Cc: Lv Zheng <lv.zheng@intel.com>, Len Brown <len.brown@intel.com>

On Thursday, January 31, 2013 12:27:25 AM Rafael J. Wysocki wrote:
> On Wednesday, January 30, 2013 10:55:17 PM Rafael J. Wysocki wrote:
> > On Wednesday, January 30, 2013 06:53:46 PM Peter Wu wrote:
> > > Hi Lv Zheng,
> > > 
> > > I encounter a regression with your patch (Linux 3.8-rc5). On my Nvidia Optimus 
> > > laptop, I use the bbswitch[1] kernel module to trigger a _PS3 ACPI method call 
> > > to turn the video card off.
> > > 
> > > After this patch, I got the following in my kernel log:
> > > 
> > >     pci 0000:01:00.0: Refused to change power state, currently in D0
> > >     ACPI: Cannot transition to non-D0 state from D3
> > >     bbswitch: Succesfully loaded. Discrete card 0000:01:00.0 is on
> > > 
> > > The expected output would be "Discrete card 0000:01:00.0 is  off". Printing the 
> > > contents of (acpi_device) device->power.state shows FF (ACPI_STATE_UNKNOWN). 
> > > Should this condition be excluded from your check or is my hacky module 
> > > outdated?
> > > 
> > > I currently workaround this issue by checking for ACPI_STATE_UNKNOWN. If that 
> > > is the value, I assume on (overwrite device->power.state with ACPI_STATE_D0). 
> > > Then I call pci_set_power_state(pci_dev, PCI_D3cold).
> > 
> > You shouldn't ever be transitioning from an uknown state to D3cold directly.
> > Please first transition to D0 and then to D3cold.
> > 
> > Can you please test the linux-next branch of the linux-pm.git tree and check
> > if you see this problem in there too?
> 
> To be more precise, I wonder why you get ACPI_STATE_UNKNOWN in
> device->power.state if the device is power-manageable.  In theory
> acpi_bus_init_power() should change that to something meaningful and if it
> doesn't, then there's a bug either in acpi_bus_init_power() or in the BIOS.
> 
> We may just need to try to force D0 in acpi_bus_init_power() if _PSC is missing,
> for example.

So, I'm pondering the appended patch (on top of linux-pm/linux-next).

Thanks,
Rafael

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / PM: Do not power manage devices in unknown initial states

In general, for ACPI device power management to work, the initial
power states of devices must be known (otherwise, we wouldn't be able
to keep track of power resources, for example).  Hence, if it is
impossible to determine the initial ACPI power states of some
devices, they can't be regarded as power-manageable using ACPI.

For this reason, modify acpi_bus_get_power_flags() to clear the
power_manageable flag if acpi_bus_init_power() fails and add some
extra fallback code to acpi_bus_init_power() to cover broken
BIOSes that provide _PS0/_PS3 without _PSC for some devices.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    6 ++++++
 drivers/acpi/scan.c      |    5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -330,6 +330,12 @@ int acpi_bus_init_power(struct acpi_devi
 		result = acpi_dev_pm_explicit_set(device, state);
 		if (result)
 			return result;
+	} else if (state == ACPI_STATE_UNKNOWN) {
+		/* No power resources and missing _PSC? Try to force D0. */
+		state = ACPI_STATE_D0;
+		result = acpi_dev_pm_explicit_set(device, state);
+		if (result)
+			return result;
 	}
 	device->power.state = state;
 	return 0;
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1175,7 +1175,10 @@ static void acpi_bus_get_power_flags(str
 			device->power.flags.power_resources)
 		device->power.states[ACPI_STATE_D3_COLD].flags.os_accessible = 1;
 
-	acpi_bus_init_power(device);
+	if (acpi_bus_init_power(device)) {
+		acpi_free_power_resources_lists(device);
+		device->flags.power_manageable = 0;
+	}
 }
 
 static void acpi_bus_get_flags(struct acpi_device *device)

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
