Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820835;
	b=00F0crB8K5T32mSUNv7yw8k5gDwyVKU/WgqIH1e1fRYE16i1Yh2p/62BjbG2AuDziTpN
	 KkMdV8/aBC570PE5BZTy8rEuLihIXx0InMT8GfYfn1Z4TovpQCfLu1eHAowvHHT+48KSK
	 N0WlhlIhxfyha7hL2jjMktbhMcBTTZ47gMVfnuLpggLTh3tLo1HnqH0o1BCl3KknxdH8S
	 bEeg7zA+glGoc8tGq4u3kNFDqBX10mXD4psTeOwjbCTOuPjlv3/X4awG24/BWkorRgRVP
	 PPAe2qSn6b7MnZ2gGko4HOjdwO6xjiNTIIIbIcBW3Q0774FKxCbuCAYu1Dd1jcXJKDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JVRdE/3Jnet+h8SyIDy0Hc/nWbQ9iRRU6k7zkm9yJs4=;
	b=FENeteE5JX1Mg1n10ZM/BIGJe2I38S9MBaM2dX49Jje3vnT7nPtPdu4UxfVq1NbvE4I7
	 7ohcwKBNcRPhUC+6hGT036JQN9Wwh2m0MnmgdCuY6HzII+4cXOGAPmVLcDwxDI2WDkkXL
	 a9gaiiDea9KtpAzfyi6N4pwhWOvg3ior7p5KzUQ7+JP7RslmQEttp+7+asLnS1lh3kLQj
	 S9zw17Oj0hlKM3Gc4WHYOqnJ+jwEi+zpvm4G3C/4elZAY07kt6qh0Jy7qTyhSGGWNC3g2
	 IAfNG5O9ib+xZFLSp0e2UcqufZPh8U2I3msyRaYfV0oYK7fjUqV6GFxoBFBKk1gggmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yuw4ixgJ;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E41F606A31B
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 05:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E41F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yuw4ixgJ
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso1522585e9.2
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792820833; x=1793425633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVRdE/3Jnet+h8SyIDy0Hc/nWbQ9iRRU6k7zkm9yJs4=;
        b=Yuw4ixgJc6bzy2bcfbKthETR1aV1KVTchu3ycgR7/NVAXtHhd80u0bNyC3XZmU5Q9a
         7nFiaAO0SGPvpxkbtFvr78kqPDoSRpZv2OEHpVI02E2vHo7FxiTuzkjPayNJtmPZqWPu
         GBfVz7OixWqhoxpGPbjn/yKao1ZNgwJfR/BZz7I9T9WJQL3q6LTUJnlN0xQHRHvcS+WO
         SSVrq+yFdxDUZiy8dppA4CwpQhMpykb7hlaaWmamK3wFMyzjbNpwSAcTcx1ydkZYBmW1
         PCp9BnH1oKZKB3XpPCVEwsM2E+ahQikbxi5VLFV1ZVihHYexv6mQuxAXi5DF7PfLP560
         Uv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820833; x=1793425633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVRdE/3Jnet+h8SyIDy0Hc/nWbQ9iRRU6k7zkm9yJs4=;
        b=utnYJHEG7WRvsRffpqZp+NXLfkINvq6Lnszd6PyXb0ZGE91AkKabVb/mlIRSwbJ1qa
         sF6Dw9XFRCsFL1S3kEeNy5TBecf8+p9xPhbrNtk6PhaGLq1zZhSjS+bwxt6wVaKY8RM+
         kQCHqtqvn9ocaPlSLU5+8ZFeIZWDHqODaT5x9VVGoUpsTlu+DaFnDmqTmgFxdal3TB2n
         wk0SScCRhZ0RZn7kau3nElyIDKb3ERnF836MfO2vyKjue+rKYI+Gi1aWBdHbv8Y327PG
         luJDOtErn26GkZJVEJbGxBUBpyFLNwFGXrbvumYJ8SxcqaTIv3EdkcQ9xxtOhd2dCOZv
         rpww==
