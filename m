Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF7379ED8;
	Thu, 21 May 2026 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372746; cv=none; b=KbYQpEdYiZPtieFkccVEJfBCZy7ewQPlYMcDeXuHl9s7+knWKYlpqtDB95ASDvISRwV+rCERRpbYndL6iJjDh80OdF9j13VX7cXLjNKQxs0uN5Ah2vfNkUOk52S5nqYiem3jrD0o34RhMUQofdGbE8WOBY8exdPcHfY2jAKXl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372746; c=relaxed/simple;
	bh=zbrjnEquKGulcRB2zVhFEwqssoftWttJufjcl12U45w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkJj8EpfOuQAkREbIq0fK/fdx0kPLPlVGOZjrzN8pp9lYKvlg1hC2uqSI2mgfHjDlHs0UBBta020o2OSUaWjF1UTmjap0Zyb1wHjzL7yV8IjSKqw5lJkwMD20uW10cK/Lf+IFy5G9SsQOWLDVKmMaIwkpFeMc0JOCMv7qJVApRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fux3igMz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fux3igMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E501E1F000E9;
	Thu, 21 May 2026 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372745;
	bh=Iq/GQjtk6bBmmvqPPmMawFbdqPEJCwxU4GLEIY9qznA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fux3igMz/9QIm5WN5HhL0Mmp5b2hUW1UtAQ4bho5iaA9S2jRHNKZqTZ/UzGLBBMdz
	 feqVJ0w1ZYqz9UklliVhpQSnnhGdN0J5bfTchlv7lTRfcmCK6gu5PEYZMFsZIsrdPK
	 uGUUner55BJsLb7GHZBhHngYIwTp8/vKF2waMh0lDqplN8ZLj5crrB1ObaP0WbZGaT
	 HfbUdtAgo58gneYHzuN/WwfAlUbSzI2qnEv6QCXinFBZgurc2swod1PSRHcKIbNcyy
	 qPagG/775Bztc43rU/xc1fqh1iVECnu2oJ3f6SRH776XmTLf64FYBwpisRU+7LUEiC
	 LSoQrKIhMkF9A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 08/17] ACPI: PAD: Rearrange acpi_pad_notify()
Date: Thu, 21 May 2026 16:05:22 +0200
Message-ID: <3345485.5fSG56mABF@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4739447.LvFx2qVVIh@rafael.j.wysocki>
References: <4739447.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Use an if () in acpi_pad_notify() instead of a switch () statement to
make the code somewhat easier to follow and reduce its indentation
level.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_pad.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index ec94b09bb747..91d32da76f8f 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -409,16 +409,13 @@ static void acpi_pad_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_device *adev = data;
 
-	switch (event) {
-	case ACPI_PROCESSOR_AGGREGATOR_NOTIFY:
-		acpi_pad_handle_notify(handle);
-		acpi_bus_generate_netlink_event("acpi_pad",
-						dev_name(&adev->dev), event, 0);
-		break;
-	default:
+	if (event != ACPI_PROCESSOR_AGGREGATOR_NOTIFY) {
 		pr_warn("Unsupported event [0x%x]\n", event);
-		break;
+		return;
 	}
+
+	acpi_pad_handle_notify(handle);
+	acpi_bus_generate_netlink_event("acpi_pad", dev_name(&adev->dev), event, 0);
 }
 
 static int acpi_pad_probe(struct platform_device *pdev)
-- 
2.51.0




