Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D231A55E
	for <linux-acpi@vger.kernel.org>; Thu,  7 May 2026 04:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778126559; cv=none; b=LJmZkXQR1gOFVUpUi2rNB2tSo3M6KmB9Evw9nGp9qOhLILvEnk7zFCDWFl+jb93z3XqnwnLs5n4g5NnR1Gxm9l8SoXoLGgRFg2nEO4+zD/pM7H8SIJlSymZ9/FaMK69mPp2KIKGcZOvbUjW3zJRerZVyLzFumKmPD+PNmpDlvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778126559; c=relaxed/simple;
	bh=Ll5t8GG+HHemlVZ/dlzGil/rBZk5oSgZbVxAUeRxn+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aa1rIAFFcYKu86mTkpsBbztYqy0ip5dzneste2pD2hiYyyGtur0vy09lplRehPCWVR+0RHzA+G26BcIl7mt6LCDt8Ue9tC6FpHTD4XHAuMTQCZI5H0DpSSoFMgwL4kqOK5fg0W6qS3r/dx9R5zl7rYXKHal2WQIJV9OhZOVsCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL2LuZGw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL2LuZGw"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso130951a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2026 21:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778126557; x=1778731357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq5gyYRLK16pcO2llT+UUfUWubla4yLA0GVq02udlXI=;
        b=RL2LuZGwYfTHFPP9NJzBHUOyErQiI5dLc0Wm4BNfPAOqZBzInj4DvHJK+HAaQkYS85
         cbxCvtE2effJedExPyIcmLObxJPL2fVcK6P/52AZo4fK4H13aGZm/VdUZpW56yYye0jy
         pw62lQI3lr80jDFoKoVnWwFBzoXWb+N26svryuTWAxI4fs+ZMZgbWzd0NxV6pWAAbcVT
         JQgnlByNqmEpWuOfkM7tv93sMhWiHXVOo2wgDNxGivfuAsuNN9yFL5ZLvAWxb72+2tVq
         PDyHCsac6uneXgRpfpLOat89XVTH/nvgvAs262hgHFv9qvkxoDgSsbb/M5cm5san5Eyg
         vx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778126557; x=1778731357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jq5gyYRLK16pcO2llT+UUfUWubla4yLA0GVq02udlXI=;
        b=Izd/9jjX7Mf3EGg8/HTjo7cUR7R/HhlxhSN1GqnKalfR1Zja3L2ibZoHvThuKoUcJC
         prGrg6yfHTl0SC6ZiuAyFeWpUBhRfeqCP2XX/627WVN7wGHVysaIXFjwo3djROuDgcmd
         UKlEGux1H6G+ljjlfs6RDan6WBL8pXnwJFs73/7sCJIVRPIa6LfB9XLJda4U+D8HZ+9B
         NzvtVYAIZ4LYbtK2M0DtJyQiBkUBc/PsUxOmuKWDFoljdRC0/mooz7/XftRmahVq5ZOV
         jVJpKZKYXAn0ZbsjJfgRoj2yv+F8SgazwFt3SUwWW7BpUXPkbfqwkcsaUTwY8oXP9rXk
         +l5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+TW8Lx9+P9iqxqKR68cmP1wRB8QF5+LYj9NERAcFaI2bZ7PAhL3KtHny4acnWQTUMpfgtFEPdg995s@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/IZ24w18pjRAEc6xubNUhaZw02MF+Q/DT4WUDb2CqPWFlaJHj
	gyvHMV/GBaPoJK8KWF2xTAjU8sO80g0FObwWpyUC3y9lM07JuQ3udm8v
X-Gm-Gg: AeBDieuyh12KwOQkx953eoQdDrme1EUSdRfgCu34cGJtLBShBUiZ8rzI07XQFyYBwlC
	brZxoCnkrySvyRoz1cZudEwboaYDzKwMQKRoN4NVnI/2uLUl+jURMkiqmhk6EXjrjSA6JSUFrGU
	/UBehttlVGGhzfKUykMOyo7+fdkTBOnP46zaIZiRyFwwRDExURUJmlLd+OWx1q/X116tvdV7T70
	Bp/KrkFLDZ5YdO2ngrM7Idp5YPbIvuufI36V83TcEPPlJQP15kWQaCU+fNj4gRQleDCY9yb4sVP
	+H0bDIJRD+6t/dlGJkNeMImprd66dKNJ8UTud5ba6NjhW5getAnH1NXjrwHVoVrHfTyTYBgN7qx
	U6ct3i6CHXB3IJhjWT02y05zd2tNOUSRrwLJlHdbvyrjZUx4SYTK1V51T0+iWOyN/zRLLRRWYHM
	PqyiS6IaBNJGMJReDyoHdywtf7vLlNRV0THhgUe3zuZI2mnGXrAfVi5g==
X-Received: by 2002:a17:90b:37ce:b0:35e:579a:7e9a with SMTP id 98e67ed59e1d1-366053f7f37mr1026290a91.7.1778126557333;
        Wed, 06 May 2026 21:02:37 -0700 (PDT)
