Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6501FBCA7;
	Thu,  5 Mar 2026 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740070; cv=none; b=n+vtlygm4GI8Yb4P3fFFIfvuvKnygoXFyhrbg9/SDg3J36P3NDLKtukJwxlWpiMvQ8Pr6oBYsxqG1SstZYqWCFkt+5c0LLs30SqDl5MVkp17UrfhxVgVYNORBRNFzl5A2qHbxrZ/b7dg5PVIhNIxxlM5tl+uW3Jqv5KwFJYg/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740070; c=relaxed/simple;
	bh=8f8Och5LlB1/S5AD7hi0oOFLMTyjXfHfvW0l0WXrifc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiDLwxxH9l9CGKhiUo48+BBDHreSm1yenfUqF8kWrD7mEgyuwqwUQ6lv0gp+d+487/1ANVQbW1tQIQ1KU7rwBUBElpxrRdVSpRDUGioOjFooFcxRT47NXLQWw2EShih+NYe1h188uH/qUfZYJqe+5+Gy0FOWbh1T4ZaIVRUQep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn8o7jM3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn8o7jM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ED8C116C6;
	Thu,  5 Mar 2026 19:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772740070;
	bh=8f8Och5LlB1/S5AD7hi0oOFLMTyjXfHfvW0l0WXrifc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pn8o7jM3KK41tIPB4HSR7/vfP/Zz+dET6BoBPDo5NP3TDWmmJnBgzYqwUH18wuCBB
	 efgjMXzMxYbj8przJt2WHuzBqr9A061dl7R5dwvJw5Bm+uta2Az4Nz9jFhH+l39iuj
	 WBtuaT719QfEIR8c+obLfm1aDFZjvgG48d82WGBySmpSp+BUw72DlyZQvYdRnY0F6w
	 d77ogvLLw+YNqovfEPnoqk5rivwXlv8X4THUI85yoogUkQiyU8UbkgskqxHsEYb1dz
	 +oYeUhwJ+68dP0fZxRlQgdAl2Lx/mgofjiiScj6V7OeE+p7vG5wrxCkxrAWfyUI8Mt
	 L9XDnCmT8kCdQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject:
 [PATCH v2 2/6] platform/chrome: chromeos_tbmc: Drop wakeup source on remove
Date: Thu, 05 Mar 2026 20:47:03 +0100
Message-ID: <6151957.MhkbZ0Pkbq@rafael.j.wysocki>
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

The wakeup source added by device_init_wakeup() in chromeos_tbmc_add()
needs to be dropped during driver removal, so add a .remove() callback
to the driver for this purpose.

Fixes: 0144c00ed86b ("platform/chrome: chromeos_tbmc: Report wake events")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Fixes the Fixes: tag (Tzung-Bi Shih)

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




