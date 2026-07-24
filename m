Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1711B3CF1F2
	for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882650; cv=none; b=o8VaZYs3Gzs3g7wt/0YYdRa2gKTj3PSv5gk5RyFRPLB2mVCZ947BiyVB+XLXUb9RnajHb3YH6+K5NZzWgZGF+cvgRDhUWB98V0LNaevKtKXglkISBROLUCkJef8oTUNQOdXOYDDpslCvPJoDozOhXjahPxsLA4tt6job05NE9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882650; c=relaxed/simple;
	bh=rN8bGYfPxlquy6cQeK5GYz3ym6oKo/FOx8yU0FBCzV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxtESSO/fzVVOeAAhOlz5DwDuDLiQ8Qpmy5apD/Iy7dxwNf11g0tlXHEIMA7hYRuQRGqvLEuZUIY5+JCoRzIjuSv79w5jebCJjCmJh0RS96EgZq2BR/Coa76LkuX88Dhxs8oV783fSZ171N+z5W+hxErQHbytT7GTdFhJ76XZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hXHF/C1i; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hXHF/C1i"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso152607a91.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882648; x=1785487448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZPli2S6cZzTtPxNu5kCcB+M+KQUeHMnkMABY4ADLcw=;
        b=hXHF/C1iFP+DzsSdCDcke6XtH45FLhGqmJxDPybdM0yRDfbEOsigMesemAKruvD4Y8
         NbDh11LPukF6dWMm7h1fXmBA0NG/a1omudCKRimwAt1eEDIbJOsSpEpmA3rT6daaP64i
         UjNN8IydQz2sdOKPDz7dzSTe9VAUG76EmTXk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882648; x=1785487448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yZPli2S6cZzTtPxNu5kCcB+M+KQUeHMnkMABY4ADLcw=;
        b=RXtYSaLtR5fichuZU+kjueXOhMSJ2U9Phjcq1ShIQXVW62pc+J1iYSEeGPQdBn28Ld
         L1IIwtchhZ9gEwkBpt8kGe3JscGLiPQg444R74k1F57t/gWr8wqBI/qKR2N+Ylgdiot+
         +0OrW8UpAfkmlDU8T7EnoTeRnG+7ZdKIfZ7CjJi/bWle+IHww7GF4SyVUwGrG8rB77pl
         i1WFeUkJ2vgmE+bW0FrVfOnGTza2SGzY5/TWyJ8m8HqxzXkbnT3AuJ9rTmn++E4iA++r
         NLFyL3XTXiuAY+0t1QaxKmU2kMflmwgtAW/ErNGbXW35ACULke3aHYEnGJRfu083f8nd
         OKmA==
X-Forwarded-Encrypted: i=1; AHgh+RrGwJaNn1THJu/gAzxZWT/Z1ihXWSZsHzT1AeRFGLBzSJFLy3X7Leq0vVPLOOybp7v4rxkxw8EH/pA+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/EEaLIuds9IK4OKZdX3/CECRfWFJu04c43OpA67PAj6Whfmk
	JMU/ih45MBbF07f1Tcc3S77Ty5/D6wuLie1C0X1ZKxLHZTIqey6Xt0CD9/joR7hEtA==
X-Gm-Gg: AR+sD11s/polE+Y7Fiyhc+ku/W0r/fUfdEb/QAR0yXddhCammPbNT57zQI9jg3dSO4Z
	HSbe3rncDBXprztOFaRQPQYPLOx2Q1lixmZuLkOLOmGU6JyYjmtXZziNHlaxOWP6WoAE38JGj/n
	xCPz20mWJFNtBSj4smB9iQOTuKdj5e0HxZla4Jo5HnNUAGBZQJmgSDkrwzUx38qED0CkMc7w5Ey
	CiAD0/qzXiVWJU4vwCsENBTyxdh/3PzrQGH0mI4oZVFqpQUWYFBruQbOaIAjrId9YGfhIwLKlPB
	2yU+goZjivMJoye9I7pA8hhlNyq4AulaIrVkuy5Qdax2KGqT2vuVUNY5Zj+U4Li2Gbg9rlKfOHO
	7bifjYO0jY4SgmsEUWx+j61C4I81EhRIensLDd7cRDf82DkzxHNctX+QT+WqDz9cXU6sF6d/1vz
	xuzAnR5nzdwcT5IqDbM+q1XLFvXW46u1B7poMsWBrSQKTzgsj4fUcleXV6PMo=
X-Received: by 2002:a17:90b:2750:b0:381:5ab5:b667 with SMTP id 98e67ed59e1d1-38ec6637d1amr6238598a91.31.1784882648264;
        Fri, 24 Jul 2026 01:44:08 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:44:07 -0700 (PDT)
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
Subject: [PATCH v7 01/16] device property: Add fwnode_graph_get_port_by_id()
Date: Fri, 24 Jul 2026 16:43:10 +0800
Message-ID: <20260724084328.3943997-2-wenst@chromium.org>
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

In some cases the driver needs a reference to the port firmware node.
Once such case is the upcoming USB power sequencing integration. The
USB hub port is tied to the corresponding port firmware node if it
exists.

Provide a helper for this.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
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
 drivers/base/property.c  | 29 +++++++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 9387bb83eb54..950defc0c55a 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1346,6 +1346,35 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
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
index 14c304db4664..01ea010cb2f9 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -505,6 +505,8 @@ int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
 
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id,
+						  unsigned long flags);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.55.0.229.g6434b31f56-goog

