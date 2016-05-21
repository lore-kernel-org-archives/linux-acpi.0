From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: linux-next 20160512 - ACPI issue with screen brightness
Date: Sat, 21 May 2016 11:29:33 +0800
Message-ID: <20160521032933.GA12918@aaronlu.sh.intel.com>
References: <4736.1463510462@turing-police.cc.vt.edu>
 <CAJZ5v0jrFoQxLY_ZQrP-HP888swZbvSJPM=xNopC5MgQgnSxNg@mail.gmail.com>
 <6459.1463698397@turing-police.cc.vt.edu>
 <7208.1463713500@turing-police.cc.vt.edu>
 <6674547c-cefb-1b93-893a-7c5909a180a7@intel.com>
 <2897.1463727728@turing-police.cc.vt.edu>
 <20160520071720.GA30152@aaronlu.sh.intel.com>
 <29833.1463789712@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17404 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbcEUD3g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 May 2016 23:29:36 -0400
Content-Disposition: inline
In-Reply-To: <29833.1463789712@turing-police.cc.vt.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Fri, May 20, 2016 at 08:15:12PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 20 May 2016 15:17:20 +0800, Aaron Lu said:
> > On Fri, May 20, 2016 at 03:02:08AM -0400, Valdis.Kletnieks@vt.edu wrote:
> > > With the patches reverted:
> > > 
> > > [/sys/class/backlight/acpi_video0] grep . *bright*
> > > actual_brightness:95
> > > brightness:95
> > > max_brightness:95
> > > 
> > > And the weird part inside the kernel - on a kernel that has the problem,
> > > /sys/class/backlight is *empty* - only '.' and '..' entries.
> > > 
> > > No, I don't understand why the acpi_video0 entry isn't created when that
> > > commit is in place.
> >
> > The commit probably makes acpi_video_init_brightness bail out for some
> > reason, adding debug prints under those "if (result)" in
> > acpi_video_init_brightness should help to identify where it goes wrong.
> >
> > And your acpidump please, thanks.
> 
> The dmesg output:
> 
> [    1.966400] ACPI: Power Button [PWRF]
> [    1.969759] ACPI: Video Device [VID] (multi-head: yes  rom: yes  post: no)
> [    1.969829] acpi_evaluate_BCL failed, 4097
> [    1.969866] acpi_evaluate_BCL failed, 4097
> [    1.969898] acpi_evaluate_BCL failed, 4097
> [    1.969930] acpi_evaluate_BCL failed, 4097
> [    1.969961] acpi_evaluate_BCL failed, 4097
> [    1.969994] acpi_evaluate_BCL failed, 4097
> [    1.970045] acpi_evaluate_BCL failed, 4097
> [    1.970077] acpi_evaluate_BCL failed, 4097

My bad, I see the problem here: the acpi_video_device_lcd_query_levels
called in acpi_video_run_bcl_for_osi didn't do the proper conversion.
The acpi_handle is a "void *" so there is no warnings...

> [    1.970621] acpi_evaluate_BCL failed, 5

This error messages means there is no _BCL but the acpidump shows that
there is.

Anyway, please apply this patch on top of the existing one and attach
dmesg, thanks, this can at least fix the above 4097 errors and let's see
if things start to change:

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 69b321580fa3..bdef49074372 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -765,6 +765,9 @@ int acpi_video_get_levels(struct acpi_device *device,
 	int result = 0;
 	u32 value;
 
+	pr_info("%s for device %s, handle %p\n", __func__, dev_name(&device->dev),
+						device->handle);
+
 	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device->handle,
 								&obj))) {
 		pr_err("Could not query available LCD brightness level\n");
@@ -1747,7 +1750,8 @@ static void acpi_video_run_bcl_for_osi(struct acpi_video_bus *video)
 
 	mutex_lock(&video->device_list_lock);
 	list_for_each_entry(dev, &video->video_device_list, entry) {
-		if (!acpi_video_device_lcd_query_levels(dev, &levels))
+		if (!acpi_video_device_lcd_query_levels(dev->dev->handle,
+							&levels))
 			kfree(levels);
 	}
 	mutex_unlock(&video->device_list_lock);

-Aaron

> [    1.970652] Could not query available LCD brightness level
> [    1.970692] acpi_video_get_levels failed, -19
> [    1.973516] ACPI Error: Current brightness invalid (20160422/video-368)
> [    1.973528] acpi_video_bqc_quirk failed, -22
> [    1.973567] acpi_evaluate_BCL failed, 5
> [    1.973597] Could not query available LCD brightness level
> [    1.973636] acpi_video_get_levels failed, -19
> [    1.973672] acpi_evaluate_BCL failed, 5
> [    1.973701] Could not query available LCD brightness level
> [    1.973741] acpi_video_get_levels failed, -19
> [    1.973777] acpi_evaluate_BCL failed, 5
> [    1.973807] Could not query available LCD brightness level
> [    1.973847] acpi_video_get_levels failed, -19
> [    1.973882] acpi_evaluate_BCL failed, 5
> [    1.973911] Could not query available LCD brightness level
> [    1.973951] acpi_video_get_levels failed, -19
> [    1.973986] acpi_evaluate_BCL failed, 5
> [    1.974439] Could not query available LCD brightness level
> [    1.974479] acpi_video_get_levels failed, -19
> [    1.974529] acpi_evaluate_BCL failed, 5
> [    1.974565] Could not query available LCD brightness level
> [    1.974603] acpi_video_get_levels failed, -19
> [    1.977783] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:14/LNXVIDEO:00/input/input4
> [    1.980879] thermal LNXTHERM:00: registered as thermal_zone0
> [    1.980884] ACPI: Thermal Zone [THM] (64 C)
