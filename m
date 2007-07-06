From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 08/16] ACPI: thinkpad-acpi: update CMOS
	commands documentation
Date: Thu,  5 Jul 2007 23:42:20 -0300
Message-ID: <118368974950-git-send-email-hmh@hmh.eng.br>
References: <11836897482509-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11836897482509-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

The CMOS set of commands is often just used to keep the CMOS NVRAM in sync
with whatever the ACPI BIOS has been doing in modern ThinkPads.  In older
ThinkPads, it actually carried out real actions.  Document this.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 7a06a27..bd00d14 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -464,27 +464,34 @@ CMOS control
 procfs: /proc/acpi/ibm/cmos
 sysfs device attribute: cmos_command
 
-This feature is used internally by the ACPI firmware to control the
-ThinkLight on most newer ThinkPad models. It may also control LCD
-brightness, sounds volume and more, but only on some models.
+This feature is mostly used internally by the ACPI firmware to keep the legacy
+CMOS NVRAM bits in sync with the current machine state, and to record this
+state so that the ThinkPad will retain such settings across reboots.
+
+Some of these commands actually perform actions in some ThinkPad models, but
+this is expected to disappear more and more in newer models.  As an example, in
+a T43 and in a X40, commands 12 and 13 still control the ThinkLight state for
+real, but commands 0 to 2 don't control the mixer anymore (they have been
+phased out) and just update the NVRAM.
 
 The range of valid cmos command numbers is 0 to 21, but not all have an
 effect and the behavior varies from model to model.  Here is the behavior
 on the X40 (tpb is the ThinkPad Buttons utility):
 
-	0 - no effect but tpb reports "Volume down"
-	1 - no effect but tpb reports "Volume up"
-	2 - no effect but tpb reports "Mute on"
-	3 - simulate pressing the "Access IBM" button
-	4 - LCD brightness up
-	5 - LCD brightness down
-	11 - toggle screen expansion
-	12 - ThinkLight on
-	13 - ThinkLight off
-	14 - no effect but tpb reports ThinkLight status change
+	0 - Related to "Volume down" key press
+	1 - Related to "Volume up" key press
+	2 - Related to "Mute on" key press
+	3 - Related to "Access IBM" key press
+	4 - Related to "LCD brightness up" key pess
+	5 - Related to "LCD brightness down" key press
+	11 - Related to "toggle screen expansion" key press/function
+	12 - Related to "ThinkLight on"
+	13 - Related to "ThinkLight off"
+	14 - Related to "ThinkLight" key press (toggle thinklight)
 
 The cmos command interface is prone to firmware split-brain problems, as
-in newer ThinkPads it is just a compatibility layer.
+in newer ThinkPads it is just a compatibility layer.  Do not use it, it is
+exported just as a debug tool.
 
 LED control -- /proc/acpi/ibm/led
 ---------------------------------
-- 
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
