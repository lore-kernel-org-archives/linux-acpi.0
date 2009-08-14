From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 9/9] acpi: fix NULL bug for HID/UID string
Date: Fri, 14 Aug 2009 14:08:39 -0600
Message-ID: <200908141408.40960.bjorn.helgaas@hp.com>
References: <200908062257.n76MvuCr024266@imap1.linux-foundation.org> <200908141044.51799.bjorn.helgaas@hp.com> <Pine.LNX.4.64.0908141854110.15176@sister.anvils>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:41493 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbZHNUIl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 16:08:41 -0400
In-Reply-To: <Pine.LNX.4.64.0908141854110.15176@sister.anvils>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Cc: Lin Ming <ming.m.lin@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Friday 14 August 2009 12:18:47 pm Hugh Dickins wrote:
> On Fri, 14 Aug 2009, Bjorn Helgaas wrote:
> > I don't quite understand how this oops happens, though.  It seems that
> > we crashed in this path:
> > 
> >   acpi_device_probe
> >     acpi_bus_driver_init
> >       driver->ops.add  (calls acpi_video_bus_add)
> >     acpi_device_install_notify_handler
> >       hid = acpi_device_hid(device)
> >       strcmp(hid, ACPI_BUTTON_HID_POWERF))
> >         *** OOPS, hid == NULL ***
> > 
> > But the acpi_video_bus driver claims devices using ACPI_VIDEO_HID
> > ("LNXVIDEO"), and acpi_device_set_id() already does synthesize
> > that HID, so acpi_device_hid() should have been valid.  So why
> > did we oops?
> 
> The backtrace I jotted down, from Intel 915 graphics, looked like this
> (acpi_device_install_notify_handler is inlined into acpi_device_probe):
> 
> strcmp
> acpi_device_probe
> really_probe
> driver_probe_device
> __driver_attach
> bus_for_each_dev
> driver_attach
> bus_add_driver
> driver_register
> acpi_bus_register
> acpi_video_register
> intel_opregion_init
> i915_driver_load
> drm_get_dev
> drm_init
> i915_init
> do_one_initcall
> do_basic_setup
> kernel_init
> kernel_thread_helper

Likely the same issue as Valdis saw, but I don't see the actual
problem yet.  If it's convenient, the patch below might shed a
little light.

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 781435d..e8de598 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -376,6 +376,12 @@ static int acpi_device_install_notify_handler(struct acpi_device *device)
 	char *hid;
 
 	hid = acpi_device_hid(device);
+	if (!hid || strlen(hid) == 0) {
+		printk(KERN_INFO PREFIX
+		       "install notify handler for %s, no HID!\n",
+		       dev_name(&device->dev));
+		hid = "";
+	}
 	if (!strcmp(hid, ACPI_BUTTON_HID_POWERF))
 		status =
 		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
@@ -420,6 +426,8 @@ static int acpi_device_probe(struct device * dev)
 
 	ret = acpi_bus_driver_init(acpi_dev, acpi_drv);
 	if (!ret) {
+		printk(KERN_INFO PREFIX "binding driver [%s] to device [%s]\n",
+			acpi_drv->name, acpi_dev->pnp.bus_id);
 		if (acpi_dev->bus_ops.acpi_op_start)
 			acpi_start_single_object(acpi_dev);
 
@@ -1182,6 +1190,7 @@ acpi_add_single_object(struct acpi_device **child,
 {
 	int result = 0;
 	struct acpi_device *device = NULL;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 
 	if (!child)
@@ -1315,9 +1324,14 @@ acpi_add_single_object(struct acpi_device **child,
 	}
 
 end:
-	if (!result)
+	if (!result) {
+		acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+		printk(KERN_INFO PREFIX "adding %s [%s] HID %s\n",
+		       dev_name(&device->dev), (char *) buffer.pointer,
+		       acpi_device_hid(device) ? acpi_device_hid(device) :
+						 "(null)");
 		*child = device;
-	else {
+	} else {
 		kfree(device->pnp.cid_list);
 		kfree(device);
 	}
