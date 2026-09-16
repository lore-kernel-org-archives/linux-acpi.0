Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8532C476CDA
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545572; cv=none; b=BCD0TmOozpaYacOVSFfHlzmaIRERgHv7GSJHmuatv19RNcxy5ADf+U4TrzF1y2Darvb7PNxMcI/CjICfw7AGVfdIhCP2eYPEx01bt65/vlz9nWLSLhAm83lTC+6DxJ2PJ0LKQL1hbIVjCvSFsRZ2uredNeAvTbvXIs9bZVUaECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545572; c=relaxed/simple;
	bh=eyI1vaHvczB69tPN00V8OLfMpbO9IL68H/HlfpvrLfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAk+EhEsRxjOvRR1JDsEjnd4SnSrsnqrwMNyG/bH+I9UtniHXGFlpeKC82McYj7q+59HlT5UuOtkx+gEt6i6viieZUpCzpoi0BSuVu7OGMc7xbf8PY4jVpFnsdOldKq6gWpk5a9jNiChDQSx3FBvIHEbrJWm8kO5odBWgs9k3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EdYWdqak; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EdYWdqak"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39d654f02baso523650a91.3
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 00:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545561; x=1790150361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ud8Ab8x/DbJP2ljWLphVYfSDOg1pJvQBgrltchLDCh0=;
        b=EdYWdqak89mpGcCcIBBIMtsyZhroWNz1AS049I9fmXFVAZFhiphJZcuAOtyVaCGoAQ
         3tTGpR6qDAYUev2vE6cobStk69IjGrt70exJu50kDrTkne6lTpdWr/Rv60/91Eepttva
         79ezHXoQ0iqFtMl9WNAlvPFXVJMn6XgZLp1HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545561; x=1790150361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ud8Ab8x/DbJP2ljWLphVYfSDOg1pJvQBgrltchLDCh0=;
        b=sg1qyqwjgwhPCrnFlBUdvtvHdxyaF7Rm741BRdovHsb3bfPFh9wUxTz8g9y5X4u3Td
         dcWXVkJSn+cy+8bxMmXMDVLDsF1mllHeNtQwnzqXdUqbvRxmRHpXZBswM/Wj/z4bFCjT
         Gdf7YhEATUL8vpNtCBHOfpb4EcMr61dThvIdesUbgvaWam09SvjBQFE85y/D7GOBLqKR
         rprNj/nmkLA2VMZIueqYzkRM4PbCimv4Y32ISt8UyD9PbdRpTuATPZpPuWf54p4X2dFh
         gau4g5jP+O6F68rLs90DhIprYcePfC+0WHaerhM7Xh0C88LhmxWKalTyxoGR21029uVp
         2bHQ==
X-Forwarded-Encrypted: i=1; AKwUvByT4F1iVz27SXLXeG3BgXPHJXswqbLCh7SP2fCuhzmu2D9MD8sJTUm3LthigtkM4yFXAQ2/WHjt8F5P@vger.kernel.org
X-Gm-Message-State: AFuF++mfHXJ+nkUdJQCOzsb5NMD/PwSR2G5mASJtJCYfJH+ICZBab+eN
	V4BFNnJwOW+x3F1kI/GdI87cvnMLQxqahZJX/XvAFwRf4TuAD7kQFJ5Bff0uigqy1g==
X-Gm-Gg: AYBFou06mZtrfQVWC+b8G3jPsaW4gz8JjEfuHtr8fL9tp2jNB4XUQqVD1nmuCC7BuN/
	jzxQFeEBGG8E+uB2FsxkNnH6ttHU7k26tEWD8WPAhhwsbtPe4lusikWyQLg6ZBJL4LAQqPqidqv
	+sHv8jM1i6clgZ7In9BHHTw8S5OYzfOr9BGpvMTDtz1grzLhTdtdC+scHiYB+nQ9N+EH+Fn92oo
	R3FNnEB4RFfXSgVTJ0jG1ubf3fOB90xrrzzjUGva7TW05mudqlrdW0xJaG0utNYiaB+K5GlZt+6
	UYat5QseENuCC/dHzCriA7owDiusSfkJ9BrkJdfFTi4n7gY3Xp+QDk2GPgFP/q8UidM1B2Nt4xf
	0aTkHYayjh9Cu2OjKPm+sUIB+uC/x3MDBlDJQJV2skBSjtPPpdezJ/pzpOqUpRqQ+LNrj+/fe++
	jgFinl/7MBbLdglHY/rMZfeJu69fSLLOlIn3yirTWyiTsizz/VLJVSWmP6M6o2bi/O+335hQ8Cl
	896cFz5ZuFDdJcSXgvnyHgUpPm14WA0K5419Eh9agC43xwiByKsHxwGpA==
X-Received: by 2002:a17:90b:3e85:b0:398:bee5:61d6 with SMTP id 98e67ed59e1d1-39e1e55f7ffmr3982483a91.24.1789545561399;
        Wed, 16 Sep 2026 00:59:21 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:59:20 -0700 (PDT)
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
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v9 11/15] power: sequencing: pcie-m2: support matching on remote "port" node
Date: Wed, 16 Sep 2026 15:57:37 +0800
Message-ID: <20260916075745.3549953-12-wenst@chromium.org>
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
index 322c307ce6c6..350a4c8831f7 100644
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
2.55.0.1032.g73a4cd73de-goog