X-Forwarded-Encrypted: i=1; AKwUvBzvPlzMUyJmwY6jrXT3edmj1Iq5jgObAO2SMUDzxXyF5qPm23lV0jEOWa6wvW5h9S9EFKBhnXJqN8iT@vger.kernel.org
X-Gm-Message-State: AFq9FYKyoNnU/qK5/KW0/qf0ADjt1RhMA0d3+b2I/4ivrxXqC/UqF/Qf
	lYiIphOiomN/FlcW7PY/PoJSbetRCg40xu35AMZKgt/7JmxtGtkaHKt9
X-Gm-Gg: AYBFou2dfIaMsJNXzPLmxcXkVs2evtOyhUEWjurDroY2vnULL861zwuYVJjYYjndmKU
	ImMERKRLAI6H5ujXA3EsJmqcJuyFMQ+gGdEhDGcgfKuHzxMqBuVqij2g8Tvo+pgaI5/MoBzsADE
	iBwgJqxR8pA5j3v+r8O+C0jCSrJq890GBewlyCUa8kHuqG1B6MGpVZUBAvcjU2FI7LFLX4xcVDq
	4zX4hma+F0a72XK5IWvploDAXmsLBshhJgrZ1acr50gcCMUUTCSsYlesDR2HlzBQY02uZu+jzLl
	3DQuymStJaSaXefceGx1OCerpPZEEh0AnD/M6n8LfOhCjopB0q4cf721qHJlqQDnFC7RgagIIIs
	t1+KA3QyVnTI0Hde7tKqRlJIZo/bRYHqfeefRoNr3K+j1/wp4+N8PEBphRutnx6mKMwvISSWFJR
	5UIs2IASndSY4RuBZAftB3sK9CKEdpjj9i5kwuBD55nF2xw0AlgaUBH7jaXMzCYM1gI2dkDC9gQ
	9HlC3PkGASoig0iIT6XbXruAuDOOIEh3guXqGwWZOFaLKDSCIJs81kwY/tVlv8ZIZ/lQFiImCD8
	5y+iVlmoGXlzCqTtJWjtlCz4/jh+jk2cEYQxu8+DsJ5fPumsbspD
X-Received: by 2002:a05:600c:8b72:b0:4a1:e11f:b2d5 with SMTP id 5b1f17b1804b1-4a35ac3948emr13955165e9.2.1792820833100;
        Fri, 23 Oct 2026 22:47:13 -0700 (PDT)
