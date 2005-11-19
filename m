From: Yu Luming <luming.yu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH]  Fix Null point in video/lcd/brightness
Date: Sat, 19 Nov 2005 22:32:55 +0800
Message-ID: <200511192232.56139.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: akpm-3NddpPZAyC0@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, nacc-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 Fix Null point in video/lcd/brightness
http://bugzilla.kernel.org/show_bug.cgi?id=5571

Signed-off-by: Luming Yu
Cc: "Brown, Len"
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Nishanth Aravamudan <nacc-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
---
 video.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/video.c.orig	2005-10-28 02:02:08.000000000 +0200
+++ a/drivers/acpi/video.c	2005-11-04 14:53:25.000000000 +0100
@@ -813,7 +813,7 @@
 
 	ACPI_FUNCTION_TRACE("acpi_video_device_write_brightness");
 
-	if (!dev || count + 1 > sizeof str)
+	if (!dev || !dev->brightness || count + 1 > sizeof str)
 		return_VALUE(-EINVAL);
 
 	if (copy_from_user(str, buffer, count))



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
