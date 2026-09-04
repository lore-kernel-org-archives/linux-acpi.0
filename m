Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771B3F825A
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511341; cv=none; b=DcFjcFa7U0epCVf6wuoYLUOkx5Dxi3krtgxr/li2+sorrHXHvx+2WeBacN1G5hwc32AmwK/rLQAJxOZd9RkQhGj/2hLNH/z5Ps6cv6UCEwbAw2ZXTZz9fZcT8EZ8/QtMTKI3YyLRwa272FoVidveI72Y2cpoJmtQyMCWGoxOsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511341; c=relaxed/simple;
	bh=RGLL0tPfDP6uNlWVczfepdqpvZGR4BjUGaRZ583Zkzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMMcKYs74YW59YYeFkpM/0Qpv3FTV2aZmtCOe1OyXG7fXjo6VYV6ShFHTVoB8uD6iYXZNXFn8g0PdW0f9rWwYj7fmob9Dw+TkC1hJ3i/LFTcmK+rZ3zX6Y7lFixIQhYM6OjJ1sO3NatyZA9Y6zJW9x5ay1Ao9QN2Ymfuc/p2bLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O7P18qCS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O7P18qCS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d91518a63fso6251375ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511338; x=1789116138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WRetEA2OXFI4SKJH2CBFzorRJvZCDQyI99zumpuCSb8=;
        b=O7P18qCSyADO8m6V5Gg4ihPJBl5pgR/VwmUQsPcIc2zxMigWUjp+iIcmNpqSlbXcA1
         qFPc2Q3ifZfB2t8nUeHzDE+a4iByPY46UwJf1agFdThUDcYFuVZcYxSpUs3vdTEtNeSx
         3MqY0fSEHLzmqSRQoffGBRnOwZTLcXJVTUi9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511338; x=1789116138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WRetEA2OXFI4SKJH2CBFzorRJvZCDQyI99zumpuCSb8=;
        b=Q2bmEoF/iopWnGgkTp4700w+iODtrSlEkws6cy76cPthULYpvjd7LR7ht5cQiwL3oW
         t66KQhirgELsg3CVH3+LNqWBpHBR3PI45B/s94mJN3RDytIYUTeJ1lE3s/ExUMKs2fGM
         l7mhpikILIIjAQcwTpDdKyyOlmF3TiI/MdOCGADVvzxYiaGPgTjN+zXNzPPTHygIbogc
         CCZ1fKA9J4eWLqvcADLTUhR86DSuaHWjVzSdzbYtQc/DPa+XcAw611LbHyeLazhnST+4
         nNWt+hrIP63Oc9IW2Ji7R0S5Sy0psjoyZ1Ko5V4L17SSVi3XwvrB3jTEWAWmFf+pr249
         8sFg==
X-Forwarded-Encrypted: i=1; AKwUvBzvCwBam5aU5swnIvNy5ULlD5Z9615efGQv3WJq27IMSqI7OVEhjgbMqdTta+0Wb41+61WMNAtxSQoL@vger.kernel.org
X-Gm-Message-State: AFuF++kRlEmQ1WiY5xOZUE1Q4KOKYRTN2NiTS00j53Pe6Q2Xgp/RNMrL
	I+54qaWhUbvwtMB99vHn8CMKc8D9cuvzloMBh0PV6Zz4qtouJuDhyHBae/cV07Jpyg==
X-Gm-Gg: AYBFou2U6sERkGZiZHxkfnx5Kz1jAsyQLL03IiOvPakxSm9P5XT6LIefDRTz+/si7rj
	7ySKAhbVqPXcrnXzqItAsWoijsA9WICq6fdlKU+GQgNortHIs5MYyQPLWJyEYV9/+HM7tuxbdGt
	BMgQR6yRQ/qTXmjiBDhQa/sOw3ZCQqIYGRutnHFlK3n36OedY+fQzrArNmgBNzmxiinHSC23QHW
	GuCfF6yCf1pQi34bEFShrd8i4d3o9Ur6KJ3d5maxJdcRCR2h7tCIDA6YgxbV3+hXfHTTWEJwW10
	W8LtSTWEMywQqH8/OOLrm+IqFSHGKEgf/H552FWUio/ZwBz0dx03150Tz9lXnXOoUemmXtMX3Ne
	o+EiAwEh6q9gNTKOckAi5CtpEutvZES56A1RJKZ2MZSfoC9ijTYSIdw7k2z498GmPHuyuSCDKbZ
	Iu0F+y6UEH30IG2dftcNXteNaoJvbbptdUoCkYOxL3L6HQFJDDtc3yEfaCQBbhadxV1I2boNdRP
	06mjmULE/6JBueA+ZLC9Bvoxsoux5082hp7T0Fj9peq
X-Received: by 2002:a17:90b:314e:b0:38f:efed:5445 with SMTP id 98e67ed59e1d1-39b261500fdmr6024537a91.4.1788511335746;
        Fri, 04 Sep 2026 01:42:15 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:42:15 -0700 (PDT)
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v8 01/16] device property: Add fwnode_graph_get_port_by_id()
Date: Fri,  4 Sep 2026 16:41:40 +0800
Message-ID: <20260904084158.1341550-2-wenst@chromium.org>
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

In some cases the driver needs a reference to the port firmware node.
Once such case is the upcoming USB power sequencing integration. The
USB hub port is tied to the corresponding port firmware node if it
exists.

Provide a helper for this.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v7:
- Mention in kernel-doc that the function does not return ports that
  have no endpoints (Sakari)

Changes since v5:
- Dropped left-over declaration in header (Sashiko)

Changes since v4:
- Added flags parameter so users can specify whether incomplete ports
  are returned or not (Sashiko)

Changes since v2:
- Moved "Return:" kernel-doc section to the end. (Andy)

Changes since v1:
- New patch
---
 drivers/base/property.c  | 31 +++++++++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index b136c339ddae..68108805482d 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1353,6 +1353,37 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
 
+/**
+ * fwnode_graph_get_port_by_id - get the port matching a given id
+ * @fwnode: parent fwnode_handle containing the graph
+ * @id: id of the port
+ * @flags: fwnode lookup flags
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
+ *
+ * Does not return ports that belong to disabled devices or endpoints that
+ * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
+ *
+ * Does not return ports that have no endpoints.
+ *
+ * Return: A 'port' firmware node pointer with refcount incremented.
+ */
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode,
+						  u32 id,
+						  unsigned long flags)
+{
+	struct fwnode_handle *ep;
+
+	ep = fwnode_graph_get_endpoint_by_id(fwnode, id, 0,
+					     flags | FWNODE_GRAPH_ENDPOINT_NEXT);
+	if (!ep)
+		return NULL;
+
+	return fwnode_get_next_parent(ep);
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_port_by_id);
+
 const void *device_get_match_data(const struct device *dev)
 {
 	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
diff --git a/include/linux/property.h b/include/linux/property.h
index 907c790a3f01..3dbbd01a52d0 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -507,6 +507,8 @@ int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
 
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id,
+						  unsigned long flags);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.55.0.979.g7e5102b832-goog

