Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845E3D75AE;
	Wed,  4 Mar 2026 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650001; cv=none; b=cdlCZx/hpg/Yxip6tssv7ZUjsctlp7VWM4CcLeFfiojSXYmFUabwv+h3zSorqzCozGWYSIY1miJX4OtlMJH2ouaQo51X6TbXbabbvi59HFmMcIwAMgHKne/+2kVl4IG0qg/lDBaIY4UAdalDkDP66jm13WdrFVMuMx/lcddbqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650001; c=relaxed/simple;
	bh=nNoBZhqpwYqpHR7ReRlpFs3+Q4ZLEDIzWp4Hf8F7jhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGo8qU0DSDPk1VabnmUmpb/Ls8xfrAC4avn0EI7rMXt2M/FVGVdrz76jt2mjqQV/6u5qwgSL7fa7BeY1hbWaEaJPjjlkrDQmAuE5J3K9YK+E817C2697GK49GGtRGHz3zT2/UAMvFUKUncUvIUSb2LiTGx4ndYFpScTmaRDWKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAJKOtJj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAJKOtJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD826C4CEF7;
	Wed,  4 Mar 2026 18:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772650000;
	bh=nNoBZhqpwYqpHR7ReRlpFs3+Q4ZLEDIzWp4Hf8F7jhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAJKOtJjYSTh6ahHTUGXW7wkcZ5yaBKRKt6h9HY26GNYWTs6gY7e7+/1WaFKwkUK0
	 69fmF96gY8EeBJO6wb4LN2xEZ2CopQ6+lHBY4sS/uLqzgIXdciJjcuwtX6Sefi81eq
	 zDDSTA0BbZvR9LFUD7lxCORKXCowZwfMjn8S1OWHGGvH389OEbYp4JfvqEyT0Q7vhL
	 mT3/OanI0NsTo95viESg+3VHx1zlpA1gx7IZEBrPir6AW9V8Z6mZVLv8x4bqejFTI1
	 CNAS0encdLuvN6npvYWKsKK8YSUlBD0Jahgp4LA2jf2AaQPKoSbGPTx8RYWK2ZCHMh
	 F76WYDgZKxDZg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: chrome-platform@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject:
 [PATCH v1 2/6] platform/chrome: chromeos_tbmc: Drop wakeup source on remove
Date: Wed, 04 Mar 2026 19:43:05 +0100
Message-ID: <1931894.atdPhlSkOF@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2274474.Mh6RI2rZIc@rafael.j.wysocki>
References: <2274474.Mh6RI2rZIc@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The wakeup source added by device_init_wakeup() in chromeos_tbmc_add()
needs to be dropped during driver removal, so add a .remove() callback
to the driver for this purpose.

Fixes: 0144c00ed86b (platform/chrome: chromeos_tbmc: Report wake events)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/chrome/chromeos_tbmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
index d1cf8f3463ce..e248567c0a18 100644
--- a/drivers/platform/chrome/chromeos_tbmc.c
+++ b/drivers/platform/chrome/chromeos_tbmc.c
@@ -95,6 +95,11 @@ static int chromeos_tbmc_add(struct acpi_device *adev)
 	return 0;
 }
 
+static void chromeos_tbmc_remove(struct acpi_device *adev)
+{
+	device_init_wakeup(&adev->dev, false);
+}
+
 static const struct acpi_device_id chromeos_tbmc_acpi_device_ids[] = {
 	{ ACPI_DRV_NAME, 0 },
 	{ }
@@ -110,6 +115,7 @@ static struct acpi_driver chromeos_tbmc_driver = {
 	.ids = chromeos_tbmc_acpi_device_ids,
 	.ops = {
 		.add = chromeos_tbmc_add,
+		.remove = chromeos_tbmc_remove,
 		.notify = chromeos_tbmc_notify,
 	},
 	.drv.pm = &chromeos_tbmc_pm_ops,
-- 
2.51.0




