Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2493DA7EC
	for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882655; cv=none; b=WNf7tjbr0gWA8VM7HTli84nxwPG41Kzao7+S0IqvXNTfcdogVKfL0VpDrHzOkb0MH1NpYK8OYntiXJzCZy6NBLRNOs9H5C+keirMgo1g5ZqZH7VOrdfQyoQj/0S20Awme9M9/2TjncnOZvc9PVgrW7SIT5x0Vxtxy33abE69KkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882655; c=relaxed/simple;
	bh=K/CXr8sGOQIlsbuegDLGNruY8OXemH3+DJMD2gXrC6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvFZ1dyrarItpiQqEr4luMUsj7cl52vuCgUuyK7v9O0A8zuCgoRD49PcbwM2+mivdDzYjW/gQe4J+1ZP5DbOXg4+K2Id0bf5YnL4bDo0Ps9cOEpN0o9rOeRas5pg3qIoU8DSKkr0N/xFZ72u1IAsMGBOxOh9orFQcFaDsiv7T+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xic4eBlT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xic4eBlT"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso152662a91.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882653; x=1785487453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15QCCMJqDJvxC4OlYXPloXq3cJq1LSRVcuMMIDjVYjA=;
        b=Xic4eBlT78W9I04d2CEONJApzA+CYXES3lepeP+ZemSqti47+9bORS/wJVBIutncD9
         shFhpqdmTpSxbycJeuzPOoeZGONL2/yQ1OSDHusiQ4vE8CqOCrVEShWTbECN9PVs/tjW
         yYkQAWsDBEhEKHP5B9XEqRlxQddDxY3yI8iuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882653; x=1785487453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=15QCCMJqDJvxC4OlYXPloXq3cJq1LSRVcuMMIDjVYjA=;
        b=c1QO67iMPvKH6WGCAWk+6LhQlSa0Afsa5eoMroc/MZZoGMkxJF1ahDTyyAJMUHUcTp
         WD1VdV4ci8GvIcOsApLWJeBOuJbBeD6+ZAXLCuh6Y+xvbeRh6/SUsh251s2unvwttgRs
         /V23Ff6QSZtTDVGed0FWO32g06hx7UlAVmgZ9EiQJDJZSGR72P+VwghKfH5lJhagqzvX
         I3eIi/gLBEwoH3IqJlhBnZIZKOef6/iBg7Gf8ys5O6u9OXoEsFtMMHxgEjqMkePGWeMi
         3HYdUMbXLG+bTB9wh6fKODV1f7aefXK3C3L77uEBUXfXqRuL2NRhhbr1Mzqodl2dHuQD
         CiZA==
X-Forwarded-Encrypted: i=1; AHgh+Rqxdbc1RPyfKEmZaQi34G63vIKll2hw+s1PrQgVewqmOEWKX/a45HnczL5CQXjG1ESP+CWBoTWBpUth@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2FhvkG5jUnSMzfru3CSZgfpizw/APf1/M40k2i1kYFhPTWEfM
	In+nzUx6OF6cbBAJWDQ+9b0jn/9DpvA2vtgNtyLbGuCCZPWNmeNf94PMbmuyIOSGww==
X-Gm-Gg: AR+sD13Qu90lFAJZeVE5hXJIuIE5uijw2vMe9W7OoFAf0K0IWftm92XIKecl2rClyrD
	odCVfgKaL1toBgSQ/sp5BONSQSNdjXJWi84K+lxZKtcWUsmXl5HfztRK1OOjsX+ZwOllar+GWtT
	7FYrI9VkjemfQU9MeWTj/ro589HZySyr8fHdqV2+Rs1Ae83AVTH1EejePf1Smv6cYsrhRomRkkT
	FvaZLP7N9Qmp87BCDe54pIoE+5zf98hWcoxJ50U/pC/w3p8JmOxRtnmhGtMNzZOqaUdmTgv0YC9
	B9FkLNfgcOT8hjdqaa2rPWKDZ7dLKppOI3l8JaIvvVKxyEfGfj+t8jO0Ihqfptdcix9YY6ESQ6T
	aWqyfIUxVedoo0TCXMy82rhh98MEEdoCL6nciunF7Gj2vZdmewvFlEBi21qQxdhmqfSeS04gqNM
	TM/3WqdYP53EuBRzxWqzStygJzySmRtz/kF8rHd2goiZ+1p7a7NXyZtQRS2ow=
X-Received: by 2002:a17:90b:56cf:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-38ec6610d34mr6642066a91.23.1784882653597;
        Fri, 24 Jul 2026 01:44:13 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:44:12 -0700 (PDT)
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
Subject: [PATCH v7 02/16] device property: Add fwnode_graph_get_next_port_endpoint()
Date: Fri, 24 Jul 2026 16:43:11 +0800
Message-ID: <20260724084328.3943997-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
References: <20260724084328.3943997-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to design constraints of the power sequencing API, the consumer
must first be sure that the other side is actually a provider, or it
will continually get -EPROBE_DEFER when requesting the power
sequencing descriptor.

In the upcoming USB power sequencing integration, the USB hub driver
first needs to check whether a graph connection exists, and whether
the other side of the connection is a supported connector type. The
USB port is tied to a "port" firmware node, and this new helper will
be used to get the endpoint under the known "port" firmware node.

Sashiko points out that the |prev| reference put is not done if |port|
is NULL. However it seems that the fwnode_*() and of_*() API design
implicitly makes the functions no-ops if the passed in node is NULL.
So this new addition follows the same pattern.

Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Dropped unused |ep| variable
- Rewrote as do {} while()
- Dropped WARN() use
---
 drivers/base/property.c  | 25 +++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 950defc0c55a..5d3993bd8fc4 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1099,6 +1099,31 @@ int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name)
 }
 EXPORT_SYMBOL(fwnode_irq_get_byname);
 
+/**
+ * fwnode_graph_get_next_port_endpoint - Get next endpoint firmware node in port
+ * @port: Pointer to the target port firmware node
+ * @prev: Previous endpoint node or %NULL to get the first
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer. Note that this function also puts a reference to @prev
+ * unconditionally.
+ *
+ * Return: an endpoint firmware node pointer or %NULL if no more endpoints
+ * are available.
+ */
+struct fwnode_handle *fwnode_graph_get_next_port_endpoint(const struct fwnode_handle *port,
+							  struct fwnode_handle *prev)
+{
+	do {
+		prev = fwnode_get_next_child_node(port, prev);
+		if (fwnode_name_eq(prev, "endpoint"))
+			break;
+	} while (prev);
+
+	return prev;
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_next_port_endpoint);
+
 /**
  * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
  * @fwnode: Pointer to the parent firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index 01ea010cb2f9..9a784a856773 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -507,6 +507,8 @@ void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
 struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id,
 						  unsigned long flags);
+struct fwnode_handle *fwnode_graph_get_next_port_endpoint(
+	const struct fwnode_handle *port, struct fwnode_handle *prev);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.55.0.229.g6434b31f56-goog

