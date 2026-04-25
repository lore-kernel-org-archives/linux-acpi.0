Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6749314A9E;
	Sat, 25 Apr 2026 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154274; cv=none; b=AGMJyM+XM5JtGew6cdOVp9WsSE4x+yUID7WU7m9mQq9Ey+z2S7JdDhy8Qv86Y+H+pMQGEwA9VsuEGwLWeV11L9rSYSMMiBfRiMTY5iDD7o//NPxivXbZjewOQ64aAbbVn+sGckFWgu329syW3lY8DCaANKOD+l8T7yVGono2H0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154274; c=relaxed/simple;
	bh=EpydV7q2mfrmOZU7jN46dDgUUkxps2DyhS44AShRAEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CA0R3dFWWPYmpw4aOT45ycD6f98BJMTGDD5shTDItM5e4R55an1zTtCyedwvA2Q2RJLxCUClYaqKxww3bZPlWl1iM6lOISdS2ZjIOqTNiqd9rTdKhIc13DfyEkR5US297SiNaHIZQJmiRWC2E75nEICm3MzFhPNAKemObf0nBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=FIGxODws; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="FIGxODws"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id C6310C181B;
	Sun, 26 Apr 2026 00:57:43 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 23F6FC1771;
	Sun, 26 Apr 2026 00:57:43 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 060BB1FD484;
	Sun, 26 Apr 2026 00:57:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777154262;
	bh=sJF1A95p1ylS9ELqAjl8fFgYptloxRu1AkVOOBlZajA=; h=From:To:Subject;
	b=FIGxODwsIOS45A24+tRAA+MGjW15Te4tscGOsjJnORnjx/749OrE/gblcBeBFmKKb
	 XlsGbZ/r01Lh9ghO3cHRYEKn58+drTMM8Mww3oaZu9TRkF15YaSi+x1XhvDCVDTyHR
	 LgA7yF8yhyYFOxM6XZp6/mAueIz5RokHdOCPDlFuiDefnxn1M+DxEhnPAGMLMtNwT+
	 VQK8yy/HUJXxapdroNPbngwfMaGUYsbxEwXOt0XzkWUmgX+igCTgRaC3Yq4ZAcYBm3
	 e/8DQgCDOzU4L0n0vD9dDzFrvqm5EfmCTxGFzteVWufthPecTxjoi53jxibQNO30pF
	 o0SXqrKzoaP5w==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com,
	bookeldor@gmail.com,
	hadess@hadess.net,
	jaap@haitsma.org,
	kernel@collabora.com,
	lennart@poettering.net,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev,
	mccann@jhu.edu,
	rafael@kernel.org,
	richard@hughsie.com,
	sebastian.reichel@collabora.com,
	superm1@kernel.org,
	systemd-devel@lists.freedesktop.org,
	xaver.hugl@gmail.com
Subject: [RFC v2 01/10] acpi/x86: s2idle: Rename LPS0 constants so they mirror
 their function
Date: Sat, 25 Apr 2026 23:57:25 +0200
Message-ID: <20260425215734.14116-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425215734.14116-1-lkml@antheas.dev>
References: <20260425215734.14116-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177715426274.3677691.9873735536126217914@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The LPS0 3/4 constants are part of a firmware notification called
"Display on/off", in which the device enters a "Screen Off" state.
The LPS0 7/8 constants are part of a firmware notification in which
a Windows modern standby computer enters a "sleep" state where the
CPU may still be active and maintain the radios.