Received: from Sheldon ([185.4.35.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a00e1b0sm25917465e9.3.2026.10.23.22.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:47:12 -0700 (PDT)
From: Victor Carreras <vicajilau@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Victor Carreras <vicajilau@gmail.com>
Subject: [PATCH v2] ACPI: x86: Disable wakeup on MSI MS-1592 and MS-1594 dGPU root port
Date: Sat, 24 Oct 2026 07:47:11 +0200
Message-ID: <20261024054711.21587-1-vicajilau@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179272791966.20251.3697951431087014523@gmail.com>
References: <179272791966.20251.3697951431087014523@gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MSI Summit E16 Flip A12UCT (motherboard MS-1592, BIOS E1592IMS.111)
and MSI Prestige 16 Studio A13VE / Summit E16 Flip A13VET (motherboard
MS-1594, BIOS E1594IMS.115), the I2C touchpad (ELAN0305:00, 04F3:31FD)
permanently stops generating interrupts as soon as the discrete NVIDIA
GPU (0000:01:00.0) and its parent PCIe Root Port (0000:00:06.0,
\_SB.PC00.PEG0) enter D3cold.

In the platform's SSDT (MSI_NB / AdlP_Rvp), \_SB.PC00.PEG0 sets its wake
GPIO (WAKG) from the BIOS NVS variable P1WP, which erroneously points to
GPP_A20 (INTC1055:00 pin 62) -- the GPIO interrupt line wired to the
touchpad.

During boot, \_SB.PC00.PEG0.PON() calls \_SB.SHPO(WAKG, One), setting
PAD_CFG0_GPP_A20.GPIROUTSCI = 0 and HostSwOwn = 1 so the OS GPIO driver
owns the pin. However, when the root port runtime-suspends to D3cold,
Linux enables ACPI wakeup via \_SB.PC00.PEG0._DSW(1, 0, 3), which sets
WKEN = 1. Subsequent evaluation of \_SB.PC00.PEG0.PXP._OFF -> POFF()
executes:

  If (CondRefOf (WAKG))
  {
      If (((WAKG != Zero) && WKEN))
      {
          \_SB.SHPO (WAKG, Zero)
      }
  }

This switches GPP_A20 ownership to ACPI GPE mode (HostSwOwn = 0,
GPIROUTSCI = 1), silencing the touchpad interrupt until the dGPU wakes
back up to D0. Under Windows, _DSW is not armed for S0 D3cold on this
root port, leaving WKEN = 0 so POFF() powers off the dGPU (\PIN.OFF(PWRG))
without touching GPP_A20.

Add a PCI quirk in drivers/acpi/x86/utils.c for boards MS-1592 and
MS-1594 on root port 0000:00:06.0 (8086:464d on 12th Gen Alder Lake-P
and 8086:a74d on 13th Gen Raptor Lake-P/H) to disable wakeup capability.
This keeps WKEN = 0 so the root port and dGPU still reach D3cold
normally while leaving GPP_A20 owned by the GPIO driver.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220725
Cc: stable@vger.kernel.org
Signed-off-by: Victor Carreras <vicajilau@gmail.com>
---
Changes in v2:
- Move the quirk from drivers/pci/quirks.c to drivers/acpi/x86/utils.c
  as it is x86-specific (Lukas Wunner).
- Drop clearing adev->wakeup.flags.valid in the final fixup so ACPI
  power resource dependent tracking between pci_acpi_setup() and
  pci_acpi_cleanup() remains balanced.
- Link to v1: https://lore.kernel.org/r/179272791966.20251.3697951431087014523@gmail.com

 drivers/acpi/x86/utils.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 4189516..84a6ca7 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -665,3 +665,50 @@ void __init acpi_proc_quirk_mwait_check(void)
 	 */
 	dmi_check_system(acpi_proc_quirk_mwait_dmi_table);
 }
+
+/*
+ * On MSI Summit E16 Flip A12UCT (board MS-1592) and MSI Prestige 16 Studio
+ * A13VE / Summit E16 Flip A13VET (board MS-1594), the BIOS SSDT (MSI_NB /
+ * AdlP_Rvp) assigns the touchpad's GPIO interrupt pin (GPP_A20) as the PCIe
+ * wake GPIO (WAKG / P1WP) for the dGPU root port (\_SB.PC00.PEG0, 0000:00:06.0).
+ *
+ * When ACPI wakeup is armed on this root port via _DSW (setting WKEN = 1),
+ * subsequent D3cold transitions (\_SB.PC00.PEG0.PXP._OFF -> POFF) call
+ * \_SB.SHPO(WAKG, Zero), switching GPP_A20 ownership from GPIO driver mode
+ * to ACPI GPE mode and permanently freezing the I2C touchpad (ELAN0305:00).
+ *
+ * Disable wakeup on this root port so _DSW is not armed and WKEN remains zero
+ * during D3cold transitions.
+ */
+static const struct dmi_system_id msi_peg0_no_wakeup_dmi_table[] = {
+	{
+		.ident = "MSI MS-1592",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "MS-1592"),
+		},
+	},
+	{
+		.ident = "MSI MS-1594",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "MS-1594"),
+		},
+	},
+	{}
+};
+
+static void quirk_msi_peg0_no_wakeup(struct pci_dev *dev)
+{
+	if (pci_dev_id(dev) != PCI_DEVID(0, PCI_DEVFN(6, 0)))
+		return;
+
+	if (!dmi_check_system(msi_peg0_no_wakeup_dmi_table))
+		return;
+
+	pci_info(dev, FW_BUG "Disabling ACPI wakeup to avoid touchpad GPIO (GPP_A20) takeover in D3cold\n");
+	device_wakeup_disable(&dev->dev);
+	device_set_wakeup_capable(&dev->dev, false);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x464d, quirk_msi_peg0_no_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0xa74d, quirk_msi_peg0_no_wakeup);
-- 
2.55.0

