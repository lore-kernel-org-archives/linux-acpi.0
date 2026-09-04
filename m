Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914303F6C26
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511465; cv=none; b=UhWePeB+/jIe/f6Mi6z8qXLd8yoK+28/n5wV62QwT4DyFbeb4npLDfBf9b5QTNmUO1LZwSuP/pcz4fzwxSWal7e4xdliHNC7rfkZ80aj1RYz8REMxsd68kcILN+vxO8oZ2ZFB3WkiXjr+aAXveNQDasBBSXCDY4wmBhFs5BKByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511465; c=relaxed/simple;
	bh=xBV8QPVdEcBZnuBIzyHhldDQGO+nq6BHDmKFvSTohgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsCl+XposUxI6t/ki/Ool2zDz5NFpD+A/9d/cWfLUMcPAWUEP8xr3E+s8p0wO0SnX1MDW6pvtn4FX98IrNkm2vZOVRlZolE1z9G2dWbJuvCfCA3B8Tmy02hUxfnbbE4OaCTERa7qfqVxKPsn0U0jNHJBdW/aCOAvHfLxbAz6eOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SXKqkSQj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SXKqkSQj"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso851385a91.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511463; x=1789116263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1exL3htqf+GpZcCvUWENBQmRfzXhNWdoVzfZaiBanSc=;
        b=SXKqkSQjIrMNOmALVals/V2vnF2xuhKA9qxk7d7X135SM5V1C+sn+6ykUj5KPRXpXa
         xWqMm9GdpHwk7C72TvNh2SXFrXgmMHGa3BATreUdsl/YwEA3OdCHRarXYUng1eX126zz
         YTT81FZTqW5EI1o5OGs88SmZlrVuIg6GskphY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511463; x=1789116263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1exL3htqf+GpZcCvUWENBQmRfzXhNWdoVzfZaiBanSc=;
        b=qpOZS0tGObSh2+Mq4rcEfWSeQG/VXOcb9XC6SnS/gHztcR9fKfpdkOk0sNRC1pAnZS
         Lcih8KgNxb3Q3E02lOuIJJRHlMGnXRLKE8VJ2/dLOiSHa/u3XM2PxLlGsnJ0VWdO4zst
         rWxoudMWk6bdZjrkhb+Z3YSXU7sD/rKrCSseEoFrEDtiGoOaWlHrpLzKIbtDfV3yStTw
         naDBccI01KwVVfQPjuKeGTE3x8Ukg80qfrMr74XE1HJNanZChtaXW9QRIM8aSSPpAlC7
         Y+RimbXBeb5MJqynde9Py+POBThKCzpcThBhOCon5QmQmq2J7lEwsNY5eWui/EgRwM46
         OaTw==
X-Forwarded-Encrypted: i=1; AKwUvByyiQTNXMNhT+g9Q2y+XgkmwO9WpR2VWZin6zSOOoGnZpaBt4ZDj40zFOAmXCO/pEBmQIAvyrXsrN2t@vger.kernel.org
X-Gm-Message-State: AFuF++nCqXJQjmil30Vuc5Ds9SJ6mbJ39UHBtAGTQ4gbNLAnynEU/PDf
	2AT4puHuxKsABR5ZUibjNUqoGP+IyNWor4sUNgSTBew9YyqcpHfZXJJ4wQYQPKVj4w==
X-Gm-Gg: AYBFou1Xyy+oLO8aoDtLJ+NjUtxKDbaJyqm1yr0IdOesHuFvhH7dkJxteJWLHGPvjk9
	NbU1hthd+6xf1jbK0bHQ2DvojGatr5jb8XsAQxkxeM9fIBGwoGDY4b2hRfOnHyb+IvAWjmGUuCN
	nPvszbzvmfSNXg7UFwE2NZRh5EnacvFUWuzzwGrcp1xq8SeJOR2C7whCCfMwdu3TEU7DttCUr+z
	2/UeaHK03vSf8jN0x1KDKgNpbHfNWwjdTIv0gnMTeTYTu89DjiH12rhgy9R2YlbIBh7sqXimLYl
	0E6+ym0FH42ruzfM95JBLQp6gefNTQZmqtR0Vg9Srw5AVhJWWzZ93mf3495y6b/rgiiYihrKZH/
	SLPmXpEimnQK5tExH4CemzDQPRzjhr4l6+ZLluw65WwYcyK9vky15TQdMffni043M95axUeuv/L
	NAc/9MWyfmCGb6ZsyUtyjvcHUMC0mNKdOWnAc5g3fL+KA0/WDCySNmrCxuj7Klbo/xbig2ABNpD
	cfqjlVTbRVK27lkXGR+W09nqg+zdCJYLzgeHgZyulM2
X-Received: by 2002:a17:90a:d646:b0:398:9bd5:490d with SMTP id 98e67ed59e1d1-39b26214798mr7405740a91.20.1788511462630;
        Fri, 04 Sep 2026 01:44:22 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:44:22 -0700 (PDT)
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
Cc: Wei Deng <wei.deng@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v8 12/16] power: sequencing: pcie-m2: support matching on remote "port" node
Date: Fri,  4 Sep 2026 16:41:51 +0800
Message-ID: <20260904084158.1341550-13-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904084158.1341550-1-wenst@chromium.org>
References: <20260904084158.1341550-1-wenst@chromium.org>
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

Also rewrite the existing "remote == dev_of_node(dev)" with
device_match_of_node() for consistency.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- Dropped blank line between __free() variable declaration and
  subsequent use of the variable in conditional

Changes since v3:
- Drop redundant device node validity check; device_match_of_node()
  does it internally

Changes since v2:
- Use device_match_of_node()
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index de9848a9a9f1..43b2328a6661 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -175,9 +175,16 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 	 * parent matches the OF node of 'dev'.
 	 */
 	for_each_endpoint_of_node(ctx->of_node, endpoint) {
+		/* USB port devices are tied to the port nodes. */
+		struct device_node *remote_port __free(device_node) =
+				of_graph_get_remote_port(endpoint);
+		if (device_match_of_node(dev, remote_port))
+			return PWRSEQ_MATCH_OK;
+
+		/* Try the remote port parent for other types. */
 		struct device_node *remote __free(device_node) =
 				of_graph_get_remote_port_parent(endpoint);
-		if (remote && (remote == dev_of_node(dev)))
+		if (device_match_of_node(dev, remote))
 			return PWRSEQ_MATCH_OK;
 	}
 
-- 
2.55.0.979.g7e5102b832-goog

