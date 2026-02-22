Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D826ACC;
	Sun, 22 Feb 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770069; cv=none; b=RXniErPvhFv0fiFslBlvHD6y9ODDY4+2FEkn2XfV2K42Yw2nYc2gQ6F7JN2I77Ruv78u01cpQBU92T6ZtGTMNWSIbdH5RyJqrnZ60+YjDjunCVplaF1j+ALBbGA6wteHJqy8jjBBqiJAzeLc1jGD7qCT85Yx8ll7I1XQTNFWsuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770069; c=relaxed/simple;
	bh=u5w8JFVQh9V063Ayn3LoWkO1eI87LCfsVRka5iu9rx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzVoZ+Ex3xPIHw35yA8nrml/2KILp494U5qbuQnTXFZ/ee64gI4xiyfedyxDhSxfFB0IBkhJgFXHSD15aFq0v86mBQ6rAFI5SfCBfW//GrKPRzDewK0ELs3fNlXfGQAvOYyOMA6qyo4+ueVXetRy7JtoBsEsPRlqPrwFj3oNlgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERw1+vC0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERw1+vC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3402EC116D0;
	Sun, 22 Feb 2026 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771770069;
	bh=u5w8JFVQh9V063Ayn3LoWkO1eI87LCfsVRka5iu9rx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERw1+vC0mU2gnfCHHkhvgwF+0QJyaNhACTEyI+J4TstNtoRzI1UEDqYurqDDljy+N
	 tukbJ7vANQuaqmq9yGdcDI+CHTLwNP5nl8Jl75oK+6GJfRPljzH8T4mHvTkuCs3wsQ
	 W6rDNh+FimlF+Q+0XZ5rGS+H/MIIffZZWw2pZdQpQ2gnFCHt/fFv4GT7n/DnJIg225
	 QU130WrfwLwRDZWAfPshCRr//czapVsEloDUqh3C7gT1xPFQ+MrPpHYUKhz4UA3lIf
	 /iYAkiaMl2mRgJBtoMhPYnVXcnIeSsushXKf1w5m64gWgDBGQ8tKTO8olGUxaJ0Mk/
	 OIWX6ZRq1sIJw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Danilo Krummrich <dakr@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 6/6] ACPI: TAD: Update the driver description comment
Date: Sun, 22 Feb 2026 15:19:48 +0100
Message-ID: <2042722.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4727679.LvFx2qVVIh@rafael.j.wysocki>
References: <4727679.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Update the preamble comment describing the driver to match the code
after previous changes along with the copyright information.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -2,12 +2,10 @@
 /*
  * ACPI Time and Alarm (TAD) Device Driver
  *
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2026 Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  *
- * This driver is based on Section 9.18 of the ACPI 6.2 specification revision.
- *
- * It only supports the system wakeup capabilities of the TAD.
+ * This driver is based on ACPI 6.6, Section 9.17.
  *
  * Provided are sysfs attributes, available under the TAD platform device,
  * allowing user space to manage the AC and DC wakeup timers of the TAD:
@@ -18,6 +16,11 @@
  *
  * The wakeup events handling and power management of the TAD is expected to
  * be taken care of by the ACPI PM domain attached to its platform device.
+ *
+ * If the TAD supports the get/set real time features, as indicated by the
+ * capability mask returned by _GCP under the TAD object, additional sysfs
+ * attributes are created allowing the real time to be set and read and an RTC
+ * class device is registered under the TAD platform device.
  */
 
 #include <linux/acpi.h>
@@ -32,7 +35,7 @@ MODULE_DESCRIPTION("ACPI Time and Alarm
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Rafael J. Wysocki");
 
-/* ACPI TAD capability flags (ACPI 6.2, Section 9.18.2) */
+/* ACPI TAD capability flags (ACPI 6.6, Section 9.17.2) */
 #define ACPI_TAD_AC_WAKE	BIT(0)
 #define ACPI_TAD_DC_WAKE	BIT(1)
 #define ACPI_TAD_RT		BIT(2)



