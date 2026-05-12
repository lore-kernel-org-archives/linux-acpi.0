Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B73CE0BB;
	Tue, 12 May 2026 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602876; cv=none; b=t9IYLSF/56MyvElqTiCX/Q9t8gwk+6BQfM21h12u1mEhBmt2l0t6WQO7JLbEUiIyYYSY7lI3agJv17bnwiMxGEAWuQHIASEGbHD6NisZuUTQSfFLP7mf0MCQBe3bkf7UpwcsdiOAUxjMXSEvZfYVaTa/POntXxvvX6zIkFCbukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602876; c=relaxed/simple;
	bh=KskKx3Z8rOZDF3v7FHwcbg+BE8AJnnEY2XiEW8kwJ4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+wFEI25e4z3FFaX9gkGgAL+AIBSEB7vSmFwdQmp8/glOA+ZxpgQGJ3wLQrJZS/xg6fGakJvj+RBUWQe6t9FYJi/Kj/fcxkf/lqbdxbhCce3BccuctWHb6uPxK20IpMeVuTHWfRKz3IMnFzq/+28C9ffMVFkQcbnCXp306fcGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNjlKqVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNjlKqVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73801C2BCB0;
	Tue, 12 May 2026 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602875;
	bh=KskKx3Z8rOZDF3v7FHwcbg+BE8AJnnEY2XiEW8kwJ4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNjlKqVLW+42TH8uqWn2ryK/wCYCTv3K1Bbum6LzvtQpq4xYTYiIykqBs7ybwdxYM
	 EWN/51szDhW7l1ydAY9qfcFXpovAJLT5tRV81wxC9LxHEn9eWynzWC+FQeJRgU73ip
	 EPfaPT6uqfmYs/1D+U+mwZx7JOH1Mm80BIRL/JqNjWAiaf5UVcRxf8uu97h2CbTZrC
	 353O/q3omwnYI7JzR+KzAqBC2mm9KqfPNf3a8RwExCCTdnOd+MJOgUPXt5PGuvRDZh
	 pZ9IoMSa4rCwNpQQkLjD7olZ2h59PRDZOgjtj4u6e3OET2QRmzjWLdLUJGkYnTkJ4s
	 XBdIL9bBEGWGg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1 1/2] hpet: Check ACPI_COMPANION() against NULL at probe time
Date: Tue, 12 May 2026 18:20:09 +0200
Message-ID: <4750803.LvFx2qVVIh@rafael.j.wysocki>
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
hpet driver.

Fixes: 71f0a267346b ("hpet: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/char/hpet.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -976,10 +976,14 @@ static acpi_status hpet_resources(struct
 
 static int hpet_acpi_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	acpi_status result;
 	struct hpet_data data;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	memset(&data, 0, sizeof(data));
 
 	result =



