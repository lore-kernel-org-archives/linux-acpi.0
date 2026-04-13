Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F93B3C0F
	for <linux-acpi@vger.kernel.org>; Mon, 13 Apr 2026 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075693; cv=none; b=UR/AfexpFI8Mn2tly99/ABIJtmrzGUYJifg9bnW+xp9HLdkt/tzd2QpAqJA0pVcbPwfwISCDSJJAMCBZT2slnk3V5DfDhk71PHBdhoZ/fueBh0jD48Dh90rBF0seBEoo/906c8PZW2+RUoqTU3L4XC9VeRVumqQuc4ZOcIPBBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075693; c=relaxed/simple;
	bh=oICiryzy3QGI3tJheynSBKYqkqw/7LjA3LQm5HpTRaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ock6p7xgx7GrPOyopJniaoU443XFY4xM1lgeKnAnto0vpgX40Z1m2dhc+znThq8xtvcPKDiZ/CS09csaR9z504psuBjikXBg0iyCIcPO6K0SCBGcYg/8176/FaOlR9kjGXhUGtGBeXSMi2ZR6Vpyd697z4Z1XjBlQP7iY4cLg1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4HwWZOe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArYUOPYZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4HwWZOe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArYUOPYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776075689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fW/Jk0WpKq11KY/BRAX8lJJtqZ8w0BPQk7uT/pBi+tk=;
	b=c4HwWZOeMBKpIcNE8/eu4bkqW59WDmPa+S873mvFFN/IWhsY6Z0h1xc6sJb8UnhcpHw3XB
	t+bA/t3n+SXvRiG/+uMx6pQ9ZHOJw92ReF3RsMAl3ISo89G0Sv/jDNIBgxUaW4HDnAg+Gc
	hJP7239n1kaDaBmM+g7bTZSAvipm/Oc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-2EBKzFKWOMqmQAwcwWsQjA-1; Mon, 13 Apr 2026 06:21:26 -0400
X-MC-Unique: 2EBKzFKWOMqmQAwcwWsQjA-1
X-Mimecast-MFC-AGG-ID: 2EBKzFKWOMqmQAwcwWsQjA_1776075686
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d70e3e4e7so1149410f8f.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Apr 2026 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776075685; x=1776680485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fW/Jk0WpKq11KY/BRAX8lJJtqZ8w0BPQk7uT/pBi+tk=;
        b=ArYUOPYZQDwSETQvLfrAKlMWezJY8F9NdLedkOqutpns5inC/fsCUm61n8+XCX9dG5
         Qt2C2jT7Arw7PQz7AQOJDT33BTM4omxikYG/5wtI9DMtTSD7AEWX/SJCWGqBqPqutE9n
         Vp963RJ4DCxHgwprZtO1ycEmypGOoSx9jZd8TDtJDFpP5RLt86/LPDcPd0+A9bx4L6dX
         hjxfxmPKaq4l4AXpuUB0zVqVg6rd1ykYT0KCsjrbr7htuiLhrjY4JtRObL5ib+AVfMx4
         NhjQlMMDK91lLO6gzuOTXoP+pdQxNbz/e30XWzmykwypCtdCRJxL18xWnaYHzXIYm93v
         afKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776075685; x=1776680485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fW/Jk0WpKq11KY/BRAX8lJJtqZ8w0BPQk7uT/pBi+tk=;
        b=ssmcfhEkFypvZOXgag0tVADf/obL+xZE9zDlPBnDZ3fnVnUx0OiYxEQm40vT0tLABU
         kEKIFKp/b4aHZEgOOoM5QvRl52BANv87a90it+zXRp6LlGrToChg0GFknf1tXKI8o0Z7
         +iCkpgJM3H4ojJqpDsDdmbLlPnZQWFnoniL6S7a5g1NmLYQukSL0HnnnVGaps6fiRq7B
         mJAD+BBcnWPD9RJcnPxIf/xAetgAQUGPHEEt+GkFYA6sX0W96QEje877D3ZJP5UEACxk
         MyWabrnHSv+1oZLllIryot7nhIXW8qgduqvZZpyuStoYS4Ze48+XYiZ/KawTTuqBJWrp
         oHpw==
