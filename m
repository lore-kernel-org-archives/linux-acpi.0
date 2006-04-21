From: Thomas Renninger <trenn@suse.de>
Subject: Re: Exit ACPI drivers immediately if acpi is disabled
Date: Fri, 21 Apr 2006 18:53:46 +0200
Message-ID: <200604211853.47117.trenn@suse.de>
References: <200604211243.32276.trenn@suse.de> <200604210918.47337.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_b4QSEMApUVmE0jQ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:63901 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932291AbWDUQxn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Apr 2006 12:53:43 -0400
In-Reply-To: <200604210918.47337.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

--Boundary-00=_b4QSEMApUVmE0jQ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 21 April 2006 17:18, Bjorn Helgaas wrote:
> On Friday 21 April 2006 04:43, Thomas Renninger wrote:
> > If booting with acpi=off and loading the processor module, it
> > may happen that the kernel oopses when trying to unload the module again.
> > Better exit all ACPI modules immediately if booted with acpi=off.
> > ... 
> > @@ -289,31 +289,28 @@ static int __init acpi_ac_init(void)
> >  {
> >  	int result = 0;
> >  
> > -	ACPI_FUNCTION_TRACE("acpi_ac_init");
> > +	if (acpi_disabled)
> > +		return -ENODEV;
> 
> This doesn't feel like the right solution to me.
> acpi_bus_register_driver() already returns -ENODEV
> if acpi_disabled, and that ought to be enough so the
> drivers can handle this correctly.
> 
> I don't think we should clutter every ACPI driver with
> the same check for acpi_disabled.
Yes, you are right.
> 
> Did you investigate the oops when unloading the processor module?
It's in unregister_driver.
> I wonder if that driver has a bug there.  It has a mysterious
> comment that "we keep the driver loaded even when ACPI is not
> running" for powernow-k8.   I don't understand that at all, but
> it sounds like it requires extra care to make sure everything
> works right.
AFAIK processor module has no functions if acpi=off.
Some cpufreq drivers still work. The ones which have the steps
for each CPU model compiled in and that should still work.

There should be no functions missing when booting acpi=off and processor
module cannot be loaded.
But I might be wrong here...

Hmm, as even proc is deleted, the module probably should not be loaded...

I think this one should go in then:

Subject: Exit ACPI processor module if acpi is disabled

 drivers/acpi/processor_core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Thomas Renninger <trenn@suse.de>

Index: linux-2.6.16/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/processor_core.c
+++ linux-2.6.16/drivers/acpi/processor_core.c
@@ -923,7 +923,7 @@ static int __init acpi_processor_init(vo
 	result = acpi_bus_register_driver(&acpi_processor_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-		return_VALUE(0);
+		return_VALUE(-EINVAL);
 	}
 
 	acpi_processor_install_hotplug_notify();

--Boundary-00=_b4QSEMApUVmE0jQ
Content-Type: text/x-diff;
  charset="utf-8";
  name="acpi_exit_on_acpi_off"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi_exit_on_acpi_off"

Subject: Exit ACPI processor module if acpi is disabled

 drivers/acpi/processor_core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Thomas Renninger <trenn@suse.de>

Index: linux-2.6.16/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/processor_core.c
+++ linux-2.6.16/drivers/acpi/processor_core.c
@@ -923,7 +923,7 @@ static int __init acpi_processor_init(vo
 	result = acpi_bus_register_driver(&acpi_processor_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-		return_VALUE(0);
+		return_VALUE(-EINVAL);
 	}
 
 	acpi_processor_install_hotplug_notify();

--Boundary-00=_b4QSEMApUVmE0jQ--
