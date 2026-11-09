Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258115;
	b=zyUpqGe19fIs9/LP2AksPmeR7cflexwqvuDMakoQ4Y3FOCHCSvCLf0sEsQX0eHOQuckB
	 b5+mOIbmMDuC0MtmHYqGqwcyuLqbmUMxItxxoHxRtqhBnNl4MUc2rkl6lxIzJ+clOE20h
	 ywCO7yGUdwzp/CEzX8Eh/BgTZCd5MVZflJXbSrFqCuozaQD7ssF0G5kZ1+7ogjlILOr8m
	 i+v+FPKTQH6F1t1ZaPdnf/DDN5TP5zX6rF724IVTEpVKPcaapJmtCUIzfz/LzzrShMkAO
	 /kZcLGmACNgepyJyksUjXWkdXq8r0j0WUrVSC5r2az/HFZJQ9lto6p2EqdkmGFIKyeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1rRofamHWsgQtnXWvZBbAiHKmjpBdt9GxPKw93w6wfI=;
	b=Eb0HnKYKCrWX1h7LIo6BHIQ2dX3GXRfDKZe5kyvWgqhD8JNHZ2Zw1Tjew5gYSemI2nBf
	 o02IeAVA5wjiRTTpeglsmdJqvSRvSDhe8OVnObeXppafZTbdy+1lIbCXQm/W1NVgjwYSu
	 kiw1ZTk+FCWtVndLq+kIhWDj1Ysboc6DSDGV4srxy/XTK1qQH5EKTvwD1CMWuYNPnSHSK
	 e985N1l7TkJVKiNhJ/5ePu7uPnXy03NZc34o/dyf2XdoKF91LbIM/h+ytvldwY9YlakDX
	 Oz5Mmnd6xCrO2W88byX5Zc9/eNxGNTwWUDLE1SBwg3l/DK3S020BkurOt9nObMY+8EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D5L6amhx;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BBC606A321
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 21:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2BBC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D5L6amhx
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so745915a91.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 13:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794258114; x=1794862914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1rRofamHWsgQtnXWvZBbAiHKmjpBdt9GxPKw93w6wfI=;
        b=D5L6amhxFSoDqc8GwvGK3NvVz5o+I0AQvBDbqUKgOzZ/CdW25tCh9hjypnl+Xpd2ve
         HHub+xs/2/NInY4mxfESNkENa6n9PPadk9TlwMOLuchIADPTzqhp7IRsub52uCgO4VqX
         +FNiv7i/pAKGWeOaHu5/27nUSNVhWxpcNRsFjHMsR7rGe6tmzt0NFkJ80SKfoRiz+K+C
         iTov9Pz6KcZ5UuU/2vHccxPKHJ3hOY1k2afJUiOIn0HKH4uzJcS6WLUv9aFoUom/GSxs
         jOl1dWq49VnmO2BQucHm5wjdl+6ZhZ7azuhhvzWPTHhxZwnNZvM225Bs5xRrdSKCfb7g
         iRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794258114; x=1794862914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rRofamHWsgQtnXWvZBbAiHKmjpBdt9GxPKw93w6wfI=;
        b=dq83XlwtSBC5P5o4BzvyBwCfZkTfXvpD97r14OARcLnNmGxKrSGtKYcM1RBipl/T3w
         tRHCYSm0CgD9vHak9l20qgNWW+GlBljMLRty15MDyHYWA0iceWINhI6HlUanRgmGriTS
         KlVf6c/5Ekgmb9sqlguyMxOfDq/AumwvTOfCwHbUnqeYSMCHKgCRmy5aR9VbOJPbRfy7
         iuH9v9JGa7K4FKaMP33anKy2NpL7CAUp44kLW/HUXvJdYKYeP2FSl8w9PDWRHcVYw3Ow
         t+Bq3qyZ0JOiks9GYHV8EBfVE8lsoGxb+/PAZPUAaXcoJOxcOSRywajpfTix91aGr51F
         xBeQ==
