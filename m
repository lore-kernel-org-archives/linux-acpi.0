From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 3/4] acpi video pointer size fix
Date: Wed, 30 Mar 2005 13:16:50 -0800
Message-ID: <200503302116.j2ULGelX027733@shell0.pdx.osdl.net>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, pmarques-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Paulo Marques <pmarques-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org>

Fix two instances where we take &p instead of *p when calculating storage
size.

Also, kfree(NULL) is legal, so remove some unneeded checks.

Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/drivers/acpi/video.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff -puN drivers/acpi/video.c~acpi-video-pointer-size-fix drivers/acpi/video.c
--- 25/drivers/acpi/video.c~acpi-video-pointer-size-fix	Wed Mar 30 13:16:04 2005
+++ 25-akpm/drivers/acpi/video.c	Wed Mar 30 13:16:04 2005
@@ -564,12 +564,13 @@ acpi_video_device_find_cap (struct acpi_
 		int count = 0;
 		union acpi_object *o;
 		
-		br = kmalloc(sizeof &br, GFP_KERNEL);
+		br = kmalloc(sizeof(*br), GFP_KERNEL);
 		if (!br) {
 			printk(KERN_ERR "can't allocate memory\n");
 		} else {
-			memset(br, 0, sizeof &br);
-			br->levels = kmalloc(obj->package.count * sizeof &br->levels, GFP_KERNEL);
+			memset(br, 0, sizeof(*br));
+			br->levels = kmalloc(obj->package.count *
+					sizeof *(br->levels), GFP_KERNEL);
 			if (!br->levels)
 				goto out;
 
@@ -584,8 +585,7 @@ acpi_video_device_find_cap (struct acpi_
 			}
 out:
 			if (count < 2) {
-				if (br->levels)
-					kfree(br->levels);
+				kfree(br->levels);
 				kfree(br);
 			} else {
 				br->count = count;
@@ -595,8 +595,7 @@ out:
 		}
 	}
 
-	if (obj)
-		kfree(obj);
+	kfree(obj);
 
 	return_VOID;
 }
_


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