Received: from ampere-server.example.org ([103.68.183.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365d8e3dad8sm2536182a91.1.2026.05.06.21.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 21:02:37 -0700 (PDT)
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
Subject: [PATCH v2 2/2] docs: acpi: dsd: add Motorcomm yt8xxx PHY properties
Date: Thu,  7 May 2026 12:02:21 +0800
Message-Id: <20260507040221.3679454-3-linchunzhi0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507040221.3679454-1-linchunzhi0@gmail.com>
References: <20260507040221.3679454-1-linchunzhi0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Motorcomm yt8xxx PHY ACPI _DSD properties consumed by
the motorcomm PHY driver.

Describe property placement, UUID usage, and reference the DT binding
for value constraints and defaults.

Signed-off-by: chunzhi.lin <linchunzhi0@gmail.com>

Changes in v2:
- Keep dsd/ entries sorted in Documentation/firmware-guide/acpi/index.rst
---
 .../acpi/dsd/motorcomm-yt8xxx-phy.rst         | 107 ++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst   |   1 +
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst

diff --git a/Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst b/Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst
new file mode 100644
index 000000000000..d64a396fac81
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst
@@ -0,0 +1,107 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+Motorcomm yt8xxx PHY properties (_DSD)
+======================================
+
+This document describes ACPI _DSD device properties for Motorcomm yt8xxx
+Ethernet PHYs supported by the in-kernel driver in
+``drivers/net/phy/motorcomm.c``.
+
+The properties are exposed on the PHY device object under the MDIO bus ACPI
+device (the same objects that are registered via
+``fwnode_mdiobus_register_phy()``). MAC-side connection properties such as
+``phy-handle`` and ``phy-mode`` are documented in [acpi-mdio-phy]_.
+
+Property names and semantics are intentionally aligned with the Devicetree
+binding [motorcomm-yt8xxx]_ so that the same driver code path
+(``device_property_*`` on ``&phydev->mdio.dev``) can consume firmware
+described either as Devicetree or ACPI _DSD.
+
+UUID and placement
+==================
+
+Per [acpi-dsd-properties-rules]_ and [acpi-mdio-phy]_, properties must be
+placed in an _DSD package using the standard Device Properties UUID::
+
+	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301")
+
+Properties
+==========
+
+Unless noted otherwise, integer properties use the same allowed values and
+defaults as [motorcomm-yt8xxx]_.
+
+``rx-internal-delay-ps`` (u32, optional)
+  RGMII RX internal delay in picoseconds. Only meaningful when the link is
+  using RGMII modes with RX internal delay; see [motorcomm-yt8xxx]_.
+
+``tx-internal-delay-ps`` (u32, optional)
+  RGMII TX internal delay in picoseconds. Only meaningful when the link is
+  using RGMII modes with TX internal delay; see [motorcomm-yt8xxx]_.
+
+``motorcomm,clk-out-frequency-hz`` (u32, optional)
+  Clock output frequency on the PHY clock output pin. Allowed values and
+  default are defined in [motorcomm-yt8xxx]_.
+
+``motorcomm,keep-pll-enabled`` (boolean, optional)
+  If true, keep the PLL enabled even when there is no link (useful for using
+  the clock output without an Ethernet link). See [motorcomm-yt8xxx]_.
+
+``motorcomm,auto-sleep-disabled`` (boolean, optional)
+  If true, disable the PHY auto-sleep behavior described in
+  [motorcomm-yt8xxx]_.
+
+``motorcomm,rx-clk-drv-microamp`` (u32, optional)
+  Drive strength for the ``rx_clk`` RGMII pad in microamps. Allowed values
+  depend on the configured RGMII LDO voltage; see [motorcomm-yt8xxx]_.
+
+``motorcomm,rx-data-drv-microamp`` (u32, optional)
+  Drive strength for the ``rx_data`` and ``rx_ctl`` RGMII pads in microamps.
+  See [motorcomm-yt8xxx]_.
+
+``motorcomm,tx-clk-adj-enabled`` (boolean, optional)
+  Enables adjustments related to ``motorcomm,tx-clk-*-inverted`` usage; see
+  [motorcomm-yt8xxx]_.
+
+``motorcomm,tx-clk-10-inverted`` (boolean, optional)
+``motorcomm,tx-clk-100-inverted`` (boolean, optional)
+``motorcomm,tx-clk-1000-inverted`` (boolean, optional)
+  Per-speed TX clock inversion options; see [motorcomm-yt8xxx]_.
+
+ASL example (illustrative)
+==========================
+
+The example below only shows PHY-local _DSD properties. A real platform
+still needs a MAC ``phy-handle`` and ``phy-mode`` package as in
+[acpi-mdio-phy]_.
+
+.. code-block:: none
+
+	Scope (\_SB.MDI0)
+	{
+		Device (PHY4)
+		{
+			Name (_ADR, 0x4)
+
+			Name (_DSD, Package () {
+				ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+				Package () {
+					Package (2) { "rx-internal-delay-ps", 2100 },
+					Package (2) { "tx-internal-delay-ps", 150 },
+					Package (2) { "motorcomm,clk-out-frequency-hz", 0 },
+					Package (2) { "motorcomm,keep-pll-enabled", 1 },
+					Package (2) { "motorcomm,auto-sleep-disabled", 1 },
+				}
+			})
+		}
+	}
+
+References
+==========
+
+.. [acpi-mdio-phy] Documentation/firmware-guide/acpi/dsd/phy.rst
+.. [acpi-dsd-properties-rules]
+   Documentation/firmware-guide/acpi/DSD-properties-rules.rst
+.. [motorcomm-yt8xxx]
+   Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index b246902f523f..db9eb7229948 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -11,6 +11,7 @@ ACPI Support
    dsd/graph
    dsd/data-node-references
    dsd/leds
+   dsd/motorcomm-yt8xxx-phy
    dsd/phy
    enumeration
    osi
-- 
2.34.1

