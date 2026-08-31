Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D937F8A4;
	Mon, 31 Aug 2026 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206677; cv=none; b=RYS0AKT00B5PfM5CSzN3TL6cCRuhcWTuigIduNhVThwEwkXli3p4Haudd0G14+XdQIvQUcBPCGqNT+TltnqjY3pc1FoMg+AKS0j6MxeD9840wpf7pCMRyr14SubjMl1wHTLRXlRM/gv+Qf0VHFMy4B53Sq13XPvtRnPPs2r3fHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206677; c=relaxed/simple;
	bh=jpApC1IxYyJ3IXDLLBdUpoiJFdbpvib33Hdf9mWwb8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ovo2jCtui7btNMPGr1vYQroj6okDjJvEG8sSaq/ACgiyvxUiVJm80S+WQ6x/3kynONCBf4MAqgptJpM32v+plmmADutxGTM/84iwvQTHZPeaUQJlZ6Zz45I0ICOSS0qhEBw1OYHZ4T1fBpCm7SRxI2/Mchu442P+DGsDo/uD938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdxxeWOU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdxxeWOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742981F000E9;
	Mon, 31 Aug 2026 20:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788206676;
	bh=BdSyXpjN1Pdbc/0U7bLGPgVv4WZN/quYZIsZ/oJCZZA=;
	h=From:To:Cc:Subject:Date;
	b=YdxxeWOUZK7HEN3g/9vSHP/2w2Jbs01C9aVMTR0XFAlY7JMqQIOYGxeT93Z4xScF2
	 g4NzN6WoOYikV7bGpr+9JUNjQQKv7bsjvyO4seiu2mBurNNozMXY9FymyCjFao4bIF
	 eoVB/CGbb/uEN0VMKGwsr6D/GxzhfOhY5NMBX5XO4k0kHHLGxkez2FCHIqnyO1F7gK
	 gQVZs+oZIOXHv69jyzPyQdj+LjdWCdq3is86IFPCGnjYdeOVYFwoimzC2UkIig8OQT
	 Ob0QuJY6HPHClpg8AU6584KXJvWdsMPSdD2sNzQ5edDF18PFz9sBzDLCjikhtoL7eg
	 V2i6Zgkf6QtLA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] ACPI: scan: Drop useless and noisy debug statement
Date: Mon, 31 Aug 2026 22:04:32 +0200
Message-ID: <2861358.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The debug message printing statement in handle_to_device() is
super-noisy because it triggers whenever the presence of an
attached struct acpi_device is checked for the given object in
the ACPI namespace and it turns out that there is none.  That
is a perfectly valid situation and the lack of an attached
struct acpi_device is not particularly interesting, so drop
that message.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -639,10 +639,9 @@ static struct acpi_device *handle_to_dev
 
 	status = acpi_get_data_full(handle, acpi_scan_drop_device,
 				    (void **)&adev, callback);
-	if (ACPI_FAILURE(status) || !adev) {
-		acpi_handle_debug(handle, "No context!\n");
+	if (ACPI_FAILURE(status) || !adev)
 		return NULL;
-	}
+
 	return adev;
 }
 



