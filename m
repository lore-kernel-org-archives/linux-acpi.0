Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6812459EA
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778033947; cv=none; b=k42bJoeJmhvQtowSUmKI8zuOSfBC/htO5nlDht86+tjh/SoXqn4WMeYTDtwwb9mjbMGu2F8FIMwnfsSosuByRmmW7XJCsLMepOYorjSMJTmkQ+ecPfQLB9WvZdW3Mn5pMAu+5Jw9HVIzG0s7tiQfC0JFXYTOlmlMnfbylSWcQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778033947; c=relaxed/simple;
	bh=86Ei1WG1fz4kMaacEOmlqzqDxWn+mO7BN44/481AeEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3lJxOxDfi9eTnt8rYcSb3leAnDmDhHIazGM4zcCHQIvBQ84djeO4DC8SlDdFYM4hBDxTS36whwh0UJ9dqrtHUcyBJaSuVEgqVviMhDSEdKsehOsnglJ9QwayAu5irG1YWlZtqKiOT4030VxodavYH15vp8FnM6DfH68INJsOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmg53ooT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmg53ooT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso32382505ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 19:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778033944; x=1778638744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpUMCxZV9PP5HhSYLbx/P1k1sQWc+4gDEtSSVnk03wQ=;
        b=pmg53ooTLNemlhOLUkNHIIYA1sI9zOQwiDK7wRMqqjsktLi2zwtgvVmuKX02hHB6mU
         NpxBq5ZivPcSSRLga2AtkJpEOlHhoeCaEHeuuwod99w3u1EP3DODdWX8gFds0923p+lj
         uVvrVEjEiF2aSuXmD8f4N7wyPOHgQWL8k4tM6gs8dfBwveAnQBwVqEheAKt9jJy9oEz6
         YAZ7PlM0mRBYtKJMD9t0laNbK/vke2Jl72duYIfDu9SGkyRc34fTyqHqHN0PiAnsZUxs
         B9/TzTiavdbipbE8JXN3VBz3/JxBjd4DVITpi/PMQqwbXQgqfKl4KT6c7OuKjrduIWWF
         lUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778033944; x=1778638744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpUMCxZV9PP5HhSYLbx/P1k1sQWc+4gDEtSSVnk03wQ=;
        b=F6Rgbjlj+fDExHlUiowSZ14+RRdQUzmOMT2lEIWUTljU0K3OEJZuLoNoeHTCK5T8El
         rddyyBydg50Mm3S87bFcBIE674kD0Fh180Tg6Cro3h1XdfbWq7gxfXOmQmXUr+9WeUG4
         z8XXYkHGQrpMLQwHLBQjl10sCLbVydS07f60nDtcyWEfA1zyJe5S33QBj2EobWY96iPC
         iVMUWrOXI1c5EPD8Y65h3Agbx2w6tHs9XJQDbmFogW9lAuPRx+YMeKQTJU/GLEsym4hS
         G3X1VWgtRdDIBLebRw/OV6xnoRTlhWYqp18ZBAyqG+LVb9VweQr1G8elsaCqqMHg2jec
         OStw==
X-Forwarded-Encrypted: i=1; AFNElJ9m8ybQFV4aoAf6LkBl5VUK53/saQsNHQZyCz4neG7h2LipYZ1ZmHBqiA2NckVimfcZOFZUC/3qLV/1@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRkDBbluA/mtlQ8Wj9tSDqUWup181eycWypyypLQet2V5mm2z
	/Nj1V/rcYm0S6rcxEQ4/BJfOclA/8+TVMOBwtdzB6yNa/faWQS1bxbrG
X-Gm-Gg: AeBDievucJg8bezh721Hqw2+bGbapr+/GWpSumDLWXw/A2lFDluTTz/gKxj12bIusY4
	vb7hbAZQdtKiFNoZ7yLS81USZwCVRAgEDTCTVRZrCIGa7PmAJDMaCC1+2sPHtFdPGacc+qNLUow
	DoXxHavDgRJu1Z1/wdINfxc/9RL75NX88w+FC8HEy/Eo00+hZeOLSndvZmo3/O/idCxAgyiP2s4
	LOshYibUSm6KXBi5N9REg5b4n/15ETua19qBzDTxIfK2cTC4LkI6qfFfJ4BogXfObltq22vIAf3
	wXJe+gx95HRXlSgLfSrl/Ht3nXyWEfp2R7eF3KfH6IZdg3A8g1B76vRLkaW572/WNLKtorW5ML+
	GGkkPr+X/uDVSgVGc55LmhJcK3xAHBM39qcd3+a3JuYUbibnVTr05JqmpU3wbiXVfR4v707l3YR
	huTZp+lgz6EsfIEvTcau8v9/XLUIIrdiY646nsuBp1HbAHH5egkeaOYg==
X-Received: by 2002:a17:902:d2d1:b0:2b2:42f8:1a45 with SMTP id d9443c01a7336-2ba7a377058mr14501615ad.39.1778033943967;
        Tue, 05 May 2026 19:19:03 -0700 (PDT)
Received: from ampere-server.example.org ([103.68.183.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e1ac6sm6319525ad.42.2026.05.05.19.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 19:19:03 -0700 (PDT)
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
Subject: [PATCH 2/2] docs: acpi: dsd: add Motorcomm yt8xxx PHY properties
Date: Wed,  6 May 2026 10:18:13 +0800
Message-Id: <20260506021813.3658669-3-linchunzhi0@gmail.com>
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

Document Motorcomm yt8xxx PHY ACPI _DSD properties consumed by
the motorcomm PHY driver.

Describe property placement, UUID usage, and reference the DT binding
for value constraints and defaults.

Signed-off-by: chunzhi.lin <linchunzhi0@gmail.com>
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
index b246902f523f..3cd38bb4de15 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -12,6 +12,7 @@ ACPI Support
    dsd/data-node-references
    dsd/leds
    dsd/phy
+   dsd/motorcomm-yt8xxx-phy
    enumeration
    osi
    method-tracing
-- 
2.34.1

