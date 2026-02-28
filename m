Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078523C4F4;
	Sat, 28 Feb 2026 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291947; cv=none; b=mSoZ3UgCe5MEwUetzGrGzILgtl4FU+s4CeEobPpwVam7dcUTEfynXGr7/T5glF+QvnW71Ic2V7TnMc0iV/rMKsSAtxkrLKkwE/0fYH5sdsrGASKJ1/oUZ1XwmxHT4hw05m80ndiWenAJ6cyi8NMYihIp++MZxIKCLf2lVBOyeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291947; c=relaxed/simple;
	bh=9wA4sRrXKbhVVReddrP2BkvqgRHsoKLiXsiay2GkiII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvie0/mnOke0sELrtFgX9nuaNY38EnBmPTvaIMgVGtRXMEo59SoeWMRXdbbqBnPDxaSFHcJ+6Z5kcELh7ig3i4ou5WAAtkAANB/9vJWz6uwbG7rB2+D3JHCfKuAh/qRdTrEO7NAZ/3G4H49ySVI034Ks31kgDUbN9+h/Pwc/bO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jECYw2Hn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jECYw2Hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239F4C116D0;
	Sat, 28 Feb 2026 15:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772291947;
	bh=9wA4sRrXKbhVVReddrP2BkvqgRHsoKLiXsiay2GkiII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jECYw2HnzLTA5rgBYAYq8uDTZIT2UlawV0oyhsDL7BZNZTw4/NlcsdxU6B9R4aIrp
	 TCupaFQr0bgX9OKJJ7Me6Hc+YTWmnUCtIGU3L5wD1bZ2BjxvMdYYdvJwyx93lPuLVu
	 bp8IL+eouRL4/KbWG5y8CVtF/i6mqzX2ricBMEQj+fsSSQ/dJ6aIyT12GSCXY8fCrE
	 QY6A4kyZJX2d49bF3eEaiCowqwmYvIFDdnFxmARBM5882DYolyq+TqXoyl87GJqz9t
	 zGXIqgX7AyLNf5iCsEc6jOCJLm7dIv1P+wnJPoeWhlRY1GwBYmWlQ7QcBVu6EeP9rP
	 ZN7Vy4ojfF2KA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 1/2] platform/x86: acer-wireless: Register ACPI notify handler
 directly
Date: Sat, 28 Feb 2026 16:18:01 +0100
Message-ID: <10810967.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3406021.44csPzL39Z@rafael.j.wysocki>
References: <3406021.44csPzL39Z@rafael.j.wysocki>
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
 drivers/platform/x86/acer-wireless.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/acer-wireless.c b/drivers/platform/x86/acer-wireless.c
index 1b5d935d085a..f44d65d97023 100644
--- a/drivers/platform/x86/acer-wireless.c
+++ b/drivers/platform/x86/acer-wireless.c
@@ -18,8 +18,9 @@ static const struct acpi_device_id acer_wireless_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, acer_wireless_acpi_ids);
 
-static void acer_wireless_notify(struct acpi_device *adev, u32 event)
+static void acer_wireless_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *adev = data;
 	struct input_dev *idev = acpi_driver_data(adev);
 
 	dev_dbg(&adev->dev, "event=%#x\n", event);
@@ -36,6 +37,7 @@ static void acer_wireless_notify(struct acpi_device *adev, u32 event)
 static int acer_wireless_add(struct acpi_device *adev)
 {
 	struct input_dev *idev;
+	int ret;
 
 	idev = devm_input_allocate_device(&adev->dev);
 	if (!idev)
@@ -50,7 +52,18 @@ static int acer_wireless_add(struct acpi_device *adev)
 	set_bit(EV_KEY, idev->evbit);
 	set_bit(KEY_RFKILL, idev->keybit);
 
-	return input_register_device(idev);
+	ret = input_register_device(idev);
+	if (ret)
+		return ret;
+
+	return acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+					       acer_wireless_notify, adev);
+}
+
+static void acer_wireless_remove(struct acpi_device *adev)
+{
+	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+				       acer_wireless_notify);
 }
 
 static struct acpi_driver acer_wireless_driver = {
@@ -59,7 +72,7 @@ static struct acpi_driver acer_wireless_driver = {
 	.ids = acer_wireless_acpi_ids,
 	.ops = {
 		.add = acer_wireless_add,
-		.notify = acer_wireless_notify,
+		.remove = acer_wireless_remove,
 	},
 };
 module_acpi_driver(acer_wireless_driver);
-- 
2.51.0




