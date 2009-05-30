From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 5/5] thinkpad-acpi: silence bogus warning
	when ACPI video is disabled
Date: Sat, 30 May 2009 13:25:09 -0300
Message-ID: <1243700709-25977-6-git-send-email-hmh@hmh.eng.br>
References: <1243700709-25977-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1243700709-25977-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Make use of acpi_video_backlight_support() also in hotkey_init, to make
sure this doesn't happen:

thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness
               control, supported by the ACPI video driver
thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
thinkpad_acpi: Standard ACPI backlight interface not available,
               thinkpad_acpi native brightness control enabled
thinkpad_acpi: detected a 16-level brightness capable ThinkPad

Note that this is purely cosmetic, there is absolutely _no_ change in
behaviour.  Those events are sometimes enabled at runtime by userspace, but
the driver never enables them by itself unless someone messed with the
default keymaps.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Reported-by: Jochen Schulz <jrschulz-gCdIjHM9zsRQtr0SbaWXQg@public.gmane.org>
---
 drivers/platform/x86/thinkpad_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 06c7c03..5a22a06 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2655,7 +2655,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		/* update bright_acpimode... */
 		tpacpi_check_std_acpi_brightness_support();
 
-	if (tp_features.bright_acpimode) {
+	if (tp_features.bright_acpimode && acpi_video_backlight_support()) {
 		printk(TPACPI_INFO
 		       "This ThinkPad has standard ACPI backlight "
 		       "brightness control, supported by the ACPI "
-- 
1.6.2.4


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
