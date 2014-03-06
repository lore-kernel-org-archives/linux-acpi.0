From: Shuduo Sang <shuduo.sang-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: [PATCH V4] support Thinkpad X1 Carbon 2nd
	generation's adaptive keyboard
Date: Thu, 06 Mar 2014 18:20:46 +0800
Message-ID: <53184BFE.5080007@canonical.com>
References: <5314AE4C.4090502@canonical.com> <20140304091916.GE1883@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20140304091916.GE1883-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>, bjorn-yOkvZcmFvRU@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org, matthew.garrett-+LlxwbBB2+6sTnJN9+BGXg@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bruce.ma-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Submit patch V4 to support Adaptive Keyboard on Thinkpad X1 Carbon 2nd
generation according to Tobias's comments.

Thanks,
Shuduo


>From b153a7b14791c6e01892c0e274e23eefd625fb8d Mon Sep 17 00:00:00 2001
From: Shuduo Sang <shuduo.sang-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Date: Mon, 3 Mar 2014 14:29:32 +0800
Subject: [PATCH] support thinkpad X1 Carbon's adaptive keyboard

Thinkpad X1 Carbon's adaptive keyboard has five modes including Home
mode, Web browser mode, Web conference mode, Function mode and Lay-flat
mode. We support Home mode and Function mode currently.

Signed-off-by: Bruce Ma <bruce.ma-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Signed-off-by: Shuduo Sang <shuduo.sang-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 102
+++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c
b/drivers/platform/x86/thinkpad_acpi.c
index defb6af..f4978fa 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3437,6 +3437,106 @@ err_exit:
 	return (res < 0)? res : 1;
 }

+/* Thinkpad X1 Carbon support 5 modes including Home mode, Web browser
+ * mode, Web conference mode, Function mode and Lay-flat mode.
+ * We support Home mode and Function mode currently.
+ *
+ * Will consider support rest of modes in future.
+ *
+ */
+enum ADAPTIVE_KEY_MODE {
+	HOME_MODE,
+	WEB_BROWSER_MODE,
+	WEB_CONFERENCE_MODE,
+	FUNCTION_MODE,
+	LAYFLAT_MODE
+};
+
+const int adaptive_keyboard_modes[] = {
+	HOME_MODE,
+/*	WEB_BROWSER_MODE = 2,
+	WEB_CONFERENCE_MODE = 3, */
+	FUNCTION_MODE
+};
+
+#define DFR_CHANGE_ROW			0x101
+#define DFR_SHOW_QUICKVIEW_ROW		0x102
+
+/* press Fn key a while second, it will switch to Function Mode. Then
+ * release Fn key, previous mode be restored.
+ */
+static bool adaptive_keyboard_mode_is_saved;
+static int adaptive_keyboard_prev_mode;
+
+static int adaptive_keyboard_get_next_mode(int mode)
+{
+	size_t i;
+	size_t max_mode = ARRAY_SIZE(adaptive_keyboard_modes) - 1;
+
+	for (i = 0; i <= max_mode; i++) {
+		if (adaptive_keyboard_modes[i] == mode)
+			break;
+	}
+
+	if (i >= max_mode)
+		i = 0;
+	else
+		i++;
+
+	return adaptive_keyboard_modes[i];
+}
+
+static bool adaptive_keyboard_hotkey_notify_hotkey(unsigned int scancode)
+{
+	u32 current_mode = 0;
+	int new_mode = 0;
+
+	switch (scancode) {
+	case DFR_CHANGE_ROW:
+		if (adaptive_keyboard_mode_is_saved) {
+			new_mode = adaptive_keyboard_prev_mode;
+			adaptive_keyboard_mode_is_saved = false;
+		} else {
+			if (!acpi_evalf(
+					hkey_handle, &current_mode,
+					"GTRW", "dd", 0)) {
+				pr_err("Cannot read adaptive keyboard mode\n");
+				return false;
+			} else {
+				new_mode = adaptive_keyboard_get_next_mode(
+						current_mode);
+			}
+		}
+
+		if (!acpi_evalf(hkey_handle, NULL, "STRW", "vd", new_mode)) {
+			pr_err("Cannot set adaptive keyboard mode\n");
+			return false;
+		}
+
+		return true;
+
+	case DFR_SHOW_QUICKVIEW_ROW:
+		if (!acpi_evalf(hkey_handle,
+				&adaptive_keyboard_prev_mode,
+				"GTRW", "dd", 0)) {
+			pr_err("Cannot read adaptive keyboard mode\n");
+			return false;
+		} else {
+			adaptive_keyboard_mode_is_saved = true;
+
+			if (!acpi_evalf(hkey_handle,
+					NULL, "STRW", "vd", FUNCTION_MODE)) {
+				pr_err("Cannot set adaptive keyboard mode\n");
+				return false;
+			}
+		}
+		return true;
+
+	default:
+		return false;
+	}
+}
+
 static bool hotkey_notify_hotkey(const u32 hkey,
 				 bool *send_acpi_ev,
 				 bool *ignore_acpi_ev)
@@ -3456,6 +3556,8 @@ static bool hotkey_notify_hotkey(const u32 hkey,
 			*ignore_acpi_ev = true;
 		}
 		return true;
+	} else {
+		return adaptive_keyboard_hotkey_notify_hotkey(scancode);
 	}
 	return false;
 }
-- 
1.9.0


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