X-Forwarded-Encrypted: i=1; AFNElJ+spkIkinV5rx3T7aS/gdoPd+f1Th/xZIwcc8Fo++XPFsTRsGPGgQuqKyECb3luJM1GclnhGjVmBuwG@vger.kernel.org
X-Gm-Message-State: AOJu0YyHidU++wzcpodxA284MG8wV5Fto0e5bhgULGr5CW70aJ6mJJ82
	9tC4SOreeit5IRkYtsyxr34srR0HlNg3oVVvn8ArkzuUD3NbXnohHPnMaymVKqQmlH2yj9HffxB
	sqPil/CMDaFC8z10qr2dFU7ltJZstDhFybHZMEyAw2O+eKPVQsr1uaegn/XI4Fxg=
X-Gm-Gg: AeBDiev32GU+BkLzyjwnCrepvzWJjMigBlzJVV+6UfUONSIDAA7bIY4lY2SradIIhan
	KiuFHemxEod8/OtwyFNjE25S9kVzepghdUFy7ELQ+B2B7LfmA0QOag9ew1ZydRbuDnhGATuOB4S
	I022GnqILuAoc79QNoS6v6ACfk3nk8d1bvY+gfcI2mmqwi+yz3m03OUt5tE7XmYXgrAdiKHK2SA
	IDNZ0ZrbTRIZgdzd/cKxK9i/xTJyDLrZ0kSCRmzPvm2miH+6SPn67vImO4W1feclWlcLB8BQjFs
	t40rxYBfGfDpROW18JMhqC4dQiVLzCZys+PSTWxWbMrUQH38CTAIUD/UV+s+zCMvTmHooCdRqO2
	W4hrWFGsgxTHS1T6zh0pJIlgYtUdAZLvf9FW/eGF6/z8iB8d/hSEVTfPCegE0UtOzxUZDaUc=
X-Received: by 2002:a05:6000:26cc:b0:43d:73de:abd3 with SMTP id ffacd0b85a97d-43d73deacc9mr6725827f8f.30.1776075685578;
        Mon, 13 Apr 2026 03:21:25 -0700 (PDT)
X-Received: by 2002:a05:6000:26cc:b0:43d:73de:abd3 with SMTP id ffacd0b85a97d-43d73deacc9mr6725790f8f.30.1776075685169;
        Mon, 13 Apr 2026 03:21:25 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6a1203b8sm26926706f8f.16.2026.04.13.03.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:21:24 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in NVIDIA GHES HANDLER
Date: Mon, 13 Apr 2026 12:21:18 +0200
Message-ID: <20260413102118.33088-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit d7610855b0b5 ("ACPI: APEI: GHES: Add NVIDIA vendor CPER record
handler") adds the file drivers/acpi/apei/ghes-nvidia.c and also adds a
section NVIDIA GHES VENDOR CPER RECORD HANDLER in the MAINTAINERS file with
a file entry referring to drivers/acpi/apei/nvidia-ghes.c. Note that the
file name in the entry (nvidia-ghes.c) differs from the actual file in
the repository (ghes-nvidia.c).

Adjust the file entry to the actual existing file.

Fixes: d7610855b0b5 ("ACPI: APEI: GHES: Add NVIDIA vendor CPER record handler")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4b396dccfe9..a74012c38542 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19103,7 +19103,7 @@ NVIDIA GHES VENDOR CPER RECORD HANDLER
 M:	Kai-Heng Feng <kaihengf@nvidia.com>
 L:	linux-acpi@vger.kernel.org
 S:	Maintained
-F:	drivers/acpi/apei/nvidia-ghes.c
+F:	drivers/acpi/apei/ghes-nvidia.c
 
 NVIDIA VRS RTC DRIVER
 M:	Shubhi Garg <shgarg@nvidia.com>
-- 
2.53.0

