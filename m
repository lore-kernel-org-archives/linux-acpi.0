Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388698;
	b=Q4VWrLkzcuArxZd2+zI3kdbHuxNFsglWGXliu9LSqW3Yo+ZLNSWZkYsGsI2RgIyR4Drc
	 IbLvtE/vDjk9+XEdKlJs65VdtZer65vLGryLjFnUIdAdaaaS8hKXJ2VYHW3ppb1qr7XGy
	 7DOfFr2yAxYkyumVN/KGzUskLx/YVOOFrwezJQsAEHuSbLWaKgcyykeNzub3c0v/Q3hnR
	 sTvAjt9BDnTAqKEhFBColowgYo/S6cDSPjHG9DoFBlgPtoULmuwgEN2fg5f16zEry47Y4
	 GrFT5FPdmAs9blsm/1gZE4DFnaVZu//6UbuuAjcD/ucT831XyFy49EDJQZ626SJ5fhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=if2lsNwuFNgP9iiP+gqcgFzaOaNYnTJU5/abbjeRaD8=;
	b=FxkMHz7wK3lEvNqu03EKEOOEQw2WrIQjwWzh+c1llmN3GgT7byXQNuQTWAh0K+16eHSg
	 kmHWyseAuYwdOqYgrgqmyk9DBq74rCeYH6ipDPI+NTr0Zzv2+WmPSRKC6hpqzIPFZRQH0
	 scBmVcKhGHGg+4yiUspQHA5gyrhbvlbrdaGWa7WKEJIwzMidTVh9GAiNUobztq4iiHnkB
	 alMjlzEfecyPgycaA7Ju7XROySGYX/kjuO8AUGP10to9XVRBd5yq0iU7i/G+0MwLS0DPx
	 HnW5c/l5+CLt6ZAFraQiOHEO7HBRm/nd6kJM4h8yFbBeHDifIyClveAd2vWV7rO6jfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8Yq7Q9R;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2B606A31C
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 19:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87E2B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8Yq7Q9R
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eac4855401so476590e0c.1
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388697; x=1793993497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=if2lsNwuFNgP9iiP+gqcgFzaOaNYnTJU5/abbjeRaD8=;
        b=b8Yq7Q9R9sqFjCVOktBmyhjKXL1Vf4v9VIfIHqJeZAEKwFqFGLiDdLEff1vqscpzGO
         rjRlccjbwf4CIVsLtInbTqQmJ1VNeljPg7ZFgRNCv6mgzyVfmY8BI93Z+8P65gx8pBhd
         Q3fKeGszXYO6fi+pI2yqg3eA+QnoCQvQNpGT47pZw4yTwzvCE/RYiZ29SKEF5Hnv9CfL
         vtWF0fKigSTyp7ZUUnQStbvyAXbXrGzamd3DqN1dlEPULFmmJYPp2JqcXbWx9YEV5JKR
         uZcAv30VyEqLv7T6/KjaIQQBU/9xLcTKz25bkEWVsxzoRehRHBKJpmT9LWnRsYEEhGoM
         /RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388697; x=1793993497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=if2lsNwuFNgP9iiP+gqcgFzaOaNYnTJU5/abbjeRaD8=;
        b=JbQtcmASHIO6tX+CKImBmRdpGUyYU2LdAaVGrwSS1MdosoAMk1TO9NDhZclBG8XyoG
         9LTB0svjFsgMG9pWltcaZCuIpt3rwrBN/AkPF3XMq+C9JiNl74xmjbKfGj+zmWddR9Ws
         od0IVxTAUyZjiGMYQINPe3oxu3eVCucK582dFcG1sWIAL2IEIEYiCtEbR4ivBdsDKPu4
         S6zmxfcdneB89aAxGnm/aVaDXByzW8LYLWyoVYpXq3cMHRYamLlKpUc33BvxyU2lA/nu
         fKvR136LGJ2y3tZt5hu5WSuyIVvvYsZltAQ0wlMPDLsNMl/seN4p0bM/Q1q7T4+WylIL
         4Nsg==
