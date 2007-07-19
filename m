From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 07/23] ACPI: thinkpad-acpi: checkpoint
	sysfs interface version due to hotkey
Date: Wed, 18 Jul 2007 23:45:32 -0300
Message-ID: <11848131493516-git-send-email-hmh@hmh.eng.br>
References: <11848131483573-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11848131483573-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The change in the size of the hotkey mask, the hability to report the keys
that use the higher bits, and the addition of the hotkey_radio_sw attribute
are important enough features to warrant increasing the minor field of the
sysfs interface version.

Also, document a bit better how and when the thinkpad-acpi sysfs interface
version will be updated.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |   17 +++++++++++++++++
 drivers/misc/thinkpad_acpi.c    |    2 +-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index fe26e50..7a06a27 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -134,6 +134,21 @@ end of this document.  Changes to the sysfs interface done by the kernel
 subsystems are not documented here, nor are they tracked by this
 attribute.
 
+Changes to the thinkpad-acpi sysfs interface are only considered
+non-experimental when they are submitted to Linux mainline, at which
+point the changes in this interface are documented and interface_version
+may be updated.  If you are using any thinkpad-acpi features not yet
+sent to mainline for merging, you do so on your own risk: these features
+may disappear, or be implemented in a different and incompatible way by
+the time they are merged in Linux mainline.
+
+Changes that are backwards-compatible by nature (e.g. the addition of
+attributes that do not change the way the other attributes work) do not
+always warrant an update of interface_version.  Therefore, one must
+expect that an attribute might not be there, and deal with it properly
+(an attribute not being there *is* a valid way to make it clear that a
+feature is not available in sysfs).
+
 Hot keys
 --------
 
@@ -989,3 +1004,5 @@ Sysfs interface changelog:
 
 0x000100:	Initial sysfs support, as a single platform driver and
 		device.
+0x000200:	Hot key support for 32 hot keys, and radio slider switch
+		support.
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 3cf37bb..4d71893 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -22,7 +22,7 @@
  */
 
 #define IBM_VERSION "0.14"
-#define TPACPI_SYSFS_VERSION 0x000100
+#define TPACPI_SYSFS_VERSION 0x000200
 
 /*
  *  Changelog:
-- 
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
