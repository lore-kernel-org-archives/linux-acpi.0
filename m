Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72BA3B5303
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080926; cv=none; b=JYH63/l4A4dOs+3v/K1OULNfeIfYaZv3MmCkqYq+KMe2HR0XCWgWw7zdfvXlPFMEJI0+Y/QeFjQ9hY1U591ZPch4t7FINxmufvRnIyuSFMCC8FxaNFGR8INaiD9trJ1GWFaqcM3V5gYKP3hLl2rVG3rhUyvl2CI+in/9jkXtzk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080926; c=relaxed/simple;
	bh=Q230lnY0gVIEr7GJLHqky4UKLxDQyNEVo5h765AhfJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjHwI0d7nSSexe5Fpq80BCVoJdxYCiC8kTipDFvD99RQ907BrVGBMiqrC3719bIkOR/VDR733aJT+Bh3TfyMXwNpRGM7zMWQzbZg9Slj+9XEShVOqrfzKSm0e8Xl1d2ygc++5RgQ+k6isSbaCLgAQRcKmUZU1ooASLbp5twxu04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q6w9RDxF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q6w9RDxF"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf22d29dabso43399265ad.2
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 01:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080923; x=1781685723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS442Iy4WHxSdJHdZSOdZpr7Kbl6vNC1J8JNZ1Janxs=;
        b=Q6w9RDxFczGEkAJjDHzISYkh32EV/GVUcvrUUaV27U+mn2Ebvskd9lzBaHss0VRlki
         /KGqDphVexrsdYmJidEiBNSv7jVSAAKZjrf/wpqAMz3DQ9psFtweva8cXC6Gotll0nos
         t9lcp8TZjW/FDQ4nWz7kzRaCA/zRKkYHxlsDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080923; x=1781685723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OS442Iy4WHxSdJHdZSOdZpr7Kbl6vNC1J8JNZ1Janxs=;
        b=RZWxS2+EO5xBYU20oaLmhZNBNl1K8f9PghvM82moR+zT80OYaEH9JHAIBXJgDMjDv2
         WCbb/OhkiXUGWecwXY+iOsREnWfeFkqfMLmBJmn88KrLADP7q1sxpT1lhcTzUO6EMamJ
         IfxsEh5ipUwNESccqKCDY6Xi2/iouITMf8F9aWqD0ZeU7rNrFE1bMy9COM7/nGmOtrYQ
         1p+9zat9NBTQE5OavtzP376FlYnjufwzk32MiUv6VRHvSdXhdig5c0Bb+OLHTmZDlF9V
         Ej32mD1gXf78jeRjXAYEc8QRHxlEj7gwx2HhyypVdciIzC4Qe0tqycjyydYK4b5ArXpd
         NQ7g==
X-Forwarded-Encrypted: i=1; AFNElJ8EOz3U0Wqc4EBbYGjn6nE/rDSWErL7JItuvHWVAznP9YtvktzsCyXyNSE6GkGKkuvhzEQ8wKZSC9uj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+EoeDzbBtno+DyKKrWyQ3m9JHNaxqTU67BV/SWk3q0knpw7W
	OisrHAlyqGZfds7dsViZ+xdeAIlVOeAG9I9K8p773S8RpTB6oPJP2nqu/vzhbI+wGA==
X-Gm-Gg: Acq92OGolreFWyBR+XdYEeNyapZ0fGMdSBmJjZJAVF0Sdj6u+K+vh50hGvdKiz/dfMs
	ZO4y6YwvM6gnarlL2OVZMksd3B67cNAeyZU/Z9+fWAgUyjlsq+DrKAxYbPnt+ZlC81s4a8ypV9y
	a/zfmWzEJRPzrWqoc92CwTBlfS+hkWrJBj3RWDAnTwfzAZqU3qMlk6v/Om9lcoX9Zo7+QfqHi4m
	ggUlf1Uow9mwenZNDyxPV3o/0WHJj5amEDT66OcB2DGXLPTgTg72bSjfPK9DW+5lMQfr57xkNAA
	7H5eIokCbuLwQ/0kIsiklZcLY3DGXTiL56897Ah0kaW7cNTx89zv6NsW9ig7ZBOhlAMNPhK7sVn
	RYy90uHAn3JbEuoCw8Sytpuj4iNAS8ddT4IywBMYfgmf6L21qB/SSh+KYTmESl8yI5EGJ4FOQYq
	Aqcrei+tNjQi3quiJ+9mwGFEN5ui6xnigrJJU1iUeqEo3DBbLK3kyo0GISkVLtYVdNVHMLC3bOT
	dSQDNcdP4YUNyt0KA==
X-Received: by 2002:a17:902:cecc:b0:2c2:9254:4c22 with SMTP id d9443c01a7336-2c2a1c66cbcmr79859165ad.17.1781080923157;
        Wed, 10 Jun 2026 01:42:03 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:42:02 -0700 (PDT)
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
Subject: [PATCH v2 10/16] power: sequencing: pcie-m2: support matching on remote "port" node
Date: Wed, 10 Jun 2026 16:40:44 +0800
Message-ID: <20260610084053.2059858-11-wenst@chromium.org>
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

A USB hub can have multiple ports, and this driver needs to
differentiate which port is being matched to. The USB hub driver now
associates the "port" node with the usb_port device, so here we can
use the remote "port" node to check for a match. Then fall back to
the remote device node for the other connection types.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index e82821655fc4..49293376956b 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -176,8 +176,17 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 	 * parent matches the OF node of 'dev'.
 	 */
 	for_each_endpoint_of_node(ctx->of_node, endpoint) {
+		/* USB port devices are tied to the port nodes. */
+		struct device_node *remote_port __free(device_node) =
+				of_graph_get_remote_port(endpoint);
+
+		if (remote_port && remote_port == dev_of_node(dev))
+			return PWRSEQ_MATCH_OK;
+
+		/* Try the remote port parent for other types. */
 		struct device_node *remote __free(device_node) =
 				of_graph_get_remote_port_parent(endpoint);
+
 		if (remote && (remote == dev_of_node(dev)))
 			return PWRSEQ_MATCH_OK;
 	}
-- 
2.54.0.1099.g489fc7bff1-goog

