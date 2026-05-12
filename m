Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F33D1AA2;
	Tue, 12 May 2026 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603816; cv=none; b=m7B8fMPc8Zj0RDH4vmJFSULFLKHY92ErZfF5LqsL755vtcuJGkKgu0wQK4lQA9VfQNwSmCYd8KcVMBo++aGYbcJguryyIzg7CFvk6ZMSnAtI2REm/pc0V6nrexCYeoyvsZcEAFX4CZAwNYGyS8NvzXdCKFHwTcaOlzMHfM7fdS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603816; c=relaxed/simple;
	bh=h7tLMokthhu7duT+CxXtiqTOpSObIdZVUSB28PggANs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G31aTY0kfkMNbFE6edR2W+6e9tkuEFJnHcO+ch7VkhbG6AcAh9I+LGd5QsTFyzcSz23TMBsmOcvDFY9VOEUAUZlH6GIZSBZdmWc/Tq147NIL2n5QaOCV0VPlKYa5kPDsHUL8TsYM7kxgFtXxrR66tAyNP3cwsmPhVt6pgWJhqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4ZdM/j7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4ZdM/j7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82498C2BCF6;
	Tue, 12 May 2026 16:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778603815;
	bh=h7tLMokthhu7duT+CxXtiqTOpSObIdZVUSB28PggANs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4ZdM/j7B7zM3P9wnKo//vbGXqNw+MkeOH1pvpuCPkZ3KIu5qvB3oUZEE4IXFX33j
	 PC8ixybER8eUpBVKJqAmfcw3gRKTDDrNyNxoxxLfrmnwgNFBQpQViwKnQy3BMGRmsE
	 Y3Bnhr2F7faADXp7moM+ko8SUj5NScuJ6Mjxdw/o/24p/5ibLZZ3WmXgEqG3Cg19EW
	 Q5o+/YAz8CZw2A5Qz4UDhqpMnW3WVogY/nS4IjtHFnyIktKn9S630Pd84g8O1gkwE7
	 /Th6bNJPkzeAlEAjdJkGFx6TCWVafgg6OX0WFmXJVr/7X7eReWNNdd/Dt/wkdtl6yz
	 LFWUC0VLHHTJQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev
Subject: [PATCH v1 2/3] platform/chrome: chromeos_tbmc: Check ACPI_COMPANION()
Date: Tue, 12 May 2026 18:35:54 +0200
Message-ID: <1875121.VLH7GnMWUR@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3710526.iIbC2pHGDl@rafael.j.wysocki>
References: <3710526.iIbC2pHGDl@rafael.j.wysocki>
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

Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
chromeos_tbmc driver.

Fixes: a2676ead257f ("platform/chrome: chromeos_tbmc: Convert to a platform driver")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/chrome/chromeos_tbmc.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/platform/chrome/chromeos_tbmc.c
+++ b/drivers/platform/chrome/chromeos_tbmc.c
@@ -69,9 +69,13 @@ static int chromeos_tbmc_probe(struct pl
 {
 	struct input_dev *idev;
 	struct device *dev = &pdev->dev;
-	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *adev;
 	int ret;
 
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENODEV;
+
 	idev = devm_input_allocate_device(dev);
 	if (!idev)
 		return -ENOMEM;



