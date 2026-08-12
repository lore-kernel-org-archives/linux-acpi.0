Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3A4746A8
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548875; cv=none; b=s6MU90AqvBy9qTUrIJXWAHGU4M3K8I7o+HKZ8b32Wy+VoNQSMvOLv0bcecwWIjQb0WwqpN66MSCQEknMjgWUWGaWG31q6N4ro1cAFHB4r2r49+bHYI854Wiaocg5E+8TTBd+4KY0lm9Yt/3DijYbl6QNaUifdn55hhZnNkWEfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548875; c=relaxed/simple;
	bh=BW+pwps1I6hyIq4fVhrPN0rElN20jmXdCuok9i3T7S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l6GL5coiAYhYgZKOdHl762ms+kXopCg24RZnk8XvruZuvNQnV8iI0qaa9Mre9XpnE97yHgDKulJXzl/jmuEOc61VPMnlkD1oJynT9D8uJ66Thz5OC1WCkIme9eLgV8bnbpRvP3kHMDXaMFCj9ngVp6hJt9pmoyvRtsk447E+a+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6OEMyvK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6OEMyvK"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so898184a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786548866; x=1787153666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/jMN3WBwV3KB4v9bEDXkBGlhmHx1HUQvcapjqufTDqM=;
        b=A6OEMyvKRsXsuQ9AksPHnd1ro7eVsutF6AoMmyGbzmc5nyg/lx4Vv7Dm9JPVQCfnXD
         kYo1KSaEwbs1QZdbrLZiyDorant/K7OOqctnl4/Ev4GTa5U3R38bvff6+e0erUBUGgfM
         TIrnboR6thlM6mN/7Lqw3RBPXyzskWigTNd1MSTqOxBT89f4zgKZrDgpT31ILEwbLnCa
         GIqkBYcZvu9oQEo/tTmOhjnXUTuiwAZkAQRFNQCwTwLaWJNon/7uIfOIMh2ZBIg5A1a2
         LmsDAsaPYMoB06evbRp2+j9aN4tVAb+AT1Qry7+cooE0nx5g3UcFGydBAUQ5yF+6AHi0
         lIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548866; x=1787153666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/jMN3WBwV3KB4v9bEDXkBGlhmHx1HUQvcapjqufTDqM=;
        b=aTWKaFlOpSY5IgVk1QHnwBtQ2ocD5WsgMDYpuTTe+QvhmayOs5LY8nla82nLUAv2Wk
         /Te0e/xbYT7IP0xHeFyk4mLdu87AoKeiyBXvAFN8qtCJ2qIMGDn+KzNsqMMQTpb3WO0w
         QaMjRfCR1PUDo3bmLFr480WSNulVU7AYHlSowvmtC15hLQELLDrNGGhybKw/uEYs48GR
         VeMO39dmcgygFQDHb+eOqc6I0trBXMzgUH6/K3HOou2fwbAZd54MKFElKI64pK4HxGWA
         vkT7azglnS1rz/BjMNg4exPdkm+uiMfXZgioNVDRyJO8RqA7HQduKsWNTk6BZrGzPcMp
         CuOw==
X-Forwarded-Encrypted: i=1; AHgh+Rrn65xz9SbhTxo5GZGGnrtM14J+2lNXNSW4YJGgkKVVfi2NFlUVgp5z6h9umZnBBmbNXEBVi75gAGpI@vger.kernel.org
X-Gm-Message-State: AOJu0YzPeQCQdKmdLArN8ssCtzKYen5qHgs0gnf5KA4VTiae8gHqExxK
	6KD62N9IgNjcCglNL7ft46YRM+gcS++un1WeBl+k2UHAUVy828AZFQU=