However, currently, the values are named as "Screen on/off" and "MS
entry/exit", where Modern Standby is abbreviated as "MS". Therefore,
perform a minor rename so that the values match their function. Then,
fix the debug message to say that it executes notifications instead of
entering states as it is otherwise confusing.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 84 +++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index b6b1dd76a06b..61a044b59776 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -43,20 +43,20 @@ static const struct acpi_device_id lps0_device_ids[] = {
 #define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
 
 #define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
-#define ACPI_LPS0_SCREEN_OFF	3
-#define ACPI_LPS0_SCREEN_ON	4
+#define ACPI_LPS0_DISPLAY_OFF	3
+#define ACPI_LPS0_DISPLAY_ON	4
 #define ACPI_LPS0_ENTRY		5
 #define ACPI_LPS0_EXIT		6
-#define ACPI_LPS0_MS_ENTRY      7
-#define ACPI_LPS0_MS_EXIT       8
-#define ACPI_MS_TURN_ON_DISPLAY 9
+#define ACPI_LPS0_SLEEP_ENTRY		7
+#define ACPI_LPS0_SLEEP_EXIT		8
+#define ACPI_LPS0_TURN_ON_DISPLAY	9
 
 /* AMD */
 #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
 #define ACPI_LPS0_ENTRY_AMD         2
 #define ACPI_LPS0_EXIT_AMD          3
-#define ACPI_LPS0_SCREEN_OFF_AMD    4
-#define ACPI_LPS0_SCREEN_ON_AMD     5
+#define ACPI_LPS0_DISPLAY_OFF_AMD   4
+#define ACPI_LPS0_DISPLAY_ON_AMD    5
 
 static acpi_handle lps0_device_handle;
 static guid_t lps0_dsm_guid;
@@ -343,27 +343,27 @@ static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
 {
 	if (lps0_dsm_func_mask_microsoft || !acpi_s2idle_vendor_amd()) {
 		switch (state) {
-		case ACPI_LPS0_SCREEN_OFF:
-			return "screen off";
-		case ACPI_LPS0_SCREEN_ON:
-			return "screen on";
+		case ACPI_LPS0_DISPLAY_OFF:
+			return "display off";
+		case ACPI_LPS0_DISPLAY_ON:
+			return "display on";
 		case ACPI_LPS0_ENTRY:
 			return "lps0 entry";
 		case ACPI_LPS0_EXIT:
 			return "lps0 exit";
-		case ACPI_LPS0_MS_ENTRY:
-			return "lps0 ms entry";
-		case ACPI_LPS0_MS_EXIT:
-			return "lps0 ms exit";
-		case ACPI_MS_TURN_ON_DISPLAY:
-			return "lps0 ms turn on display";
+		case ACPI_LPS0_SLEEP_ENTRY:
+			return "sleep entry";
+		case ACPI_LPS0_SLEEP_EXIT:
+			return "sleep exit";
+		case ACPI_LPS0_TURN_ON_DISPLAY:
+			return "turn on display";
 		}
 	} else {
 		switch (state) {
-		case ACPI_LPS0_SCREEN_ON_AMD:
-			return "screen on";
-		case ACPI_LPS0_SCREEN_OFF_AMD:
-			return "screen off";
+		case ACPI_LPS0_DISPLAY_ON_AMD:
+			return "display on";
+		case ACPI_LPS0_DISPLAY_OFF_AMD:
+			return "display off";
 		case ACPI_LPS0_ENTRY_AMD:
 			return "lps0 entry";
 		case ACPI_LPS0_EXIT_AMD:
@@ -388,7 +388,7 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, g
 	lps0_dsm_state = func;
 	if (pm_debug_messages_on) {
 		acpi_handle_info(lps0_device_handle,
-				"%s transitioned to state %s\n",
+				"%s executed notification %s\n",
 				 out_obj ? "Successfully" : "Failed to",
 				 acpi_sleep_dsm_state_to_str(lps0_dsm_state));
 	}
@@ -545,16 +545,17 @@ static int acpi_s2idle_prepare_late_lps0(void)
 	if (check_lps0_constraints)
 		lpi_check_constraints();
 
-	/* Screen off */
+	/* Display off */
 	if (lps0_dsm_func_mask > 0)
 		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_SCREEN_OFF_AMD :
-					ACPI_LPS0_SCREEN_OFF,
+					ACPI_LPS0_DISPLAY_OFF_AMD :
+					ACPI_LPS0_DISPLAY_OFF,
 					lps0_dsm_func_mask, lps0_dsm_guid);
 
 	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
 
 	/* LPS0 entry */
 	if (lps0_dsm_func_mask > 0 && acpi_s2idle_vendor_amd())
@@ -563,10 +564,12 @@ static int acpi_s2idle_prepare_late_lps0(void)
 
 	if (lps0_dsm_func_mask_microsoft > 0) {
 		/* Modern Standby entry */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
 	}
 
 	if (lps0_dsm_func_mask > 0 && !acpi_s2idle_vendor_amd())
@@ -616,21 +619,24 @@ static void acpi_s2idle_restore_early_lps0(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 		/* Intent to turn on display */
-		acpi_sleep_run_lps0_dsm(ACPI_MS_TURN_ON_DISPLAY,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_TURN_ON_DISPLAY,
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
 		/* Modern Standby exit */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_EXIT,
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
 	}
 
-	/* Screen on */
+	/* Display on */
 	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_ON,
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
 	if (lps0_dsm_func_mask > 0)
 		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_SCREEN_ON_AMD :
-					ACPI_LPS0_SCREEN_ON,
+					ACPI_LPS0_DISPLAY_ON_AMD :
+					ACPI_LPS0_DISPLAY_ON,
 					lps0_dsm_func_mask, lps0_dsm_guid);
 }
 
-- 
2.53.0


