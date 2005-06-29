From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH] video.c: properly remove notify handlers
Date: Wed, 29 Jun 2005 19:03:52 +0200
Message-ID: <20050629170352.GA11807@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
The video driver doesn't properly remove all the notify handlers on module
unload. This has a side effect of subdevices failing to register on module
reload, but sudden death looms if the handlers trigger after the module is
unloaded (not that I've seen such a machine, but still). Please apply.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org

Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>

--- a/drivers/acpi/video.c	2005-04-26 00:43:38.000000000 +0200
+++ b/drivers/acpi/video.c	2005-06-29 18:02:04.000000000 +0200
@@ -1666,6 +1666,7 @@
 acpi_video_bus_put_one_device(
 	struct acpi_video_device	*device)
 {
+	acpi_status status;
 	struct acpi_video_bus *video;
 
 	ACPI_FUNCTION_TRACE("acpi_video_bus_put_one_device");
@@ -1680,6 +1681,12 @@
 	up(&video->sem);
 	acpi_video_device_remove_fs(device->dev);
 
+	status = acpi_remove_notify_handler(device->handle,
+		ACPI_DEVICE_NOTIFY, acpi_video_device_notify);
+	if (ACPI_FAILURE(status))
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error removing notify handler\n"));
+
 	return_VALUE(0);
 }
 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
