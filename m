Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA32314A6F
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779167463; cv=none; b=k40EhespgKNmFXtge0B7Pw7JtVIpuIr/6q8LVkXI1ApHPOqR7UBSj7FqzAguc7sBJKWFZrLeQfJNl29H4rh8ZeqYNmSXQ0XDMUYA24FFdh0KzVKXPKLmuBwmCbJk5bvQ+LIdoXMx7Gqb0fAa3DGhZ4EnyPNdhSw5gSPeU58aH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779167463; c=relaxed/simple;
	bh=lhtTz6r9h3gam08PpROtwyqAJ6lm3HQYUI3xZrXDqkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWMtbw3iYEPkwsOMcrYFxYNtaBfJboxKAMVqD90HpuylJmj+b5SoLmkNnweBpDiyOBAPmEDdBzc+x61iaH1BvYc+A9Zgp9MckVzx4Bi+l3nN5Gk7bsRnTyvSgoJYc/A2B6kII/fjEVrlKznUpOKkMjjpSHKHis+P6a8EGiMsO+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/ItlpCq; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/ItlpCq"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-912475287a5so344246585a.2
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 22:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779167461; x=1779772261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HlSbwvOjgwkLSIAC4sw+jiTYmv44YqHx2Q9LfFfV2q4=;
        b=R/ItlpCq4oLyEFoxZdE23eqeQvJPpHM19VZ9Ty1WzV72lSKqPS//wMPtu97L+CnRdU
         e/iRj4/N4K2pAmZiliMU83AHOohTJsxYwRlvdfiV0Mlh5T17qrXjNp5tNG5VbCmrn7sY
         mSl387ENfGU6bHcY5m/JvpXylBA31RTQGNY23f/C9vXuelOuESUlZK0uyUHAHFlwHw2H
         UT82Yn1de0Af/VNSMauIjuLmfD6sPwS9lHHeXYCCp1+A4ZVyowpblsrLb9zofHGfYnX4
         YbPP+de8KxJE7QNcd/fkxjqNDZOQqiDZYGGMYbHeCe6pVXMHU0fVyXXd7aHsTTU7mQs5
         mwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779167461; x=1779772261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlSbwvOjgwkLSIAC4sw+jiTYmv44YqHx2Q9LfFfV2q4=;
        b=kxDUgwFl5Aca5+u/LmfzMyPA1ipzzG8/HJ7ZRSD6W6r23E/CE/A7cWTQAIeHSIMjR/
         hkOPF61E+66XXCjy4/ZdMqymCHQHI05A+bAC9t0Y6CqOh6oFXHpiWPh+0LwWNXcz/kG+
         exFNdiHrS4LmFhQqFqhO3G6P+08dCu1OAtICUodYB5MduOo0zFk/NgGLhk3tmn2RGdLt
         EvKJjK3zK2h03s9fmV3QsKPeM87ar0MZq0Sdi1oYj8DjhKHceLv3sTlMkcnfiBTxpv5A
         24UicB3W2oMviq1OVXiUaBRzEzsgr0wJgZzxq/VTyxc9PZjiV7BGVucYkAMJFschEmCw
         bPBA==
X-Forwarded-Encrypted: i=1; AFNElJ+GKB3YAX6uIYWkLbApD7J6nRLXVDjbm8CkN0p+LFTO8pX1r0s5mOhieww6IIzMHjzczgn33kwBtLLf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0NxjeikQf6cUgeHCPmq9bR2rhPLO+qQNzRYVIJ43E/Y5mj5iy
	swsxVWWY7h2bDLaOLItOt4pTBjB11wgeY2+a2kx6ECOE+iG5QzKLw4mh
X-Gm-Gg: Acq92OEMGrpnE5x4FrRZuba/uWMQNSMjz7cpmgBBywiUziCTbSEjqccK3ss1c48VsDJ
	6Q2b0lZYrqjPbHOMr7JordkujTbHUMnsUEg9DNXuUKrrV8yWzm2c0byL0mdIM3sa+ZTytBTXuB1
	2+t81GiVkkHB36pFOg/y1NrqOKnlkau7CZTR4BkaGbG36gVpFbhQlEmY21bCS3YFnLHZAVkJZS5
	O7nniqtAM/gWv2JE80ijVKnv8ziuGFmI10OgwyY19LJZSWIGhGnIZJzOKwk78xzgAPpuhGULzlq
	tJjOzutOYx14XXoOFhoaawdTij1QJFI0bmpgU7zT/EOJseAcpx2spP29EwOE+rNk+g1CKxSKHnl
	YDQLaguYZPuJ+k423RudCL0p1wlmHtQJHImCUwCbXPGDtUAWsi0v9UfCCCRvqFR/2BeXUlvRVka
	2TKMXJIVe3rnVeC2srBbhUPUKrfv/z/gwbmqCJ3w2Lq9uIWaXeYnEy1Dhtcg==
X-Received: by 2002:a05:620a:4713:b0:910:87f4:9a05 with SMTP id af79cd13be357-911cda50b31mr2665504885a.1.1779167461141;
        Mon, 18 May 2026 22:11:01 -0700 (PDT)
Received: from xps (ool-45718bcd.dyn.optonline.net. [69.113.139.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba463814sm1708612785a.5.2026.05.18.22.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 22:11:00 -0700 (PDT)
From: Jacob Bazata <jacobbazata@gmail.com>
To: wsa+renesas@sang-engineering.com,
	westeri@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	inux-kernel@vger.kernel.org,
	Jacob Bazata <jacobbazata@gmail.com>
Subject: [PATCH] i2c: acpi: Add VEN_04F3 to i2c_acpi_force_100khz_device_ids
Date: Tue, 19 May 2026 01:10:31 -0400
Message-ID: <20260519051031.6660-1-jacobbazata@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This model trackpad (04F3:32AA), found on various Dell XPS models
from 2023 including XPS 9500, 9510, 9520 and 9530 is well documented to,
at random, exhibit excessive smoothing with no obvious cause, similar
to other trackpad devices listed in the i2c_acpi_force_100khz_device
_ids struct.

Forcing the bus to 100KHz eliminates this behavior.

Signed-off-by: Jacob Bazata <jacobbazata@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 28c0e4884..512ebdfcc 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -373,6 +373,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	{ "DLL0945", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },
+	{ "VEN_04F3", 0 },
 	{}
 };
 
-- 
2.54.0

