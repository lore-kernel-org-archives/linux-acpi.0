Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0051339FCD7
	for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877385; cv=none; b=rSUuNBN0Wb4jeV/t+Qv3ZNsxqZUOzUWpn4i+1I+A2t7dJrJn7KfE0qAbTeSJJlsAAJN1imav0Fq0O7uBgp7X/OApqQKFmA8Sk+a+wIdUyu4OeJZ/+v1G8qse6cgJHRcNQ5C2IiWbgql5kwD3qfWtSLCupe0CWwOmNJdzW8zwRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877385; c=relaxed/simple;
	bh=sPWH6kGGEdy0SO1YJgy6hw6EHWHf0o43IA3RS1ddH8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDndqMbnL5jfiFr4Yk9b7CgDbqXQEn/7K8mS8acFHpxVYQJc1B/xzkihr3ZPE69nXl6AqmS9vZ+5HS7uWPjeJ9AsTHyvmoAHH1YmqmQjNJQstW3cczlwiokTtFkFLZiimyI8/ppTyn+qtRPyHjoUz7GLcpoJ0JbUvpVwZWJGoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrdmE4UN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrdmE4UN"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2df8e3c664cso2568865ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2026 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791877383; x=1792482183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iOcyaK3UgGBmuqv2SQSsYi/FLmbjcHTE0pm55WgaC5Y=;
        b=JrdmE4UN6nS7KXXtpJ5b3uVHJ9ksiYXK8EQAmc9Z/0vEpv8Xbojzicg+RASdqRcb2u
         zV0t6mCF61lCi5re6S50arYzAZ0EBOVm63O6nRzFb7q+g2wpaxBCUjWAX8aZ2+sQVZHJ
         PpYox0O58yDlFS8EdgYL5gFFaELsx0MEwSAl3QbfC9Y7A3NYCbJE0ZDT4ew7RPpoPeAA
         0QeAv6eXdi5vJYnn2HfLMk/8lkRXvX1izAXv74wBEFCT2pTswXDvrd4ICY273CzMSbQd
         sFax/8IHUpcAMLD0dHCUKk5Usp27PhgdYId+LRLj9DEL1K01o8LoaJzDd1p8fdbEa2eK
         c4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877383; x=1792482183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOcyaK3UgGBmuqv2SQSsYi/FLmbjcHTE0pm55WgaC5Y=;
        b=jV0SQQiRh6N5CUQJvmAoCpVwFyNMU8E4FkkDqP3bZBbqNaonkm3VvS2yNmipyCBJZY
         UeW7A1vyt3GGTi7awHgvvZLHHo1nEn/ejmnY+ZFo7MVCUBmCkwg1ubIJjiUJv6L8pdLb
         0tOM4xRBLEnJaooMYwRQ9HWrDYcoJ4Owm7pNzx8RspuH0g15BynEyc3kEoNdWXF+EXIk
         1cCZyIgYXl9DKAvrcXurfplsvrYyHWtSPiz3BkrrGKeANeWnsBi72evCQOFAEHNoUZiE
         wzvhVk/NfSmcEdzh1to991vhVgw8TO19sOfEowjYrDVFPSAwJ/frd/htL1w7cPJ+31I/
         aVKw==
X-Forwarded-Encrypted: i=1; AKwUvBxL5hz2eMND0nelAid2xAsQj2pNUsA1a5n8WnKaXxN5+JddgO5+iumeQNBKLyMgT70aGum5+sucsgqe@vger.kernel.org
X-Gm-Message-State: AFq9FYJQH0TBrjsbO9xlnjDrmIPnPzbD2b/LNExMkAh+JYa8eIf4KCgq
	fkt/sTyNrxtE2QylCtJJ6YY65DJsLBuVD9FBhvtNxNoXFVVYUBp0lbzD
