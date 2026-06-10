Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380D3B42E3
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080890; cv=none; b=UbqSthPWoWMOTt3iB8gR3VdvGKYDi8CxOOLTCAxBIZtlBcLjgxzzO7F3u10+hDY0DfW9bIMBe4I22AuhIcEPr0EDwlczsAtYobb6gbe9691Zu9Y5GoDZPILPXVu2qlYmyRHq/XPuY0g//IOZLckWrrlHw4L/abdStLi5FifVlyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080890; c=relaxed/simple;
	bh=kGHE6+HJMR5imhLKMaKrAxWZPafgyUmm3WFusAEShNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhPENNXuypjansd7zAuTMoeut/kBPrnz0S9xyV2PM1RzeWdrdbMYvPsAbSssq8wFnuj+tOCo6nR2s04KFNFnEV9DnqRkjcrXU0e2tl/W21nB2XfVHTibXzWisokvBdre1VXxtkztk2+Jr9L2Iq9eNFN9z3KLyNtlIm25+1ukcC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UeNZamHz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UeNZamHz"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf18c30bb2so47290285ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080888; x=1781685688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6pTgkTdjphaP4G6StNKBNkGmsxmuRCJqaledSqIiFY=;
        b=UeNZamHzBpxIDD55A/EpwJn4VeIt196/YcqEaOqVYM09w3muTzoBxBOKqKvPp6POCC
         eNVk6BBUujs6WDSOg0wl1x19Pft9XwIwjGDZYxXqQhJaGS2hZnLtnhMnmXuQvCmj0G+R
         4LHFquxEOnD4063odNEqmxWl+8B3g3n3036cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080888; x=1781685688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e6pTgkTdjphaP4G6StNKBNkGmsxmuRCJqaledSqIiFY=;
        b=VYffZOKd1st85pgdUjuDZHPRWySmKRguNWJep8z6OZE4z9YwRyOLhP1g5Ilqtm6cjQ
         kJGHQ5DL9lWAPsugRfMF1p8jgkCprV0OZldGTlDXidZcCGpi9/FsHobMiKgkaKiVYhle
         GB5+rSVSpuUDeLK4bWHfKUO0N2/Rwqni7Zwl37Ln7hTA3Fd2jL81zqdJ0QsZ4R6bRzuR
         ZXv2b9xMGC+EFMB6NpmbMQJFhopmZ69fVOvVT7jO/EwWIc0iXkxGJj5AEuZSAqQucuxG
         G9xsBDKFENbq07QlN8w0ZvE30NoYjzYq0ii9mSrQS2xi10MbmxBYSe+nvP0VDEUBXMN/
         lIyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7Ld5Xz7ZyoD8qfKsOkgsy06WlHW8SalsKWwNR5ifs5z9NOJUeNjSLwmJsQunRV8UOA+2aHBbIOi6n@vger.kernel.org
X-Gm-Message-State: AOJu0YyzdpCxIcD8xk77NLtyl1sE9/8MmcBc0aDJp9UTGjCNcVFUevIH
	fesRlcNEXfAmmHEcJQSbAd+jtQ8/F73K0p0VI5Hf7Sbm0Gnxd4Ywfh+Ra07msT4/2g==
X-Gm-Gg: Acq92OEhFbI4lMjQPfZjwdHliODqyC8MXM2/8ay+R5wtKoBuKGfTkdUQU50DV2ND53z
	4leYJPQtoCg3C8aiopqNTw2vu3nlMCoJtdoye+8D5YilqcvlloS+OyHu/SsB/mW0JEaUBx8v2JF
	gls7/TSSGJgFOJD0+Uh38qH1QqalWhVMeWv76ClbfM833eAzmnJ7cXE3LphjZTBj7tIJmcCCg8C
	/74QMc/IIuND+KtU4r4hRrxxy5DdPUtiKVefnrqh5jzhOdVMyp95x+F7Yx/Ga4u1+elzwA+2A7X
	8M9rUBLaceoAXtazVhyiOIeL13jdVLPMyYUJYci4oljXeMbqEwoWC9i9YfA2hX52f7YvQIQEfWO
	kE/twoSoYIS3b47scrKN308r9uCJGs07JWEAOE08CMaMZ59IBhpPCfYwYo39/HVABVV8TQUD1+B
	dcPHqi9VI6jzif6pJbsMVCQTtLe7nz9KM8nzJZs1Ydpdg8A+0WeYNhIKd9dwAUMOVyNCzXKsH5M
	7+McgY25uvgmf8Z1A==
X-Received: by 2002:a17:902:ce8f:b0:2c0:cb0e:ac42 with SMTP id d9443c01a7336-2c1e80f9d2bmr271193835ad.3.1781080887890;
        Wed, 10 Jun 2026 01:41:27 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:41:27 -0700 (PDT)
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
Subject: [PATCH v2 02/16] device property: Add fwnode_graph_get_next_port_endpoint()
Date: Wed, 10 Jun 2026 16:40:36 +0800
Message-ID: <20260610084053.2059858-3-wenst@chromium.org>
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

Due to design constraints of the power sequencing API, the consumer
must first be sure that the other side is actually a provider, or it
will continually get -EPROBE_DEFER when requesting the power
sequencing descriptor.

In the upcoming USB power sequencing integration, the USB hub driver
first needs to check whether a graph connection exists, and whether
the other side of the connection is a supported connector type. The
USB port is tied to a "port" firmware node, and this new helper will
be used to get the endpoint under the known "port" firmware node.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/base/property.c  | 33 +++++++++++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index a2afd854a604..cf14f9b0a3e0 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1099,6 +1099,39 @@ int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name)
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
+	struct fwnode_handle *ep;
+
+	while (1) {
+		prev = fwnode_get_next_child_node(port, prev);
+		if (!prev)
+			break;
+
+		if (WARN(!fwnode_name_eq(prev, "endpoint"),
+			 "non endpoint node is used (%pfw)", prev))
+			continue;
+
+		break;
+	}
+
+	return prev;
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_next_port_endpoint);
+
 /**
  * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
  * @fwnode: Pointer to the parent firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index 11f3b54c7de0..2e744c6f251d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -500,6 +500,8 @@ int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
 struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id);
+struct fwnode_handle *fwnode_graph_get_next_port_endpoint(
+	const struct fwnode_handle *port, struct fwnode_handle *prev);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.54.0.1099.g489fc7bff1-goog

