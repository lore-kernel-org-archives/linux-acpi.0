Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA923DD51C;
	Mon,  1 Jun 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334027; cv=none; b=ZHuFb8uPRSNeLgvjp55+S8yLwFDuNINmpRPDiu2xhEbiPzoOdteUrV4K2Tx5UF6MrxsxX8o7JxuMMg09wL5Bwt7yGLGmS5kv98QxHajsQZP+qyM3JuHltv6RNrXk9YS7M0noMJ83M7Lx0b422WxpnPyT+9aU4Ggbwkns6orEnrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334027; c=relaxed/simple;
	bh=fxvsUDVuIk1QzCRCzzn559CUBJafGcFYXn8jb8Re7To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaoxkPsjKU+BF+DHrcqLXvtyyLoSDlOZNY8UBxW8taG9IEQGQXofgavY71KYoDfvDhR5EQQrxVeD2/52BvvZqtxKFp/E7UHupaEvBuiQTRK434oSQifZcN72OuoYk7k2O3xTEnZd8TZO9e+5/Gam8ADd6yY66bkpmW6cYLwQXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFsOhcZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFsOhcZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EDA1F00893;
	Mon,  1 Jun 2026 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334026;
	bh=mKisc4Syq5ji6pifJ2lXPya7slOfSetrdxDCBRpQOoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RFsOhcZDWW3UfsX6mwrHExDCwy8jvfERlPzcAoMfPY/6ZNZumfVyzGxHQRQyVNrAZ
	 X75T3X6+HZuRmM7gZVPtqmH6BU+E1rZ1F5RC3v13pBbs2xhdKb0KWzsNXX+xkNZ+vk
	 /lltO0zCGQN9Iuy/x8DVaMxhhiG01s/3WOWhWL73gCAudW0xuPCo4+XVHDWWXGw+4O
	 A7dMf+wnfHaOdIRgr4BkEzWehFAQT4+KgJg8p3u+SSAM1T4te0Ln7t8sR2BqbXas8R
	 Bg2bWzUST1AOTp/jRBqP70s2fn2NUTVAWrX7vhdMcWQRrX1lWhgYFPMhWqoD5yX0SH
	 46eKxyAWwC+yg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 05/15] ACPI: button: Eliminate ternary operator from
 acpi_lid_evaluate_state()
Date: Mon, 01 Jun 2026 18:59:06 +0200
Message-ID: <3055906.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12913564.O9o76ZdvQC@rafael.j.wysocki>
References: <12913564.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The ternary operator in acpi_lid_evaluate_state() is not actually needed
because the same result can be achieved by applying the !! operator to
the lid_state value, so update the code accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 21a10da8b60b..ae97c83bae2c 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -201,7 +201,7 @@ static int acpi_lid_evaluate_state(acpi_handle lid_handle)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	return lid_state ? 1 : 0;
+	return !!lid_state;
 }
 
 static int acpi_lid_notify_state(struct acpi_button *button, bool state)
-- 
2.51.0




