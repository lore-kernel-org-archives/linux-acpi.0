Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5039B952;
	Thu, 12 Mar 2026 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315052; cv=none; b=F5Hc/9AtOsVwtAk+jC369qU6TdLx8vBPZf1ny4dgkEMmujSB0QOKQO5256A4ruXX04G7oGhPgCOKhGbJuO9UZVa2hxn6TLmchaOoyo6PGB0W33cabDDxQ7IHGoAm2T4IbF1R7LAjhecYFneNBptMHxRZECAXSKC0j3K9oWhqTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315052; c=relaxed/simple;
	bh=VxkNQSbGIQJmKyxNvV7elLYc3cA2yXB+GSllmSqKAqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnM11rfGznlk5YoxWAXOCQ7dkgP6MriTpTo5KwArWv+/fFrDb9lPm1r49X2rhc21vBEUC4v4CkrZn/WyHtyrJxpBP1ImdYhkZHe+LawEMBXExGpOAJk+o06c9kFMTAaK+1Iy3xB8WPD4XYDMtkVjHFGbdGqfHk86m6Xhu3t/BkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mylRoa2S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mylRoa2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FF5C2BC87;
	Thu, 12 Mar 2026 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773315052;
	bh=VxkNQSbGIQJmKyxNvV7elLYc3cA2yXB+GSllmSqKAqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mylRoa2S+J0+HZ/EXRw87szmwVzLOEBejlQwfwQe3ZKHXxFn7hT7Aj0mC4BX/1f0/
	 5bDgIOMK8nFAflvXRIe890KFgIED8JEMlOduhHpoIZ/wx7bjwozWt3cFSrJ9aZ4xau
	 d5ZL9oyJDEQSPpaHggToo1xzXNgqfVELuP5seBxDFC5RgA6ne8OMeh6+9iemTaEiVR
	 8Cj34qmemfi3ZUtECR/NO9IMnvup6mVaWp71gY5Z119TW1RxCLvUGcQQflXHrETV+J
	 D1k4kIVg9VIyIMdoDYOH1/9TNa7rHqdIlsRS5zjwI0dG+X/KsV0byRZV8QMUiZ2+sZ
	 w6Bw8nZ8aZ63Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Mattia Dongili <malattia@linux.it>
Subject:
 [PATCH v1 1/3] platform/x86: sony-laptop: Register ACPI notify handler
 directly
Date: Thu, 12 Mar 2026 12:28:52 +0100
Message-ID: <2559802.jE0xQCEvom@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2284006.Icojqenx9y@rafael.j.wysocki>
References: <2284006.Icojqenx9y@rafael.j.wysocki>
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
 drivers/platform/x86/sony-laptop.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index d3e7a52c22a7..6f417b5cdfe2 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1176,7 +1176,7 @@ enum event_types {
 	KILLSWITCH,
 	GFX_SWITCH
 };
-static void sony_nc_notify(struct acpi_device *device, u32 event)
+static void sony_nc_notify(acpi_handle ah, u32 event, void *data)
 {
 	u32 real_ev = event;
 	u8 ev_type = 0;
@@ -3244,6 +3244,11 @@ static int sony_nc_add(struct acpi_device *device)
 		}
 	}
 
+	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+						 sony_nc_notify, NULL);
+	if (result)
+		goto out_sysfs;
+
 	pr_info("SNC setup done.\n");
 	return 0;
 
@@ -3270,6 +3275,8 @@ static void sony_nc_remove(struct acpi_device *device)
 {
 	struct sony_nc_value *item;
 
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, sony_nc_notify);
+
 	sony_nc_backlight_cleanup();
 
 	sony_nc_acpi_device = NULL;
@@ -3304,7 +3311,6 @@ static struct acpi_driver sony_nc_driver = {
 	.ops = {
 		.add = sony_nc_add,
 		.remove = sony_nc_remove,
-		.notify = sony_nc_notify,
 		},
 	.drv.pm = &sony_nc_pm,
 };
-- 
2.51.0




