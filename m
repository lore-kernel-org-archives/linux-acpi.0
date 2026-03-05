Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB61FBCA7;
	Thu,  5 Mar 2026 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740099; cv=none; b=KXBondVNnRKy19FqiV1E9pP0nlnT5IkCW4n0lXfLmJ5suc3qTRZWsG9MyL90v6eCs/25FLpXCqTz0iZMe4DPnBkg421zcdnm6Bo3kglwYr/YYoOTFwd/MY/VmL4LOD/IOvla/tqdxL7pa67b6jIcBVUMvBIaHCxZyRYH/UkVmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740099; c=relaxed/simple;
	bh=Q82r9wg0x+buil6mOSMF4yHR/SO7a2zHEs98f/7HQig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1vV34cqll+wzxfqvxR0YokFnYI0zFo9oCeX1oEw6j1RDIma2Ojy54kRUzgtqrGwj3Uq3k/4j1L2sbckcCmRpXNcSEm+6F9zMxB9HZwPRdj+RIW4/KRC19Wotex0M0FiL+l0Gbq7ax12LOye48zkZe5Kxf6I/ElNzWHNdDecs2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDLCk2G6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDLCk2G6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096BDC19422;
	Thu,  5 Mar 2026 19:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772740099;
	bh=Q82r9wg0x+buil6mOSMF4yHR/SO7a2zHEs98f/7HQig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDLCk2G6+ORhm8BTd6UQ7in2x+8z3VEhybNcH9421i8nzGmOF5ztrYgm8vCNtEp7F
	 naaqmHliMpPQ1xPxZb7AfyfzgtdigrGcTiXC2tLPUhx9zVnuEBhuZn3rbYEiJWBp8T
	 aLnewtcVuORCrYB3ZgZsacBfhTzkV0NwaH50dRQ7kQcO5y2XgO/oRpJWsDsPKhQS77
	 YtphPBvGOjjHvzGWwIn2jnnI3Pnp13rFmsAhCXaWG/iPHrwWkS57U4PzPaZKcwHujL
	 sw8Bfy/lYdCK96ltmNmFhkpUKcHTwHygqM9rNuS+k3kuBRfR51PCAO3VIZ6b2bESxd
	 Jlu6xd+ieMIiw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject:
 [PATCH v2 3/6] platform/chrome: chromeos_tbmc: Register ACPI notify handler
Date: Thu, 05 Mar 2026 20:39:05 +0100
Message-ID: <3413961.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6259948.lOV4Wx5bFT@rafael.j.wysocki>
References: <6259948.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/platform/chrome/chromeos_tbmc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
index e248567c0a18..9c988e697d09 100644
--- a/drivers/platform/chrome/chromeos_tbmc.c
+++ b/drivers/platform/chrome/chromeos_tbmc.c
@@ -45,8 +45,10 @@ static __maybe_unused int chromeos_tbmc_resume(struct device *dev)
 	return chromeos_tbmc_query_switch(adev, adev->driver_data);
 }
 
-static void chromeos_tbmc_notify(struct acpi_device *adev, u32 event)
+static void chromeos_tbmc_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *adev = data;
+
 	acpi_pm_wakeup_event(&adev->dev);
 	switch (event) {
 	case 0x80:
@@ -92,11 +94,22 @@ static int chromeos_tbmc_add(struct acpi_device *adev)
 		return ret;
 	}
 	device_init_wakeup(dev, true);
+
+	ret = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+					      chromeos_tbmc_notify, adev);
+	if (ret) {
+		dev_err(dev, "cannot install ACPI notify handler\n");
+		device_init_wakeup(dev, false);
+		return ret;
+	}
+
 	return 0;
 }
 
 static void chromeos_tbmc_remove(struct acpi_device *adev)
 {
+	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+				       chromeos_tbmc_notify);
 	device_init_wakeup(&adev->dev, false);
 }
 
@@ -116,7 +129,6 @@ static struct acpi_driver chromeos_tbmc_driver = {
 	.ops = {
 		.add = chromeos_tbmc_add,
 		.remove = chromeos_tbmc_remove,
-		.notify = chromeos_tbmc_notify,
 	},
 	.drv.pm = &chromeos_tbmc_pm_ops,
 };
-- 
2.51.0




