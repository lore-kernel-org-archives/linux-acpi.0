Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBE45FFAC
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545517; cv=none; b=rPw2rT+GO9fTkEc8TXjMD2OpZK3LVdtU7ojP1K/7UWL444jYcVpYTz0A227bZ/8tXQ/S38llx/ztzndmsqNrf+LK87Upd3L/HQUwnUJ2QZdqm4lj2YnBdFkzD9UF1UX4+HbqcUFaBJQQUWfQuLSnW9b7fzgcxpFOpe9MBfmWLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545517; c=relaxed/simple;
	bh=WB3HiPndp9Zotj1PQ53f357swoA5uLM5cWEs+E4kzDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kk9GoX+NOHiPZlpIgDmJu9wPsC5EkkL4yO4Cd9dBmugNm3FkOCBc+RsKNCk0fD5sxmM3j5YMrf6BsG9Gg9mspUYzUcXQyssQbxIRoUrYB0lzQS2QMTTh4ujGW+ORpP5T6GC5UXtwhOWYGGhyj2JeHzJLmc4U5TUMpvIgLOG8flM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e5aAvZJf; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e5aAvZJf"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398a1676000so460472a91.2
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545507; x=1790150307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=27brx5O9Ivpq2x+qbJykPxVf6DAdKCDChl3K9VtBSIY=;
        b=e5aAvZJf7gy/oWNE8Bl8LCWnphU8XZBC0/zVc/gDAzCf4e7tNFTXFjGD+Y6FpBdGW1
         ViY3eJ5fpE1Gl+5QSvMmHoPcqHTyBCUEhCDUra07Tt6fIngX5+623h++WNuSpjd+kHBl
         /5moxt7/Wxlzr1sJEY0LlG3LLg6VmBaQEBmu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545507; x=1790150307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=27brx5O9Ivpq2x+qbJykPxVf6DAdKCDChl3K9VtBSIY=;
        b=V/83NrGV2kyoW4G7ZseQRyMFM7w9zphtE1C1Z6503rLQ01bRZBzyTy9M4FtSsSKseZ
         4tZloM0d4uKWkfK2slWRpugzqekiLPQqviOMzftoMLDPG2TFlzVW2UrD6J4NhpyvMp83
         drDS/oHJyir2+HBC1MvDrcbWr6Xww52HC4hrJXdqu3nEJ/0/h7DNWzCgWezNpyXTLLY4
         eDAFryHaWIIS1VRritrRwc8ZloAjjcYADlytmW8JXnZ/UCWvsqbpnNSCzxcylZnKZGoI
         25s64pbVqr1AJQhc6Jy0QzuAwYznfeVsmZd8fwlonEKqZ2bosDeePGRyOEBGU4fhezMG
         WMsg==
X-Forwarded-Encrypted: i=1; AKwUvBwdk9z9dlw4P7ILzBh6WdEaH1+EAAjoxI9h31s4dnFOAKeWBmRuBJO2GaEBb03hJc1yugMraaczMFAW@vger.kernel.org
X-Gm-Message-State: AFuF++lPy2hJKGK+4Al8GT7kG8XsdKemTYnvHnMxbnuyiTDX9Jo4mDhd
	BT/rHvb2zPIZ7KksJWMv8A8zTMLGnu9SjAPT1zjzxyAKjxZvPhrWB67b5yJ16UeqNw==
X-Gm-Gg: AYBFou375GN14nJPjJyBHrKWKa0SwlXPJm4GerkWX6pwwkUIj5fzaeMnpzOgWyuY1MX
	UiBds9h/9UaYWKR4DDf+kArWnDwXVlvbXL7/jKaFLwkK+cBjoMxxXpLTLVBfdAqR7MHlJTHCSri
	XrOfU/toBZwSsJ8LfErfr80NDndTMm3sllYVc5BIGD4ZkWi5B6nvDuZCRt40wM+t85jXp13mRVW
	dsozCQjgNnPURcUR70lWy4uimD5oD6Q9V1t7qiq24ijkc2bFNp7Uw342R+8Dm+DDcds78b2kHOp
	ZNKMpViZes/F0BpCE76LIT6+WmSJ4ioIipGR+iNCxdavffgnAPeF9uMAN+bTR85NYB1zKqbbkQr
	XcSZvaldpJXclHnw6n1LiRsRgvJOlq8erbQf/dMQvRlBPZHuGvQ+QQ/4w/ni3/ik3NoXSi8Iq9d
	qqYrPyaPNe8jzBpjbhHOUMblf6B3lf/IARVYPwsof4F7QiEqdfVX/OL2OKnk3xJEak2hHy9pDpL
	YeF+avfbY9f+stTBV4UvcNnS5cp4ZTYB1CbL4JXEKGEePsNjSvKbUuybg==
X-Received: by 2002:a17:90b:6cf:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-39e1e329409mr4159709a91.10.1789545507055;
        Wed, 16 Sep 2026 00:58:27 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:58:26 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v9 01/15] device property: Add fwnode_graph_get_port_by_id()
Date: Wed, 16 Sep 2026 15:57:27 +0800
Message-ID: <20260916075745.3549953-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916075745.3549953-1-wenst@chromium.org>
References: <20260916075745.3549953-1-wenst@chromium.org>
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
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v8:
- Collected Reviewed-by from Sakari

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
index 51109794d727..c2b7a571fe03 100644
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
2.55.0.1032.g73a4cd73de-goog

