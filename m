From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 1/1] ACPI: thinkpad-acpi: fix lenovo keymap
	for brightness
Date: Thu, 13 Dec 2007 12:14:09 -0200
Message-ID: <1197555249-8520-2-git-send-email-hmh@hmh.eng.br>
References: <1197555249-8520-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1197555249-8520-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Several reports from X60 users complained that the default Lenovo keymap
issuing EV_KEY KEY_BRIGHTNESS_UP/DOWN input events caused major issues when
the proper brightness support through ACPI video.c was loaded.

Therefore, remove the generation of these events by default, which is the
right thing for T60, X60, R60, T61, X61 and R61 with their latest BIOSes.

Distros that want to misuse these events into OSD reporting (which requires
an ugly hack from hell in HAL) are welcome to set up the key map they need
through HAL.  That way, we don't break everyone else's systems.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index ab23a32..cf56647 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -987,9 +987,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
 		KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
 		KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
-		KEY_BRIGHTNESSUP,	/* 0x0F: FN+HOME (brightness up) */
+		KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
 		/* Scan codes 0x10 to 0x1F: Extended ACPI HKEY hot keys */
-		KEY_BRIGHTNESSDOWN,	/* 0x10: FN+END (brightness down) */
+		KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
 		KEY_RESERVED,	/* 0x11: FN+PGUP (thinklight toggle) */
 		KEY_UNKNOWN,	/* 0x12: FN+PGDOWN */
 		KEY_ZOOM,	/* 0x13: FN+SPACE (zoom) */
-- 
1.5.3.2


-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
