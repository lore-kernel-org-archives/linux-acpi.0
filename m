From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 4/7] acpi: video.c: properly remove notify handlers
Date: Thu, 14 Jul 2005 15:54:43 -0700
Message-ID: <200507142255.j6EMtPg7010361@shell0.pdx.osdl.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>

The video driver doesn't properly remove all the notify handlers on module
unload.  This has a side effect of subdevices failing to register on module
reload, but sudden death looms if the handlers trigger after the module is
unloaded (not that I've seen such a machine, but still).

Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/video.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN drivers/acpi/video.c~acpi-videoc-properly-remove-notify-handlers drivers/acpi/video.c
--- devel/drivers/acpi/video.c~acpi-videoc-properly-remove-notify-handlers	2005-07-14 15:53:43.000000000 -0700
+++ devel-akpm/drivers/acpi/video.c	2005-07-14 15:53:43.000000000 -0700
@@ -1665,6 +1665,7 @@ static int
 acpi_video_bus_put_one_device(
 	struct acpi_video_device	*device)
 {
+	acpi_status status;
 	struct acpi_video_bus *video;
 
 	ACPI_FUNCTION_TRACE("acpi_video_bus_put_one_device");
@@ -1679,6 +1680,12 @@ acpi_video_bus_put_one_device(
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
 
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
