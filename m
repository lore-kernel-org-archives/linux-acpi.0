Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082572;
	b=C79nMbIZORkv/aquq+nIIGjHUJE1LfprwvPjereF4IDAkzPUrzzfJGXAlorCKwXfWi/M
	 7/nTLMc4Rg06iBuzxVR8qNFxIJjcHUNJX6jOOGN/pqEZO28qrrQdS4s6zOKNC+Nbk+vIj
	 nL8NRt4eilFvFV9RqwItYlc2jEqsFv3LkMF1XL1wqoJYFtgboZPXdxui0efDJT+qSamaj
	 WR7FcFSZ65G7xaj9H+ef3/caYE0QbzAAPitKU370TKj1GV9UUZ7QbDcBldMM4RHkSKFVi
	 yLz9yoP9hYGD2L1TSufLEz3PHeKV96Y6u7xj4HNOouvNGF9UlpGz2nrlDbhpTM14P8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MRGtR/xM2hkitb9/TQ1LM0e/3K3eoc1ThDALVep6pH8=;
	b=M6ri9ENZQB+eGvfPMKS6+l2gUdV1aHTx5bSqV1Vq2cXF9MoVAGNajjZdwwjQFUKva4Rc
	 HE5ls1gZrc89XuTZ/qzE2jarp7H3j4E23xUsZKxChx7oyCbWSleT6E8E0kGfoUT+UvgqH
	 PH3L4JjwKOj68igSAYV7ALR/TRzC+qHYWQ7TT35IGjUGxMMBBluKZImu7Z4asU+4JZ4Hn
	 R6MCwXvVnn0ZlQHQJk58/WCu0nRq8qlv4SAPMCcw1g0cQSadrKw2SnjlKG3cWrkvEn5RX
	 vwYDZIBJPYiWWXPqrCCMyT3ixg2xxlwcDDClAHfRyTQ4peHRkmyjXn1m1R6bSm1PLYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MZVhQxWN;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54339606A326
	for <linux-acpi@vger.kernel.org>; Sat,  7 Nov 2026 20:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54339606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MZVhQxWN
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso18855505e9.1
        for <linux-acpi@vger.kernel.org>; Sat, 07 Nov 2026 12:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794082570; x=1794687370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MRGtR/xM2hkitb9/TQ1LM0e/3K3eoc1ThDALVep6pH8=;
        b=MZVhQxWNfMYU5hB8FHNQ2thbUux2qMhFmANkktLXSu0oY+V4uh5CcMcXqT+dDlQ/ix
         en5kHuRMLHLDnHmK1Y6M1Lc6Tli0+2hKtnNnmOEToXp8AWy3HbaUP8u3adql60MovtwK
         oOIXtCDeYKxdnQ3au4PcWTtrV+FOpAm/pHTvSs4egqY+RqwRAxCiC09beKmeq4VpzBX+
         zresHB3NeTfWKhhg4PSnRaq9E70uuY3l51ZjvqVJ5RGHaRPq9hrM29vznWVI4eRxpMPo
         of9sq8+UBA4XsXdkY09BKnZn71uknKv9e7koMO8jbe2dc604VjdmtTce3h5aO3jEx+sW
         g1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794082570; x=1794687370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MRGtR/xM2hkitb9/TQ1LM0e/3K3eoc1ThDALVep6pH8=;
        b=QaTmQxyuHSZHyzQgWzuTO+5ZdZz0t/9kkZarlVX3hVk9MOnw30PaUT1F7UjjQldhNo
         8m+bSAKw1dau9s5zxCPOaTQuuPMCWI/Wis0h12vn9fS43nr8hSczrA1+ppeo/4fcvXF7
         G1/4fIZlmPaHaplxGaEvJ4xQAGspibDp8N8yqM0TDsGAPLk0JrplxMhLDCOljJicijEx
         WJj8ypgLeGgq/cTQw2JNaNAKqT5eTCuxPhlwmvVOp0B2APDvbnFBGswoC/5f2oV/Wipa
         nF2kfLB2ZhSZ882RwjtHN6fDqhSGp/0zJcwJ5HvTgkp1P7TTFcBG3OX61tytayRrKKHm
         vQIw==
X-Forwarded-Encrypted: i=1; AKwUvBxtbc8PdYKgRF/LVgdIUCPgDu4xd6sZkGLObtu3+t8eEdrLuETx/axCl5oDa98MIow9vNB7ihxOjCvk@vger.kernel.org
X-Gm-Message-State: APuU4Z9Z4O0rvDFDAu3QYvCYezGNjFeJ8Vx4t6VU3msv7si2UatdgjuR
	mJT0qxT1FM4hPlhk7HTMZ+ZeNVdzrvBq6isxtGMBjTJZ9vHaOox7Ia+b