X-Forwarded-Encrypted: i=1; AL+hErH6UmE/F4Y+D+xthJLNVXEXfyK4RCoSgUDb9fJGRDR4EEiOwpzormbE0gejoC3qdZgkDT1IGrc77ei0@vger.kernel.org
X-Gm-Message-State: APuU4Z8mm+Yt3G3T7ALcNyO28sCZGqjXFDblNw4S+MoRfqQH2ZQ/5qp3
	6YD+zQJdA9SeH5wVJIjbKpAoCIWFWFXQJ/rxuUg05gAJJnBcrHIEhlS2
X-Gm-Gg: AYBFou17pbsfHjMqsTkBxsK5FbmSqbGWpiXT0Yu6FypPuV+OZqKhT+NWw2yFkvRmSkb
	n1XmUwsFWl+h/NJ+FbpIS2MqQt/vdEuj9M1+Vje/UmzydvqMfcbAgseJh3HnC7MWmmz+h8sfguL
	4ZWoG2s6dq+ZqRt0ksCeAKFBj1QK4tPUAC53QdpC8nf+KHmDtuwBCU/YH0aE6oXcx4EXKfsOift
	6mAb8L8yibqUOv6pYuffxVaWs41gaTpd2+yL1m1vm9mWe6fDodOh32B31h5clvsFZUMuDU/GzAS
	jlAOucU2qd7xTKSewXdtYZ1NZHRPlqQXxuUvCrlT/yBUT7yzcfdRYc1oFE+QRpub4K3u7hqGn1k
	NlFbC8iGWv0NtQZsCeR0deRl2wNhlaMD7gX1IEZge43hO3qEDyq1bLtSchpF9gqGKIAVjiIStB7
	JoPg9CENpMs7qjuyYZlITEcGQ13TKuZujYPj7TOg7lT9HNycEMrUe2oJdtxs1BICnUsFH6Y8hFX
	bH/ax4SbR4OsgJqY9KVSP7DqeFChlv1s0vP4+BUAKjmuoUc0iF6QFmKl6oHTdZlZu/zW4T0rEgK
	E7NnOdvaUNPu4kfkpmT+ZkN3YMxE3SH5U1pDp4lWNkWVr078N7cwnMNS3tLzE/47PmL2wFOp4gy
	wD9hTauOQlxK3pfIK3cnXONiMF/R5YSjfjAl0QLLSAivmn8LJ7+68+oT6dDf3vhxFUHSds5lsPo
	RGJTnqhRJK2oaVQTrZG9ARF5FT7RjL4ATEpARQlpBE
X-Received: by 2002:a17:90b:3e4c:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3b1679e9575mr500295a91.32.1794258114035;
        Mon, 09 Nov 2026 13:01:54 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168ed00d2sm275299a91.1.2026.11.09.13.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:01:53 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Jeff Kirsher <jeff.kirsher@microsoft.com>
Subject: [PATCH v2 1/1] i2c: designware: Add ACPI ID MSFT0006 for Microsoft Cobalt SoCs
Date: Mon,  9 Nov 2026 21:01:46 +0000
Message-ID: <20261109210146.57766-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
in acpi_apd.c.

Without an explicit MSFT0006 entry, ACPI device matching falls back to
its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
the controller's actual 300 MHz clock.

Acked-by: Jarred White <jarredwhite@linux.microsoft.com>
Acked-by: Jeff Kirsher <jeff.kirsher@microsoft.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/acpi/acpi_apd.c                     | 6 ++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index ea226fd987567..66a7607752d9b 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -198,6 +198,11 @@ static const struct apd_device_desc hjmc_i2c_desc = {
 	.fixed_clk_rate = 200 * HZ_PER_MHZ,
 };
 
+static const struct apd_device_desc msft_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 300 * HZ_PER_MHZ,
+};
+
 #endif /* CONFIG_ARM64 */
 
 #endif
@@ -272,6 +277,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
 	{ "LECA0002", APD_ADDR(leca_spi_desc) },
 	{ "LECA0003", APD_ADDR(leca_i2c_desc) },
+	{ "MSFT0006", APD_ADDR(msft_i2c_desc) },
 	{ "NXP0001", APD_ADDR(nxp_i2c_desc) },
 #endif
 	{ }
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 13dd7c50486a4..cf364f3c26199 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -280,6 +280,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ .id = "INT3433" },
 	{ .id = "INTC10EF" },
 	{ .id = "LECA0003" },
+	{ .id = "MSFT0006" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
-- 
2.45.4

