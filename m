Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A04D1548C;
	Sat, 14 Feb 2026 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771085740; cv=none; b=Oyh5ka1GNT9vdOM8eBm6CRGYH0K2A+KrBsPkxZ1T7jy5EuOf7rhNuXIgsiuPlMERMg/mVZyS12qk66Q1aXXEsXeFRbt4q9/QX67qLFdbA3WBS/TXNWjstNGT8sOQsFsKfcqLhFN7SGzmBNojo7pWcI9d/4wI1r7hLSaEKa55Q+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771085740; c=relaxed/simple;
	bh=yXmVIuG2vtSrnsZnJEWSoxkWgYlWENfl+zfqoWvx+ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+niZ3OMrU3ZeZML76UeM3gTcjjHVvhBEuL34VYxnmpTvuercT1MCYoSqMBdm0gNB9m3JjWzWas7T5xYIKtcKLwBpPdRPvYrQGXAoR30/42XFMJjc2JwVuyl1S3oZt6BK7yV7eYhi39YES9yVXt/eC8WDrARXG9JPU3L+eMnOkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Xt2lzwkx; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Xt2lzwkx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=t1
	Omtm7Z3WjifG8nSb5bwSmycGi+6thW/gXZ/+jKJLg=; b=Xt2lzwkxceyAza+Lnm
	tKgpOmWUvwc6SX4XGUTcFb0i6VJ9UbxyT8wI056ADIQv8W4vi0dFmPr+b0PktpVi
	ir9bf2BCS3bNLLD5TwX9HnmwIxMLOBFnNWXI6xxwPCvyQPK0+mNxd1V9Qhg39sJ4
	S6wuKjqRePXidtXOM+rV7RhHA=
Received: from bczhc-arch (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3Zw6dn5Bpd+65Ag--.13379S2;
	Sun, 15 Feb 2026 00:15:25 +0800 (CST)
From: Zhai Can <bczhc0@126.com>
To: rafael@kernel.org,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bczhc0@126.com
Subject: [PATCH] ACPI: PM: Add unused power resource quirk for THUNDEROBOT ZERO
Date: Sun, 15 Feb 2026 00:14:52 +0800
Message-ID: <20260214161452.2849346-1-bczhc0@126.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d0785a7c-7e4c-434b-af31-4ec6f690ed89@126.com>
References: <d0785a7c-7e4c-434b-af31-4ec6f690ed89@126.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Zw6dn5Bpd+65Ag--.13379S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury7JFy7AFWUKrykuF43GFg_yoW8ZFyUpr
	s2qa98JwnrtF4UJFWYyw1jqF9xXw1vkr4aga9Ikrs3Xa4Y9F9Yyr1aqFZ5AFyYy3W2gF1F
	vF1UZr1UCFnxWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_PfHxUUUUU=
X-CM-SenderInfo: xef2xuaq6rjloofrz/xtbBpB2NjGmQn534fAAA3H

On the THUNDEROBOT ZERO laptop, the second NVMe slot and the discrete
NVIDIA GPU are both controlled by power-resource PXP. Due to the SSDT table
bug (lack of reference), PXP will be shut dow as an "unused" power resource
during initialization, making the NVMe slot #2 + NVIDIA both inaccessible.

This issue was introduced by commit a1224f34d72a ("ACPI: PM: Check states of
power resources during initialization"). Here are test results on
the three consecutive commits:

(bad again!) a1224f34d72a ACPI: PM: Check states of power resources during initialization
(good) bc2836859643 ACPI: PM: Do not turn off power resources in unknown state
(bad) 519d81956ee2 Linux 5.15-rc6

On commit bc2836859643 ("ACPI: PM: Do not turn off power resources in unknown state")
this was not an issue because the power resource state left UNKNOWN thus being ignored.

See also commit 9b04d99788cf ("ACPI: PM:
Do not turn of unused power resources on the Toshiba Click Mini") which
is another almost identical case to this one.

Fixes: a1224f34d72a ("ACPI: PM: Check states of power resources during initialization")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221087
Signed-off-by: Zhai Can <bczhc0@126.com>
---
 drivers/acpi/power.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 361a7721a6a8..7da5ae5594a7 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -1113,6 +1113,19 @@ static const struct dmi_system_id dmi_leave_unused_power_resources_on[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE Click Mini L9W-B"),
 		},
 	},
+	{
+		/*
+		 * THUNDEROBOT ZERO laptop: Due to its SSDT table bug, power
+		 * resource 'PXP' will be shut down on initialization, making
+		 * the NVMe #2 and the NVIDIA dGPU both unavailable (they're
+		 * both controlled by 'PXP').
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "THUNDEROBOT"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZERO"),
+		}
+
+	},
 	{}
 };
 
-- 
2.53.0

