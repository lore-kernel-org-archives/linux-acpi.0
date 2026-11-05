Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901827;
	b=W077dKE0gBr7A/LOXlZPqMDIwo1oizrWRKs0d5ewjL5eEtnOV19DIDRvC5k/khCrwKup
	 onvS6mbOyjFxJBLuvholyx4FSMFJXUOTVosQi39y442CJgcXXA30oR3tAZoV+rEYrX8ff
	 ABmQFvuQ7a0OQgM0FXCwjznMTdcQtW+6OSdGsma+xAXPu8kp5DPJjgUFbap00Bf5d6Nr5
	 Y1McK0jBT0MfFGsrMd57lGEDuWnpia1k9NfjL3rWI4nLPtYZeuqkEb58XQGnj+VdAC07S
	 klTxESMPmbRpTxrzIVKU76gak0bv2JtljPW56ZxlzTYkPRCch4SWth9x5Ss9aRk21ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901827;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=FszNzi5W6BVkUDAXdQk1QKMMfImnvE6FsmKPIP4VJgs=;
	b=szke6/ZI5JoXKZydy0vVlk0lxib5FBL6C1C9g8YChSdIO3HuXlFhbVrx1vY8xUESYBIR
	 j3kTB8H3E2+hWl2xN1j8m8lwaxMsTo+1E2ZRfR/AXCPOmoF8DkfMcJiqBk9iysyWlj81W
	 vOFTdA6jnbnZRr6NL+BLXfF8xlohj0VCyG2WsaYd9E6t1ZZWKpKtK8GbZWBQVW7a9uRLe
	 8qcgFJkshicP/8blnaZe4jP+F4DUkZUcvBJ+MkJbXBwQAMZ6e7xJbFHknZjAYsoEqerlM
	 XPaFHFuYs7i1LWz7PEy42ZSN6pyNO2JaSfpRbZDVD7ewq3irZa/si1DDwcbDO7JXADQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S40ARWyb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9008606A31B;
	Thu,  5 Nov 2026 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S40ARWyb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEFA1F000C1;
	Thu,  5 Nov 2026 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901826;
	bh=FszNzi5W6BVkUDAXdQk1QKMMfImnvE6FsmKPIP4VJgs=;
	h=From:Date:Subject:To:Cc;
	b=S40ARWyb0TrRGVbXkaX/OJiCEryidQoK/raNHWPNsXaPEzD6a6IrTqJNlmmUSN/r4
	 HdxeJzOZdBlSRwWBhjozbLLvuYf8mvPlAcI65fAMoi4Gm2ep0R6tx491jNuW8tcrlR
	 cG8nVDn4p0fkFx3xjShuJFv0ffwyIrPjGwLJphQVwrmR9z3v3bMNF/meQshsAIFIjk
	 2Biaz1h5G5WoPzlluuIxDHebYE5LqFLTnfgFPG4DaIoFAHUsAl38YaHX9pz47nq4o4
	 AodDv3Z+hqcCxXoyKPKtfwtKX1NtYcowXbKJBVJgFQVHImzQIqEx/D8mGOKdMdEdyh
	 npQ7/Za6LSzOw==
From: Mario Limonciello <superm1@kernel.org>
Date: Thu, 05 Nov 2026 12:03:36 -0600
Subject: [PATCH] pinctrl: amd: Drop CONFIG_ACPI ifdef
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-superm1-pinctrl-acpi-v1-1-2367e584912f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCQAxG4auUrA1MihbxKuJinP7ViI5D0opQe
 nfHdvkt3pvJYQqnUzOT4aOu71whu4bSPeYbWPtqakPbiQRhnwrsJVw0p9GeHFNRHiLQ7w9HQRe
 opsUw6Hfdni+bfbo+kMb/i5blBzsgZxl4AAAA
X-Change-ID: 20261101-superm1-pinctrl-acpi-faeed4581e60
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Linus Walleij <linusw@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Mario Limonciello <superm1@kernel.org>
X-Mailer: b4 0.16.0

commit e7280ab196ba4 ("ACPI: bus: Use acpi/acpi_bus.h without
CONFIG_ACPI") added a stub that means that we don't need a #ifdef
anymore for the _AEI check

Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
 drivers/pinctrl/pinctrl-amd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 9fa752f552d43..efe8859fcd5a9 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -955,14 +955,12 @@ static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
 
 	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3);
 
-#ifdef CONFIG_ACPI
 	/*
 	 * Platforms without _AEI leave GPIO wake sources to firmware, so
 	 * preserve their S4 wake bits.
 	 */
 	if (acpi_has_method(ACPI_HANDLE(&gpio_dev->pdev->dev), "_AEI"))
 		mask |= BIT(WAKE_CNTRL_OFF_S4);
-#endif
 
 	for (i = 0; i < desc->npins; i++) {
 		int pin = desc->pins[i].number;

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261101-superm1-pinctrl-acpi-faeed4581e60

Best regards,
--  
Mario Limonciello <superm1@kernel.org>

