From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI video: dmi check for broken _BQC on Acer Aspire
	5720
Date: Fri, 24 Apr 2009 14:40:14 +0800
Message-ID: <1240555214.7661.586.camel@rzhang-dt>
References: <1240550980.7661.544.camel@rzhang-dt>
	 <alpine.LFD.2.00.0904240212540.15843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64236 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759217AbZDXGju (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Apr 2009 02:39:50 -0400
In-Reply-To: <alpine.LFD.2.00.0904240212540.15843@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "maximlevitsky@gmail.com" <maximlevitsky@gmail.com>

On Fri, 2009-04-24 at 14:15 +0800, Len Brown wrote:
> On Fri, 24 Apr 2009, Zhang Rui wrote:
> 
> > 
> > On Acer Aspire 5720, _BQC always returns a value 9 smaller than
> > the actual brightness level.
> > Add dmi quirk for this laptop.
> > http://bugzilla.kernel.org/show_bug.cgi?id=13121
> > 
> > Tested-by: Maxim Levitsky <maximlevitsky@gmail.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/video.c |   30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6/drivers/acpi/video.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/video.c
> > +++ linux-2.6/drivers/acpi/video.c
> > @@ -87,6 +87,8 @@ static const struct acpi_device_id video
> >  };
> >  MODULE_DEVICE_TABLE(acpi, video_device_ids);
> >  
> > +static int bqc_offset;
> > +
> 
> are there other machines with a similar bqc_offset AML bug?
> 
well, the answer is no for now.

> If no, then I'd rather this simple workaround be simpler
> rather than be ready for a general case that will never happen...

I don't think there is any place that we could make the code simpler.

> 
> in any case, the code/comments should be clear that
> this is a hideoous workaround rather than how things
> are supposed to work.
>   eg call it bqc_offset_idiotic_aml_workaround or 
> something..

agree. refreshed patch attached.


On Acer Aspire 5720, _BQC always returns a value 9 smaller than
the actual brightness level.
Add dmi quirk for this laptop.
http://bugzilla.kernel.org/show_bug.cgi?id=13121

Tested-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -87,6 +87,12 @@ static const struct acpi_device_id video
 };
 MODULE_DEVICE_TABLE(acpi, video_device_ids);
 
+/*
+ * For some buggy _BQC methods, we need to add a constant value to
+ * the _BQC return value to get the actual current brightness level
+ */
+static int bqc_offset_idiotic_aml_workaround;
+
 static struct acpi_driver acpi_video_bus = {
 	.name = "video",
 	.class = ACPI_VIDEO_CLASS,
@@ -556,7 +562,8 @@ acpi_video_device_lcd_get_level_current(
 								 - 3 - (*level);
 				*level = device->brightness->levels[*level + 2];
 
-			}
+			} else if (bqc_offset_idiotic_aml_workaround)
+				*level += bqc_offset_idiotic_aml_workaround;
 			device->brightness->curr = *level;
 			return 0;
 		} else {
@@ -698,6 +705,29 @@ acpi_video_bus_DOS(struct acpi_video_bus
 	return status;
 }
 
+static int video_set_bqc_offset(const struct dmi_system_id *d)
+{
+	bqc_offset_idiotic_aml_workaround = 9;
+	return 0;
+}
+
+static struct dmi_system_id video_dmi_table[] __initdata = {
+	/*
+	 * Acer Aspire 5720 _BQC method is broken,
+	 * it always returns a value smaller than the actual brightness level
+	 * http://bugzilla.kernel.org/show_bug.cgi?id=13121
+	 */
+	{
+	 .callback = video_set_bqc_offset,
+	 .ident = "Acer Aspire 5720",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5720"),
+		},
+	},
+	{}
+};
+
 /*
  * Simple comparison function used to sort backlight levels.
  */
@@ -2287,6 +2317,8 @@ EXPORT_SYMBOL(acpi_video_register);
 
 static int __init acpi_video_init(void)
 {
+	dmi_check_system(video_dmi_table);
+
 	if (intel_opregion_present())
 		return 0;
 




