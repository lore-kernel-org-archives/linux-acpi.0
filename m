Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB53E557F
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105720; cv=none; b=uqqZpdt37FyaQXtBmFtD8gSS/CNvVcMAEqRfmwz6hpdt3W/vtObkyJ8A8/RUlqM8BA8d2jru33Vza4M/7xYCh37H7cYNw/rHvTN3p8/oWIQG5Z9Xc2hzLX76fLFbi/E6FNWBrbjuujeQWEjtR6ZbBd7ujGaBVNd/vPbFpJTbbtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105720; c=relaxed/simple;
	bh=gDXGZ+qtSgJBs1RokahbHI9JUNzui3YVteN3ANdaDwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdLLkTlRbzP762OaLoamtUH0cPEhP9Q94Hn2ePbfojOSqiOb8BtL7DvepjIKdAPjXjpMK23LHJt7/5W1C1tZytVci12Af/GgJm2H+RT1+0MXgyy2Qa2CCgAJoLTVjmmXwJkcLsyXpNQLdFlbf0j0Y/C71wKHsJdDUopaSn7ZVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gPJdLGFW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gPJdLGFW"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8423f236418so1552139b3a.1
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 01:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105715; x=1784710515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVHm6p5wN5KSAyn8QSBlqPHJusamsYORhaWsm3vPLUI=;
        b=gPJdLGFWJPu2ncT7/v+qGEENyv+INhQHiPv30+8oFRe4ZhZwvfT17x6mf5srhvRY1h
         0DqNNIeyWvxN8I2h36QSj+Vh7MjpJFQBsdtR6qSS9eGhrahvhC4gMpYd6qDFeC9pmFa0
         SZn5tMfTJS8wd6zi59r47jW8IR+Vox1siunCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105715; x=1784710515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YVHm6p5wN5KSAyn8QSBlqPHJusamsYORhaWsm3vPLUI=;
        b=aWqT4mfOiP8fiM4zcZi5IY05AWWPrCtAXYdi90VjqlW+yWml5K2ypQ+RQ/BWOLJN8d
         MYGSIt0Wedy08sJnDQ04d7TpL2I+EgT8xLE1F05bmResLP6CxY6dLcJaLJD3Zh0qf6fs
         OVBTAqLFD7F1NcqEeol8ObQ6PpNTezqUbyTtBnLrETSsOuyDdId3FTuzcRec/S7YWoCK
         elfmdOql+nNu925Ujml0WBUQod5WIc9SI8jeec4h+9lzAT/e7Op0gg7dO9WoChIdzaWT
         1n5rQQUPxlOtyioM1DR9mtwbWzMZDJban9t8J73fOhqVAKsSzh2Sv+OrgTOd/R4byIPC
         yVew==
X-Forwarded-Encrypted: i=1; AHgh+RrZhZYHyobQJIgLekODnTX/2gjOVamxe1Y07nttOp2EVZpz7LLpr9ojuNL3HuxrVSun+0zpIRoWqSrj@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFr+p/ocWp1Hi5TCXQ8xaZd9i1Cq75wcWASzAM/ICPtXCWz/X
	ubUnFwwHuSnscpmjBK8JR1Yq6d6N2gTIDvxf3kFAoaJfohDZfL6XnDdfACLvPTiO4w==
X-Gm-Gg: AfdE7ckBDqgDIo0Ab0MHQhtd9fqW49wdb/OXMFOoNs18MQHYsSEc+DyWXWVMi7wh3jn
	ZJ/gIGs4r+UtJqGCy6EJBIAxVCXlGucF7as0ML8FPnzwW1k74UFaLkOHOI48Nl8+Laz6aCwEPH0
	9Ui2cgbuB7wqWBQzdmkyBTxE6DOafBGi4gIW8VQNpAk/TZoxOsn+F8eEtUIFQc/D0HB8rZQqf5d
	+RyCJ+cisfSgJRmsgyE7JRIspEypIJ7wnliAX3bGfZgGjzaOEcHYnmpZLgypcsfNIv+7oXh9Oao
	OkBr/PaahOplRxo6zrjIJ3kwVlUbo6gs0JVCPMZk6949cxnUP/Az+bMVz/KVqz5I9o8oJDTlFky
	/HJIidQNhZNspW8Hg3y2dOufz0Zy8nDrgwJY9znshh0knlO4VrhPUqluQ1ifi4e6DVVkZxtWu4N
	VADNsumrvbHrgPPRmOtvHkpNz4a2MNDyVlJLGRTtjBpSNFMrqe5FPlYN8mZj/nXSSeNNjquw==
X-Received: by 2002:a05:6a00:228e:b0:842:3aee:12c0 with SMTP id d2e1a72fcca58-8488960660emr14884802b3a.23.1784105714825;
        Wed, 15 Jul 2026 01:55:14 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:55:14 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v5 12/16] power: sequencing: pcie-m2: support matching on remote "port" node
Date: Wed, 15 Jul 2026 16:53:42 +0800
Message-ID: <20260715085348.3457359-13-wenst@chromium.org>
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

A USB hub can have multiple ports, and this driver needs to
differentiate which port is being matched to. The USB hub driver now
associates the "port" node with the usb_port device, so here we can
use the remote "port" node to check for a match. Then fall back to
the remote device node for the other connection types.

Also rewrite the existing "remote == dev_of_node(dev)" with
device_match_of_node() for consistency.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- Dropped blank line between __free() variable declaration and
  subsequent use of the variable in conditional (Andy)

Changes since v3:
- Drop redundant device node validity check; device_match_of_node()
  does it internally

Changes since v2:
- Use device_match_of_node()
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 83fe6a1396bc..691cad0a6dd0 100644
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
2.55.0.795.g602f6c329a-goog

