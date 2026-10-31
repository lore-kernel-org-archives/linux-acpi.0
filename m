Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793457681;
	b=n2zO5f9HTOyV4ih8dp/eyj1RXJYaH4mfXup56500O0eaQG9KcRyA0MVjtGKwhs6J3rxo
	 EF9ooFjPgjbklTyBbMg3sa4/wlfR8Ye/JtN2OTADWWDmZxSLwuPbv0OIEia/2tmYjVQPA
	 emtnkd85C9RMnChuXETUKIV6ArncNd2q/PxZNlNarI6JO7kefZACqa31VpNzPk/OLJBcB
	 8W8WMegWokZmnh3OZnFMfQ01vpLfuAP3VYIfToQYRFWWlHR3RFhwzu651DHTQJoQ1pBVr
	 QM8obWFFREAgQoUEgcF3GuiF/llcJEgABanf0mnNNxRJalBBgYaegdnhPTV3tfoPvgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793457681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oCTOQEu19vJBXJZSzplSgZ0tLJZz7jYyxcdF5qx0J8A=;
	b=A4fUzdGtvea1pRnb+fxeBedqrQ3ellzMaDx4V95GygslH7U36f7pdR3hc6CShapL/ozh
	 ov1GH+0egtJcLK2MW0qMrTt5GAjOUwS7Ud4epu0oovIip6sn+rQgsil7tZ/cVM7PCwFQA
	 VTCf+66RfiJ1JVmWCrRdzjKemKTc1QbbmNI3lz1lnd7QatSEjHG/Qb0odlONoNswWYulH
	 mcMqRY/KLYPC2d9pN+cn0gzvxGAlVdN2WenALnZPtbbHwkIyMAVgNMyn+0ZNkIkiZaDEg
	 hj8IdTYemIMpt7hjtT3n+N67HDUo4Ly2RXTyDLN1IeuOwRXUQ8Yld3UERR9V6OjduEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F+0Zn6Lp;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2016606A31E
	for <linux-acpi@vger.kernel.org>; Sat, 31 Oct 2026 14:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2016606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F+0Zn6Lp
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a7992e2f7dso17537815e9.3
        for <linux-acpi@vger.kernel.org>; Sat, 31 Oct 2026 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793457679; x=1794062479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oCTOQEu19vJBXJZSzplSgZ0tLJZz7jYyxcdF5qx0J8A=;
        b=F+0Zn6LpVJkO0s9itSEl6vzhKyFlbNanlpwhwgkV95PMhEQYnpfvCMwa8aXCaV7/C2
         b2s6hpnG07tyt6seYAbyNM7h4of6LC+dOWMG1XfIs1uoPUlRa5/WUtxpdyk+1hcqZJ6S
         yo/cuiIQ82FH2/MzEkAoq1BGGhXsws1Tsva85OiEYDyl1sm4cs2IFxBQ6QqkLJldCAcM
         IGGP3zyq8IVStMNZ2+ETWO0g8XNRdpo4inmSaGgNahygeF+nOnfqfGTudVtt6iVv6ocU
         YAzS9Dfj5uPrio9CTuKUOI/AY74t3jIeiqw0wbRT1d+KjM0K9WOKZi7kv7J8gVojnZmn
         xo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793457679; x=1794062479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oCTOQEu19vJBXJZSzplSgZ0tLJZz7jYyxcdF5qx0J8A=;
        b=MaRXQvQpwr1bTFutDn0DPHnLXlHdZt1Fr6oMxk81d/rEY466u9uN+yUIFrDYF0kM7j
         1VP0qtGtBsYQpot0B2atngYU2zECz7nFnDOj1k7nxuqh9K6+l5Hp2WRYBVN1wH+MWc7L
         EchBXME5o3R7NmHlLgLWrhfj/Q1rJXY+lUkMfqqcM/WfpGC/hT/WnL6yvfKHrh+64m9j
         xAWBGQ1T0NPDbg2bCjSYwPkOoHqD6tPGKhPw118xEx9LnJREbQRSmnb78Oly2pvJLJ1E
         c9PjKTuqvYlJMMK/UmrZM8eLOztThxbbSOUJh8PyfZodkbCzi9HYDK7bks5DClRYjSqK
         V3XQ==
