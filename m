Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C51FF7B3;
	Thu,  5 Mar 2026 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742574; cv=none; b=Yb9fCzb7IrI7LCz/06d76xygGrWHMqvowsvkF2W9lPFxxg1s0dA8yyn1W0Ck/NObFxGrX+O8TlmWPQoXD6NGDx+QJHCmkfWB28IhxrE+s0TExwLs7uJVa43L6EEzfwbFiDsihG7fXhZgtpT6G4CKDLd8bYMC8GealETvfHMjUK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742574; c=relaxed/simple;
	bh=skQTu+h+u0witjVwSV2X+6tqI82KGS7SQretGx4eAhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rh+su8yMeSowOba5TTgVOt3DxsN1mXSdPos32uBWA2Sle/JG2aaofbDy/u0IJeX9SKpsy97UxLhDTmPVVaS3GLn5VLKpMXN36T2V5cXyA0Q0Nso81T2Rs/x6FR8Jz0c9Wq795Kehob57cybfYivl2kuM8aN2Grq1OpsRY8FIXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiCGzLn4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiCGzLn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9ECC19422;
	Thu,  5 Mar 2026 20:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742573;
	bh=skQTu+h+u0witjVwSV2X+6tqI82KGS7SQretGx4eAhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HiCGzLn4Fd22UeJ2fLU4oI6eO0JMTCmzUJDGOwOKoYDD6TYukDTd9xHIWmzG7Lj8s
	 /a/8FfJ/wq9srLtyP0oHRCpQtTkypGa6RWBlSOGRN26VbsXaHURZ5EnhpgGd2zmmV4
	 qChcFCPc9GeHYfokYFPLnHOwuQQU5z+ZOVPZED9vBluKHYq6Y7j1E3AZOWhw2b48h3
	 qLi9w85DEaOWY8AJa8MilMFP2Iu8dt70Jh7jMV6S2QbpNfOjtoZNrZHg8XO6qHUecf
	 Ncfcxhg13eK5UApGyXrwlp5cYHKydcPW7fEsJJaS07sSFeuGrrgPfG5pkSIJmQ6Ud/
	 OVq+yyZfRSxUg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 3/9] ACPI: video: Consolidate pnp.bus_id workarounds handling
Date: Thu, 05 Mar 2026 21:12:02 +0100
Message-ID: <47929842.fMDQidcC6G@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4505861.ejJDZkT8p0@rafael.j.wysocki>
References: <4505861.ejJDZkT8p0@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Reduce code duplication related to pnp.bus_id workarounds by combining
the two existing cases.

Also move the definition of static variable "instance" into
acpi_video_bus_probe() because it is only used there.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 3fa28f1abca3..6337376be196 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1978,12 +1978,11 @@ static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
 	return 0;
 }
 
-static int instance;
-
 static int acpi_video_bus_probe(struct platform_device *pdev)
 {
 	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_video_bus *video;
+	static int instance;
 	bool auto_detect;
 	int error;
 	acpi_status status;
@@ -2006,16 +2005,15 @@ static int acpi_video_bus_probe(struct platform_device *pdev)
 	if (!video)
 		return -ENOMEM;
 
-	/* a hack to fix the duplicate name "VID" problem on T61 */
-	if (!strcmp(device->pnp.bus_id, "VID")) {
-		if (instance)
-			device->pnp.bus_id[3] = '0' + instance;
-		instance++;
-	}
-	/* a hack to fix the duplicate name "VGA" problem on Pa 3553 */
-	if (!strcmp(device->pnp.bus_id, "VGA")) {
+	/*
+	 * A hack to fix the duplicate name "VID" problem on T61 and the
+	 * duplicate name "VGA" problem on Pa 3553.
+	 */
+	if (!strcmp(device->pnp.bus_id, "VID") ||
+	    !strcmp(device->pnp.bus_id, "VGA")) {
 		if (instance)
 			device->pnp.bus_id[3] = '0' + instance;
+
 		instance++;
 	}
 
-- 
2.51.0




