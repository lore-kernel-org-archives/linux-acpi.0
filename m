Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3EF1A262D
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778033935; cv=none; b=hjDpmtzpIHwweFUPhcf0C2bHP2GKQ0d0P3JOwEC2YYdPkBHIIktYwVtbwVOE8b28rGppDwGt3XEfxGdhk+R6q22tQ/tbHqy8n1FHitFDYLuSQmVIsm5qkyU1pG5rx8QnZKq6jijkEKMn6Wjoo/QDQvgRE6fqFZHv+Kxhz1fMn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778033935; c=relaxed/simple;
	bh=nYGUtFmrE7NFnwEteDS0bxvruck9Gt4KBftRooMcZlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AoHl1+GDARMEHyXY4Ih+WfsV7yfwWRq7Bvi8lP1xjRwnyiJx2OmKXWqd/Rjb7/zLPLICWsS9ALg6r5AtYfquSX5ue8zUcxF3GnRT2adD1QONDch0Jc3ZfbFgs5nAqfBq4az6Rix1kC7uSZrBYbsWVOQv4zAF+jybQPvjAsyArss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4Z/iuD6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4Z/iuD6"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba0714574fso17149425ad.2
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 19:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778033933; x=1778638733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNPyJA5HM8VYEeeR34CvWajirDL/QwxofztcaoCL5/I=;
        b=Y4Z/iuD6qms7uqQsYakbyYRTE7XPYf9vpGpysUVWDHGe+Ld8WAmAkRVnkzMBCKLhis
         FECwrVZdb0f07HvnQHXnCtXOyZXLqz3BDQcbMH6b53H6wYCHEDGd6TvLlnAhNzkuWVVO
         LdrjgXxmOBdSD8lf3CHXeS7Ygq9AOSFlrvz9l73tcNbYMli9FAmPJbZIgJCzqHcuskKa
         VOgsq8FjSZw96VWKcsmsUlpjnxKY7E4rZE5ZKc1D/K/GFwfuW27HPyPP9dS93gkKOw2k
         8Sw+qgP29l0O2rvKgL7iK4nSznbj2Ph7D32eExw1nb/xQ9SZtdbZWhO9pScbfvtxySlo
         6lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778033933; x=1778638733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tNPyJA5HM8VYEeeR34CvWajirDL/QwxofztcaoCL5/I=;
        b=GbKM9Zm1RaCecQcGrphm2LTd+o24opPzFG7ME4rFmuMVhf3Sb41KEMYDRS+V5m+yYy
         EA7S8Zp0G5XRyvqcDDsFLECBBUx+9jQ1KCghpvpT0fJQDPlxlG/aBwRv3Beo0V+Z9q1C
         GNjcsdldsgEnfzUZZp8tGUtn4RLeTmG7bGbyLps1SRMYPPKjezZFmTgxMpV3BWnqNV5m
         KHO4bvQLz3376f1xdrOfQKVSBvJiXu80rsFzu83hugORKEHcb117VrF/73EqE8u4UZEh
         ZuSVcQButuOC4BLqBlUc3SHDNcsOUx4lRI1oSB/YDoOQj0NiSC0/IfEkzZbIyHCnY9b6
         PQ8g==
X-Forwarded-Encrypted: i=1; AFNElJ/nGGHSirsuJURBbi0pItvzOIuvAuz6F7IrzWaYc8LsH+enAtPhNKTq6O/W8kZBMw8zySuVQqCmoM19@vger.kernel.org
X-Gm-Message-State: AOJu0YyDKqe37rCgIb5HawQs4JfHMPG5+2mC88Qt+B5XVxPYSmLCV+HW
	479wK3R1NBJ99PCTyxCzQSCFOXyHgQFj5ObXCTchd8ciodDyoHaZtYtg
X-Gm-Gg: AeBDieuolQc1Qzr/DLUV33w/BHY9aAd+DCz6C6fVmRPfYa8Mt1vtxxjCPaH+IGK3G9M
	Pw48PUBDo9nUmYk726y/dPg6ZKQkYK94NcZp8NqBSTbSkErIUz4zdxO558yVVwXIS1N97LRLh9a
	C0nbElqfbSwZCuENDiQeotT3G6ucZ9HIf08HiAf8sd72h6ag2Osa0i91i8tPmZju2ESKDsG6wv1
	bpWyDrbLoqOFTwZF9Fee201nIirOOKdSf701POzHc3jUpHZmDAb/HXNL0ax1TkYG+61vBHKJuMp
	2QPjwo6ra5A4lt1vTad0uphjt5kVRDBq+mySiFgutF/IYsJhq3kSuOb+IWCTdh14ofzanON/6Ar
	HzjuQm6XOHBXFv74S1z8DgnkypVuQm2P27Xe4L+tp+zHzk9o5sNY5j+fEXeOyZJN6OXcU01vbEv
	jOJ11/jlgd6eflv5xvd2MMnOy/UDBT5TEs/qo6+5iod2t5yQJYs79gJjai0XJT90Ci
