Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2B38BF6C;
	Thu, 19 Mar 2026 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920022; cv=none; b=dypCWwQsinpAlEsHcGbVIZokT5A7dj3vEVA1HaH/YMih071ylRP0zhVPXlP6oQS6zwfPXQpu7g6uzivdyE2OzOi3cMU8j/VLnKSCY3DtAKat9GV3ZI3q+evl3pxZvL8Ll+lKO+f4Qvt0O8QZAroaog3xiei3AdVJpE3o8alO4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920022; c=relaxed/simple;
	bh=HmtlJiVGVW00VjMg4kccRWBVLs7CI0yBIlexAK9e1G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoFssxB4b1fEBdf7eaQTTRolWB1cTlB3BZxNsIHE7au8ioXl8EClyh5jSyeXAQ074rysJsPe2RzgGf2uBiouXr7huBXTo8N/XgzniLv865AW0OSu3tERGD8Xz23Rsm2KenjXHdO7oCpDMDTdrWoT0Ljsf6rN32nczJkravaW0zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3vlR9py; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3vlR9py"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DBEC2BCB0;
	Thu, 19 Mar 2026 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920021;
	bh=HmtlJiVGVW00VjMg4kccRWBVLs7CI0yBIlexAK9e1G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3vlR9pytbRAsbvy3ng1eacWJ3qZJNvnUKtwLtdAMxwNHQk8MHxkjUgwGDDax9fyZ
	 xrRFd5f+xFl0T3P5BDvxMQw59J+HEM8xrq84Zpupp3YMDqR7E1wCUe59o9/LjfYLeU
	 KKfCL+04jZLA/mVCek1XMOu/SdPs8MOqsLxCAqM2yrZn4FPKzYS9ohAT4ysWO1YocV
	 Fe5iCBYLk1IMZXK8XxCGXdt0FSrU+KN3SSIFhtKRx3GH1YzvLmKcxFhPVDTh+xaWw2
	 +c5SKMQG8uDGZwGkiN4oZ2JPlBQiZdGLzNv1OfrHC0OsOdCVuQVvx7Bm3oBLnPr4gX
	 Cc0IzH3xAaCnw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v3 2/5] platform/x86: panasonic-laptop: Fix OPTD notifier registration
 and cleanup
Date: Thu, 19 Mar 2026 12:28:33 +0100
Message-ID: <2262785.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12863246.O9o76ZdvQC@rafael.j.wysocki>
References: <12863246.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

An ACPI notify handler is leaked if device_create_file() returns an
error in acpi_pcc_hotkey_add().

Also, it is pointless to call pcc_unregister_optd_notifier() in
acpi_pcc_hotkey_remove() if pcc->platform is NULL and it is better
to arrange the cleanup code in that function in the same order as
the rollback code in acpi_pcc_hotkey_add().

Address the above by placing the pcc_register_optd_notifier() call in
acpi_pcc_hotkey_add() after the device_create_file() return value
check and placing the pcc_unregister_optd_notifier() call in
acpi_pcc_hotkey_remove() right before the device_remove_file() call.

Fixes: d5a81d8e864b ("platform/x86: panasonic-laptop: Add support for optical driver power in Y and W series")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Do not fail probing on OPTD registration errors (note that it is
   not a bug to attempt to unregister an ACPI notify handler that has not
   been registered)

v1 -> v2: New patch

---
 drivers/platform/x86/panasonic-laptop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index a481f2602ce3..56b4e61d7e5c 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -1090,9 +1090,10 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 		}
 		result = device_create_file(&pcc->platform->dev,
 			&dev_attr_cdpower);
-		pcc_register_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 		if (result)
 			goto out_platform;
+
+		pcc_register_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 	} else {
 		pcc->platform = NULL;
 	}
@@ -1126,10 +1127,10 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 	i8042_remove_filter(panasonic_i8042_filter);
 
 	if (pcc->platform) {
+		pcc_unregister_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 		device_remove_file(&pcc->platform->dev, &dev_attr_cdpower);
 		platform_device_unregister(pcc->platform);
 	}
-	pcc_unregister_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 
-- 
2.51.0




