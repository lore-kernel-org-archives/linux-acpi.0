Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD43A7189;
	Tue, 12 May 2026 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603813; cv=none; b=WhihbThzNuMPRImkcGzBFJ+HB/SkEF2Xa0Uvj4vMU3Rpz2VgbIa2P8FK+bZXCsBmCaYvh9CoMcfCg/U7/X0YXDiva+wBSeDU37wbtYxuMPFADMH0alopx9x7OBjRgZZLemw+cb3TXYF/e37P2fHey95j+oLBSVipFQ22CUFO/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603813; c=relaxed/simple;
	bh=9G64oPB65QzMEeLwViRLqkRU6UwkQIafbAUrXxjcKBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iv3OYGWU214fz39YBPPlKPvRT5164WaBpBensvRGhhKp6pyrrWQL+zfPKks7gMdgEIh55Berjn9vVSTJ4a4uOtumHk3PicHHE9Y6NdHM1uCI/+lbVfDVjoyCkpMSXo8NwZrPMkMwIyXpaMUQBC/QSDoQLy281Rq07Prrd+AcyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJFQafFi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJFQafFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD7BC2BCB0;
	Tue, 12 May 2026 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778603812;
	bh=9G64oPB65QzMEeLwViRLqkRU6UwkQIafbAUrXxjcKBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJFQafFiaLVU792VATCdkI5gakG+62l7a7Ur0Rl3ApmI92dO1W/5ynGjbuJP8VJg3
	 JbbNxdV5vRFqBJG38rEHa8D2bNRI8QklV3iwvJXWS+sGTWDJnREPQRytMpznkNyk1l
	 wTdk6AxHDwnSCqJEPUjC8JAVFMYDFBeXePrTnQwrKpX8i3/qEG1qGLzbwUQYiY3Gay
	 NTsTK/B+bpR3edkQPYeJL2riGezYx/ak0eo+HNDbaogMOn40LgYlodBS8SwFnxqJYt
	 dkSSuE5elV3qbM8MgdmlNuO0SANyeYGVmO2VXfxP563XFzNPhnGEN7+yBcaz4e+I9R
	 u0FwdAQLHsIzQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev
Subject:
 [PATCH v1 3/3] platform/chrome: wilco_ec: event: Check ACPI_COMPANION()
Date: Tue, 12 May 2026 18:36:42 +0200
Message-ID: <2076666.usQuhbGJ8B@rafael.j.wysocki>
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
wilco_ec event driver.

Fixes: 27d58498f690 ("platform/chrome: wilco_ec: event: Convert to a platform driver")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/chrome/wilco_ec/event.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -452,8 +452,13 @@ static void hangup_device(struct event_d
 static int event_device_probe(struct platform_device *pdev)
 {
 	struct event_device_data *dev_data;
+	struct acpi_device *adev;
 	int error, minor;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	minor = ida_alloc_max(&event_ida, EVENT_MAX_DEV-1, GFP_KERNEL);
 	if (minor < 0) {
 		error = minor;
@@ -494,8 +499,7 @@ static int event_device_probe(struct pla
 		goto free_dev_data;
 
 	/* Install an ACPI notify handler. */
-	error = acpi_dev_install_notify_handler(ACPI_COMPANION(&pdev->dev),
-						ACPI_DEVICE_NOTIFY,
+	error = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
 						event_device_notify, &pdev->dev);
 	if (error)
 		goto free_cdev;



