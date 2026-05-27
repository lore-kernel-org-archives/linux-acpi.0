Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED247DFB7;
	Wed, 27 May 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905543; cv=none; b=ROSYdciibERf3snxL2e9zu1iGkHsvlu18KCsttW2X77dxU/0mo9g+tVLyEWdMDsYMg1EBpZZV6u3ZZ2UQycB07JzIALl0yByLESge03/tXjwBkpGkZUMDhkHKzL1yoYfqNBFCwFHsCwHP5pvcgozqShyrMK/G6UFZl/z9h0K0vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905543; c=relaxed/simple;
	bh=MbJ8LCCnZLMdeEVgjXBeYP3IXX7f816HqdQCp8dTJJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0r9kQOxiHwe4Io/A/f/8AEj5BkONIttFxjavA1kquAOxhnJUVfLtpMaLtaaxrBWAA6NZwuRekWL8i3g03fchOMuKKDf8dVNqgVd1KlVAki0ALvNuCW2DQVCOamCj5zL65vlvb7Ux9hdZlEWEcu40jDJRuX9OtggynFK6FqIc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lki9a0jo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lki9a0jo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918AD1F000E9;
	Wed, 27 May 2026 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905541;
	bh=LVTY1rCi3JF2Mfq42FscjaJEUU7AI3lZueYZ4+pITtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lki9a0joPsTE6vFxFErnbgnWkuZVwRqr8u9bL8BFfchZ0vMBJrlxQNfio2k4r2hh1
	 LrAPigeOBqlM3esxfy5XhORHToxP8X1gIjj70hk/mOGdZyi5jpq//TMXv5Si6+EzwE
	 wTn8zgYo6OPBQbgUZLIwGc4TWihkGXJhU6WIbTnDoUN+SpM7yKIGk1gUt6Kbx8p16a
	 jIJfxBm8MzKJB3W31XDz03jOWTchfpCzxq8P7Mdw2YK6b1QD+6/IPP81hRKpR5taS2
	 N5Nkaf/Y9he6qsnYgJe+VomruXKhC5w+kNfWlfOtzzADfjz4ySoymUYGkEKdgmYqrz
	 XE/pr8vdhLZfg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1 11/27] ACPICA: fix I2C LVR item count in the conversion table
Date: Wed, 27 May 2026 19:58:29 +0200
Message-ID: <6164740.MhkbZ0Pkbq@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5998844.DvuYhMxLoT@rafael.j.wysocki>
References: <5998844.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Akhil R <akhilrajeev@nvidia.com>

For ACPI_RSC_MOVE8, the 'Value' field in struct acpi_rsconvert_info
is the item count count and not a bit position like for the
bitflags. Set 'Value' as '1' to fix this.

Conversion still works coincidentally with '0' because
item_count is not reset between table entries, and the previous
count value was taking effect.

Link: https://github.com/acpica/acpica/commit/70082dc8fc84
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/rsserial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index 7d7ee3af7272..5ab41e9b9039 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -394,7 +394,7 @@ struct acpi_rsconvert_info acpi_rs_convert_i2c_serial_bus[18] = {
 	/* Read LVR from Type Specific Flags, bits[15:8] */
 	{ACPI_RSC_MOVE8, ACPI_RS_OFFSET(data.i2c_serial_bus.lvr),
 	 AML_OFFSET(i2c_serial_bus.type_specific_flags) + 1,
-	 0},
+	 1},
 
 	{ACPI_RSC_MOVE32, ACPI_RS_OFFSET(data.i2c_serial_bus.connection_speed),
 	 AML_OFFSET(i2c_serial_bus.connection_speed),
-- 
2.51.0