X-Gm-Message-State: AFq9FYJMJv68L7Ge10vEpEA2rdy59B5mCmbnXPvSLTOat4MpQRABXNn4
	MhxHt8JiRRv4aYwL+o7jWI8pTO9DuY87CIcXwhFYWT/HQjmJ70rybv1f
X-Gm-Gg: AYBFou0Rq+tq++Nh6NXMrgrliIboYjeZ1mGv6tNzB3Jn8bMeZ+SDAjR9+Y1WBiXLtGE
	jWtPPV7QjFo3xYPMmRQTndf75TUvK9Z5LRZhn3rGwrJN42rdFnOGrKYw2wCY4t7//BM0+S2aY5l
	tKucRKivc3lYJPToUCy/jl09cOvsV5kyujIjZM249lGIC8XWevNkj0DUwb6tFjNMYQw18rQEeBU
	4auKmkXw3BI010HCSz5YcRjMwbTBpYlTIeEwo7aml3l4nHD9EtESDQVA+3q1wDOXsHnwU0RS3G2
	kt2I0OmuYfgoDMyCGg4hcgmhXL9ABfUvyyNd1+7WyeROPzS//d6Y+/umg9ff2n5dPuDWTGRi99/
	NzdCO9uyKAsYCueygdg4Pn9yQhO4qvJ71XisWUWgY0LzXrdXStVbmMTjJJtmRlatbB7WYbB5M/G
	pbaj//GRxp8/SPIHpbzb0cVJ/tm+6vVJLKftVa/hqOGMUAnVc8LvKMMmQz6PnOyAcj3oVC6sUU+
	ASlUEQfIiQFVwSdwF15mhXrBqraNDAQ9BLHiauYrlZCFOPYQv9H/iip9BIX9mwo8PvklEd/OJei
	TnSI14NP8164JSqnOMRGgjDAUf09NrRDXSMVWtJkSwoerlKdk1YW3/k5WQKF
X-Received: by 2002:a05:6122:8b0a:b0:5e1:c1c8:9ff9 with SMTP id 71dfb90a1353d-5ec68515f92mr1845617e0c.2.1793388697480;
        Fri, 30 Oct 2026 12:31:37 -0700 (PDT)
Received: from munique-a520 ([2804:3bf0:fe29:ac41:2d94:706:4bfd:852e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bb872dsm3671250e0c.6.2026.10.30.12.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:31:37 -0700 (PDT)
From: Munique Feitoza <muniquefeitoz4@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Munique Feitoza <muniquefeitoz4@gmail.com>
Subject: [PATCH] ACPI: processor: idle: Add DMI quirk for HA0QING A520
Date: Fri, 30 Oct 2026 16:31:28 -0300
Message-ID: <20261030193128.19493-1-muniquefeitoz4@gmail.com>
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

On the HA0QING A520 motherboard paired with AMD Ryzen 5000 series
processors (such as the Ryzen 5 5500, Cezanne), entering deep ACPI
C-states (C2/C3 mapped to I/O ports 0x414/0x415, corresponding to
hardware C6) causes severe system instability, random hard freezes,
and memory corruption ('BUG: Bad page state' and list_del corruption
in page allocator / LRU paths) during idle transitions.

Restrict max_cstate to C1 via processor_power_dmi_table for the
HA0QING A520 board to prevent the processor from entering broken deep
C-states and ensure system stability.

Signed-off-by: Munique Feitoza <muniquefeitoz4@gmail.com>
---
 drivers/acpi/processor_idle.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e113bcbbb..49768b176 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -105,6 +105,10 @@ static const struct dmi_system_id processor_power_dmi_table[] = {
 	  DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
 	  DMI_MATCH(DMI_PRODUCT_NAME,"L8400B series Notebook PC")},
 	 (void *)1},
+	{ set_max_cstate, "HA0QING A520", {
+	  DMI_MATCH(DMI_BOARD_VENDOR, "HA0QING"),
+	  DMI_MATCH(DMI_BOARD_NAME, "A520") },
+	 (void *)1},
 	{},
 };
 
-- 
2.56.0

