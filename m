Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8673B9931
	for <linux-acpi@vger.kernel.org>; Wed,  8 Jul 2026 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478960; cv=none; b=sTXiUkv35UNJtrn3iC5cFEvQp/raMbMvhE09Vg8Ayc5RsNr0EdaRn0m62FpNVdxJB2EOCSwPaF+u0O9UKCjVYX3X0yAkRCIuvhe/7FxVI+O0PFUQokZgVgdv84axk9ggXgfybWsNw9VXuIZXBOzthosiivX3HDLiilvJ/KBHMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478960; c=relaxed/simple;
	bh=9kNqTwStaQbpsnPsaUKdWQ5RRg2AMjRoY3gcvAOrCtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJszwAPkQJ+T5TX/qxMfYTxJlkZ+nIwbk4cQRtRhaIbrQ+PkLNkpK5Rtfjk4Bvexx028a3Lo7x8YbF1ENWzDpOqK+tCHlFqSgfdcvQSCmc1D9VPSX8wT+71KBlckdjeOfHgj4At5Nc4AkeIO1UIYkc0otMHunASYsvlbg9WopIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cabe9335f1so1555805ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jul 2026 19:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783478958; x=1784083758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z3Et2l0jTe8v2tHjcu+3b3zxs6Brl8fMVpxofs6B4U4=;
        b=NLKQ0wFYcOOZi5ce6S9uGZI/fljWYr0S5/DkwA9juvU9No91R3rFIRC0Mq/UdWnBqU
         tcOwHdTIaQh6Ru+eK7UOWIJg4JZfLz1Qg32nsu3EskwyY5BujH6T53Vfwm5wEZR3d0GB
         EAsUpX5jsdvEJA3x0OR0+WE1cPdQWAqwT90HFyXNav0K/D362G7y+oZoqHZPhjCevguu
         3m8EUMo8IFao7JDNReMwICE0uzDKFxm41n9IxE9odquOUFVk9xlTq704b8KfuJUQ5aWL
         PVxCc3FmTGA9ekryX4e6vSb0HAO5EaKF8cNjkvk1/dswog2tLNA6eudobducSBkmW2bG
         2hjA==
X-Forwarded-Encrypted: i=1; AHgh+Rol3L8di2OthH+XV+redjQEUIeE1jwh4PNtlfsjPZ448OLBIwA6eP/pi6xIBYrTlZsxvHy3en7QZomK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7/Zav/QdpJz3z0alYCc3x65zXunYfKAiZBflvKZNrdFJjBa1
	A3/JEkGtWmpdJuYKjMfLTaM8Q12jLSWk+/wCJ2AXHcyYEdrLPaRoBtGeWx1aXwa0/0iTUQ==
X-Gm-Gg: AfdE7cl38u6UDGqt0froJFi0XevRgRH1iqcwMLptkhlwHoh2J4Al9vFIH+iaKQhiFXp
	u6n8N+MF+6YVkeEWXvdvxmT7OiMiloMfJUJhq+Fq2tpYHO9CS/hN3X18K8fALyuUYYD5We9I6ip
	iOfYmPFta0QQP5KI28oQo/ZLDnO087kngJLz3v68cFXRjSpVcKyx1F4vkxadWviQOCHfjv3DbGz
	RRaPxunRKReQOmpd/PuqAFzN6kkmZ7gWDtv59xdbMo4Xb36kVAqZ7ah+gGk/2sfceq0+uyuNLeF
	dMIFXZmCCuGUl4q3VNHvAeqaXaE/5FOrIB/8rEcxekPWGn42xh8fblbAXpKaJImEtXzoVxLpDjk
	yXDj48WsxiUkffuIgvdYgs+QzjzvbV61G/tQTtclUzE5Ug2iOrVkySY7+muEQSWI8fjQRZyhNyp
	+KkqQQ0mC/GGa5fLbwo2my7XzrMJWoLrTfLg==
X-Received: by 2002:a05:6a20:918d:b0:3b3:e05:7fc4 with SMTP id adf61e73a8af0-3c0bca52d15mr451793637.30.1783478957573;
        Tue, 07 Jul 2026 19:49:17 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3c1f77fsm1680032a12.32.2026.07.07.19.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:49:17 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] ACPI: TAD: Use devm_pm_runtime_set_active_enabled()
Date: Wed,  8 Jul 2026 10:49:02 +0800
Message-ID: <20260708024902.70806-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace pm_runtime_set_active() and pm_runtime_enable() with
devm_pm_runtime_set_active_enabled(), which also handles runtime PM
cleanup on driver remove.  Drop the redundant pm_runtime_disable() call
from acpi_tad_remove() accordingly.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/acpi/acpi_tad.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index fc43df083738..51f8d1b9a8fb 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -809,7 +809,6 @@ static void acpi_tad_remove(void *data)
 	}
 
 	pm_runtime_suspend(dev);
-	pm_runtime_disable(dev);
 }
 
 static int acpi_tad_probe(struct platform_device *pdev)
@@ -866,8 +865,10 @@ static int acpi_tad_probe(struct platform_device *pdev)
 	 * The platform bus type probe callback tells the ACPI PM domain to
 	 * power up the device, so set the runtime PM status of it to "active".
 	 */
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		return ret;
+
 	pm_runtime_suspend(dev);
 
 	/*
-- 
2.43.0

