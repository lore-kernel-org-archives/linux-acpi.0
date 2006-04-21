From: Thomas Renninger <trenn@suse.de>
Subject: Re: Exit ACPI drivers immediately if acpi is disabled
Date: Fri, 21 Apr 2006 19:18:12 +0200
Message-ID: <200604211918.13025.trenn@suse.de>
References: <200604211243.32276.trenn@suse.de> <200604210918.47337.bjorn.helgaas@hp.com> <200604211853.47117.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VPRSE7RQHfACxFs"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:15020 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751334AbWDURSJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Apr 2006 13:18:09 -0400
In-Reply-To: <200604211853.47117.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

--Boundary-00=_VPRSE7RQHfACxFs
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 21 April 2006 18:53, Thomas Renninger wrote:
> On Friday 21 April 2006 17:18, Bjorn Helgaas wrote:
> > On Friday 21 April 2006 04:43, Thomas Renninger wrote:
> > > If booting with acpi=off and loading the processor module, it
> > > may happen that the kernel oopses when trying to unload the module again.
> > > Better exit all ACPI modules immediately if booted with acpi=off.
> > > ... 
> > > @@ -289,31 +289,28 @@ static int __init acpi_ac_init(void)
> > >  {
> > >  	int result = 0;
> > >  
> > > -	ACPI_FUNCTION_TRACE("acpi_ac_init");
> > > +	if (acpi_disabled)
> > > +		return -ENODEV;
> > 
> > This doesn't feel like the right solution to me.
> > acpi_bus_register_driver() already returns -ENODEV
> > if acpi_disabled, and that ought to be enough so the
> > drivers can handle this correctly.
> > 
> > I don't think we should clutter every ACPI driver with
> > the same check for acpi_disabled.
> Yes, you are right.
> > 
> > Did you investigate the oops when unloading the processor module?
> It's in unregister_driver.
> > I wonder if that driver has a bug there.  It has a mysterious
> > comment that "we keep the driver loaded even when ACPI is not
> > running" for powernow-k8.
Arggh, I didn't see this.
Next try:

Subject: Exit ACPI processor module gracefully if acpi is disabled

Signed-off-by: Thomas Renninger <trenn@suse.de>

 drivers/acpi/processor_core.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.16/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/processor_core.c
+++ linux-2.6.16/drivers/acpi/processor_core.c
@@ -906,6 +906,8 @@ void acpi_processor_uninstall_hotplug_no
  * ACPI, but needs symbols from this driver
  */
 
+static int driver_registered = 0;
+
 static int __init acpi_processor_init(void)
 {
 	int result = 0;
@@ -926,6 +928,8 @@ static int __init acpi_processor_init(vo
 		return_VALUE(0);
 	}
 
+	driver_registered = 1;
+
 	acpi_processor_install_hotplug_notify();
 
 	acpi_thermal_cpufreq_init();
@@ -943,12 +947,13 @@ static void __exit acpi_processor_exit(v
 
 	acpi_thermal_cpufreq_exit();
 
+	if (driver_registered){
 	acpi_processor_uninstall_hotplug_notify();
 
 	acpi_bus_unregister_driver(&acpi_processor_driver);
 
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-
+	}
 	return_VOID;
 }
 

--Boundary-00=_VPRSE7RQHfACxFs
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="acpi_exit_on_acpi_off"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi_exit_on_acpi_off"

Subject: Exit ACPI processor module gracefully if acpi is disabled

Signed-off-by: Thomas Renninger <trenn@suse.de>

 drivers/acpi/processor_core.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.16/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/processor_core.c
+++ linux-2.6.16/drivers/acpi/processor_core.c
@@ -906,6 +906,8 @@ void acpi_processor_uninstall_hotplug_no
  * ACPI, but needs symbols from this driver
  */
 
+static int driver_registered = 0;
+
 static int __init acpi_processor_init(void)
 {
 	int result = 0;
@@ -926,6 +928,8 @@ static int __init acpi_processor_init(vo
 		return_VALUE(0);
 	}
 
+	driver_registered = 1;
+
 	acpi_processor_install_hotplug_notify();
 
 	acpi_thermal_cpufreq_init();
@@ -943,12 +947,13 @@ static void __exit acpi_processor_exit(v
 
 	acpi_thermal_cpufreq_exit();
 
+	if (driver_registered){
 	acpi_processor_uninstall_hotplug_notify();
 
 	acpi_bus_unregister_driver(&acpi_processor_driver);
 
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-
+	}
 	return_VOID;
 }
 

--Boundary-00=_VPRSE7RQHfACxFs--
