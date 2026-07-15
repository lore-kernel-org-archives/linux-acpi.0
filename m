Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E93D79EF
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105664; cv=none; b=eNa1HNZTwo+GaaoB+jletvWela2F3Yomz0B/9QA9X0InOY+p/i5KIzcEWl2ToIkVzM9Pr+IgFamvz5IJTUV0v7DY/dOILZPyG7m0L9LJ6OVuslRuWDcdLAHknG4SYpRVYDSoyolyN8XK6BcyF5YWjf92ap8K8EtdFam17a9/9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105664; c=relaxed/simple;
	bh=sHMrDgD936gJSs9bJLfV9Xhglpv5Agcq8aSC2pp7OfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHOAsa3WL8kAgsjPdyxv3/VQPetPk/ElX95ejTA3/OVYT9B0QbLug6NN3yQwM7TgKH+uRTHczLBCwmdCcXjCw5cXyRsTNmeimIOhU0VFxhlx8K6Q551oVMxTdk0bdkdjWBtxu09KU6xvxwgj9WI+cgTjWukgiGL1yjQUXBCmUY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ParLHhyM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ParLHhyM"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8423f236418so1551811b3a.1
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105662; x=1784710462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1XAlo36/cvqlWCfJP/st8V9NvEK1f/LvSK5OHVxavmM=;
        b=ParLHhyMLjNtZyB47iyTQu6bup3gTadNnJF4K/RdC43t9WZqyYxs41M01cpNtDEuDZ
         gKWxPz2jeK7D5s91p4R71J5TPrecM4fjNCnl2sHMivWga/g1OP3YR35F7cyuz/1v2/RQ
         EXKC+264rTh6Z1T/5knxodQ6pq8aZTSwK8jCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105662; x=1784710462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1XAlo36/cvqlWCfJP/st8V9NvEK1f/LvSK5OHVxavmM=;
        b=T9ib52jfCinvFqKnb21CSXCG1HyF1gP6IX0KSRXJk8BZZJwN4Nr85NkJHf9KtWQkpy
         NZnrxP3eFK/TpFS+jWPnrd3HdlGtigfG00p14JxIU0x/X70Q+84fVT6hoDEKMqQpjBLW
         ybs4vu0X/mn4imgzNzpot7uDl98DZ7xV4dBcvehzz2yddSJw0i+jEbayhUtWx9w7mvet
         70MF9/J7erhmeAkWc+d33A2QF5PeYRmZNuPp1bcaOXj1Fv2//VXJ0t9dXsoiVp30vX4S
         rpiPh6O143enM170cEaHFWVeOCWFgesU2GaeoxbgT6XoIovEXPhZzJV6QHbuJPeJ4HSN
         4eRg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9p0gc8uvtGKwMgO4PMno0Acc7KhHvy39B8RwzVnd5dpre0JLWGICTTveWsEauGkCmazdDTyGqbHyn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2MM7nc2rkUTso8N1iRcfGadHGexQkMb+I2o7F9Yuvdqgvvd9y
	MbN+qmxkOaMdC726DfrdU8f9vhCu0RptU/CP2Mu23IUkVkEuJM5joep3LpkI+Q96UQ==
X-Gm-Gg: AfdE7cng2jMt4CyY+jzBTEHepGFv9nPi+tzn7hj3YkoZTuUOmDZHtZpYhBtLWWRaPa0
	X4iQuS+reafZrXniHQrB/ZcZhnfKxcr4oooMLXMUbvVATKeK/e2K+ngIaOu7gBX6DH+nT9SfWWz
	UO6WSkmHRdYks7U+bc1GwwbjfP9VyopdZCEHPshAfJgsPO1oNfsYEtesTwoXwTF/8eIQzo2t7y3
	TZEnqfYfU+enD75JGKo1CzL3v2PF7EhAtWLkwhCjBue3FOs/ZGJOnIhYpc7S3gy9VOWZDq2Vche
	og1tKIGK8TOTc/1e9hnRMW+YeDEGM7Nzuk+Hm71t1KQaRTC2L+iAbFSfwEgNkls4SRxtwpjuuw0
	1ZlfTTIKD6+I3yhm9U5TvSZqsQUXigjgWVaQP76oD5lQlnKYjIloiCCrpWGJ5Dtmzpn9GvdMt5G
	NuZtDLhqJp+VJwhJgoC3YkCbvt83MEEQ7WJ5ppQLQG3nZKOL4nJras6yYNqerNVo2xkEBKdg==
X-Received: by 2002:a05:6a00:21d2:b0:845:c6fc:2821 with SMTP id d2e1a72fcca58-84889604f51mr14884898b3a.22.1784105661732;
        Wed, 15 Jul 2026 01:54:21 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:54:21 -0700 (PDT)
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
Subject: [PATCH v5 01/16] device property: Add fwnode_graph_get_port_by_id()
Date: Wed, 15 Jul 2026 16:53:31 +0800
Message-ID: <20260715085348.3457359-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260715085348.3457359-1-wenst@chromium.org>
References: <20260715085348.3457359-1-wenst@chromium.org>
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
Changes since v4:
- Added flags parameter so users can specify whether incomplete ports
  are returned or not (Sashiko)

Changes since v2:
- Moved "Return:" kernel-doc section to the end. (Andy)

Changes since v1:
- New patch
---
 drivers/base/property.c  | 29 +++++++++++++++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 32 insertions(+)

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
index 14c304db4664..480ba8646bcc 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -505,6 +505,9 @@ int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
 
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id);
+struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id,
+						  unsigned long flags);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.55.0.795.g602f6c329a-goog

