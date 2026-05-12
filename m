Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A13B2D3D;
	Tue, 12 May 2026 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595531; cv=none; b=K/YAZ9tac9B3ndrUF0oMkQKoT8pszSpxVR+OvBTC1BmTrJRttBtD+mU63EQeMRwK9PvrNcL2pvPx0ch0oCl96ta2YysieiDk5O7dDtp9ikhLqZNsABEHdmkF6dMNlnSGBuK5kul3qnHZqi1X9gHWe2OTaAPYyjfib0Cq4SegpjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595531; c=relaxed/simple;
	bh=x8uV5tyGdsWbhx4JIoAlLo/7EV+PydOiiuVxwV29HeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I72bTlQj0wudEOIqXaBk6BEKsw3IE1PBYuc31sucjXLWsac6dID6IwWESSB+fFr6b08gt6/WZJu2vTEQdsHGYdY78UZpqjGIsAPNKIEYZksW+mX6mCz/SWWF3LJVbagyvd3I6iTnlevW1ljpl3W1mQPfOjXnCPijWWsZDIE9k0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvCdlrSb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvCdlrSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A182C2BCF5;
	Tue, 12 May 2026 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595531;
	bh=x8uV5tyGdsWbhx4JIoAlLo/7EV+PydOiiuVxwV29HeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvCdlrSbO1Bzff/aaRErnQ9zhQAHTiZHtA5kzHF5EDqvuJLDQ+QCv7JhMLeqfqt/q
	 gtTiZuciWC6LZI5ruojEXSe63ADK4+iIYG+kgGdf9xysQIR30mAO15IFRrErr3ie9d
	 zwd8hdjrufsoxEqq0+egQW6dSqxCQMQOTUCsza4mfWOTJruLE7dzaLrpdNVTv28qHr
	 yqFMtPKpG7/7k8gVqjpr4wYOIvLmbt+7YYL8Ld4dsRkp9ao1IO1qLsgWsMrHrea3VL
	 zDFeO10zn+E9oXJKFpU7vXCCq1iI9FVSjbtmKgtZWH6Jm9KdlQFc0zV7hh/DYPsOs8
	 oaZv+VT13BZeg==
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
 [PATCH v2 08/16] platform/x86: intel/smartconnect: Check ACPI_HANDLE()
 against NULL
Date: Tue, 12 May 2026 16:11:43 +0200
Message-ID: <7956676.EvYhyI6sBW@rafael.j.wysocki>
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

Accordingly, add a requisite ACPI_HANDLE() check against NULL to the
platform/x86 intel/smartconnect driver.

Fixes: 8a44bd3ffdb2 ("platform/x86: intel/smartconnect: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/smartconnect.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/smartconnect.c b/drivers/platform/x86/intel/smartconnect.c
index 4d866b6366d6..71e91ac60e5d 100644
--- a/drivers/platform/x86/intel/smartconnect.c
+++ b/drivers/platform/x86/intel/smartconnect.c
@@ -12,10 +12,14 @@ MODULE_LICENSE("GPL");
 
 static int smartconnect_acpi_probe(struct platform_device *pdev)
 {
-	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
 	unsigned long long value;
+	acpi_handle handle;
 	acpi_status status;
 
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
+
 	status = acpi_evaluate_integer(handle, "GAOS", NULL, &value);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
-- 
2.51.0




