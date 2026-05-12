Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C3D377007;
	Tue, 12 May 2026 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599009; cv=none; b=LajKyLEOwQ1WtrvEaStsORGjiIuY6303HBhjZq/YqJJnyk0xzeOpA3OUataNMAozgqA5ggkAavvHaWXAXS6YGSOu3m2mbn82KtqBUkbLoU6InOT1LOWc35DGktXPAYQnoC7UqgXB3OYDXaImxDF0Yt2t0V3Myqyzvxpjy6qVxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599009; c=relaxed/simple;
	bh=01H42Jexe5aI+uHOezmQoZgnB9LnnOxFJhgAq0Km7D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSwr67Mv6j8chCbcZKmp8qqgPBnLvBcBseoWGFd8qqMimz2a9WnW5fka9Ot8cuuaxFIGbHJIz6ZrUSqCJ3Cveo9Ry0/yK6QfvCZqmxi1gUyah4LWoKb3zQCPWvb4L9DKY9+BMYn54r+zd+L2afRSfg9OI4rKkomVN7QdfHtsRsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPxYG9UJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPxYG9UJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6526BC2BCB0;
	Tue, 12 May 2026 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599009;
	bh=01H42Jexe5aI+uHOezmQoZgnB9LnnOxFJhgAq0Km7D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPxYG9UJeS9FC6kOOvq/q0Fq24wcOsqM7pQlipdKNKgRH+NUDbyMDkhmo1nfSdGoz
	 trbSz9fqv+sSD5BGcjTyVnDmxqjXoyhpzWgP/mzSYlMxiSKbPNuOtEGIs2AvbrdFAz
	 2WYa2cs6eWB4pCMqBwbaN57oOWAx6oK3vyUUA0ZTjnWvoJ/qeKLiswcwL+nsUbzFw4
	 IROtzy0ESA+9hw2iFpJoU+k4MdZb/LiGA3ibFAqBGMf31t28OwDT8/Zf2i7krGQ7VB
	 NksNwaC+TjqLxyzWKTJ+jrgmeQQmHKDNhCUdWvkwOjjYuVVFs1gGj92oK7pJ+BDo4u
	 aYsWSpOu4tD3A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, Andrea Ho <Andrea.Ho@advantech.com.tw>,
 Eric Piel <eric.piel@tremplin-utc.net>, Alex Hung <alexhung@gmail.com>,
 Shravan Sudhakar <s.shravan@intel.com>, AceLan Kao <acelan.kao@canonical.com>
Subject:
 [PATCH v2 5/5] platform/x86: intel-vbtn: Check ACPI_HANDLE() against NULL
Date: Tue, 12 May 2026 17:16:22 +0200
Message-ID: <3426431.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6007701.DvuYhMxLoT@rafael.j.wysocki>
References: <6007701.DvuYhMxLoT@rafael.j.wysocki>
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

Accordingly, add a requisite ACPI_HANDLE() check against NULL to the
platform/x86 intel-vbtn driver.

Fixes: 26173179fae1 ("platform/x86: intel-vbtn: Eval VBDL after registering our notifier")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel/vbtn.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/platform/x86/intel/vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -275,12 +275,16 @@ static bool intel_vbtn_has_switches(acpi
 
 static int intel_vbtn_probe(struct platform_device *device)
 {
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
 	bool dual_accel, has_buttons, has_switches;
 	struct intel_vbtn_priv *priv;
+	acpi_handle handle;
 	acpi_status status;
 	int err;
 
+	handle = ACPI_HANDLE(&device->dev);
+	if (!handle)
+		return -ENODEV;
+
 	dual_accel = dual_accel_detect();
 	has_buttons = acpi_has_method(handle, "VBDL");
 	has_switches = intel_vbtn_has_switches(handle, dual_accel);



