Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA57B406298
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591118; cv=none; b=SkJsFJXPDeCux2eon3yCaEN76YUpz7agVFrwLHwMck9jDyR09du+tWz/TZIZsZTdeseAHVXMGpAXVwy30QsDYc2vaATCBivD6G/ydRYjoa6Scbjl1ZzG0pWMfr0Bsoks6ur3Ja4FLltpCfAUJY4vT+I70WCOVtFiC9PDEb+I3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591118; c=relaxed/simple;
	bh=wBafzaV3gjSM9m4C5Xt10gLLMadwusWzqQ8Oa+RTMik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKGVIinEqeL14w2EDVh5kScXM/VKsIwPoWX0KJEN6IJXE6nsDkJpYDA6OyyltQk7g/FvpHDYCjZj9SXCGX61lMvtd2M2aEc48GgokZcky/q7vaMWRFYGgSb57RgKAVriAJlGpFNxUxVlvUo0j+XgeVv6D8/64GSg03n89HQGZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HGewnmle; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HGewnmle"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc6dd436c6so16682805ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2026 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783591116; x=1784195916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+6qS8sNKqohtOzh0Qv5rdb1r/B7Aj2Rva8hJLtH9EXY=;
        b=HGewnmleUf1fRlxmhIvnIY9EShmWAYlRiIQ3qU5pDd72sg5Qmc3Q8PXc1/6Kd1BZq9
         OgEew67NURfR+qa42DXyz1uvm8K5/XRA3Dic0+kygI1hPhbL21hsXRmB5fobDa/VpXLs
         /wxg8fcUDutpgbVKSJdAL00O+/s4BduLJqIBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591116; x=1784195916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+6qS8sNKqohtOzh0Qv5rdb1r/B7Aj2Rva8hJLtH9EXY=;
        b=BLuguKLZU8hTnoX4m+/+0fKHyd+xh6hZk19cNz+RfD2NkphPX/u2YCfC6QVdVYx0Uy
         C5IZjRvLin/H9HTrDcrspoUi/l1pvXfA+FdBuAfaskeuKISAw4YdpJzhH2kitHPMr2BM
         jWn/R4z2Qrur/xsVoy8hlr0KmRXhIFo9xNcNd5GdXpGzYf4w3795B7DQZHtAsCgVP3Sn
         PVKap0RPinHCiEoIyi5ZcNc5lLChq8kQ5dgXkzjBllh1AmYLt9kTzkKRePK2o7xY6g9Q
         wBd2tOtxVcRwKUUVZD4eR5TSFfbhyK/acAQM75rNnOrqYaNoFXsZthMUEXFSZC3aoIAg
         9VQA==
X-Forwarded-Encrypted: i=1; AHgh+RrIbkfVgN8QNFIA/hrmYZxbxVzHLU4lLSiB5d6dgBDSfHtRnPSe3xqxvFGYluq7VrFFGvdV96CabCnq@vger.kernel.org
X-Gm-Message-State: AOJu0YzwDB71RFIJTxcjD+tUejnHr/G6umCDjTWvPbmLKo6cK2caazQj
	O+Cdb57EQXl0GfC9KYMIyXOrkKCa3O6IgEgBqAQSRqMWiz83A3bEqO+NSQhL4rsvZA==
X-Gm-Gg: AfdE7cngS3/oi6SNO/DZoUCbYw9mk9qpGPIS+ExduRLC46pKtgX/OlL/YBAT6yuq5V+
	awPhtGHX1Hu3R9eU6NZDj6U7gdR5w6IeyreTEbQ0BlccvVwq+7bdyJ943Cj52AE2LXu7Ab/1cBV
	bIcLP7pk+RSTB42wyAwTK7ENQqDHk8fMS6iKiX2XWgbTEvqHhKzcU3csOby4q242gcINAN9N8te
	KaLf6K2Bv2+w2AAmCTwOCo0tRLpwSo1zJiQIoRDFD1Nf1zRJWvTagjj4PYVG1oizNZfXjAP+Ip/
	hTLC4U3sMEM+I4mj850KQiaBlKS3TbgRSN/U2YiSgeLTsdIwqvneSh++v9eHmOLXT7JnxQSDM/i
	H4nUoKSqJRNxQd/kDeKdUuHsaBhrVdTCb8o43akEFjMgVbiWBJ5fR4mtK66TyJ6QrVHxx88kc8G
	o+uH37F9H4HuwQ/e5Xq77KoF1EWdS8VZoWjqkqciienAcRuyx7sMlqj23QEibk8nBh8SFZ/A==
X-Received: by 2002:a17:902:e74e:b0:2ca:e106:8e69 with SMTP id d9443c01a7336-2ccea371b50mr70745585ad.10.1783591116169;
        Thu, 09 Jul 2026 02:58:36 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bd09:6ddb:180a:69c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm41082155ad.78.2026.07.09.02.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:58:35 -0700 (PDT)
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
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v4 11/14] power: sequencing: pcie-m2: support matching on remote "port" node
Date: Thu,  9 Jul 2026 17:57:16 +0800
Message-ID: <20260709095726.704448-12-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260709095726.704448-1-wenst@chromium.org>
References: <20260709095726.704448-1-wenst@chromium.org>
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

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Drop redundant device node validity check; device_match_of_node()
  does it internally (Andy)

Changes since v2:
- Use device_match_of_node()
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 83fe6a1396bc..733190175f84 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -175,9 +175,18 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 	 * parent matches the OF node of 'dev'.
 	 */
 	for_each_endpoint_of_node(ctx->of_node, endpoint) {
+		/* USB port devices are tied to the port nodes. */
+		struct device_node *remote_port __free(device_node) =
+				of_graph_get_remote_port(endpoint);
+
+		if (device_match_of_node(dev, remote_port))
+			return PWRSEQ_MATCH_OK;
+
+		/* Try the remote port parent for other types. */
 		struct device_node *remote __free(device_node) =
 				of_graph_get_remote_port_parent(endpoint);
-		if (remote && (remote == dev_of_node(dev)))
+
+		if (device_match_of_node(dev, remote))
 			return PWRSEQ_MATCH_OK;
 	}
 
-- 
2.55.0.795.g602f6c329a-goog