X-Gm-Gg: AYBFou2F8RXZSIzl/AViNO21rB1oicDSnDWkLNeQmoUGkHWD2Hm5aZKjjryLn/nvZSz
	k6W56/1pBDserP1yuXT00I4Xt37D8V8niyhDVDzKUFEu+5E2Cwrbn8TOdHX+NEszXQbqAj/OOqx
	xyo0427vsk5K5c/CV68JB4y0qQ00iKabzrsMoVB2P0YYhU2jkuxNnBVbmVOOlOss+0vU6/mrOa1
	+kmfqGs7mZj/z86fqItjZtDTpJMa7UgQHL4dIzFjgP/g9k5w1bYOAg7yTMGc4o3bVHbUW2Hr9IC
	Qhi9sI9kNQeFR1OYRzBoliJxNYO+0iP03fUZTeDQB4o4EsZ31vdol1gdoacdAiLJH4zUbefWNua
	6oVBtSGnU4MyPdOH7dSOkGPQofbliXFIQAA4NO1b9fJwzArYpi1TJfLunKe5EcMc/fpIxwIVrBv
	8JlEWSU/gKNQdmUUuYnJx2PKi2uSjwmzaQ1nIGwUM4E4oT5Kw6Np4LTz1tb13JGG+bml1FIF27+
	UI1n7A62J7AFvtt/PubyKz3mYuD2szcESH2jMgHFtrvtLOZCu7tOgGqjyr0LfWEvTY1CFZVQVWb
	3nBNpB9fg+2nar7mLKJlvvBTrzZ+myhtUgwRYorHFa73qA8=
X-Received: by 2002:a05:600c:138c:b0:4b6:5dac:b61e with SMTP id 5b1f17b1804b1-4b6df6df5d9mr103278195e9.32.1794082569692;
        Sat, 07 Nov 2026 12:16:09 -0800 (PST)
Received: from Amir-Yoga.tailec48ed.ts.net ([143.58.202.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad610sm230762005e9.3.2026.11.07.12.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 12:16:09 -0800 (PST)
From: Amir Sabbaghi <asaba90@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amir Sabbaghi <asaba90@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: EC: Add quirk for Lenovo Yoga S740-14IIL
Date: Sat,  7 Nov 2026 20:15:53 +0000
Message-ID: <20261107201553.9268-1-asaba90@gmail.com>
X-Mailer: git-send-email 2.54.0
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

On the Lenovo Yoga S740-14IIL (81RS, BIOS BYCN29WW), the ECDT
advertises GPE 0x6E for the embedded controller, but the EC is
actually wired to GPE 0x43, which is what the DSDT EC0 device's
_GPE method returns. Since the ECDT and DSDT EC share the same
command/data ports (0x66/0x62), acpi_ec_add() keeps the ECDT GPE,
so no EC events are ever handled:

  ACPI: EC: GPE=0x6e

  /sys/firmware/acpi/interrupts/gpe6E:  0  EN  enabled   unmasked
  /sys/firmware/acpi/interrupts/gpe43:  0  EN STS invalid unmasked

GPE 0x6E never fires, while GPE 0x43 is left enabled with its status
bit set and no handler, so each SCI it raises is counted in sci_not
(about 7/s, 1.4 million over 55 hours of uptime). As a result, EC
query events are lost: the brightness hotkeys and several other Fn
hotkeys produce no input events at all, and battery/AC notifications/
laptop lid event are not delivered.

Add the machine to ec_dmi_table so that the DSDT GPE is used.

Tested by overriding the ECDT through the initrd with a copy whose
GPE was changed from 0x6E to 0x43, and later by applying this patch
and removing the override. With the fix the kernel reports
"ACPI: EC: GPE=0x43", gpe43 receives events, sci_not stays at 0,
and the brightness and other Fn hotkeys work.

Cc: stable@vger.kernel.org
Signed-off-by: Amir Sabbaghi <asaba90@gmail.com>
---
 drivers/acpi/ec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a89f10256..7c0643d5d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2007,6 +2007,16 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP 250 G7 Notebook PC"),
 		},
 	},
+	{
+		/*
+		 * Lenovo Yoga S740-14IIL
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Yoga S740-14IIL"),
+		},
+	},
 	{
 		/*
 		 * Samsung hardware
-- 
2.54.0

