From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [ibm-acpi-devel] CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 16:56:34 -0700
Message-ID: <20070319165634.2f2f380c.kristen.c.accardi@intel.com>
References: <20070315110156.09e80b99.kristen.c.accardi@intel.com>
	<20070315193123.GB14394@khazad-dum.debian.net>
	<20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
	<45FCD062.3050001@gmail.com>
	<20070318082751.GA28591@homac2>
	<20070319132243.GA2869@srcf.ucam.org>
	<20070319134822.GA4885@homac2.suse.de>
	<20070319140403.GA3697@srcf.ucam.org>
	<20070319143746.GC4885@homac2.suse.de>
	<20070319111109.1a62740b.kristen.c.accardi@intel.com>
	<20070319231119.GB5932@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15051 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030754AbXCSX7B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Mar 2007 19:59:01 -0400
In-Reply-To: <20070319231119.GB5932@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Holger Macht <hmacht@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Len Brown <lenb@kernel.org>

On Mon, 19 Mar 2007 20:11:19 -0300
Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:

> On Mon, 19 Mar 2007, Kristen Carlson Accardi wrote:
> > On Mon, 19 Mar 2007 15:37:46 +0100
> > Holger Macht <hmacht@suse.de> wrote:
> > > Sure. What actually bothers me is that in its current state, the dock
> > > station driver signals 'green' on the dock station as soon as the user
> > > presses the hardware undock button, but regardlessly of anything else. I
> > > think it would be ok to let the ACPI undock event up to userspace because
> > > in many situations it knows best when it is save to undock.
> > 
> > I disagree - as I mentioned, not all laptops actually let you (userspace)
> > control the undock process because they don't lock.  The dock driver
> > does notify user space of an undock, before it actually undocks:
> > 
> >         /*
> >          * here we need to generate the undock
> >          * event prior to actually doing the undock
> >          * so that the device struct still exists.
> >          */
> >         dock_event(ds, event, UNDOCK_EVENT);
> >         hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
> >         undock(ds);
> >         eject_dock(ds);
> >  
> > 
> > We even notify other subsystems of our intent to undock prior to actually
> > doing it.
> 
> The above does not support two-stage-capable (i.e. non-braindamaged)
> hardware docks properly.  While a two-stage (notify always, but undock only
> if userspace (or another kernel module) tells you to) can support both
> two-stage and broken-as-designed single-stage docks.
> 
> You can either let a machine-specific module (e.g. ibm-acpi) generate the
> "undock immediately" functionality if the machine has a single-stage dock,
> or let userspace do it, or even use black/whitelists on the dock module if
> you want... but please give us the two-stage undock support.
> 
> -- 

Is this what you had in mind?  (Warning - I didn't test this).


Allow the driver to be loaded with an option that will allow userspace to
control whether the laptop is ejected immediately when the user presses the
button, or only when the syfs undock file is written.  

if immediate_undock == 1, then when the user presses the undock button, the
laptop will send an event to userspace to notify userspace of the undock, but
then immediately undock without waiting for userspace.  This is the current
behavior, and I set this to be the default.

if immediate_undock == 0, then when the user presses the undock button, the
laptop will send an event to userspace and do nothing.  User space can query
the "flags" sysfs entry to determine if an undock request has been made by
the user (if bit 1 is set).  User space will then need to write the undock 
sysfs entry to complete the undocking process.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Index: 2.6-git/drivers/acpi/dock.c
===================================================================
--- 2.6-git.orig/drivers/acpi/dock.c
+++ 2.6-git/drivers/acpi/dock.c
@@ -39,6 +39,9 @@ MODULE_AUTHOR("Kristen Carlson Accardi")
 MODULE_DESCRIPTION(ACPI_DOCK_DRIVER_DESCRIPTION);
 MODULE_LICENSE("GPL");
 
+static int immediate_undock;
+module_param(immediate_undock, int, 1);
+
 static struct atomic_notifier_head dock_notifier_list;
 static struct platform_device dock_device;
 static char dock_device_name[] = "dock";
@@ -62,6 +65,7 @@ struct dock_dependent_device {
 };
 
 #define DOCK_DOCKING	0x00000001
+#define DOCK_UNDOCKING  0x00000002
 #define DOCK_EVENT	3
 #define UNDOCK_EVENT	2
 
@@ -419,6 +423,16 @@ static inline void complete_dock(struct 
 	ds->last_dock_time = jiffies;
 }
 
+static inline void begin_undock(struct dock_station *ds)
+{
+	ds->flags |= DOCK_UNDOCKING;
+}
+
+static inline void complete_undock(struct dock_station *ds)
+{
+	ds->flags &= ~(DOCK_UNDOCKING);
+}
+
 /**
  * dock_in_progress - see if we are in the middle of handling a dock event
  * @ds: the dock station
@@ -549,7 +563,7 @@ static int handle_eject_request(struct d
 		printk(KERN_ERR PREFIX "Unable to undock!\n");
 		return -EBUSY;
 	}
-
+	complete_undock(ds);
 	return 0;
 }
 
@@ -593,7 +607,11 @@ static void dock_notify(acpi_handle hand
 	 * to the driver who wish to hotplug.
          */
 	case ACPI_NOTIFY_EJECT_REQUEST:
-		handle_eject_request(ds, event);
+		begin_undock(ds);
+		if (immediate_undock)
+			handle_eject_request(ds, event);
+		else
+			dock_event(ds, event, UNDOCK_EVENT);
 		break;
 	default:
 		printk(KERN_ERR PREFIX "Unknown dock event %d\n", event);
@@ -652,6 +670,17 @@ static ssize_t show_docked(struct device
 DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
 
 /*
+ * show_flags - read method for flags file in sysfs
+ */
+static ssize_t show_flags(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", dock_station->flags);
+
+}
+DEVICE_ATTR(flags, S_IRUGO, show_flags, NULL);
+
+/*
  * write_undock - write method for "undock" file in sysfs
  */
 static ssize_t write_undock(struct device *dev, struct device_attribute *attr,
@@ -667,6 +696,7 @@ static ssize_t write_undock(struct devic
 }
 DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
 
+
 /**
  * dock_add - add a new dock station
  * @handle: the dock station handle
@@ -715,6 +745,15 @@ static int dock_add(acpi_handle handle)
 		kfree(dock_station);
 		return ret;
 	}
+	ret = device_create_file(&dock_device.dev, &dev_attr_flags);
+	if (ret) {
+		printk("Error %d adding sysfs file\n", ret);
+		device_remove_file(&dock_device.dev, &dev_attr_docked);
+		device_remove_file(&dock_device.dev, &dev_attr_undock);
+		platform_device_unregister(&dock_device);
+		kfree(dock_station);
+		return ret;
+	}
 
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
@@ -750,6 +789,7 @@ dock_add_err:
 dock_add_err_unregister:
 	device_remove_file(&dock_device.dev, &dev_attr_docked);
 	device_remove_file(&dock_device.dev, &dev_attr_undock);
+	device_remove_file(&dock_device.dev, &dev_attr_flags);
 	platform_device_unregister(&dock_device);
 	kfree(dock_station);
 	return ret;
@@ -781,6 +821,7 @@ static int dock_remove(void)
 	/* cleanup sysfs */
 	device_remove_file(&dock_device.dev, &dev_attr_docked);
 	device_remove_file(&dock_device.dev, &dev_attr_undock);
+	device_remove_file(&dock_device.dev, &dev_attr_flags);
 	platform_device_unregister(&dock_device);
 
 	/* free dock station memory */
