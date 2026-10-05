Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FF4CB8B9
	for <linux-acpi@vger.kernel.org>; Mon,  5 Oct 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222628; cv=none; b=q9bo0J+3b87Drpesf7LcwmfOP4T2rHCq80ErPlzdUk5REm5uwv11xPal6j321h2QiSfotbBYjHzuFaDtE9AWDNg1gIM02V8Fvey6jeh5LY+5GQNHPHCTgX/YkGbUZfrPVqG3iENX2010JCzfpsfyKEKfdRbnLA1dEAViIZeoWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222628; c=relaxed/simple;
	bh=uC4N6kDGNZ60H4Z6vYY8qHWcXEtUdvHlfqRDVS4CX/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KNka/JONL0Ni2PMEWSd8MmLzKfoovQlXehost/XUocxFh3uH6DTFeT/1asBDwT1JAHaLdSgvu3tiUWc+C8Kxv99SnZHgn0OlUYh17awUjZswrFO7SfF4kWHztUFtBx6nL3ygxO/Crv2PB/rDIk/Ri3TLVzGmBvBq9LamPIxGCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cit0tw1o; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cit0tw1o"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a1742171d5so4928995e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 05 Oct 2026 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791222626; x=1791827426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DqwXYeDMzOLK6QDykmnpHzDSXaAWN0zurPaKYTPdxsM=;
        b=Cit0tw1ohsJQqY19oa0wcy5XxR3yldZjHvgl0Dk9zpWCPMPTuJbo4oejfu+52INTvO
         XMZFVvX+nacRoxN0RjhaVVdxr3sNxlbp4tPvrkBhih7yjfiXNbjULSkaywopRwXPTPQW
         v9RVuVUkGFA+T7Koqrt8XciilHcoWIyfmROy1lJQqyJ03cGWnAuR3KHbzix82vSGBf2x
         m1UYg3u7tNL34HxRBIQf5HueoiCzWL+0530/HaXLQIkRpznlqgoAGscezN++J9CDkuoo
         QWu0AuuiwBhzkQEuVZLfg65kgIEmDCcYL22S5LaevpNDYO9393ZuwIrrDp3q1kGU3SW2
         dM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791222626; x=1791827426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DqwXYeDMzOLK6QDykmnpHzDSXaAWN0zurPaKYTPdxsM=;
        b=hjaIy/XeCTrhOGrW+6wARB49XOy/Idw+a4pN2km3kmSgeeJ20AzmZ8NCBzUBtZvbbl
         BXT0PbUHZlG/+OtZ9DAKuxSbgbvz03wN60wvcI2shjFTUmWN8V8c78R2Qpx78aVlsXBK
         XYVEMjljbxy0XclcqMu9ShECrsTwMm5olxsbjMOUZNIVv7v62GxsK41P6DULaSjpL5kp
         1nWVw6lpFyzKb7ZDrJ/CE+S9M5LYFp6z9t8w+u5LF+M1PC6x1KXLt6+qQM0H2ynGAhZu
         584L49P6qKne4edBKkH7giv/JMdqhRebyEk3g62+DO+r2k0pJ96FHy/5NMVSN7zqKJHs
         ScNA==
X-Forwarded-Encrypted: i=1; AKwUvBwGfoDmi3oO2km51vplS5z/S6dn0UMCQnnV2RWbKNPY331yf8t9Ap5J2jZ7i5ODAx4Cox4q1ZEhYUFG@vger.kernel.org
X-Gm-Message-State: AFuF++meWcrG5HUW7UIIuLQNlHN+OIIbVrDHDTu/V1y8jytVc98/MGwi
	qkkmuJyY3913WeHt65wppPECAtux3pHy3f4d9MOjJwIdBb8EfTmd3RQeuIOHm5BOjegHvsJY
X-Gm-Gg: AYBFou1pbbJgpc/IUhEMbRbFQm54d37dhy9Uqjsq0Mik2QJM5kqSsuBWH8uwH07j9Ta
	A72O7Lk/gG1gmY4MJLguouCRwwpLKy3Ao34SkfPZhUTaqKLGmcJlkPa1MPfY592bQKLrDOWw4UM
	GHj4u23uqmljkQCUjcabbEvPGkOGOUOZp3dNhTArkE9H4jqGTky5WsRI4nPMz9LGf4k364Cl0ZB
	+t+pan6fHUBJaMgxCVNf/k4Yt09rpiZalLxXhLIQ+tZuAy0xH84S4fGCqyqfPLKsnsHgWUC2MaA
	vSbBhOTv5eDrso9Cahduj03/zROBgpFph+5j+RiZVLlff5d+3boYTJyax84fNduQmW5Vx5pBde7
	wEv7hmZnxjx1DyCN+d+LGArtKnt9O/HG9ANPldr49QMkNoIObk2etU+8Y38tLJm0aPrPvN26W5L
	jMPMVZIdNH2b1uZgGlFecVepBF8nZITqFyfiQbUZ3t/bF6FDklBnFzZIrXDaaJ+tVz
X-Received: by 2002:a05:600c:1546:b0:49f:bc43:9e96 with SMTP id 5b1f17b1804b1-4a027572e12mr206653365e9.8.1791222625570;
        Mon, 05 Oct 2026 10:50:25 -0700 (PDT)
Received: from kali ([159.146.69.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178daa062sm5570555e9.8.2026.10.05.10.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:50:25 -0700 (PDT)
From: Hakan Abay <hakan.abay84@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hakan Abay <hakan.abay84@gmail.com>
Subject: [PATCH] ACPI: PM: Add unused power resource quirk for Casper Excalibur G900
Date: Mon,  5 Oct 2026 20:49:39 +0300
Message-ID: <20261005174939.53873-1-hakan.abay84@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the Casper Excalibur G900, the NVIDIA discrete GPU and the second
NVMe device become inaccessible when unused ACPI power resources are
turned off during initialization.

The failure is similar to the THUNDEROBOT ZERO case addressed by
commit cd7ef20ba8c6 ("ACPI: PM: Add unused power resource quirk for THUNDEROBOT ZERO").

Without the quirk, the NVIDIA GPU and the second NVMe device are left
inaccessible in D3cold and attempts to transition them back to D0 fail.

Add a DMI quirk for the affected Casper Excalibur G900 with NLCC 001
mainboard to leave unused ACPI power resources on.

With the quirk applied, the second NVMe device remains accessible. The
NVIDIA GPU can enter D3cold while idle and subsequently return to D0
for accelerated rendering.

Link: https://bugs.kali.org/view.php?id=9891
Assisted-by: LLM
Signed-off-by: Hakan Abay <hakan.abay84@gmail.com>
---
 drivers/acpi/power.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 23a4e207a01e..2e79defca42b 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -1121,6 +1121,18 @@ static const struct dmi_system_id dmi_leave_unused_power_resources_on[] = {
 		}
 
 	},
+	{
+		/*
+		 * CASPER EXCALIBUR G900 laptop: Keep unused ACPI power
+		 * resources on to prevent the NVIDIA dGPU and NVMe #2
+		 * from becoming inaccessible.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "CASPER BILGISAYAR SISTEMLERI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G900"),
+			DMI_MATCH(DMI_BOARD_NAME, "NLCC 001"),
+		},
+	},
 	{}
 };
 
-- 
2.53.0

