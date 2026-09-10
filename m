Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58C1EF39E
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072652; cv=none; b=i9teuQNnw99jeLgc4zvHr8cUuKITmnvozPpB5m7IWsUuu1Vbw/vUjuK2rV00jh7gEvP9cD17A5a6qvH2NWnFhIvAami5jI1xUjKrFDpj1p4ztlfCde2DNdx9b/NPTgEF1kA8ZMnAPnaInohtMRswhGnfga5ACQrEGorPwrXAsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072652; c=relaxed/simple;
	bh=zwGJ3GPA/cKqZXB6RBg3UlMxboJriBQTlXHQ0fTi9LI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epGgcdR6xi2qd6A29kMU9jfYVS2OaN6vZL1WMDLv57cEq6NGdPUuNWjC2W5avk21V69X7c1eKEgiWZhcU8bte5x0Da5rHgAxP+mzxmXv/AHrXTO+AlvXol6yyeP1mFa4eqRsHq+xaHdLafjC3CCo37QYAJwBE7p8Ce4mN28GyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBRsTOHy; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBRsTOHy"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53016020b2fso3303381cf.0
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 13:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789072650; x=1789677450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQ//0wLx0ZrUFKEVfJ2KOKRoOutXC31Ghgf5LXlFB7I=;
        b=JBRsTOHyWTYRrPmShFHH+ZSdGZeQ8GuHYfnovnz9UbDTPrdhrVTvExEkxqaHJY4bCR
         L36ymihikorow6QK4la9r7E/dGfD8pGRqJWLSk7AqQgZIZvWBDktEGyxtNqqSuocVkBP
         5mcpxCkqrl5JSBt2SOUg/K301AtGG0vGGP9Yau+m4MkIvLGAGqFbEjXCsyNfpffu3Akv
         6LxbPU+eovnPfxI3E47Q3ojQQTqXvvZvcRzVjfdcZ0e6XxHf56eHQdR0fTseHUgJKFh7
         xkxhU6ixLuMOfoVnFZzmkrN35nPp8gLq9YJ8PhF09lgdyT45s4Q2CSyc0A2LkyRZdZ0r
         qf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789072650; x=1789677450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQ//0wLx0ZrUFKEVfJ2KOKRoOutXC31Ghgf5LXlFB7I=;
        b=RBlAG1lps16SIc2Ns7ItRiGatFkOSq/g/rgslrm+EzYUY2RjynC0XA5fzmnZWCOW24
         B3U2PWkKiu1h9GLocQt57Qd0BjYQ8eXPD+6gInO+fD+Ity9lo6gWmzwvuB6gIvaGT15b
         62I+6Lr+LqluFHjLq+J5XLA8K9RMXy7Qf9/bPH8iE2/Ou+lb2BwNyletaX3ZD4tzW632
         sDBQLOfpA8DOaZSmViUkmE8ZsV0tK73bdyk5ff6t+QeLVaqE47nipU1yj0lvIywHdvl7
         0fPjrQHLaK0CnUUwuslfF+lEgTAXqi9eldgarP6SMENWMsa+YOf6VJpkvIeYQjb6hX1/
         qonQ==
X-Gm-Message-State: AFuF++kHD9QjFjcohk9TY/IhG3pLcxkel15w28VVvFIGe2bEU2tzv0Ek
	u/TDvJiGy3fyOl9o7c48jVteNCChD7/K786dlUeoQOzxnC8TXvch+6Q=
X-Gm-Gg: AYBFou1f4US1o9lJFHePxqwZ+SNcGXrVEzbS+AITa9BZMRTI5+21/Tj32Aj9lX17Db9
	eMcTL6JpGkknVHAjE2kvJe/7AMJp159erZ+8FQPApPJOsonPb9rhTqO9XTPi+je+5FuSfNXfk9a
	kfGnN073GX5JmROZGeFUREJv4PU0ITaZWs5t3Ra2dUnPwTJa1LaS33LNbZkR8ZIzkjtKGEzZ2dN
	1HZOZLsmHKHUp1F08wOjpHLQDud/N6XeG6TC38Pwv7hcDhG/JSpJYacF9qnJuMK6wLKhGYHrfy5
	VR5spLZkGbkAqwfQKfP3EGmCJV007Sbw0FkVQWYLcRX84+0qoBicTCreSEbC5nI8d6volpBGjqi
	Lg8G+07F9gdmd2x8sBh7NTgk3E/YvG3hdLKf0cjzDBep2blmUpNwPsKkRiEjLzrK98dv7iZq/hh
	Fvi79aQEGIQatAerdI1oLrHVALLnjPWkEPzuvBnBh6JKtcDll6s+igkRmJfUM6zE249JT0CLH8r
	yHyjJcH/NTHwxHVYy5p9sNCrR1lVhP81VrkLJh3kOmma69pNdf/TZyCjQCSfOM0ZPI8jHDwZ37l
	f1e3blEtZGsc6a0Sj1jc1QGn0UuNZxB1iw==
X-Received: by 2002:a05:622a:1446:b0:530:178a:9de8 with SMTP id d75a77b69052e-530c859b375mr17874041cf.22.1789072649848;
        Thu, 10 Sep 2026 13:37:29 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca3098easm2538941cf.3.2026.09.10.13.37.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 13:37:29 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] PNP: Detach device after resource transition failure
Date: Thu, 10 Sep 2026 16:37:27 -0400
Message-ID: <20260910203727.63489-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pnp_device_probe() attaches the PNP device before it activates or
disables its resources.  The attach changes the status from PNP_READY
to PNP_ATTACHED, but errors from either resource transition return
directly and leave that status behind.  A later bind or manual PNP
configuration attempt then sees a device that is still marked in use.

Route both errors through the existing failure path so it restores the
status to PNP_READY.  Do not disable the device or clean its resources:
pnp_activate_dev() only marks it active after a successful start, while
pnp_disable_dev() preserves the active state and resource table when
stopping fails.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/pnp/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index 6d58b1465081..80c2a0f15b80 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -96,13 +96,13 @@ static int pnp_device_probe(struct device *dev)
 		if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE)) {
 			error = pnp_activate_dev(pnp_dev);
 			if (error < 0)
-				return error;
+				goto fail;
 		}
 	} else if ((pnp_drv->flags & PNP_DRIVER_RES_DISABLE)
 		   == PNP_DRIVER_RES_DISABLE) {
 		error = pnp_disable_dev(pnp_dev);
 		if (error < 0)
-			return error;
+			goto fail;
 	}
 	error = 0;
 	if (pnp_drv->probe) {
-- 
2.50.1