X-Received: by 2002:a17:902:f650:b0:2b0:917c:bc4 with SMTP id d9443c01a7336-2ba78f50041mr14256185ad.4.1778033933226;
        Tue, 05 May 2026 19:18:53 -0700 (PDT)
Received: from ampere-server.example.org ([103.68.183.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e1ac6sm6319525ad.42.2026.05.05.19.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 19:18:52 -0700 (PDT)
From: "chunzhi.lin" <linchunzhi0@gmail.com>
To: netdev@vger.kernel.org
Cc: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	linux-acpi@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	"chunzhi.lin" <linchunzhi0@gmail.com>
Subject: [PATCH 1/2] net: phy: motorcomm: use device properties for firmware tuning
Date: Wed,  6 May 2026 10:18:12 +0800
Message-Id: <20260506021813.3658669-2-linchunzhi0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506021813.3658669-1-linchunzhi0@gmail.com>
References: <20260506021813.3658669-1-linchunzhi0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Motorcomm PHY driver reads optional firmware properties via
of_property_read_*() from phydev->mdio.dev.of_node. This works for
Device Tree based systems, but causes ACPI platforms to ignore the same
properties when they are supplied through _DSD.

As a result, ACPI-described Motorcomm PHY devices fall back to default
settings instead of applying firmware-provided tuning such as
rx/tx internal delay, drive strength, clock output frequency, and
optional boolean controls like auto-sleep-disabled,
keep-pll-enabled, and tx clock inversion.

Switch these lookups to device_property_read_*() so the driver uses the
generic firmware node interface and can consume the same property names
from either Device Tree or ACPI.

This keeps the existing DT behavior unchanged while allowing ACPI
platforms to honor PHY configuration from firmware.

We have completed testing on Sophgo RISC-V architecture server SD3-10.
This server has a 64-core Thead C920 CPU whose DWMAC is connected to
Motorcomm's PHY YT8531. This server supports UEFI boot and it would like
to use the ACPI table.

Signed-off-by: chunzhi.lin <linchunzhi0@gmail.com>
---
 drivers/net/phy/motorcomm.c | 41 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 4d62f7b36212..708491bc198a 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -10,7 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/phy.h>
-#include <linux/of.h>
+#include <linux/property.h>
 
 #define PHY_ID_YT8511		0x0000010a
 #define PHY_ID_YT8521		0x0000011a
@@ -843,12 +843,12 @@ static u32 ytphy_get_delay_reg_value(struct phy_device *phydev,
 				     u16 *rxc_dly_en,
 				     u32 dflt)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
 	int tb_size_half = tb_size / 2;
 	u32 val;
 	int i;
 
-	if (of_property_read_u32(node, prop_name, &val))
+	if (device_property_read_u32(dev, prop_name, &val))
 		goto err_dts_val;
 
 	/* when rxc_dly_en is NULL, it is get the delay for tx, only half of
@@ -996,12 +996,12 @@ static int yt8531_get_ds_map(struct phy_device *phydev, u32 cur)
 
 static int yt8531_set_ds(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
 	u32 ds_field_low, ds_field_hi, val;
 	int ret, ds;
 
 	/* set rgmii rx clk driver strength */
-	if (!of_property_read_u32(node, "motorcomm,rx-clk-drv-microamp", &val)) {
+	if (!device_property_read_u32(dev, "motorcomm,rx-clk-drv-microamp", &val)) {
 		ds = yt8531_get_ds_map(phydev, val);
 		if (ds < 0)
 			return dev_err_probe(&phydev->mdio.dev, ds,
@@ -1018,7 +1018,7 @@ static int yt8531_set_ds(struct phy_device *phydev)
 		return ret;
 
 	/* set rgmii rx data driver strength */
-	if (!of_property_read_u32(node, "motorcomm,rx-data-drv-microamp", &val)) {
+	if (!device_property_read_u32(dev, "motorcomm,rx-data-drv-microamp", &val)) {
 		ds = yt8531_get_ds_map(phydev, val);
 		if (ds < 0)
 			return dev_err_probe(&phydev->mdio.dev, ds,
@@ -1051,7 +1051,6 @@ static int yt8531_set_ds(struct phy_device *phydev)
  */
 static int yt8521_probe(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
 	struct device *dev = &phydev->mdio.dev;
 	struct yt8521_priv *priv;
 	int chip_config;
@@ -1101,7 +1100,7 @@ static int yt8521_probe(struct phy_device *phydev)
 			return ret;
 	}
 
-	if (of_property_read_u32(node, "motorcomm,clk-out-frequency-hz", &freq))
+	if (device_property_read_u32(dev, "motorcomm,clk-out-frequency-hz", &freq))
 		freq = YTPHY_DTS_OUTPUT_CLK_DIS;
 
 	if (phydev->drv->phy_id == PHY_ID_YT8521) {
@@ -1169,11 +1168,11 @@ static int yt8521_probe(struct phy_device *phydev)
 
 static int yt8531_probe(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
 	u16 mask, val;
 	u32 freq;
 
-	if (of_property_read_u32(node, "motorcomm,clk-out-frequency-hz", &freq))
+	if (device_property_read_u32(dev, "motorcomm,clk-out-frequency-hz", &freq))
 		freq = YTPHY_DTS_OUTPUT_CLK_DIS;
 
 	switch (freq) {
@@ -1665,7 +1664,7 @@ static int yt8521_resume(struct phy_device *phydev)
  */
 static int yt8521_config_init(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
 	int old_page;
 	int ret = 0;
 
@@ -1680,7 +1679,7 @@ static int yt8521_config_init(struct phy_device *phydev)
 			goto err_restore_page;
 	}
 
-	if (of_property_read_bool(node, "motorcomm,auto-sleep-disabled")) {
+	if (device_property_read_bool(dev, "motorcomm,auto-sleep-disabled")) {
 		/* disable auto sleep */
 		ret = ytphy_modify_ext(phydev, YT8521_EXTREG_SLEEP_CONTROL1_REG,
 				       YT8521_ESC1R_SLEEP_SW, 0);
@@ -1688,7 +1687,7 @@ static int yt8521_config_init(struct phy_device *phydev)
 			goto err_restore_page;
 	}
 
-	if (of_property_read_bool(node, "motorcomm,keep-pll-enabled")) {
+	if (device_property_read_bool(dev, "motorcomm,keep-pll-enabled")) {
 		/* enable RXC clock when no wire plug */
 		ret = ytphy_modify_ext(phydev, YT8521_CLOCK_GATING_REG,
 				       YT8521_CGR_RX_CLK_EN, 0);
@@ -1801,14 +1800,14 @@ static int yt8521_led_hw_control_get(struct phy_device *phydev, u8 index,
 
 static int yt8531_config_init(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
 	int ret;
 
 	ret = ytphy_rgmii_clk_delay_config_with_lock(phydev);
 	if (ret < 0)
 		return ret;
 
-	if (of_property_read_bool(node, "motorcomm,auto-sleep-disabled")) {
+	if (device_property_read_bool(dev, "motorcomm,auto-sleep-disabled")) {
 		/* disable auto sleep */
 		ret = ytphy_modify_ext_with_lock(phydev,
 						 YT8521_EXTREG_SLEEP_CONTROL1_REG,
@@ -1817,7 +1816,7 @@ static int yt8531_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	if (of_property_read_bool(node, "motorcomm,keep-pll-enabled")) {
+	if (device_property_read_bool(dev, "motorcomm,keep-pll-enabled")) {
 		/* enable RXC clock when no wire plug */
 		ret = ytphy_modify_ext_with_lock(phydev,
 						 YT8521_CLOCK_GATING_REG,
@@ -1844,7 +1843,7 @@ static int yt8531_config_init(struct phy_device *phydev)
  */
 static void yt8531_link_change_notify(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device *dev = &phydev->mdio.dev;
 	bool tx_clk_1000_inverted = false;
 	bool tx_clk_100_inverted = false;
 	bool tx_clk_10_inverted = false;
@@ -1852,17 +1851,17 @@ static void yt8531_link_change_notify(struct phy_device *phydev)
 	u16 val = 0;
 	int ret;
 
-	if (of_property_read_bool(node, "motorcomm,tx-clk-adj-enabled"))
+	if (device_property_read_bool(dev, "motorcomm,tx-clk-adj-enabled"))
 		tx_clk_adj_enabled = true;
 
 	if (!tx_clk_adj_enabled)
 		return;
 
-	if (of_property_read_bool(node, "motorcomm,tx-clk-10-inverted"))
+	if (device_property_read_bool(dev, "motorcomm,tx-clk-10-inverted"))
 		tx_clk_10_inverted = true;
-	if (of_property_read_bool(node, "motorcomm,tx-clk-100-inverted"))
+	if (device_property_read_bool(dev, "motorcomm,tx-clk-100-inverted"))
 		tx_clk_100_inverted = true;
-	if (of_property_read_bool(node, "motorcomm,tx-clk-1000-inverted"))
+	if (device_property_read_bool(dev, "motorcomm,tx-clk-1000-inverted"))
 		tx_clk_1000_inverted = true;
 
 	if (phydev->speed < 0)
-- 
2.34.1

