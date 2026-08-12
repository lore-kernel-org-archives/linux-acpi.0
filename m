Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2A4746B7
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548879; cv=none; b=iclsQHmokLOzFUrF2DpzGuUFmwXJPENautzBoUF3ySnbPRuo/6h6DCNoSa+fPt0gcS5YDNVJzPspPTH+mnXbQKmk9iGB1jDdk5k/usX3+ASENjMWUZHAZCi/wnqaau2qNp0K2mcxLCOS5BOkaIbmFLu+Ec5HEUbIDR5+bCGqSPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548879; c=relaxed/simple;
	bh=x0XfJfYYmm0lZckHiSTrULL19u0GEKu1sJMJbH7EwyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/pqEo6vMhybzqsQd1uO0U0YnwYTXxR8VbMR7Qa6POGs2U8pHPc9kBau3jEqkLdHSgm1HRMZfDGMy0olG2duGpkuW2hXTNKkMVLuzAc72qcnF4UcGppqXu3Xy6gG9NKrigiBl+atQwG4EkE7zt/B/jWss5m2ObASSmNPLGx5yIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFJpR9Hy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFJpR9Hy"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1111403a91.2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786548873; x=1787153673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzIk5I7OqDCOAhpxa2DhuDUN9BeeRjYb7EQC4Ahia0I=;
        b=XFJpR9Hyc8Lt2lxvmcKjpWT7qA5Lv0Wp74VAnzbEFy/nbzJvnRpccTNcBpOX84y+j1
         Lxv5U9cmTQFxcw95NLAj1d1Zr68cI4J5L8+Yv8tEPDbvppTypDY9FhNEI8yYK0EHLM3c
         KtB/jk0EC5vXa3FNej7452fEg5YfCfSlpc5SqyZrbIjvQgIwijFogwO5vccuU6Bbo1IH
         GHfKHEJwjw1dq11r0B7YS2aoF36SheP+Hdnk1OTPmrOHF7Gp87qUG22d4Z75pF5J4L6N
         U8cibdvEdUgyS+mrsuUqGEEwY2KG6i+sWpibhrnYb3qB7supSglugw5qKeOtyWJb1Mnx
         UUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548873; x=1787153673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fzIk5I7OqDCOAhpxa2DhuDUN9BeeRjYb7EQC4Ahia0I=;
        b=F0jsdVYtnA3ZkBPT6K+W0z9Puc5j9EJmtttEPf9s100LgMh51bSED7kxRzrnb3JZsc
         1yyFFI2m8Dcn4m+cwAMaHAOlkDLPFs73SEGs9xc6Kf4p9xwDUJ6yeH/eXXB5FNg8bM+d
         dlD9y4z1U5jvnE2LbM0inydKufbdj38RLaR71LRt+D0FVwUTzDMzuNFcX/RjPFr3Q+ls
         0dQNjyN3FqHHPFgfep4n5Pi/+IH8fovFpBIfJKdV3aWDarvF1oSJf93+o0GrXsVeOHIx
         9eKL+y3m7Y64Ww8uTndEfO5g4QTEZhQt9eN/2CWsbALIFIKFQnqfnjHjQ2fqdQFuDLPz
         ZQlw==
X-Forwarded-Encrypted: i=1; AHgh+RrLPQByRe3UCStBiGbHL4b5Y6GZK6lYgrFC/ilcXUrZO1O8rzIgS7y0K0CP3KMXNrztjJC5lv4wOGb9@vger.kernel.org
X-Gm-Message-State: AOJu0YyRkymfPynh5Hghfv6ZSfeHlmjv7n6DQAxpJ2PG7+JUOI7Zrk/F
	5m9NRsW28eny9D9W8BUvKxyL0W6bezQbmuKXefI+PbOSMlp8csfVE0Y=
X-Gm-Gg: AR+sD11MN4KP6Go5ncQTtjtZX/Ok1OPWEkLnvl7nSxgv1wUk4BPqSPXgmk1GlYBFrcn
	yWgWn2ZeYLLeZefiS4/toPAgk2oGKXgYybROKSzYtgymfSQqNZMhs5RyK5BunmUX521Ugq4ol7D
	2rSic3opH50eXszZBWJHDLHcz/T1rpGgqhz9o+WhfRwuSeWs+FZSbmXUV4F5jsR5uhsQHKnokBi
	iuaFm+qhXv3Xz2i0xPoHz/2SoDIeBZVYtgIvWN7lhDJJ7XUsET5sbzpNh4W5Qz/FcEynQ5gq7uN
	b5UZptC4TpNFEI8EcFLzd3v3LEI+Cf3LRkD0Tj6FvnAGlUljfK7oYO96YVcRrK/kJuaUEIUI6qf
	4lr04dJzcCVR3+uS97kkAmW5yC8Z09OS8POONzQwDf+N7eu/x/TY0BGffl3vSmYd8FfoHBTd6yY
	zNPrgMhUmnnAxVbnQRYbu4TpF7AIjn7Fsr1v0Ejecb6MzQGP7F52lIK8ggms06VbBbJVMfCwg5r
	Mgwx0/8CuVE3sjMtmudBjiCK1lMovLXStA=
