Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1054145E
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705473; cv=none; b=Aa1p7wUQuhfikjspvjGWYmOfA14WkHH9J1X/PS2tJ91gNOUS9JTgz++mfs8m3C7Ohm+5+B6G/eVNZnA6P99zIgy59ZCUS7RZK9PYpeYb7duVDibyJwgDWaHlTwyvbBwMCxeHb623W0rXCEAyb4LaGGKpR7bzyobG59F1kl9Nqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705473; c=relaxed/simple;
	bh=bFC+TshhTmM0v4253iAy7r1VYxcLXC8treYolVAgLgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pRMWny0uAlQNg9lE4EmZLdnWazFw+d0ZH0IOaaNSn4mhE6bUNBcv4Y3uO09B8JwdatILruiIB8xkLT+QqxrizNW9GJuKWlxuFUZ7N4lse1ulCoYL+cQWB1LQUmoFXk86KOe8DB150Eft/nQffNa8SYArdb8XUVK04HX+hYu/Gi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2QO3N/y; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2QO3N/y"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd412cfso1726350a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790705470; x=1791310270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Civ9zmYjZCgx8nR3DY84Bu2yh9FlAvluUU+pFA8atcM=;
        b=r2QO3N/yy1gTU4TdtEND5KbMyxGJaaa0GqoLLmfW2PJYZO9FiqOjXHKNeioo/SEya9
         69YO68PyWk0FV2blPUiLJFmO6tDGKTxN9YnVnxtaQ4JvQTRnadn8BhHRJJ9RiUrdQea4
         69TSf9aLC0Xc8o9vt5tJOnK4lmJCFG6ILmO3xarxX172BR43Kuk8Rb188/oXYz8arUDb
         xW/u+E88awQYcahT4aVnyiAWbBWzJ90LZ8ZiOYLJOx8v2dV2niffUHSVmLyPM3Siip7U
         IKX1FCl5iL/nMSfORbJPxzS6APRi+1JCopuQaAZDFSG9S9wYAFTLGxfY9mEVfWluStkJ
         kYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705470; x=1791310270;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Civ9zmYjZCgx8nR3DY84Bu2yh9FlAvluUU+pFA8atcM=;
        b=dIDXwGB7buQkUPYOeKUx2msr4k58YQK0vL13vg1MYIfqvRWcSzgjerB1IrldNCDxXG
         O4GLot6n7lvoFRTWtSPCFNeUjDpwp/fkiw2TIqdAmFLdsWycSCxEWnA2ElznymfMXKp6
         MH5G5YRzamiZRBF7ybZaJe03g2aMpJP/FfN3m/UK75Ar6uvSALd1Ij+whV5d0sOa++sL
         MIrXyDBHS1y0p0dfvFrT+x8uDRLiPHJrfGxk7Kc5TK97sD7hd4crPEfu+HPTT8zFJrTk
         Gfkfzx2UoZcIpyUCakGKjAhwP84u80vHWYt/wmDuq+SSGoa51QCBhgFRKxjxMFP6UsA9
         7OFQ==
X-Gm-Message-State: AFq9FYKqIsFYFTmMWXKRrHZgkOkHHowme3+3llCrcTZsFsNsnOK5rJWO
	eHeGfvHOfZmE10bLMtKguI2vFibWGb3PvwcnkzhnCLP2WM7lSTVRJx5+
X-Gm-Gg: AYBFou2QA9IA4wZd1W9Q/YwFsf3gjtI8zywVL5OTxA77TXK/YWjUGb9Sx6B4iPEUKwi
	7ag4fvT3B2hFDGsIg+GbVQrCg+rYepMREnVTyVf5WgbpAegJ4jKwAKSZ7BxJ35hDk62D8zRN/Sr
	Ddh7Zkp/ILRPefAvJ78sArufQjxEh0T1d4k3wjGCbp9xgbpv41bALIBSWwIwjwc5CLeYWeF1918
	artyTySHeSMM1lmDtEDyv0unI2UlDOJ4r/6EqtcL12x7KnmtT/+RPGX+3ZQ3tNjHU00s16T9OhM
	7BewUxHoG7ebmG7PnkfZupGKgO/BOGL6tPhPeR/Sn00RA1A31rtKLE5mBKDa39LGSBKxHLYtye8
	zCmn7Tz87Pj1gIrljXitltdA+I4C8gRU8Mw+Q4jscLP+IOaX7k4K9khmCgaZDvAP6/GVZcLY3Ht
	lPEm7DClODMvHoZq1jjGqbWrIDlcIxSIz+ixYc4zdeASzYCCXk3zfsZ2jPrIOGHONY/d7wVnfoM
	w3pPfpi6OMHih726vYdhACsNIlIA9mK6AEh8rYOZ50mkUIyQ5hKCTsA9VxulaSV
X-Received: by 2002:a17:90b:4b87:b0:3a0:c13d:8b2b with SMTP id 98e67ed59e1d1-3a4bfedd2fcmr109934a91.33.1790705470160;
        Tue, 29 Sep 2026 11:11:10 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986a1910sm6914590a91.14.2026.09.29.11.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:11:09 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] PCI/ACPI: Remove Hyper-V special case in pcibios_root_bridge_prepare()
Date: Tue, 29 Sep 2026 11:10:56 -0700
Message-Id: <20260929181056.4746-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcibios_root_bridge_prepare() currently has code to handle Hyper-V
guest root bridges with the sysdata parent field set to NULL. While
this special case existed when commit 7d40c0f70d92 ("arm64: PCI:
Support root bridge preparation for Hyper-V") was accepted, more
recent commit 8d21732475c6 ("PCI: hv: Propagate coherence from VMbus
device to PCI device") always sets the sysdata parent field to a
non-NULL value.

No harm is caused by leaving the special case in place, even
though it is no longer needed. But in the interest of overall
code cleanliness, remove it.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
This patch does not just do a revert of 7d40c0f70d92 because
an intervening commit moved the code to a new source code
file.

 drivers/pci/pci-acpi.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 42d545edd7fa..452a90317c58 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1572,17 +1572,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 		return 0;
 
 	cfg = bridge->bus->sysdata;
-
-	/*
-	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
-	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
-	 * NULL in this case because there is no proper ACPI device.
-	 */
-	if (!cfg->parent)
-		adev = NULL;
-	else
-		adev = to_acpi_device(cfg->parent);
-
+	adev = to_acpi_device(cfg->parent);
 	bus_dev = &bridge->bus->dev;
 
 	ACPI_COMPANION_SET(&bridge->dev, adev);
-- 
2.25.1

