From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 4/6] thinkpad-acpi: make driver events work
	in NVRAM poll mode
Date: Fri, 26 Feb 2010 01:11:22 -0300
Message-ID: <1267157484-23925-5-git-send-email-hmh@hmh.eng.br>
References: <1267157484-23925-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1267157484-23925-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thadeu Lima de Souza Cascardo reports this:

Brightness notification does not work until the user writes to
hotkey_mask attribute.  That's because the polling thread will only run
if hotkey_user_mask is set and someone is reading the input device or
if hotkey_driver_mask is set.  In this second case, this condition is
not tested after the mask is changed, because the brightness and
volume drivers are started after the hotkey drivers.

Fix tpacpi_hotkey_driver_mask_set() to call hotkey_poll_setup(), so
that the poller kthread will be started when needed.

Reported-by: Thadeu Lima de Souza Cascardo <cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org>
Tested-by: Thadeu Lima de Souza Cascardo <cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org>
Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
---
 drivers/platform/x86/thinkpad_acpi.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 933bcc4..5f45083 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2082,6 +2082,7 @@ static struct attribute_set *hotkey_dev_attributes;
 
 static void tpacpi_driver_event(const unsigned int hkey_event);
 static void hotkey_driver_event(const unsigned int scancode);
+static void hotkey_poll_setup(const bool may_warn);
 
 /* HKEY.MHKG() return bits */
 #define TP_HOTKEY_TABLET_MASK (1 << 3)
@@ -2264,6 +2265,8 @@ static int tpacpi_hotkey_driver_mask_set(const u32 mask)
 
 	rc = hotkey_mask_set((hotkey_acpi_mask | hotkey_driver_mask) &
 							~hotkey_source_mask);
+	hotkey_poll_setup(true);
+
 	mutex_unlock(&hotkey_mutex);
 
 	return rc;
@@ -2548,7 +2551,7 @@ static void hotkey_poll_stop_sync(void)
 }
 
 /* call with hotkey_mutex held */
-static void hotkey_poll_setup(bool may_warn)
+static void hotkey_poll_setup(const bool may_warn)
 {
 	const u32 poll_driver_mask = hotkey_driver_mask & hotkey_source_mask;
 	const u32 poll_user_mask = hotkey_user_mask & hotkey_source_mask;
@@ -2579,7 +2582,7 @@ static void hotkey_poll_setup(bool may_warn)
 	}
 }
 
-static void hotkey_poll_setup_safe(bool may_warn)
+static void hotkey_poll_setup_safe(const bool may_warn)
 {
 	mutex_lock(&hotkey_mutex);
 	hotkey_poll_setup(may_warn);
@@ -2597,7 +2600,11 @@ static void hotkey_poll_set_freq(unsigned int freq)
 
 #else /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
 
-static void hotkey_poll_setup_safe(bool __unused)
+static void hotkey_poll_setup(const bool __unused)
+{
+}
+
+static void hotkey_poll_setup_safe(const bool __unused)
 {
 }
 
-- 
1.6.5.2


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