X-Received: by 2002:a17:90a:d64f:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-393011eea08mr7525677a91.7.1786548872437;
        Wed, 12 Aug 2026 08:34:32 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([14.97.72.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31dba3e9791sm7160804eec.0.2026.08.12.08.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:34:32 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Andre Eikmeyer <andre@negmaster.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Sebastian Reichel <sre@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH RESEND v7] thunderbolt: Add device links for Apple T2 NHI
Date: Wed, 12 Aug 2026 11:34:07 -0400
Message-ID: <20260812153411.1159-2-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812153411.1159-1-atharvatiwarilinuxdev@gmail.com>
References: <20260812153411.1159-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ice Lake Thunderbolt NHI That are only on T2 Macs. The NHI and its
associated PCIe Root Ports all sit directly on the Root Complex
with no upstream port. Identify the tunneled PCIe Root Ports by
their PCI IDs and create device links back to the NHI so that
PCIe tunnels can be re-established after sleep.

And on other Thunderbolt NHI's, like Titan Ridge, the default method
is used to add device links.

Co-developed-by: Andre Eikmeyer <andre@negmaster.com>
Signed-off-by: Andre Eikmeyer <andre@negmaster.com>

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
Changes in v7:
- Used pci_lock_rescan_remove to prevent race conditons.
- Fixed patch format.

Changes in v6:
- Used for_each_pci_bridge in Icelake section
- Removed has_apple_t2_chip as its not required now

Changes in v5:
- Used Icelake root PCI IDs for detection of root ports instead of TRP

Changes in v4:
- Limited TRP check to T2 Icelake systems only
- Optimized has_apple_t2_chip check
- Included pci.h to drivers/thunderbolt/tb.c
- Used __free(pci_dev_put) to avoid label

Changes in v3:
- Fix build errors with non-x86 machines
- Used __initconst for apple_t2_devices
- Removed UEFI_QUIRK_SKIP_CERT as its unused now
- Used IS_ENABLED(CONFIG_ACPI) in tb_apple_add_links for the T2 part
- Removed !bid check to remove warning with -Waddress

Changes in v2:
- Used a less generic name for has_t2_chip
- Used DMI instead of PCI for has_apple_t2_chip to avoid PCI problems
- Initialized ret in tb_apple_add_links

Link to v6:
https://lore.kernel.org/all/20260730223435.2874-1-atharvatiwarilinuxdev@gmail.com/

Link to v5:
https://lore.kernel.org/all/20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com/

Link to v4:
https://lore.kernel.org/all/20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com/

Link to v3:
https://lore.kernel.org/all/20260721063412.11588-1-atharvatiwarilinuxdev@gmail.com/

Link to v2:
https://lore.kernel.org/all/20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com/

Link to v1:
https://lore.kernel.org/all/20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com/

 drivers/thunderbolt/tb.c | 49 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c69c323e6952..2534c6378000 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/x86/apple.h>
 
@@ -3305,16 +3306,62 @@ static const struct tb_cm_ops tb_cm_ops = {
 static bool tb_apple_add_links(struct tb_nhi *nhi)
 {
 	struct pci_dev *upstream, *pdev;
-	bool ret;
+	bool ret = false;
 
 	if (!x86_apple_machine)
 		return false;
 
+	/* Identify the tunneled PCIe Root Ports by their PCI IDs
+	 * on Macs with Icelake NHI's
+	 * and create device links so that
+	 * PCIe tunnels can be re-established after sleep.
+	 */
+	if (nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI0 ||
+		nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI1) {
+		const struct device_link *link;
+
+		pci_lock_rescan_remove();
+
+		for_each_pci_bridge(pdev, nhi->pdev->bus) {
+			if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
+				continue;
+
+			switch (pdev->device) {
+			/* Ice Lake Thunderbolt 3 PCIe Root Ports */
+			case 0x8a1d:
+			case 0x8a1f:
+			case 0x8a21:
+			case 0x8a23:
+				break;
+			default:
+				continue;
+			}
+
+			link = device_link_add(&pdev->dev, &nhi->pdev->dev,
+					DL_FLAG_AUTOREMOVE_SUPPLIER |
+					DL_FLAG_PM_RUNTIME);
+			if (link) {
+				dev_dbg(&nhi->pdev->dev, "created link from %s\n",
+					dev_name(&pdev->dev));
+				ret = true;
+			} else {
+				dev_warn(&nhi->pdev->dev,
+					"device link creation from %s failed\n",
+					dev_name(&pdev->dev));
+			}
+		}
+
+		pci_unlock_rescan_remove();
+		return ret;
+	}
+
 	switch (nhi->pdev->device) {
 	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
 	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
 		break;
 	default:
 		return false;
-- 
2.43.0

