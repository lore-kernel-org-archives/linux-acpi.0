Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863CB3D6CA9
	for <linux-acpi@vger.kernel.org>; Wed,  3 Jun 2026 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504283; cv=none; b=oYp95/kFNmkQAkIzNCf8UQQ+QFDtZJqRJjHIuO6ahZFYQ06UJy1CBHurya2XrhcB9hi3pDYFHSgrVw8hN5GQc8csWN2G2NH2YN5lg+lDYf3vuKVbqHmIPrFyGCBp3wfzXHaYvetOfesqlDLN5GeIQSFKdm+C49pLgrGu3H3dqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504283; c=relaxed/simple;
	bh=kZuntGh7R1Zcir8T4NZB55Zh2HDLKf7Nfeerp7Ltv3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFj75ELr4ODpM+R1EmDvvFDC4WW3iV3daVtNDNcPif0BqZMub0QLJ16De65zosKqZ3c2dcsQoo8JoiZ+fu9tL5sbSd5ofx317xabUHMVx+1fL0rAPBMCEPHlBymgZavxyKbq/M8Hu+AiQfHjt+0Tpiear0UnviDSol+auh4zHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOagqHWp; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOagqHWp"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-516d0db9372so112124081cf.2
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jun 2026 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780504281; x=1781109081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQQVNMiIZrFDCExxcCQvpDKG0jGJapLATHkxQnfkmNw=;
        b=aOagqHWpCflWnCYDngC5We9HU/n6EFr1hcyVGvdESqA71isKBVExDu2+5FpEfIiU/a
         hPCqwiEp1bIOjLc9TQNKyPBiNnGowQfIYaM54quUXJ0wFvsIZeST91tG6lKxmmEUgtQu
         U8/aGqi5UOXl2gwAV3Fnx6ryS0MTWITWw1FVh6Q7pZVm1jwJdYoCK8Al8htLTCtsggPq
         NooYJT4cQvlxG/0vj9VBvl371aFchqY0dnzDmcZoN/5Cpelzo5RU2cCmpJPofWGf5xls
         K1M2SJHnLoZjRv67FJByVxYlH+7RT4iH8pHi8jXvyR+O1DU55vnHOIS9lunDKqHynlCn
         KUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780504281; x=1781109081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQQVNMiIZrFDCExxcCQvpDKG0jGJapLATHkxQnfkmNw=;
        b=F+bM4P6vJM6L95cB5XK46oxcaMyOM9+6SwRCOojI5MXmohVDHAWavfkmdARcCuSbiJ
         ODTCZUS4fQCqe5ZNoMmXWvXvwvHqpCTfwh2oU2juLu7lsAfdrUeOfcD03hj2wfA7Mdzq
         c2k89PWSo5eSUQ5Dwb1JBW4Kj5K2VVVDCjXkm5IRznsNju7kYMzUB0zBLnsbPioeXVTk
         7/jldGun49sW0JT8g414SS+ljhs3B3bVzkbYU/i0MyVxxrcbY3Iqy5SKRXn6AgawUpaG
         qBsPE66phoPckHRB9yvtkknJkYJcT+2/V+aqQj6V0lQOyjHHlffYFINePBIP2fmcfY+7
         jgJw==
X-Forwarded-Encrypted: i=1; AFNElJ9d9OCg0XnzpdCoCSyhTHNFgUc4f7zS41SI9Mm5h/60Ds2PTXjUbi+z2B3Qbcl6BkECdMzcV3m9nPkX@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMccFSLBe6eZp6CPInutiZaGbufL+/YRus20MBmjOSjdNU1TJ
	UMp00GEloVR6Z4HH35m7TVbQPhHo3f7FM7Svm4Xb6PrEbg8Jk+B66L3XgslJ4TtH76E=
X-Gm-Gg: Acq92OFlkGSL4Nyz1rFSyi91O99b1CnWEBgr9C3DOu5CSRRFPhgLIv6fBfGNCcUGsec
	+K+gHqOavryDNHI8IJuTTL+KN45l0L7NB4zexsBqFD8oJeRHmHhKBbrRvc+H3q42UMksVF/NYIv
	Gtes8er+8C1GqFFelvAnNq6LL/lAksrphMJubhzsu/6gaVgi9YXbJwUHYabfc7dkzERXoQEiZ3c
	ZeOr4VOWj7JLP37rl2ynYYUyigr6idTv9mwPuUXVEjdfimpMPNT3DK4pxCdeOtjjzM7PM9FruI/
	ygVYr52UJ4d6BnH1yvMAZTWm7+2E1Lwhv59XArRvawcvRT4dBYS1Bjigy+OjsJcC4honqPCPTci
	SZQKuHfJ5o3v/kZuEK+ybPeSdrMQvB9Pn556wkAFASwi1yTDHJbvroI/RWb5c+cwyUT6R95vIZa
	YgxLtyZvFW/2fPBniB6gfR4EaEfvKxOokIIYCf4PKXl/6v6rBagqs=
X-Received: by 2002:a05:622a:1814:b0:50d:efc1:841d with SMTP id d75a77b69052e-517786447camr58410201cf.23.1780504274255;
        Wed, 03 Jun 2026 09:31:14 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775ddf0cfsm27179891cf.26.2026.06.03.09.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:31:13 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] ACPI: IPMI: Fix message kref handling on dead device
Date: Wed,  3 Jun 2026 12:31:08 -0400
Message-ID: <20260603163108.2149359-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_ipmi_space_handler() takes an extra reference on tx_msg before
checking whether the selected IPMI device is dead. The reference
belongs to the tx_msg_list entry and is normally dropped by
ipmi_cancel_tx_msg() or ipmi_flush_tx_msg() after the message is removed
from the list.

On the dead-device path, the message has not been queued yet, but the
error path still calls ipmi_msg_release() directly. That bypasses
kref_put() and frees tx_msg while the queued-message reference is still
recorded in the kref count.

Take the queued-message reference only after the dead-device check
succeeds, immediately before adding tx_msg to the list.

Fixes: 7b9844772237 ("ACPI / IPMI: Add reference counting for ACPI IPMI transfers")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/acpi/acpi_ipmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 8f1aeae8b72e..79ce6e72bf29 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -550,7 +550,6 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 		return AE_TYPE;
 	}
 
-	acpi_ipmi_msg_get(tx_msg);
 	mutex_lock(&driver_data.ipmi_lock);
 	/* Do not add a tx_msg that can not be flushed. */
 	if (ipmi_device->dead) {
@@ -558,6 +557,7 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 		ipmi_msg_release(tx_msg);
 		return AE_NOT_EXIST;
 	}
+	acpi_ipmi_msg_get(tx_msg);
 	spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
 	list_add_tail(&tx_msg->head, &ipmi_device->tx_msg_list);
 	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
-- 
2.43.0

