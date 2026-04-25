Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00B3624CB;
	Sat, 25 Apr 2026 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.62.234.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154274; cv=none; b=FsE5/SLj9h48CArPsUAoKOphYRYapVNUPkj9+bios2+eScRhx9xzCHG3LNj37AmxYGZU/50rO3EI6dySUxZlPo28yieVVg2vpAIeNZ4hHdaE6PbNGCEJMHFLDTxmFLvxUF7EJonZvA2QWH1i8H2UicM/vJpIS7O294NWcjlEVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154274; c=relaxed/simple;
	bh=hFG/4D6D/v24vwJZVdlI1C34PrQRR0Igdzc9eIh0Ss0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DC+6zOG4kprMk3iL2OCD3muQ+g0oHSXE9E3cgToqY+QHORNfzGD29OkYFzeKzuduCDfVcRPmyO7LHJ6yuV78AMgflzotVCphfZQDJvzzbsq7SPx3YU5TPJG4isYu5L+WJcqAGYEyKf/xm/XVUaR5JlZNf/G0/uFINATwWp86/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=DmhXjzq/; arc=none smtp.client-ip=46.62.234.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="DmhXjzq/"
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id 16BA440507;
	Sat, 25 Apr 2026 21:57:45 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id 51D7B407D3;
	Sat, 25 Apr 2026 21:57:44 +0000 (UTC)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 15C8A1FD48B;
	Sun, 26 Apr 2026 00:57:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777154263;
	bh=OHWCQmUJKPeq0NthTR9w3ifOIUDymX5i/+sG3RtrMmc=; h=From:To:Subject;
	b=DmhXjzq/OZv46cHbT/XXGm3RbB35GmRMRqrCnagvhSFe1lxf+iosbpo3S/LWwr3kw
	 XeUY3868gwvwV6zmr3iuWItXgfgEjdI1uAXRsdfDSwURHs42ni5ohRMcymXnC28bjI
	 qKNGzB5T5aG0H8KhmSGQ7FKpznBii+KbDtgQE5kyzfhg91nZmM1FTEwopT3Ouw43ac
	 8b9Vv3LLzjsKc161f8MAUHxUchTG3kcSaubsZlNfIb6PuPsyLNKi/8BJysjQf/GLoC
	 HD0eQn1F+HTwUwsZCe5POduVK0hWQKV628KbBGq1EL0LPtzCVpA8AetHCv+IUaeBy1
	 Bq93MYJ2hzz/Q==
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
Subject: [RFC v2 02/10] acpi/x86: s2idle: Move Modern Standby calls to s2idle
 begin/end
Date: Sat, 25 Apr 2026 23:57:26 +0200
Message-ID: <20260425215734.14116-3-lkml@antheas.dev>
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
 <177715426378.3677768.8424112739099184786@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

In Windows, the modern standby calls for sleep entry/exit and display
on/off happen while the kernel device subsystems are active and the
device is asleep. Currently, in the Linux kernel they happen in
prepare_late, after e.g. the USB subsystem has turned off. This
disimilarity causes obscure issues in certain devices that use these
calls to turn off peripherals that should not be active during modern
standby, e.g. handheld controllers, and RGB.

Therefore, move these calls to _begin(), and _end() to match Windows.
Particularly for _end(), introduce a acpi_s2idle_end_lps0() function to
wrap acpi_s2idle_end(), matching the structure introduced with
acpi_s2idle_begin_lps0().

Of note is that unlike the ACPI ABI of LPS0, there is no device power
state requirement before entering sleep/screen off, therefore it is
appropriate to move these calls to _begin(), before s2idle suspend.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-states
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 63 +++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 61a044b59776..f5aefba8b191 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -517,8 +517,10 @@ static struct acpi_scan_handler lps0_handler = {
 
 static int acpi_s2idle_begin_lps0(void)
 {
-	if (lps0_device_handle && !sleep_no_lps0 && check_lps0_constraints &&
-	    !lpi_constraints_table) {
+	if (!lps0_device_handle || sleep_no_lps0)
+		return acpi_s2idle_begin();
+
+	if (check_lps0_constraints && !lpi_constraints_table) {
 		if (acpi_s2idle_vendor_amd())
 			lpi_device_get_constraints_amd();
 		else
@@ -532,6 +534,24 @@ static int acpi_s2idle_begin_lps0(void)
 			lpi_constraints_table = ERR_PTR(-ENODATA);
 	}
 
+	/* Display off */
+	if (lps0_dsm_func_mask > 0)
+		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
+					ACPI_LPS0_DISPLAY_OFF_AMD :
+					ACPI_LPS0_DISPLAY_OFF,
+					lps0_dsm_func_mask, lps0_dsm_guid);
+
+	if (lps0_dsm_func_mask_microsoft > 0)
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
+
+	/* Modern Standby entry */
+	if (lps0_dsm_func_mask_microsoft > 0)
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
+
 	return acpi_s2idle_begin();
 }
 
@@ -545,36 +565,17 @@ static int acpi_s2idle_prepare_late_lps0(void)
 	if (check_lps0_constraints)
 		lpi_check_constraints();
 
-	/* Display off */
+	/* LPS0 entry */
 	if (lps0_dsm_func_mask > 0)
 		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_DISPLAY_OFF_AMD :
-					ACPI_LPS0_DISPLAY_OFF,
+						ACPI_LPS0_ENTRY_AMD :
+						ACPI_LPS0_ENTRY,
 					lps0_dsm_func_mask, lps0_dsm_guid);
 
 	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
-					lps0_dsm_func_mask_microsoft,
-					lps0_dsm_guid_microsoft);
-
-	/* LPS0 entry */
-	if (lps0_dsm_func_mask > 0 && acpi_s2idle_vendor_amd())
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
-					lps0_dsm_func_mask, lps0_dsm_guid);
-
-	if (lps0_dsm_func_mask_microsoft > 0) {
-		/* Modern Standby entry */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
-					lps0_dsm_func_mask_microsoft,
-					lps0_dsm_guid_microsoft);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
 					lps0_dsm_func_mask_microsoft,
 					lps0_dsm_guid_microsoft);
-	}
-
-	if (lps0_dsm_func_mask > 0 && !acpi_s2idle_vendor_amd())
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
-					lps0_dsm_func_mask, lps0_dsm_guid);
 
 	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
 		if (handler->prepare)
@@ -615,9 +616,19 @@ static void acpi_s2idle_restore_early_lps0(void)
 					ACPI_LPS0_EXIT,
 					lps0_dsm_func_mask, lps0_dsm_guid);
 
-	if (lps0_dsm_func_mask_microsoft > 0) {
+	if (lps0_dsm_func_mask_microsoft > 0)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+}
+
+static void acpi_s2idle_end_lps0(void)
+{
+	acpi_s2idle_end();
+
+	if (!lps0_device_handle || sleep_no_lps0)
+		return;
+
+	if (lps0_dsm_func_mask_microsoft > 0) {
 		/* Intent to turn on display */
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_TURN_ON_DISPLAY,
 					lps0_dsm_func_mask_microsoft,
@@ -648,7 +659,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.wake = acpi_s2idle_wake,
 	.restore_early = acpi_s2idle_restore_early_lps0,
 	.restore = acpi_s2idle_restore,
-	.end = acpi_s2idle_end,
+	.end = acpi_s2idle_end_lps0,
 };
 
 void __init acpi_s2idle_setup(void)
-- 
2.53.0


