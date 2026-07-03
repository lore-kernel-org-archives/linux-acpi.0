Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D63B4432;
	Fri,  3 Jul 2026 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078712; cv=none; b=r2JZN71CpRHkIFT04N86hUgZGfT1E4iCFg6ffHnn7vD+2eYJOtQs0N/jUIsuzR5Hck/twee7ydwYN+2sO+8PPHpJmstgoybjf4y74ekmgkGqlC2FLG4vO7j/mPqOFypMF3Xcvvktq7YEEUZx21WuWOdAATdEpLKQM7fCCKE0mHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078712; c=relaxed/simple;
	bh=sskW3GxG3TYqv1SxlRbNJJRAaPQ/QmKvCB4a18vMiho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7d35Vp96GKiFAbbo6nzsR2JRVOGmXvP66DoAIuYLIhl7jTNlUMURY3SoYjr7G5SI/KsAXCyQDg52bpwVr+UK41trUhpAHK049H4JLXbNsuxKGN4XhRoQ3btNASityHhV2bhNR2Tx0iECnsjERc0k3XJGPVskfOXWBggFGd8vgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7ivX7h+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7ivX7h+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363C21F000E9;
	Fri,  3 Jul 2026 11:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078709;
	bh=mkiVFcgZvUd4BDFRVF8wOGpqr8F8scW3yxPiFEmfJS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T7ivX7h+7G49nwBsJhChQutXBYJc5lAdsRUQY3L8NzO0spnj9CEMnxcjvPkVhVjmn
	 vk7bJII4/a81aS754NNLQxjPny/kIBedPwFo8eYoBSjSFxFgnShoN1fIveH08wMmfJ
	 Z2n8iXbUP1g7rsp157szpm6ImGnr09nT1zqUmHWZ+tS1Td0GBlatAVsXRbAgNI6WVA
	 gbEi9XyF+Qtyz8KrLo2Rrh5iflMlU9043LUWHYDTtZinTe1kkQxC5LZqLjljhtE2Su
	 WxkQdyHd3pY+LOsjFIjw019Uojk7RUulwKRi3YCr3M2yOoEM5wTyzGM8V7ebZmb7Cr
	 t3BUlQEITLMYA==
From: "Rafael J.  Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <denis.benato@linux.dev>, Jonathan Woithe <jwoithe@just42.net>,
 Robert Gerlach <khnz@gmx.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Kenneth Chan <kenneth.t.chan@gmail.com>, Mattia Dongili <malattia@linux.it>,
 Azael Avalos <coproscefalo@gmail.com>
Subject:
 [PATCH v1 10/10] platform/x86: xo15-ebook: Stop setting
 acpi_device_name/class()
Date: Fri, 03 Jul 2026 13:37:57 +0200
Message-ID: <2731795.Lt9SDvczpP@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5135166.31r3eYUQgx@rafael.j.wysocki>
References: <5135166.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The driver sets acpi_device_class() which is never read afterward, so
make it stop doing that and drop the two symbols defined specifically
for this purpose.

Likewise, acpi_device_name() set by the driver is only used for input
class device name initialization and the "EBook Switch" string literal
may as well be used directly for that, so make the driver do so and
stop setting acpi_device_name(), which allows the symbol defined
specifically for this purpose to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/xo15-ebook.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index e40e385c52bd..4c3185e2ceec 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -19,13 +19,10 @@
 
 #define MODULE_NAME "xo15-ebook"
 
-#define XO15_EBOOK_CLASS		MODULE_NAME
 #define XO15_EBOOK_TYPE_UNKNOWN	0x00
 #define XO15_EBOOK_NOTIFY_STATUS	0x80
 
-#define XO15_EBOOK_SUBCLASS		"ebook"
 #define XO15_EBOOK_HID			"XO15EBK"
-#define XO15_EBOOK_DEVICE_NAME		"EBook Switch"
 
 MODULE_DESCRIPTION("OLPC XO-1.5 ebook switch driver");
 MODULE_LICENSE("GPL");
@@ -105,12 +102,9 @@ static int ebook_switch_probe(struct platform_device *pdev)
 	if (!id)
 		return dev_err_probe(dev, -ENODEV, "Unsupported hid\n");
 
-	strscpy(acpi_device_name(device), XO15_EBOOK_DEVICE_NAME);
-	strscpy(acpi_device_class(device), XO15_EBOOK_CLASS "/" XO15_EBOOK_SUBCLASS);
-
 	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", id->id);
 
-	input->name = acpi_device_name(device);
+	input->name = "EBook Switch";
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
 
-- 
2.51.0




