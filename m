Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58583DB318;
	Thu, 21 May 2026 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372742; cv=none; b=LMY3wjtzdhE4IjzlPsBXdUDbTvYZhX4q7DI4UW3L7uIgnRNc1y4Uopl8fq6dtCJAeKUQw4iRIFfHlhODzebzoTf1nvF+Yp1vmO1hnxqZ0ML2NIWWvbCdxI27nbryebZa9Ho5NX3lmeXqp7yP5DsbIIonwoDquzNBY6cxGwN2BdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372742; c=relaxed/simple;
	bh=Bcu0JrIq+ElngJgtztTQJO+QyM5X98LM2t8mPLwBK9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IznrIdBGWO6fe4sMIwbfpAMVmUJ4HdnUvvtLghTZwWa6ALUI3A093kb1nb2DSZyJ8z46H+dua82+SDrLhQWYMytgxCglBKjou2XUZ6+/r7vyZwpt/CUfeJeoee0WKhT981ls2QcxZwPZvb/g8u1ubw9egLNmkVL+WCjosGLqagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChR9RPCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChR9RPCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD381F000E9;
	Thu, 21 May 2026 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372741;
	bh=DfkgF74rOTMy5HnJaRBntCYZklGLpqiu8MCcY6kL5A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ChR9RPCMhDTjYr6wpaxR/pRMBqJWHWzw+SFja5xh4CTqQxYFSOp78IVVW5qFeKMZ1
	 QEpaAzivZ+GAMqVEnM7TYD0mSgQSbqkTWNGwLF8fdKI6xw0e9LDR9vvYzUp2VtjJy5
	 FJc558Uo07weIn36kzm8K0QGB2x3LoeNeiPcD4HkZa83bCopI8QmoOeKofQr2JGfqy
	 IH2qUdYUFROEFCaILIrBbpMCoK1fDJm2a4Yxu/Yd0sC4h+390oAcwN9hiuydJakDV6
	 D9s80GVhzWByywly0x82binWOFqkRCVvSyZ9mRQ4RxlQaoo5tsIZ8mUVdWr4IE0ThW
	 9yZryS6BwNg6w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 09/17] ACPI: PAD: Pass struct device pointer to acpi_pad_notify()
Date: Thu, 21 May 2026 16:06:05 +0200
Message-ID: <1862521.VLH7GnMWUR@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4739447.LvFx2qVVIh@rafael.j.wysocki>
References: <4739447.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Use the struct device pointer to the dev member in the struct
platform_device object representing the platform device used for driver
binding as the last argument of acpi_dev_install_notify_handler() and
accordingly update acpi_pad_notify() to pass that pointer directly to
dev_name() when generating the netlink event.

Since the dev_name() value for an ACPI-enumerated platform device is the
same as the dev_name() value for the dev member of its ACPI companion
object, as per acpi_create_platform_device(), the above code modification
is not expected to cause functionality to change.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_pad.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 91d32da76f8f..b0a6723fb854 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -407,15 +407,13 @@ static void acpi_pad_handle_notify(acpi_handle handle)
 
 static void acpi_pad_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *adev = data;
-
 	if (event != ACPI_PROCESSOR_AGGREGATOR_NOTIFY) {
 		pr_warn("Unsupported event [0x%x]\n", event);
 		return;
 	}
 
 	acpi_pad_handle_notify(handle);
-	acpi_bus_generate_netlink_event("acpi_pad", dev_name(&adev->dev), event, 0);
+	acpi_bus_generate_netlink_event("acpi_pad", dev_name(data), event, 0);
 }
 
 static int acpi_pad_probe(struct platform_device *pdev)
@@ -427,7 +425,7 @@ static int acpi_pad_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	return acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-					       acpi_pad_notify, adev);
+					       acpi_pad_notify, &pdev->dev);
 }
 
 static void acpi_pad_remove(struct platform_device *pdev)
-- 
2.51.0




