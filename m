From: Corentin CHARY <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
Subject: [PATCH 1/2] eeepc-laptop: add bt support
Date: Sat, 12 Jul 2008 12:03:06 +0200
Message-ID: <200807121203.06561.corentincj@iksaif.net>
References: <200807121159.03034.corentincj@iksaif.net>
Reply-To: corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200807121159.03034.corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eeecommunity-donated-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Alexandre d'Alton <alex-jojFES6RfZNxtahE/wReCQ@public.gmane.org>

Adds a bt file that allows to switch the BT power if
a BT module is added to the BT_CON connector of the eeepc 900, I think it
will also work for the 901 that has BT by default.

Signed-off-by: Corentin Chary <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
---
 eeepc-laptop.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/misc/eeepc-laptop.c	2008-07-03 13:36:19.000000000 +0200
+++ b/drivers/misc/eeepc-laptop.c	2008-07-04 10:09:28.000000000 +0200
@@ -88,7 +88,7 @@
 };
 
 const char *cm_getv[] = {
-	"WLDG", NULL, NULL, NULL,
+	"WLDG", "BTHG", NULL, NULL,
 	"CAMG", NULL, NULL, NULL,
 	NULL, "PBLG", NULL, NULL,
 	"CFVG", NULL, NULL, NULL,
@@ -97,7 +97,7 @@
 };
 
 const char *cm_setv[] = {
-	"WLDS", NULL, NULL, NULL,
+	"WLDS", "BTHS", NULL, NULL,
 	"CAMS", NULL, NULL, NULL,
 	"SDSP", "PBLS", "HDPS", NULL,
 	"CFVS", NULL, NULL, NULL,
@@ -312,12 +312,14 @@
 EEEPC_CREATE_DEVICE_ATTR(cardr, CM_ASL_CARDREADER);
 EEEPC_CREATE_DEVICE_ATTR(disp, CM_ASL_DISPLAYSWITCH);
 EEEPC_CREATE_DEVICE_ATTR(wlan, CM_ASL_WLAN);
+EEEPC_CREATE_DEVICE_ATTR(bt, CM_ASL_BLUETOOTH);
 
 static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
 	&dev_attr_cardr.attr,
 	&dev_attr_disp.attr,
 	&dev_attr_wlan.attr,
+	&dev_attr_bt.attr,
 	NULL
 };
 

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
