Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0963B1EC8;
	Tue, 12 May 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595565; cv=none; b=TzDJmuRsCN0gNwI7rOuShNbEYLer49hqq2PYyZWyhIBDq0eztlzuxJ/ZA5cRpdNmhgpqgj+B9DbTncg8CKwe98UGiErx4B0R86C5pINvTMOik5m0Qmq+rP+G2oSgZn1Rnc5sONN+Rc/B+5GjaFrzsHDGaamg8y9ef+7YxxM2hDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595565; c=relaxed/simple;
	bh=jKCNqnqrMcs8HpiAmusRHcEnRsqJjCrqRerGX4HePrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBboAloDiGYno25UaY5OPLXFuulBv3pSj0DgQhGy1ehA4wObHruYcovfw95IvJmW+htOMFdBnUItJRWURijRSMhjE9n1UZJo56vibt2ch6k3M5oGbbyG9gMrQMKBtDTSh/RCTX0ZY3XLXS4fybRt+nyfIMeYog/1vge69sBoiB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/tBTFPt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/tBTFPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123BDC2BCF7;
	Tue, 12 May 2026 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595564;
	bh=jKCNqnqrMcs8HpiAmusRHcEnRsqJjCrqRerGX4HePrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/tBTFPtsdS6RoXYOhTBKaawAy1xNH7xORpwqtNcVb2vx+tf1m/RS5D77rwYK6fPD
	 SMJm0PeWB50tCh3N+0ahiBqq7mNx/DESEhI9VV+8vGjzXQL5ruKfQP42Wf5aOHIcGS
	 2+PI8C61TaT0ybtdoBTGdaKSMTdK2U487WfTMj4vZy8+PbDYB3LTV1nWbOcQu4lbQQ
	 7EnUWtHJ5XhFmLQLS3WwAFCOz2PSY+n7WRncMe+/Rk9CWF2WMc5q60RSzr5x86ik4m
	 75cE9rEFwmpr9fkPVpr7ZhZSD3Q6MIOR4WtbBjAHKWHLFBm3USxJkNLoI5f/4mFIlv
	 gnw9BHxpxqOag==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <denis.benato@linux.dev>,
 Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Jonathan Woithe <jwoithe@just42.net>, Robert Gerlach <khnz@gmx.de>,
 Matan Ziv-Av <matan@svgalib.org>, Kenneth Chan <kenneth.t.chan@gmail.com>,
 Mattia Dongili <malattia@linux.it>, Jeremy Soller <jeremy@system76.com>,
 Azael Avalos <coproscefalo@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v2 01/16] platform/x86: acer-wireless: Check ACPI_COMPANION() against
 NULL
Date: Tue, 12 May 2026 16:03:21 +0200
Message-ID: <4746824.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12904885.O9o76ZdvQC@rafael.j.wysocki>
References: <12904885.O9o76ZdvQC@rafael.j.wysocki>
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
platform/x86 acer-wireless driver.

Fixes: f7e648027d7e ("platform/x86: acer-wireless: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/acer-wireless.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/acer-wireless.c b/drivers/platform/x86/acer-wireless.c
index f464b13a58af..fae8e5ad0f97 100644
--- a/drivers/platform/x86/acer-wireless.c
+++ b/drivers/platform/x86/acer-wireless.c
@@ -37,9 +37,14 @@ static void acer_wireless_notify(acpi_handle handle, u32 event, void *data)
 
 static int acer_wireless_probe(struct platform_device *pdev)
 {
+	struct acpi_device *adev;
 	struct input_dev *idev;
 	int ret;
 
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	idev = devm_input_allocate_device(&pdev->dev);
 	if (!idev)
 		return -ENOMEM;
@@ -57,8 +62,7 @@ static int acer_wireless_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return acpi_dev_install_notify_handler(ACPI_COMPANION(&pdev->dev),
-					       ACPI_DEVICE_NOTIFY,
+	return acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
 					       acer_wireless_notify,
 					       &pdev->dev);
 }
-- 
2.51.0




