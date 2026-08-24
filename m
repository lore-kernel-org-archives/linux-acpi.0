Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886337B407
	for <linux-acpi@vger.kernel.org>; Mon, 24 Aug 2026 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595379; cv=none; b=uumW90sxJOqVaVu4EXjdJ5Ufji/dB6EwUU2EDYRCHGSo1qaXZl7JCjOpGOidMg1UlOdl9dkQuQnoFqqdv4Po122fTiw57FRik54/Yiz5f4qLVgJKsHwmAcnkGUWhbi/KB9ks5xCEG1NdkNs3uCViSpBEaSaVU5uVhSH2Yw2gKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595379; c=relaxed/simple;
	bh=Xf/vtFg9XHDHbpj8BPPhagxrEjOllb/lmVYHdVEfkS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhF+kq5BRUKsTuh/Pt08TOmuPgm3oozL/L2yKfuSdI3Ar10JC5tBu8u7ghnb90L9qOIxKuIYasQjckL0ky5F8y4WUgiLs5KAAaYGMzN5WYK263dHcb/HfDJ17u9Zkbp8lHLiFnfVNZyhpYegXnVrR9avwzkPlFV16vWFiwH900Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBUccWLD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBUccWLD"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dcbade417so4563024a91.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Aug 2026 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787595378; x=1788200178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TYyCkSIU7eKC/04a/F6o+tJf0qYZ/8bHxi+4hQtbxFM=;
        b=HBUccWLDysKMp+NrgjAMQEdKJcY/I8848f3uNqLceuHKJ/19dyKJfgZiBmPZu9lPhO
         ZyJon+C01CR/XfQ1TVYHfEFlCKLPnRzmo35rFnitrge2KE/VVU/RHXvaZG29olQRNvmg
         DuoWiiXzJSsFuGNTVUtRutDepLedTr1RrSteuC/xhe+9bUyKIu5EsNJXm2qpixygdWIk
         tBXQYa8P+KQsMbBDc2PrCuTZWexSql5HkufDOzxiP+Oa/RoqzT3O5d1HsIDrEw39jbqe
         rPYjVt6aOLk/fw988qD2vewLf9ay/DIdqm3r9D4m4NE4sCVPbhc81q/1N/siy6KFyMQK
         iIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787595378; x=1788200178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TYyCkSIU7eKC/04a/F6o+tJf0qYZ/8bHxi+4hQtbxFM=;
        b=Xc+hI1crtVY1eUukvhBM1GLYmhfFYCbOXJA8Eyo7Kd7+2d1TGjq/3PGLyzX5v7SAyx
         ptHAENf0YuYnnzUi+jgdkw0csLRHVKRLK78jtwaxWYBgOU9BfUTe11zsa75i2hjTOdi9
         SVr0oNpboPKbqlmDgSEhupVNI4X3IUKgvP6gE9k4hqk8Ahcg2A8yIqBKCLqaRLL7oHbX
         8skAxGGsls1OsOw47/L4TkmGlSBM2EtjYnIhgzrY44aup13CSAMWXpr2ajkcnf40HO0k
         C4dOby91Cn0J/DeNwWrOg9PEiM01LQI4wj5CDmoM3pWD5g7EGKUPHMo642CktJjPaYwU
         8gjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrCCeovZEJkwlOwfR62uugIoFygODUMC8Elm0ouxn7uHdaGAckjVoFM6GdAMiRMPVDL3fkETut/Nwy1@vger.kernel.org
X-Gm-Message-State: AFuF++nsVvGl28KWgog98OeKVy4LYO7MlHt1cJhlTqEvG0xyl1s1qFc4
	tE3CzMpPskvOn52yLX2kc6cd2CK78JmYzceenhaewdEIHbPQ/zoAq0HF
X-Gm-Gg: AR+sD11F7oLEjJODffmKsjHWTcdyj11gKt6KqXPCxD9iJ2S8ovmceh3jiSRPzjKyGCn
	YLrejgNFVFlFvz7wSbUhFWbx7mX88LT55bTJrVv5+zK4tOW2lzUoh5SKJVdp2fR0qOYKfaiJIE8
	m/K9hoWWsd5e5iJJFzJw+IzL9GI1090ObLwIftk1wpDRJjUbya+dJO7BPj9oqoeXKHuZX69QvrJ
	49fDcBNUJDn6/qbx9iwx+/iY8QtqU6XX2OGaMJtt70N+0+R5cOG5DzcZSEFbqi4DKzmrwEKt32h
	r5ESboMuP8zoHcJQTauFcH6MggNkhAwOHwiRuPwIMRU5H9mdKetJw7ZtyFJ94boxDvcB8Hy1S9Y
	U2Jf05U6z9xQHpx5wNky1RCrA5ggh8aJQ1DBCx7e0UASbVGnvqkELO70fWgo3bazXNiDxWoa/8b
	v2dxtsTZKNViRhqpwDSxjGCvKnLspaGlN6rNLOrOb4BNpIUko0OPcJxX4jLmrbdiQC9LMrXNIB
X-Received: by 2002:a17:90b:3985:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-395c357d3a3mr48892418a91.15.1787595377740;
        Mon, 24 Aug 2026 11:16:17 -0700 (PDT)
Received: from InspironBook ([23.26.139.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b7ff6dsm446080a91.10.2026.08.24.11.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:16:17 -0700 (PDT)
From: YuXin Xiao <xiaoyueyoqwq@gmail.com>
To: andi.shyti@kernel.org,
	westeri@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] i2c: acpi: Add DELL0A86 to i2c_acpi_force_100khz_device_ids
Date: Tue, 25 Aug 2026 02:15:59 +0800
Message-ID: <20260824181559.146133-1-xiaoyueyoqwq@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111814.75242-1-xiaoyueyoqwq@gmail.com>
References: <20260824111814.75242-1-xiaoyueyoqwq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ELAN 04F3:3185 touchpad exposed as DELL0A86 on the Dell Inspiron
13 5310 intermittently exhibits excessive smoothing when the I2C bus
runs at 400 kHz. During an affected period pointer movement becomes
severely sluggish and sticky for tens of seconds.

The ACPI firmware configures the touchpad bus for 400 kHz. Add DELL0A86
to i2c_acpi_force_100khz_device_ids so that the bus runs at 100 kHz, as
is already done for other touchpads exhibiting the same excessive
smoothing problem.

With the quirk applied, the kernel reports that the firmware requested
400 kHz and that the bus is forced to 100 kHz. The problem did not recur
during extended heavy use, including an S4 hibernate/resume cycle.

An independent 2021 report from another Dell Inspiron 13 5310 user
describes the same intermittent sticky behavior and identifies the same
DELL0A86 / 04F3:3185 touchpad.

Link: https://www.reddit.com/r/linuxquestions/comments/nsso5b/help_needed_with_sticky_touchpad_spoiling_brand/

Assisted-by: Codex:ChatGPT-5.6-Sol
Assisted-by: OpenCode:Ox Alpha (x-preview-f-free)

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: YuXin Xiao <xiaoyueyoqwq@gmail.com>
---
Changes in v4:
- Add an independent public report for the same model, device, and symptom.
- No code changes.

 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3bdd5..3af0e05 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -371,6 +371,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	 * the device works without issues on Windows at what is expected to be
 	 * a 400KHz frequency. The root cause of the issue is not known.
 	 */
+	{ "DELL0A86", 0 },
 	{ "DLL0945", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },
-- 
2.53.0