X-Gm-Message-State: AFq9FYKW+CdwsMuLkT46SdkJxiFoSmouo8sdUa9ykGJp7AATCbrVE830
	XjaTeN+T9yvwqMbV41HItjBJyCkQtuWZQbczoTBj8AiiEUt0OMXnAMIv5uYg/ESp2KdwyWVm
X-Gm-Gg: AYBFou145+5eE8qw1PQF2pPUS3L32NCWE4tKTplkcoCSAXLWmr2UcmyRvgdBdlwQobv
	qJJVhP+wSKSs1vvFgXRqpQsg6JtQ8cskrh1NFD4YulF0Bynh7J1v+uTS+S1IwbqwJI6LqbfQbC8
	X0gtoLfZ33E6/sBvUwm3U0mJ7V1kcl5TZC8Pm62t+MMk6/QDElP2FzbDi0x6912B2hBmMDnylmK
	wUj1M4m3auhHL6MuUrFgfUd4lZ9YhAA46us/RirslvJvYQ5fIdgrThgX0MoJ/jQBYaf4z6322N9
	3hVA1ZmHJ+ishgr9p6h4xk3C76ofuhqm/PVcedYjyCWfUXOVGYkayalfqQpgmeRg90jmSlc1y65
	VocVJJjY5wzOAMRUUeDWLqtBLD3h30t8h7dCQER1MaZP53OevSNiUGD/omIYwgnqRSCI3e0LglK
	Sq1Q6PKDwXs9o7/6v/oM8i6AUBfzJiIBky4NAkDJIj2SGJwPyPkp7YPdaQQx77XnPgVlWarW3UU
	n/CB0AzL1Myxkv8U87LavB9/XIRuRLXsUYD+c4yUoo3rZdRejPivAm3LFa4uWVD6hPaBJRILRBM
	h3dHL4IFYhbX2veto+GGFJNGWMzIpl5yHYjTMhwwBvCZ
X-Received: by 2002:a05:600c:4e12:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4ac1765cf2cmr129879855e9.19.1793457678846;
        Sat, 31 Oct 2026 07:41:18 -0700 (PDT)
Received: from localhost.netbird.cloud ([94.242.199.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf67aab10sm132090535e9.9.2026.10.31.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 07:41:18 -0700 (PDT)
From: Andrei Galiant <zakat1984@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrei Galiant <zakat1984@gmail.com>
Subject: [PATCH] ACPI: resource: Do IRQ override on MECHREV GM7RG7M
Date: Sat, 31 Oct 2026 17:41:15 +0300
Message-ID: <20261031144115.4189-1-zakat1984@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The MECHREV Jiaolong17 Series GM7RG7M (TongFang GM7RG7M, Ryzen 7
6800H) describes the PS/2 keyboard interrupt in its DSDT as
edge-triggered, active-low and shared:

    IRQ (Edge, ActiveLow, Shared) {1}

The keyboard controller actually asserts IRQ 1 active-high.  On AMD
Zen systems acpi_dev_irq_override() skips the ACPI IRQ override for
GSI 1, so the IO-APIC redirection entry is programmed with the DSDT's
active-low polarity and the interrupt is never delivered: the embedded
controller still scans the matrix and places scancodes in port 0x60,
but atkbd_receive_byte() is never called and the internal keyboard is
dead under Linux, while it works in the firmware setup, in GRUB and in
Windows.

Add the board to irq1_edge_low_force_override[] so that the standard
edge/high override is applied, matching the already-listed sibling
GM7XG0M (Jiaolong17KS).

Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
Cc: stable@vger.kernel.org
Tested-by: Andrei Galiant <zakat1984@gmail.com>
Signed-off-by: Andrei Galiant <zakat1984@gmail.com>
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 56df459..0a944ba 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -553,6 +553,12 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM7XG0M"),
 		},
 	},
+	{
+		/* MECHREVO Jiaolong17 Series GM7RG7M */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM7RG7M"),
+		},
+	},
 	{
 		/* XMG APEX 17 (M23) */
 		.matches = {
-- 
2.56.0

