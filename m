Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7331B131
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783049779; cv=none; b=sq/e8zUbHfx/CkxnOxy8qvTK6JuqoQHDFcPQlRQTOVW0+LVjCKxmZVyPKTCuK29Zc7F5ou7k59xKk665i4l6Yx12yKWRpxBx9HXTcP0xGz4WaVyLuSdvkEZ1O5VKO4plirH/5jdnF6MSDORcJ87nbIxvQlqb1A20ukXKMCgs8lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783049779; c=relaxed/simple;
	bh=wN3lEVyKOMHyjDD6acY7nyX/t554l+VvLqmIJ4eBF6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBXccjYgrbJcOtKqWSjrSs20b3bcgT1XLgnLlF1vH9ksW3dScYEWRc2gCUacY7G4MAk5uD5hTuA3YkDMtWqOVX+BPe1D0+9H4tYfMqNHcjnZixAJWj1J2Er4wCyxeVDpFa7eWVoWUwf2fhrfXRoc1/jogBTgk/J0MP6iLfIVW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHT44WUp; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHT44WUp"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8eabb1a9378so585546d6.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jul 2026 20:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783049768; x=1783654568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPgdxMTOh9PJ/MITH4rM9z6UY/LwynPrTFaYmN69gIQ=;
        b=AHT44WUp/crhBOO+FQNO1gOovi5rhVVdA5ajXYSASBTHlVyIY2wCIdptwkh9T1xKM/
         3lUPiSRNMWixEvtz83yRFHV2V87VZFWlfXuKsA3/qnYWCcx+r/6LKA1VZgWuj4di7JMG
         KIfH4m9w2Ty3pY9UtLizYs5MS4g3sI+fV5KQDEvUsszkaO0UT2ToOUsJmBBiMOfF59Wm
         LOncyA7LPl5bk8zvitaUrUdvYS5HIWZMqPwjKS1VTCwScesfeNAPTUcVpptBSv4zLbr8
         rh3Ils8QBpE1F0GNQ6DMa8PEWsyGzL442S1Ak7zJi88wpaMjAbQP5H6KFpx51tjcJksc
         0Rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783049768; x=1783654568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPgdxMTOh9PJ/MITH4rM9z6UY/LwynPrTFaYmN69gIQ=;
        b=Z/+srGL/3ClxjvpZ/pr0c67iYpOgYSOCYYwugpEhlZRTDJPybCuZW8lRwP8exKWcA+
         4HuAzodltAuD7kZJF21uEhL9w/1/76MjCrSuWVoSC11LJj5lN8P1m9oztAHBrjanKIU5
         yAMMeYss2FhLCzLQsAT6+I+4eMqs8+e1Ka0rqnMxRoG3wYeD0/CX+Hxx/MDnjtGVWhi4
         Y6I7XZ6OYTS8GZhpUa+7IcQhCfyaF7Ftr9RDNWCh32bpM4uWfxrkXQksFXLkk4feCbEB
         MfzCu6Bj2+F0Ywzz2K83ZafZ8g08bYXjxWM5eawkuGjP3A4ziUKoYbVaalvLzLmxFdtG
         KuPw==
X-Gm-Message-State: AOJu0YwR9TnZOjO5YzWIC4iaxEzSE/GVRPe49ixvFTMpg1fswlNw+iyM
	SukhDEnZ4x1tr0c2rDmG2nHk8v9q7t2S+oy4ZnUE1SCrKGtUSUx82mXnz4fKm5JnKzE=
X-Gm-Gg: AfdE7ckZ2yxQBFdUc3QeLYnse/oDA6oiDuBrXy+ub5kJN+O+fjb64rotiQogd7LFRLZ
	O2ce/zU9oelOZAOw5yB5wTd6hwJuFAJQz7WqXuEgJooXQ5rXueHrFaELQEX1z4iWoIwes2WSK/Z
	T/v37FR/pMtw1wxSOa1sDufK5i0ORLxJdbxvHRK16NgxEIVT2Pbx+6YhZDiWDGGKKib0pGo47LA
	qvgQPzzEWL3BIupdyvfFAFS90JhNgRmHVNS5EsNvpibUXSZmgiqlnqCo2iabCg16GQBqKCeGQ+i
	3IDbNCGZdsGyRt3UQiw1GJHtc+3F29BSCYH4c930woC4Itw/pNftdAkQjJ0mirNH6PsDN2KKAgl
	LkghLL0uTiySgW2uhg6x0Z/aOApcHiseJVBJ71j8SJmPsNM3/Tl3JBwB0m2sD+q/Bs2Sygd4x/t
	VV6XsFURQvqTfz3ZJG8BghCv+ksAWQpc3q7wJUbF2GsbHpsBAp7WSWBDW1WbmhTU5rQuOjjz8Ia
	mqJOQl7/bjrLCk=
X-Received: by 2002:a05:6214:4841:b0:8cc:de2:3b5d with SMTP id 6a1803df08f44-8f3c789bc75mr102073386d6.16.1783049767890;
        Thu, 02 Jul 2026 20:36:07 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d533sm43682316d6.8.2026.07.02.20.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 20:36:07 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] PNP: Fix card device cleanup on registration failure
Date: Thu,  2 Jul 2026 23:36:03 -0400
Message-ID: <20260703033603.114931-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pnp_add_card() ignores __pnp_add_device() failures. If device_register()
fails there, the device is removed from the global and protocol lists, but
remains on the card list and its device reference is not dropped.

Remove the failed device from the card list and call put_device() before
continuing with the remaining card devices.

Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/pnp/card.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
index 87f5af454751..df5e3d3cbf6c 100644
--- a/drivers/pnp/card.c
+++ b/drivers/pnp/card.c
@@ -254,9 +254,16 @@ int pnp_add_card(struct pnp_card *card)
 	/* we wait until now to add devices in order to ensure the drivers
 	 * will be able to use all of the related devices on the card
 	 * without waiting an unreasonable length of time */
-	list_for_each(pos, &card->devices) {
+	list_for_each_safe(pos, temp, &card->devices) {
 		struct pnp_dev *dev = card_to_pnp_dev(pos);
-		__pnp_add_device(dev);
+		error = __pnp_add_device(dev);
+		if (error) {
+			mutex_lock(&pnp_lock);
+			list_del(&dev->card_list);
+			dev->card = NULL;
+			mutex_unlock(&pnp_lock);
+			put_device(&dev->dev);
+		}
 	}
 
 	/* match with card drivers */
-- 
2.43.0

