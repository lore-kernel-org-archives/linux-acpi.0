Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72D42DA4F
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616888; cv=none; b=PjLX5xf5pbC4yea+RzoFvCfoNviSUKZsa6MV58fOc+U16TWxq/hUgsdrtQe4malo3szuvPpQFkXaY9Qzbv+v84NHEIVeqcGs7Dqqya64+NlXKDex009fPxj0tPLYjYDDYlFp7zctGGqaNupVPW+glHzjGtqskMNhWsmo3mvgZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616888; c=relaxed/simple;
	bh=K/CXr8sGOQIlsbuegDLGNruY8OXemH3+DJMD2gXrC6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZLon0hiu+/IYbIfqFG/yaY0cSTo2J4ihVbIZUkfFqcj2pvIS9htydMpreKHeNTtTtwzVjO+ee1eRDy/jNtVIEjO9Bn+1Qdqd3bm2OHHb5ncQgbOFZXUBIInMlN0o1Qn+8uLCMOIDJE0ytE1+jvE7bR+c46/Op4sn99UPAMh9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lIx/TyVR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lIx/TyVR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cacb8416a1so75084605ad.1
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616886; x=1785221686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15QCCMJqDJvxC4OlYXPloXq3cJq1LSRVcuMMIDjVYjA=;
        b=lIx/TyVRtZrlwFniXWRGEHfwmAduhmlywwFuRvNQ1TbhXzyFoyXkqLMDYTqhHuGNcT
         u9Wa4cW6aynB4+uk90JhRPtMdmZH3lAVQpA9hAyB4Yn/VK8bklOrkI6sYeIAMA0rZ4kz
         FGW9iNk4/Kkb3sU/nYnZtyDt3b9ruuG7Uguq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616886; x=1785221686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=15QCCMJqDJvxC4OlYXPloXq3cJq1LSRVcuMMIDjVYjA=;
        b=Twv4i6hsxck85/BZDlBjqr5h5I8y+ydfQqtsjXJvS8F1HGLoQ05CneyOeZw1RZpoiR
         cpAonUeR+7AgjbYW0+0++KHgfNE2kM9k8hriySA1EaFRR3O8PL0f43L4+8np5CJnqkph
         AqyC20Pbgx5Y7qF/MX9Gk9cbSh0QZQ1ablVUsgYauTBJqitLKSe3aKJ5dWbB8mUj79JL
         lPlUNnKAot0r7+rTTsgkGqNWU9EmqLFN3NW64ln+XUMVzNOMAcmcDsyecI3UJaF/usci
         eqOojLPGKE6v7iQYolEuVUR5VdVrWC3UtM4J2cnyLIf6Y60AcogJE0CNESzZJQzB1B7P
         TLpg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8uUK8HF+/eou0CI0JliU9LVx5TBcmWmhhFennqdCxI4e0iE3KkviWE4pf064GXHTlVz/tJc1aXKb8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7oiq8wSiau6p6eKiUUDnj/qkYiU4WDAWhjXBSbfnDm+6FZ6aA
	r9mJJCR/GJ3+/df/TBMMgwDF/ZUEOl9CX+T2hf5OkUz8jS5ezT5bbfc/p1Mlt1aSvg==
X-Gm-Gg: AR+sD11cB+ZkhkpZpa+17ecwlKw9EusylVkgVgn/241S98mPrP32LrPLlPHIL0cB4hs
	Hi5pXNWnnNVqyrITlvDvYzDZrA9P8iZNfxRhtb+OmpKusBO8gBpebBT//7EUapHyfJu4qRPyluV
	PNsk209VKhQYc+Bq0GapphFzRNzKYCsYIx6m1JmDKiiw+TL/yzQlBlxVsDx1wppWgNTrTV+Dl0r
	Qyj7RpniicKh3U+VdouH99xmkx3wowbX8LuW4FGwXlmC0OICB8XowaaHzEdVomFRcHoXKggpiN6
	Ab+wJIji7/Xk0tu2cTJm7n3BDqShaVXlL/uh2143CYGsD/sbea3FHccajlCxAtpjSsS0KcbhRDW
	6LpzB1QPRh7mxhYHMLWSPyq8rpRCq+itHKzUAijC3VEa9QWfGINQsjBvG62X0vQxTfRatGPkNpb
	Ky9cyt7NIMmWCn1eYuh67/4fsKJ+HWCtVYauOJjqDa89X/MPgXDbDSUZgMRp4=
X-Received: by 2002:a17:902:c412:b0:2cc:86a9:ebfb with SMTP id d9443c01a7336-2cf349b839amr193173875ad.33.1784616886249;
        Mon, 20 Jul 2026 23:54:46 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:54:45 -0700 (PDT)
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
Subject: [PATCH v6 02/16] device property: Add fwnode_graph_get_next_port_endpoint()
Date: Tue, 21 Jul 2026 14:53:57 +0800
Message-ID: <20260721065413.2306137-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721065413.2306137-1-wenst@chromium.org>
References: <20260721065413.2306137-1-wenst@chromium.org>
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