X-Gm-Gg: AR+sD10PQjKmwGMQET/vgBCduCijgo6wtGoR+gJZ2twL+tc5+DQq1Co33G8r69pQvoi
	eGMwPzVLezxPaQd3Sa0MEHLN4p9NJBvQd7dP2cw8oQtgeiwMh/4EZVaIJMHeM3eG9TyBcm0A1dR
	Kli7wVxFbMDru2l2SyvknyoC03tRKtZQVwSMerOKBIbBARcKGyoZWZYW90xJ6/rsvpjHaUTT1K/
	ttK13pw1p0OFFehx4HwHKQ+fi3i3Il+E1MMrmiJXVxWULbqHxTldx/hiQLsIXgu7pilV+nU5rui
	BxBrfvIssuwCt8ZJNDFkE+qhOjZ10JLiUDk2Atj1W7yeMWBwl1TjPG/YROpEsppx5aWqjPRF+pH
	Em3JcXIbUGjyckNCm7MUx0ODqyh1czZkcVGc4H77Wlbu2O+ZrnzTlRWQloD4F2wOvsqRKpV5Ry9
	vB+/TRoyYMmLZQZecCF0nN4+FPkKSP8pn3JZoKGZvoCbfVTe70/7sZkeAyxsZ7CJWaWKOVPM8zE
	mcauXtCY27EeGFN1upLU0Tv
X-Received: by 2002:a17:90b:580b:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-39301490293mr7234944a91.9.1786548865759;
        Wed, 12 Aug 2026 08:34:25 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([14.97.72.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31dba3e9791sm7160804eec.0.2026.08.12.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:34:25 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Sebastian Reichel <sre@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH] debug
Date: Wed, 12 Aug 2026 11:34:06 -0400
Message-ID: <20260812153411.1159-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/acpi/sbshc.c                | 11 +++++++++--
 drivers/power/supply/macsmc-power.c |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 6bf5c5de5b89..a919be8bff05 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -207,6 +207,7 @@ int acpi_smbus_register_callback_global(smbus_alarm_callback callback, void *con
 
 	struct acpi_smb_hc *hc = READ_ONCE(global_hc);
 
+	pr_warn("registered callback\n");
 	mutex_lock(&hc->lock);
 	hc->callback = callback;
 	hc->context = context;
@@ -233,6 +234,7 @@ EXPORT_SYMBOL_GPL(acpi_smbus_unregister_callback_global);
 
 static inline void acpi_smbus_callback(void *context)
 {
+	pr_warn("acpi_smbus_callback\n");
 	struct acpi_smb_hc *hc = context;
 	if (hc->callback)
 		hc->callback(hc->context);
@@ -243,15 +245,20 @@ static int smbus_alarm(void *context)
 	struct acpi_smb_hc *hc = context;
 	union acpi_smb_status status;
 	u8 address;
-	if (smb_hc_read(hc, ACPI_SMB_STATUS, &status.raw))
+	pr_warn("smbus_alarm called\n");
+	if (smb_hc_read(hc, ACPI_SMB_STATUS, &status.raw)) {
+		pr_err("smbus_alarm: cant read status\n");
 		return 0;
+	}
 	/* Check if it is only a completion notify */
 	if (status.fields.done && status.fields.status == SMBUS_OK) {
 		hc->done = true;
 		wake_up(&hc->wait);
 	}
-	if (!status.fields.alarm)
+	if (!status.fields.alarm) {
+		pr_err("no alarm\n");
 		return 0;
+	}
 	mutex_lock(&hc->lock);
 	smb_hc_read(hc, ACPI_SMB_ALARM_ADDRESS, &address);
 	status.fields.alarm = 0;
diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/macsmc-power.c
index d4614fd728c5..8fb3694ddc58 100644
--- a/drivers/power/supply/macsmc-power.c
+++ b/drivers/power/supply/macsmc-power.c
@@ -927,6 +927,8 @@ static void macsmc_power_acpi_callback(void *context)
 {
 	struct macsmc_power *power = context;
 
+	dev_warn(power->dev, "got interrupt\n");
+
 	power_supply_changed(power->batt);
 	power_supply_changed(power->ac);
 }
-- 
2.43.0

