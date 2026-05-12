Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466C3D1AA2;
	Tue, 12 May 2026 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603818; cv=none; b=t7M3hGVXJnWVg69buVCCJDar070lu5arr0p2vp8aDFl5OJpLw9pQIiaamdLa7hgjnqFHhvqA308tgiyY/mVsF76Jbo6eG9K6YBgENbCqOfjrYWk48yNgO+lUP6L/irwmSgKsORuLzk/3nMO0MJohDXwoRS8n4gYSM5iV5PvWkj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603818; c=relaxed/simple;
	bh=HaZfBFzSuj0FeFH/u00lJi5H3h6ewp7MHnsrS2lTmf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=je6y6tVoNJUNR1Bu9uJ5MiK/iKq7bZ1XV3+mY32yWdtQlhVJAxReRH+WVC4Ea/8D6ntTMgXXz19en9rQErF1w2cKN/k/iH92D0Vly9UT/NCdvcKqtq+3RJHwdb/ZM2E7G1VUcc65WjbFHtafARUj5hcU+zVbZbIwYO9VmdwUuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcOQv53G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcOQv53G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76544C2BCB0;
	Tue, 12 May 2026 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778603818;
	bh=HaZfBFzSuj0FeFH/u00lJi5H3h6ewp7MHnsrS2lTmf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcOQv53GaKWnKJ0qz9+52/NZS5Jq8ljtwMJXR9fTn5vbCSeLrUzEuyCqFEVSlLunT
	 LKo8n0vaSOYKFPeDtgbfrwmxcNgm1qeUAPlzzRm8r8H4Gh2VNh69rx3yWrmGwgOn7U
	 6QkKc4YvnlrzIGJwDEGryUpTl8/pBe4/ajR6l+lucsdPIsjsuAHpeTr8Bhb+8lMDao
	 zV61wsdIIAMPZgqtRd7GR7+ekYBBlIlRYKshjMUXJ/xiCl0epzBholmAnEE10gxjg4
	 i5uynSQhxf2Dej+hRYSZWlwUgTjKneMChxphWbqxMADLOqotYTJkbrb31v9e27fdvo
	 ki0K84cmZgB+g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev
Subject:
 [PATCH v1 1/3] platform/chrome: chromeos_privacy_screen: Check
 ACPI_COMPANION()
Date: Tue, 12 May 2026 18:35:20 +0200
Message-ID: <3357444.5fSG56mABF@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3710526.iIbC2pHGDl@rafael.j.wysocki>
References: <3710526.iIbC2pHGDl@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
chromeos_privacy_screen driver.

Fixes: d3c2872ae323 ("platform/chrome: Convert ChromeOS privacy-screen driver to platform")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/chrome/chromeos_privacy_screen.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/platform/chrome/chromeos_privacy_screen.c
+++ b/drivers/platform/chrome/chromeos_privacy_screen.c
@@ -104,6 +104,9 @@ static const struct drm_privacy_screen_o
 
 static int chromeos_privacy_screen_probe(struct platform_device *pdev)
 {
+	if (!ACPI_COMPANION(&pdev->dev))
+		return -ENODEV;
+
 	struct drm_privacy_screen *drm_privacy_screen =
 		drm_privacy_screen_register(&pdev->dev,
 					    &chromeos_privacy_screen_ops,



