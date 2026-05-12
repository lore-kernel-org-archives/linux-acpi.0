Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54DE3CC7FA;
	Tue, 12 May 2026 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602872; cv=none; b=MPpkPKXhO8ExN28UkwP31mYRzWF1eeBlFQs5S34Addj+mmxGb5nhBrd57kBnMO2k0hPfyVTWlbvCK8HpQQiFQbca7dNv277BaejKe4tOQfWrYQ9u4TYonRXBSuj/PEK+JNyOjLUekCP8qHItM47YNCYrUpnHi9UQM5HGyqhO7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602872; c=relaxed/simple;
	bh=8ARQKbgZvNjaDH9bNsf0q+BHMnL0oxpt8PQGP26r1wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxnGbP0LVKHJ04aw4Rp1TpJYybtxxDMGFdFpPB06lWdcRh288A9B87raVcJhDQeJwB1vb47T44B61tgWF69ip3XWn6+Y7ODpuo5DUfu2QJ13j4QmPiLOH7t9TGvrIKiVU4bg3BVhUSQJ6yNQuamPOEfF9bvqPIPP8WSvl1KB6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntAtTweD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntAtTweD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B45DC2BCB0;
	Tue, 12 May 2026 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602872;
	bh=8ARQKbgZvNjaDH9bNsf0q+BHMnL0oxpt8PQGP26r1wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntAtTweDYJ7PzEK7FZVwlMhSgUfrcfVQpTdAz7Mfq0erDa6kvVNyXRzYyXVEdlejh
	 mxXBKH4ziNxlxa1Gb1Qr0PbG4I3NbqxxFS6/BieNlO0d9cNGQsJ9RYIwOSlu1Epnew
	 OTksl0cpkr1+rNYyjR6eCiwcCm6TVLd2qU7FSuh3W3K68o48vedG6BznDaAf/Zn6E/
	 K106o7+qgqRAqCZh/qnd3hHO9u6mCeR37AD65SfmLoOtEVDskjZYF7Feoo8aep4NmP
	 BeADZGv+dxNKjrOoMjd+NGJFnJsDlyQNSqn0eqa0JuCaeb2xsd33hz+IiGzTBz8JZo
	 1pF57NIpPJDMw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1 2/2] sonypi: Check ACPI_COMPANION() against NULL at probe time
Date: Tue, 12 May 2026 18:20:53 +0200
Message-ID: <5087721.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6283162.lOV4Wx5bFT@rafael.j.wysocki>
References: <6283162.lOV4Wx5bFT@rafael.j.wysocki>
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
sonypi driver.

Fixes: 7e488b0af021 ("sonypi: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/char/sonypi.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1117,7 +1117,11 @@ static int sonypi_disable(void)
 #ifdef CONFIG_ACPI
 static int sonypi_acpi_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
+
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
 
 	sonypi_acpi_device = device;
 	strcpy(acpi_device_name(device), "Sony laptop hotkeys");