X-Gm-Gg: AYBFou0aAqWha1vu5O+wcXJgkZatmq36bblbqNIG67xMcjegN98UxTnP/JbiJ3lA6Zy
	as2YZeYZS6P3/8HBHtcZ8ARdBPl4r6D9OmL7R8a0OAbBPEBdUtsB1phIuNI4F8HYgB0vv1Eyypd
	fHN/rnFDmdmEDtUnO10q7En+Dn3f+y90kFZTtRG59s13l+B4LUVk453Jb4ron141l5Fjkj+ZCwi
	DulTeLha066c+b09mD/KwtqPHLxq/Vyt9ixc361lh6bIecT4XzM+9cQn+zbqzX+RUBZHydWBaIf
	PbjXpHtjPkjpIGgX/vdWkLKv95ibNFGLCtekZolrpQpGJvcmKKAYLBo7TjZcZCosLLB8yIo/qm3
	h90YIA2LiduJhR202Qb+Qf1TkIe/kJC6mlJOObX79FmWVkJA1vbpfrGxX8byovmKuFwIZ9fb57a
	9A5uljCxdrIN+02YJCArnUv4kYVKr/YRS3U9isHH7w86Wa0I9AnZxcMjBesdt+d07TU/DFfg==
X-Received: by 2002:a17:903:22ce:b0:2e5:e361:5560 with SMTP id d9443c01a7336-2e842719490mr160161305ad.0.1791877383223;
        Tue, 13 Oct 2026 00:43:03 -0700 (PDT)
Received: from candy ([2001:fb1:138:d47b:6b0e:5f1:e489:a994])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e82asm49928955ad.14.2026.10.13.00.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:43:02 -0700 (PDT)
From: Krittikun Wongnin <krittikunwongnin@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Krittikun Wongnin <krittikunwongnin@gmail.com>
Subject: [PATCH] ACPI: PM: Add Acer Aspire A515-53G to dmi_leave_unused_power_resources_on
Date: Tue, 13 Oct 2026 14:42:45 +0700
Message-ID: <20261013074245.4327-1-krittikunwongnin@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the Acer Aspire A515-53G (Whiskey Lake + NVIDIA GeForce MX230), the
dGPU behind root port RP05 (00:1c.4) falls off the bus during boot and
is unusable until the next power cycle:

  nvidia 0000:02:00.0: Unable to change power state from D3cold to D0, device inaccessible
  NVRM: The NVIDIA GPU 0000:02:00.0 ... has fallen off the bus

The firmware ships two SSDTs which both provide power management for
the dGPU:

 - One SSDT defines \_SB.PCI0.RP05.PC01 together with
   RP05._PR0/_PR2/_PR3 = { PC01 }.

 - A second SSDT defines \_SB.PCI0.RP05.PCRP (_STA initially One,
   _OFF calls \_SB.PCI0.HGOF, which puts the link into L2/L3 and drops
   the dGPU power enable GPIO) and its own RP05._PR0/_PR2/_PR3/_S0W.
   The latter fail to load:

     ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.RP05._PR0], AE_ALREADY_EXISTS

As a result PCRP is not referenced by any device and
acpi_turn_off_unused_power_resources() turns it off right after the
ACPI namespace scan. This cuts power to the dGPU, but PC01 still
believes it is on, so its _ON method is a no-op when the PCI core later
tries to bring the GPU back to D0.

Windows does not turn off unused power resources, so the dGPU works
there.

Add the machine to dmi_leave_unused_power_resources_on, like the
THUNDEROBOT ZERO which has a similar SSDT bug. With this change the
dGPU stays on the bus and the nvidia driver binds. Runtime PM of the
dGPU is unaffected, as it is handled through PC01: with no driver
bound and power/control set to auto, RP05 reaches D3cold and the GPU
comes back to D0 on resume.

Link: https://lore.kernel.org/r/CADS-TgDQ1G8vrTQLJeQ3RTBVFTyMe0C+5p2=UBKS=EFCDFuaxw@mail.gmail.com/
Signed-off-by: Krittikun Wongnin <krittikunwongnin@gmail.com>
---
 drivers/acpi/power.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 23a4e207a..cf36dee56 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -1121,6 +1121,19 @@ static const struct dmi_system_id dmi_leave_unused_power_resources_on[] = {
 		}
 
 	},
+	{
+		/*
+		 * Acer Aspire A515-53G: Two SSDTs both define power resources
+		 * for the dGPU root port RP05 ('PC01' and 'PCRP'). Only PC01 ends
+		 * up in RP05's _PR0/_PR3, so 'PCRP' is shut down on
+		 * initialization, cutting power to the NVIDIA dGPU behind the
+		 * back of 'PC01' and making the dGPU unavailable.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A515-53G"),
+		},
+	},
 	{}
 };
 
-- 
2.55.0

