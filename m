From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: linux-next 20160512 - ACPI issue with screen brightness
Date: Fri, 20 May 2016 15:35:36 +0800
Message-ID: <20160520073536.GB30152@aaronlu.sh.intel.com>
References: <4736.1463510462@turing-police.cc.vt.edu>
 <CAJZ5v0jrFoQxLY_ZQrP-HP888swZbvSJPM=xNopC5MgQgnSxNg@mail.gmail.com>
 <6459.1463698397@turing-police.cc.vt.edu>
 <7208.1463713500@turing-police.cc.vt.edu>
 <6674547c-cefb-1b93-893a-7c5909a180a7@intel.com>
 <2897.1463727728@turing-police.cc.vt.edu>
 <20160520071720.GA30152@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9865 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719AbcETHfu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 May 2016 03:35:50 -0400
Content-Disposition: inline
In-Reply-To: <20160520071720.GA30152@aaronlu.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Fri, May 20, 2016 at 03:17:20PM +0800, Aaron Lu wrote:
> On Fri, May 20, 2016 at 03:02:08AM -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 20 May 2016 13:45:30 +0800, Aaron Lu said:
> > > On 05/20/2016 11:05 AM, Valdis.Kletnieks@vt.edu wrote:
> > > > On Thu, 19 May 2016 18:53:17 -0400, Valdis.Kletnieks@vt.edu said:
> > > >
> > > >>>> next-20160512 sets the screen brightness to about 40%-ish or so, rather
> > > >>>> than the 100% intensity I want.
> > >
> > > Do you mean after boot, the screen brightness is now 40% instead of the
> > > previous 100%? Are you using a GUI?
> > 
> > Nope, even the very first line of output from initramfs is dim, and if I then
> > reboot and go into the BIOS settings, the screen intensity is at 40%. While
> > it's rebooting, the Dell bios splash will start off bright and then suddenly
> > dim down.
> > 
> > With the patches reverted:
> > 
> > [/sys/class/backlight/acpi_video0] grep . *bright*
> > actual_brightness:95
> > brightness:95
> > max_brightness:95
> > 
> > And the weird part inside the kernel - on a kernel that has the problem,
> > /sys/class/backlight is *empty* - only '.' and '..' entries.
> > 
> > No, I don't understand why the acpi_video0 entry isn't created when that
> > commit is in place.
> 
> The commit probably makes acpi_video_init_brightness bail out for some
> reason, adding debug prints under those "if (result)" in
> acpi_video_init_brightness should help to identify where it goes wrong.

Like the below one:

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 3d5b8a099351..69b321580fa3 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -323,8 +323,10 @@ acpi_video_device_lcd_query_levels(acpi_handle handle,
 	*levels = NULL;
 
 	status = acpi_evaluate_object(handle, "_BCL", NULL, &buffer);
-	if (!ACPI_SUCCESS(status))
+	if (!ACPI_SUCCESS(status)) {
+		pr_err("acpi_evaluate_BCL failed, %d\n", status);
 		return status;
+	}
 	obj = (union acpi_object *)buffer.pointer;
 	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
 		printk(KERN_ERR PREFIX "Invalid _BCL data\n");
@@ -765,13 +767,13 @@ int acpi_video_get_levels(struct acpi_device *device,
 
 	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device->handle,
 								&obj))) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available "
-						"LCD brightness level\n"));
+		pr_err("Could not query available LCD brightness level\n");
 		result = -ENODEV;
 		goto out;
 	}
 
 	if (obj->package.count < 2) {
+		pr_err("_BCL count smaller than 2, %d\n", obj->package.count);
 		result = -EINVAL;
 		goto out;
 	}
@@ -786,6 +788,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 	br->levels = kmalloc((obj->package.count + 2) * sizeof *(br->levels),
 				GFP_KERNEL);
 	if (!br->levels) {
+		pr_err("kmalloc for br->levels failed\n");
 		result = -ENOMEM;
 		goto out_free;
 	}
@@ -870,8 +873,10 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	int result = -EINVAL;
 
 	result = acpi_video_get_levels(device->dev, &br);
-	if (result)
+	if (result) {
+		pr_err("acpi_video_get_levels failed, %d\n", result);
 		return result;
+	}
 	device->brightness = br;
 
 	/* _BQC uses INDEX while _BCL uses VALUE in some laptops */
@@ -882,12 +887,16 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 
 	result = acpi_video_device_lcd_get_level_current(device,
 							 &level_old, true);
-	if (result)
+	if (result) {
+		pr_err("acpi_video_device_lcd_get_level_current failed, %d\n", result);
 		goto out_free_levels;
+	}
 
 	result = acpi_video_bqc_quirk(device, max_level, level_old);
-	if (result)
+	if (result) {
+		pr_err("acpi_video_bqc_quirk failed, %d\n", result);
 		goto out_free_levels;
+	}
 	/*
 	 * cap._BQC may get cleared due to _BQC is found to be broken
 	 * in acpi_video_bqc_quirk, so check again here.
@@ -910,11 +919,12 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 
 set_level:
 	result = acpi_video_device_lcd_set_level(device, level);
-	if (result)
+	if (result) {
+		pr_err("acpi_video_device_lcd_set_level failed, %d\n", result);
 		goto out_free_levels;
+	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "found %d brightness levels\n", br->count - 2));
+	pr_info("found %d brightness levels\n", br->count - 2);
 	return 0;
 
 out_free_levels:
