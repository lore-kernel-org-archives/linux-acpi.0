From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] asus-laptop add kill switch support
Date: Thu, 7 Feb 2008 00:40:20 -0500
Message-ID: <200802070040.20871.lenb@kernel.org>
References: <200801161657.50967.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200801161657.50967.corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
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
To: corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabien Crespel <fabien-czgx1wgAc3rR7s880joybQ@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

scripts/checkpatch.pl
ERROR: do not use C99 // comments
#101: FILE: drivers/misc/asus-laptop.c:63:
+#define ATKD_BR_UP       0x10  // Brightness Up base value

ERROR: do not use C99 // comments
#102: FILE: drivers/misc/asus-laptop.c:64:
+#define ATKD_BR_DOWN     0x20  // Brightness Down base value

ERROR: do not use C99 // comments
#103: FILE: drivers/misc/asus-laptop.c:65:
+#define ATKD_LCD_ON      0x33  // LCD Display ON

ERROR: do not use C99 // comments
#104: FILE: drivers/misc/asus-laptop.c:66:
+#define ATKD_LCD_OFF     0x34  // LCD Display OFF

ERROR: do not use C99 // comments
#105: FILE: drivers/misc/asus-laptop.c:67:
+#define ATKD_WL_TOGGLE   0x5D  // WLAN Toggle

ERROR: do not use C99 // comments
#106: FILE: drivers/misc/asus-laptop.c:68:
+#define ATKD_WL_ON       0x5E  // WLAN ON notification

ERROR: do not use C99 // comments
#107: FILE: drivers/misc/asus-laptop.c:69:
+#define ATKD_WL_OFF      0x5F  // WLAN OFF notification

ERROR: do not use C99 // comments
#108: FILE: drivers/misc/asus-laptop.c:70:
+#define ATKD_BT_ON       0x7D  // Bluetooth ON notification

ERROR: do not use C99 // comments
#109: FILE: drivers/misc/asus-laptop.c:71:
+#define ATKD_BT_OFF      0x7E  // Bluetooth OFF notification

ERROR: do not use C99 // comments
#110: FILE: drivers/misc/asus-laptop.c:72:
+#define ATKD_KS_ON       0x81  // Kill Switch ON

ERROR: do not use C99 // comments
#111: FILE: drivers/misc/asus-laptop.c:73:
+#define ATKD_KS_OFF      0x80  // Kill Switch OFF

ERROR: do not use C99 // comments
#118: FILE: drivers/misc/asus-laptop.c:78:
+#define RF_HWRS     0x01       // Radio Frequency enabled

ERROR: do not use C99 // comments
#119: FILE: drivers/misc/asus-laptop.c:79:
+#define KS_HWRS     0x02       // Kill Switch present

ERROR: do not use C99 // comments
#120: FILE: drivers/misc/asus-laptop.c:80:
+#define WL_HWRS     0x80       // Wifi adapter present

ERROR: do not use C99 // comments
#121: FILE: drivers/misc/asus-laptop.c:81:
+#define BT_HWRS     0x100      // Bluetooth adapter present

ERROR: trailing whitespace
#146: FILE: drivers/misc/asus-laptop.c:120:
+ * $

ERROR: do not use C99 // comments
#167: FILE: drivers/misc/asus-laptop.c:199:
+       u16 status;             //status of the hotk, for LEDs, ...

ERROR: trailing whitespace
#189: FILE: drivers/misc/asus-laptop.c:346:
+^I$

ERROR: trailing whitespace
#198: FILE: drivers/misc/asus-laptop.c:355:
+^I$

ERROR: use tabs not spaces
#219: FILE: drivers/misc/asus-laptop.c:371:
+ ^I^Ireturn read_wireless_status(mask);$

ERROR: use tabs not spaces
#220: FILE: drivers/misc/asus-laptop.c:372:
+ ^Ielse if (mask == GPS_ON)$

ERROR: use tabs not spaces
#221: FILE: drivers/misc/asus-laptop.c:373:
+ ^I^Ireturn read_gps_status();$

ERROR: trailing statements should be on next line
#232: FILE: drivers/misc/asus-laptop.c:386:
+               if (handle && read_killswitch_status()) return;

ERROR: trailing whitespace
#241: FILE: drivers/misc/asus-laptop.c:780:
+ $

ERROR: trailing whitespace
#261: FILE: drivers/misc/asus-laptop.c:810:
+^I$

ERROR: trailing whitespace
#288: FILE: drivers/misc/asus-laptop.c:837:
+^I$

ERROR: trailing whitespace
#304: FILE: drivers/misc/asus-laptop.c:853:
+^I^I/* $

ERROR: trailing whitespace
#310: FILE: drivers/misc/asus-laptop.c:859:
+^I$

ERROR: use tabs not spaces
#349: FILE: drivers/misc/asus-laptop.c:921:
+ ^I&dev_attr_killswitch.attr,$

ERROR: trailing whitespace
#396: FILE: drivers/misc/asus-laptop.c:1159:
+^I$

total: 30 errors, 0 warnings, 308 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
On Wednesday 16 January 2008 10:57, Corentin CHARY wrote:

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
