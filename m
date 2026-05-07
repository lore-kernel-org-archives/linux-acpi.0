Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9644D023
	for <linux-acpi@vger.kernel.org>; Thu,  7 May 2026 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169420; cv=none; b=j8sTcQ1/7O9aWDlTUcj107Pz/rIFdlhtHhu6bfWLQfIj+56hxB8OcL23o3cXnZx47mWT0f+jBQ+LBwBh5zCvQkDrsh9VfZ0dGGgBU4JqWADuTnn0GoVqRHkcmWZIzIXp4q5TiraWEvnZexz9EwOpDrILBteZnfsXDkNVOVAO0G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169420; c=relaxed/simple;
	bh=nbaIl3cWAUayfZ68Bw38GpU8PLcyTE4jy50VHYLn3X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkSbMjPUOXZQZ7cwLz+a7i3v/EeO8z9W5lJd80DMMoh8A6SbhrqEoFT7MnEOzWXA0ST2omJ7C/QdCVKXu2lEysUK8YguZklbWLV/9NvoPwZA02TxVNcdzbRAQ1rtNKtl4/Z09Rv83BfT4GeBuFYkoca/RqJ1WIzMzlgr1c1b5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBQBrdvh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBQBrdvh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso7419435e9.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169417; x=1778774217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy6jWWAG+WnrqZjUEDtwqVMfyW+YY1GrQIhezkYTLCw=;
        b=rBQBrdvhp6QUtGVAB+Jc2K5dYEeWwdQuF4c6kuLsS/19pjabpKQzXY8oy2etSlSX3d
         XmI1zR/Ne46zaqucZFMDKXC1vAqnJacnYE9NYZM9rF6XFt4NuTLHANudEY/3Gv77nOgS
         /ToqkK6dKPGbFRaLRa2Up1OvkH+MRSWzvZjc9LPT2+ZlczAPjmvZhk6rqc+3kbTwhHTL
         tLOnsJENQog8+sYJy65C28wLYKWHzIe6udzDt5OrAc9+PwsaWqhud5BC+1k5WlthfOMz
         1DKryO7UCxOWTlrPfcAd5F7gqGlEdyqxXIXJaSKLoX0midxCyZlA72HFbzCHfUt2lKYH
         wfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169417; x=1778774217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wy6jWWAG+WnrqZjUEDtwqVMfyW+YY1GrQIhezkYTLCw=;
        b=EBVZgTDx9PkcqSYxe3pJwbRZnc8LKqIPYf5UwJgady4fGQhg2mFTVHal0kjaPf0Ska
         CAoyFS5XNRq/Mcj2hkje05LGfwOWgPTXq6NPCUFNVJEfu2Fn8yOf/Dk9n0P5WbX2Q1OO
         Xfjy+FucMeskEe8kNFN8SDp5MgzEN/d9ESMFHRCWOPw44lG5voWcg7zCFbGGbR59YCSe
         QLbIYu7JzPRw3FiwPfPlHOCCbKdfgPessaU0Z5lz+Wa1139UdDRNJstXTpg+t63+TH86
         Uupno51YcnEKwzMDgtumeTpd8DDDwh4qTwTvl8hD78JCs1R/OLYoCZk0+vO4OB5VjSBy
         sHeQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SkwURHWjFs9TViZukSnnin3M76sDwNe9Ih6s1m02oCpY1vEx5OpDO8LmS4S7u0bGUprUlI5XPWD0m@vger.kernel.org
X-Gm-Message-State: AOJu0YxvxwQICaurHiGJwd7u/bbVLsm8Vkfnn+vH+yJsWdOapGpgFvsB
	iKZX3yGwo1iFNmXyA3Sdb9qcHkFrnGKdnkjjxGeMGrCWLqapR8RO8bnp
X-Gm-Gg: AeBDieuMm9e5xQ1buy491KCil8pjTWsY7ODRxN6YzKSjvQ0iSOM+P0G6RfxfrGOLyME
	KLE1MoEUNzdCZXJmzk3z0UtUkfh2jyeiB2+PeL2eP0zNo1dhVsFyFY4e2p2T6iyKY2WI0JXSr2T
	NkZdlDUOYBZzo5hGf0MpkafEPXjRSjQzdhDcT5ofkX6J+Ud/fh5HiqxUBvWtVB9Z1sXT/9Y+v+5
	F6HUuStrrnJVcd4pj3UrIpZ6q9kWF5DmW0cMNDkUDh8oSrVFBSd5+gjBL0akksb5C8hJW00ZHbn
	UgQ1TQ56jIzldz/uK4cr01JiYtkxvO8Dw23in9id+mbv7QI7XoYJUxGU8B7X0bII86vlIgHoyn2
	0YTpWjKdKKQDuUhFwTJJ0udQjG6e5zGYTuAvIKwdMQAepvSM513swXNSEbuZ0Tx+5fzrEyt1FJ9
	yKBFh7FaJcXQW4m8poR2rBGBF2WA==
X-Received: by 2002:a05:600c:3420:b0:48e:51f5:2764 with SMTP id 5b1f17b1804b1-48e51f52779mr87836065e9.27.1778169416854;
        Thu, 07 May 2026 08:56:56 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45412820463sm44581f8f.3.2026.05.07.08.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:56:56 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: andriy.shevchenko@intel.com,
	mathias.nyman@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v3 4/6] gpio: acpi: use guard(mutex) for conn_lock
Date: Thu,  7 May 2026 17:56:45 +0200
Message-ID: <20260507155647.403964-5-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507155647.403964-1-mscardovi95@gmail.com>
References: <20260506123421.1077421-1-mscardovi95@gmail.com>
 <20260507155647.403964-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/gpio/gpiolib-acpi-core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index e53d68578024..33d6c3b6cdf0 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1123,7 +1123,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		u16 word, shift;
 		bool found;
 
-		mutex_lock(&achip->conn_lock);
+		guard(mutex)(&achip->conn_lock);
 
 		found = false;
 		list_for_each_entry(conn, &achip->conns, node) {
@@ -1155,17 +1155,15 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		if (!found) {
 			desc = acpi_request_own_gpiod(chip, agpio, i, "ACPI:OpRegion");
 			if (IS_ERR(desc)) {
-				mutex_unlock(&achip->conn_lock);
 				status = AE_ERROR;
-				goto out;
+				break;
 			}
 
 			conn = kzalloc_obj(*conn);
 			if (!conn) {
 				gpiochip_free_own_desc(desc);
-				mutex_unlock(&achip->conn_lock);
 				status = AE_NO_MEMORY;
-				goto out;
+				break;
 			}
 
 			conn->pin = pin;
@@ -1173,8 +1171,6 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 			list_add_tail(&conn->node, &achip->conns);
 		}
 
-		mutex_unlock(&achip->conn_lock);
-
 		/*
 		 * For the cases when OperationRegion() consists of more than
 		 * 64 bits calculate the word and bit shift to use that one to
-- 
2.54.0

