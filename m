From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/acpi/video.c: fix a NULL pointer dereference
Date: Sat, 11 Mar 2006 16:11:54 +0100
Message-ID: <20060311151154.GR21864@stusta.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3006596EE5@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751183AbWCKPMR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3006596EE5@hdsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 10, 2006 at 11:00:45PM -0500, Brown, Len wrote:
> 
> >The Coverity checker spotted this obvious bug in 
> >acpi_video_device_lcd_query_levels().
> >
> >
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> >--- linux-2.6.16-rc5-mm3-full/drivers/acpi/video.c.old	
> >2006-03-10 18:04:18.000000000 +0100
> >+++ linux-2.6.16-rc5-mm3-full/drivers/acpi/video.c	
> >2006-03-10 18:04:33.000000000 +0100
> >@@ -321,11 +321,11 @@ acpi_video_device_lcd_query_levels(struc
> > 
> > 	status = acpi_evaluate_object(device->handle, "_BCL", 
> >NULL, &buffer);
> > 	if (!ACPI_SUCCESS(status))
> > 		return_VALUE(status);
> > 	obj = (union acpi_object *)buffer.pointer;
> >-	if (!obj && (obj->type != ACPI_TYPE_PACKAGE)) {
> >+	if (obj && (obj->type != ACPI_TYPE_PACKAGE)) {
> 
> how about
> +	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
>...

Yes, thanks for the correction.

cu
Adrian


<--  snip  -->


The Coverity checker spotted this bug in
acpi_video_device_lcd_query_levels().


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/acpi/video.c.old	2006-03-10 18:04:18.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/acpi/video.c	2006-03-10 18:04:33.000000000 +0100
@@ -321,11 +321,11 @@ acpi_video_device_lcd_query_levels(struc
 
 	status = acpi_evaluate_object(device->handle, "_BCL", NULL, &buffer);
 	if (!ACPI_SUCCESS(status))
 		return_VALUE(status);
 	obj = (union acpi_object *)buffer.pointer;
-	if (!obj && (obj->type != ACPI_TYPE_PACKAGE)) {
+	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
 		ACPI_ERROR((AE_INFO, "Invalid _BCL data"));
 		status = -EFAULT;
 		goto err;
 	}
 
