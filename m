Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2436E47F;
	Sat, 25 Apr 2026 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.62.234.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154277; cv=none; b=XfdRcNjCHqBhjeDWME/VvTEataPrLAzsxx2kT7z9YuvOj+Ws7OIXdfSuVb4UrzsdDXPeaNNgf6YE3DL879b4s4BeO6dihOu9B/E+SKatVOMkQRDZaL9fCkqXh/j6hkr5kxOi5mfZXIBRuAC9AhkBOAfvCaUtyuNFthFVuaQqXoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154277; c=relaxed/simple;
	bh=rnM4kr+xfytfhGnxhf5OAD59qQ5Iw/Q4eFOqnpG5ty4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIDORy3380MWi0Z7PLnBg9CMvL1mwNSXA9qKZwo8HmKiwE5V6vlE97dN215TJSNi4jSSTGDZ0XhRibik8C3TZ9glUOXcVBlu/Fg2sr1jStbCqKk+eYiEtk3n3HWy9UlEm30e8Tc0ebQmmNRxeZfzDiYj49lRNUYfNQy2jbbKe4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=jfLS9Rmg; arc=none smtp.client-ip=46.62.234.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="jfLS9Rmg"
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id 48DAF407DF;
	Sat, 25 Apr 2026 21:57:54 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id C7F1E407D3;
	Sat, 25 Apr 2026 21:57:53 +0000 (UTC)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 887721FD3FD;
	Sun, 26 Apr 2026 00:57:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777154273;
	bh=1cCY77CgxDb6pnSiiRkFPzyB1zIP5mxrDh80kv/GOaE=; h=From:To:Subject;
	b=jfLS9RmgCDzbgMoFn5yUWuDgmZjI1FOWHzYE8uieoiUQSyjExZMIZYOwMjHnbme4t
	 TeQXpkmBTr3X4BkhaRG0osO1epHj9GqtXkSKnTsY71fQeEqFuEw+FX0FPpnxky9d7e
	 i0JL5zCc1DIgjjdbsBNCSas1cLsi8TwPkhQ0JgBaSxC7FFOLayzyQWJmqiTCvpZ3B+
	 ukr0LUpLiHF6Osl9ZqFAUj9DBhTj447hiHmKwtGoAalRqwlT1mXnMF5OnBIudgCFYZ
	 QtZ1QgJDtBHwMoFe/qXu2R761VEX32FgM1j2v9C/WToCNwxCXH5pNVn3eY4dUocGDK
	 dmOPk6stoPjYA==
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
Subject: [RFC v2 10/10] acpi/x86: s2idle: Subtract delay from last DSM fire in
 begin delay
Date: Sat, 25 Apr 2026 23:57:34 +0200
Message-ID: <20260425215734.14116-11-lkml@antheas.dev>
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
 <177715427328.3678454.9608862315811293747@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Certain devices require a small delay to settle prior to suspend after
the last DSM firmware notification. Since that notification can now be
fired by userspace, subtract the elapsed time since the last DSM call to
lower or skip the begin quirk delay.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/acpi/x86/s2idle.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 357d6f9406dc..06f08b5a21fd 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -70,6 +70,7 @@ static int lps0_dsm_state;
 
 static enum hint_idle_option current_idle = HINT_IDLE_ACTIVE;
 static enum hint_idle_option presuspend_idle = HINT_IDLE_ACTIVE;
+static unsigned long idle_transition_jiffies;
 
 /* Device constraint entry structure */
 struct lpi_device_info {
@@ -507,6 +508,7 @@ static int acpi_s2idle_idle_set(struct device *dev, enum hint_idle_option idle)
 						lps0_dsm_guid_microsoft);
 
 		current_idle = HINT_IDLE_RESUME;
+		idle_transition_jiffies = jiffies;
 		return 0;
 	}
 
@@ -594,6 +596,7 @@ static int acpi_s2idle_idle_set(struct device *dev, enum hint_idle_option idle)
 		}
 	}
 
+	idle_transition_jiffies = jiffies;
 	return 0;
 }
 
@@ -694,6 +697,7 @@ static struct acpi_scan_handler lps0_handler = {
 static int acpi_s2idle_begin_lps0(void)
 {
 	struct acpi_s2idle_dev_ops *handler;
+	unsigned int elapsed;
 	int delay = 0;
 
 	if (!lps0_device_handle || sleep_no_lps0)
@@ -726,8 +730,15 @@ static int acpi_s2idle_begin_lps0(void)
 		if (handler->begin_delay && handler->begin_delay > delay)
 			delay = handler->begin_delay;
 	}
-	if (delay > 0)
-		msleep(delay);
+	if (delay > 0) {
+		elapsed = jiffies_to_msecs(jiffies - idle_transition_jiffies);
+		if (delay > elapsed) {
+			msleep(delay - elapsed);
+			acpi_handle_debug(lps0_device_handle,
+					  "Waited %d ms for begin quirk\n",
+					  delay - elapsed);
+		}
+	}
 
 	return acpi_s2idle_begin();
 }
-- 
2.53.0


