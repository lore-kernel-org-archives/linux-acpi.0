Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FF3B4EA2
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080894; cv=none; b=vB96HbbwNHVGgqB44oja378ZB49hsd5htcbGDT+IouaSaZ4xGZJImpLwYr1GyTUHIGFtVOYei2ofzqhgVzrPHpkKLp1klcvpqToWtzIRb/wo0+eubbw+ErVgnSk25mIANBRl4vIQKE78jYtLcPMgrEwilK0DKuZaWvw18S7yCCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080894; c=relaxed/simple;
	bh=sAi0MURaPjHAXe7GjHIr2vzfcZt5+QnjAoJMj8LuBqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpfwtCjm2xE02V2OTI6U+vns0ZgvmgIZvSSBXnZnsme5GFi4JGtkv1H09xreC8IzjNNOXpr4vaKmEOMKmeOEruExgo00vbz9f392TWkoPRspAzH7tdETM1JKLOILIrf9fK3CgHu7TcL4JuwcNXDN53rPcmUov6PZh7r0UlflvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WUVjfzI8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WUVjfzI8"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf22d29dabso43396255ad.2
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080892; x=1781685692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDEOB4zDGGA532YGopw6vfAouEtuG7p7cdbO9K1VfZ0=;
        b=WUVjfzI82etRAabNHQ6HbAxofP3BN440TN41o5OswepdmNA8IVuahtLZUskHeFe+o/
         axAbywQs3Mf+ku4DOxzed2TnCrSoOZY5yy8S2xiVd0LtTfG70YB5KO73ZwqsVA6qC+h+
         YP/HsFEWVAeCYU/AfFm+fdP4tOJSRyX/fjSUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080892; x=1781685692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dDEOB4zDGGA532YGopw6vfAouEtuG7p7cdbO9K1VfZ0=;
        b=D6ZzZxxJpy8eGKp/TiI4XQ6qEfN15i5T9B8/NiNRaV6t0xSmsUFwPO7QNVXL6oRp9X
         4uVcUTkncTAUta7/8RMn+ky3HK7ES8NvHuBJdYkjQk7gmleV5Y0MHrpZ+3yLMnBaBhF7
         +OvflOAr+Pcx0X8MElgfuMe3DsayRNIVqsTqpC+ousoyBTVBsVUP4BRYSbCwVMyb5Gho
         AukrzJ90NE0nmppIqn13VzkQDzp7I7E5oSu0N5M50VsMY8/RwSnRjcYt7rke1/H/ENX/
         ckVnNFFhk/EDwv8sBlAk+2XW6YLIl7yjB8YEp6Oz8WqEfmEx+tPjhXPzcnnKskF4dokE
         wX7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9LEjKpPS+hXPzg+XL0UcduSySR1As5wz10gQyea3dNXDhRdLL6TMoupZEBGO+T/Y9PHXvpwxPwnbnM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6c9tGnj3hYsBChLWdBmvra5U+iKUzn1AdpnO/ASZH3v8rj7h
	7+xK3d+FF2og/VqZORq5NUnfvHiaJZ3+8+RYVjHxuDR6LdQV3jzC0/1KHnsh0mkKpQ==
X-Gm-Gg: Acq92OGCG8zeoe1cgZ30haYgOd+8KNtjdvGY8lFl2SkqiynxXFHCFQDg9VOoWqluD2O
	3yoSzaCNJh2EhwZxHwRr6b1QIX/UgDJB51AfstjcsM0mb1EPDmvHWh//dWkBCfBzc7Sk2N83JWS
	KHO287FB3Ts1kQcVS7nU9JvvYx+UTO+WLChxbiM/YHibx+hqeyd3kZyt6xp/2tgVq7uBSKzU6jq
	AML2jqFEZlv4oqzfupu5sT/6iJMYOtz6Vjyuh3gWhBCAR/79HWkHdNlr6s1Y9i7rJF+0Fu7DguV
	gosRFOZlbgE2E3FLwBgZmbns1ngHvLnK/ZjZw+KnNc5CqNRGXnyBddVT7WmJDxsDaoGQSttL1Ui
	JrSVEQPuFM4512VkE++v4o76QXU+SV5SQKzKi6oXNbQ4B6/auqvX7hYLYIJiYPKjd+ggMWffyR1
	kYX+kXMZ3wh+y7MWFkxAVzxAeyHDh3SVa1DxgLr8Aj7WvVFZOyILik3h0A2ObnsPxfkrVPgd8AQ
	bQ3+jfcJuvElgFpPw==
X-Received: by 2002:a17:902:e74a:b0:2c1:8fea:4dbf with SMTP id d9443c01a7336-2c2a1bafeb4mr79293415ad.8.1781080892355;
        Wed, 10 Jun 2026 01:41:32 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:41:31 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 03/16] power: sequencing: Change CONFIG_POWER_SEQUENCING to bool
Date: Wed, 10 Jun 2026 16:40:37 +0800
Message-ID: <20260610084053.2059858-4-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <20260610084053.2059858-1-wenst@chromium.org>
References: <20260610084053.2059858-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

USB support, including the core and hub driver, is bool, no modules. To
be able to use the power sequencing API in the USB core, the former must
also be bool to avoid the latter being built as a module.

Change CONFIG_POWER_SEQUENCING to bool.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/power/sequencing/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index 1c5f5820f5b7..27448fba9dc5 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menuconfig POWER_SEQUENCING
-	tristate "Power Sequencing support"
+	bool "Power Sequencing support"
 	help
 	  Say Y here to enable the Power Sequencing subsystem.
 
-- 
2.54.0.1099.g489fc7bff1-goog

