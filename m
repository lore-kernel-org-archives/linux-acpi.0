Received: from sonic313-9.consmr.mail.ne1.yahoo.com (sonic313-9.consmr.mail.ne1.yahoo.com [66.163.185.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3766021D00A
	for <linux-acpi@vger.kernel.org>; Sat, 23 May 2026 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779497053; cv=none; b=sK1Bo3CQdLQ5o1FdBbtH0i5tgSVF+LYEo/0hbSRWR48K8D5cLS/PPPmIbMGCo1Z/y/ayDaPOusbQd1ARZYkje5RgOCy+/3uusbKPkG7zyh0TjqHBojmJvwawncNggsftcnLJ5VYq7DB1AuriHCLDw/Fn4uyu/AdWyfatRRG6CsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779497053; c=relaxed/simple;
	bh=urD6GaIfJwKMBFMpwmgmNLLHpRQz6qhYGlLKNW2SGec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJzCiBhhr5j1uBXpaWLuyTfwPNNcao/pGGDmB1dfr+YoJON43qmgyXuGYDYEvkumhHXvgedzjyOP/rKYDCXQ8JMAl4XjZRUVcTYaHbUXHFyL47DP6yyXeIGXS2tKqQQx0W303PojtamrJsk/qwXvPhgAKT6kE1I2lWK5wBWEuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=OD4KPfV5; arc=none smtp.client-ip=66.163.185.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OD4KPfV5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779497051; bh=FzknOax7kpG8A7HUtg2lGxyRS10yqdEpJcR5/6cx4ds=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OD4KPfV5/ND9XJeqVjlXAu6cSAWNR9foZTHvjhoCHMzuKuteQnTjEJMWaAMpGUULF31qYsn6L0IpNJDCS4u+Nud8fW3XslDkJVjHZ6iCCcny9k92hek8w3k5dT8C23IQn8TNecAQ0dNB4OiASBWC58j/zuZ3ZKl5mW8h5nQKX6SFlBf3iZPSpWZcP0jGV4gYNGp5BhDmLpYzmM1ubEjDv6UlMd+JlDH8U6rq41YAzoJJgjtOqFrpjaPl5lftjVREPWB6jV54OuMTUQJpSBQjPNchj3zWRJucKjd3JOV/U7uhCXz4r491IZE+PWFrwgVQJBEvtRJhPDMgNY/SJ8w6Vw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779497051; bh=+C4BXoqkEmCYPlBwKC1KuofGL59gkHfN0FgL+Geakf8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FrnBvw479A4i4UEGpnAtjwYyI2iu9FsR99UUqLU/eDcBjWALm7Ks+WzXlBZu3s6Hp28FsJTiqhUIUTqNCdMOUgU1Uc2JpA4ZkXZsA+sKhoLS5jtWt6MoWbfXE2tAYMyV2PYjEj6Tu6KRAGIUd6rwGlcvZESwna0Zxyiv/NyR9a4SBrIcWuj1cU8PvhbIUi/gUbV0sSYlw1+Z0tp+O9u9VZAErDDla7ZDXj96kcqNVXHDj21Ybi794acnO3nAvsNz77bFupCUOK5D+ui1moUvhCjvMi1PcK83mq2nOLLs40coIQUbdOz3oQ/tnWN9dV62HXvwaUjEs/FKZ4cjWDrnbQ==
X-YMail-OSG: CedHYi8VM1mliPHbE9VDR2hfdNhE5Tcy6j6zMAkAgyfhgasK5Uc7oG7VAlODfdn
 7F2fAUU.vOskXd9EDzDIhna5SJ6xF8YcZrotkpahBVZ.PVMGV64b8nbJ.HqlrMblOtwmzErO2DIW
 Vh4_mukSXeE4UocSR4tWBEGv5ns4cDnYzXfUT1PP0p8xwC68pLT4DbIbrPrr9ZHUSMAw7ql5kdfZ
 zaXUEarYWA9RXvxmmepGVz7Fg4aHk03cy9PyDQY6pNXbTUKoAXKbMAR6AmwcYIUxioQFFE3ls8oI
 K.jHl9e.5rwac4AZ4QfxYDZUzGl1rlLaJlUGmPq_3UbvHGhdk9ThgDUAfZvrcqe4dIhGrmodCA4k
 GVEAEJ7OsXUwCecAiOM9YMqFGb8Odzlv1af55fNUtFLX7RVPzx0aU_043L8NRMmgM8oW_RC9nPmG
 vjgsM6wWJLImXTUgqXUf8e.DdWoIxRQE2Ug59nn0HxvqLrbrrrS5uuUFXcXYKK7AxlCUQSYvSTCh
 _rLkjhqIqjz6E3JLa4ZEsLC0kHklYg.IhJxbBrcInR7Vx1Z3qRvMOoz6KoGzOPwCcKSw3HMnl3St
 .oBhZHuWoQvLC.KaJdiKg3vPsjIFz3mJd5Xrolr0xB9dslonyAKyDSjklFLmPSSdhsCfqZVw5IQ4
 BIAqdB3KKoQL5Wi7bg5xaMjO8A4e5sqvjIjesedl8wO0KeVNpnP8YbX6sjM6vYfO1rR94rMG.uAR
 gEQeL6l42jwFFy5fk_yGToKgQSmBxiTW8fadY.ASKwnHqonUCgDGw7touB7_BwqECdaqimoGuNtE
 EsBC6tW456vM.M76ouWdrj5GtK2D3Qld8ih0vFv44sw2A9gRKtalKnf7sM3xpt0MOoK7UCxiWSEZ
 mf4tk3vrrvx_IAHRcmNml3pvCHRxl75X1ZEOyPVA0F9qaGhH2Kf1PL8g.Bgy7jR2Dd7o5Y64qN3B
 IXB9MTwXcTaa22HPKz2zKwkOoTicW5Lz88trDkty.MzYrVZAtV.8kkaK1y7FWYsPCBwya0sPVbAa
 FN0QPnRfHej9hYPvKYH7YSyaMHAterWxnCXHm9iUoXxA1yTaE44hA4JurzBl_opzoTULbZHcjPD6
 o.RX6p_E7uVQriZBHydCe9VtA2ZMVkzrLqadInKRQc.TVR4T3gi1QqNtJun96bD20OzHsCxHlW5g
 h34vdCGmUkZ.WcjB.PrHZBLWjescpndEGVLoYCHcwr3Osd5gUKvDwKrH8yhgcc3e2fCpog.2C0Tw
 xVlLBNBr8YFEHq.ijRZthaaUkcm1AunFPrp8dca7Uf4zvXvGXxbGuXLIz6_iCfpn94FdeZMR0ESR
 0QaVeGxj1HzxcsxZgHHMdFesYLSoJYhr_UXiRfFOAWQSJYqfJOIJfxq3HLutWBzpoYROxN9nQZZ4
 SVgGxj8DnV7qpasw2usRgyLt2qlFU4Wl4bVgHAeGcKP.lHP6JRhCQz30VnrdpJPThkVWT28G9kcj
 Uw98K7LifacvhOxcUAlZ4opLVsYoduTtLGCyh7JRP0TUHSaxormyvj3mntfwdfS7b95IL6FQBQ15
 bN.cvWsiYF.Owl11_amJh3gnQwTPEicTdGb9UuYrYkUSqx0wIP7Ldw1Ex00U60.0uDUMkDGu_c80
 rwGO4E8vrE6f_ZHjiq3lD_cYMcOHwkEP.xwBGKkJZxDynSDL8QYSqZ7ztVuhQf06PfaK.kysk8KS
 sMXM6n2W1MvgVnYyTfgRaVrmGVLpiw9KEIZGd5KgapNfU04_GpmFWdAC9lppCT1.9ACzQA479Ks2
 ag7s8VR.fzzeHrDKj9QFpPEpwpfgYz72Hbs3LyXzMeOXkvRiyA.Jqw2E9a7PzOspCjiTQMrwz3ec
 TzhQOI7J5E.ncWj5UwyqzeTddIR4fE9Hy.5dT_obkqnIVMw5UmGypiBIBWzPCuIkpxmIb0O.kMdb
 YtkR9zPcQFLO1kcvWRFyCHlf1nd5pIS_4mELYlXzOCOb0wKzmXVZ4yQWlWuHFEfi8KBDOozIjU55
 QIPrW
X-Sonic-MF: <sakunix@yahoo.com>
X-Sonic-ID: 7c7e40c7-c057-4a74-9f74-1657b11cc9d5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Sat, 23 May 2026 00:44:11 +0000
Received: by hermes--production-gq1-7bb7df5c46-hjhbv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 472109d1fa8341d4a7fb471e72f29321;
          Sat, 23 May 2026 00:01:37 +0000 (UTC)
From: Manuel Quintero Fonseca <sakunix@yahoo.com>
To: rafael@kernel.org,
	akpm@linux-foundation.org
Cc: bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	mika.westerberg@linux.intel.com,
	hansg@kernel.org,
	Manuel Quintero Fonseca <sakunix@yahoo.com>
Subject: [PATCH v3] resource: Downgrade "resource sanity check" warning to debug level
Date: Fri, 22 May 2026 17:01:31 -0700
Message-ID: <20260523000131.7086-1-sakunix@yahoo.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAJZ5v0ikd24Vj3H=2XAGwwHtBudDXJumL4H-whu1GgU-KjMnmQ@mail.gmail.com>
References: <CAJZ5v0ikd24Vj3H=2XAGwwHtBudDXJumL4H-whu1GgU-KjMnmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "resource sanity check" warning currently triggers on certain
systems, causing unnecessary noise in the kernel logs for users.
Following the maintainer's suggestion, this patch downgrades the log
level from pr_warn to pr_debug.

This change reduces log clutter while keeping the diagnostic
information available for debugging purposes if needed.

Signed-off-by: Manuel Quintero Fonseca <sakunix@yahoo.com>
---
v3:
   - Downgrade 'resource sanity check' warning to debug level to reduce log 
     noise, as suggested by the maintainer.
   - Drop the previous DMI-based quirk approach as it is no longer needed.

 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index d02a53fb95d8..e676ea99c93c 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1859,7 +1859,7 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
 		if (p->flags & IORESOURCE_BUSY)
 			continue;
 
-		pr_warn("resource sanity check: requesting [mem %pa-%pa], which spans more than %s %pR\n",
+		pr_debug("resource sanity check: requesting [mem %pa-%pa], which spans more than %s %pR\n",
 			&addr, &end, p->name, p);
 		err = -1;
 		break;
-- 
2.47.3

