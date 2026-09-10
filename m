Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4F56E05B;
	Thu, 10 Sep 2026 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063008; cv=none; b=DuTpPajvMp1VeAIQRGoQugbpwResYZGu28hAeF7S9Ve89puj/cUpXdnKjUE2ome9IB9owcsCH82zGvDmK1NSuP4zaFua/gzK5oW9VFDFWFOljQv2neGsk6UQegvCPDGKeu5InVDM9HcMbPFUfmOkslzTwJMwsOKEOgoXZGNmG8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063008; c=relaxed/simple;
	bh=32jdSFjdfOg0u5OevMlQMRGedokP33/5ea+cJ51Fo4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nF3bOKAv509dJ1D39a7ypj6KdyCMmKhEWtAVn4KUTAvtyIsf3z0UJtz3GVjKIOcx/0TyOv1kLXrH78okfHjk/5Ct7IZSExWYcEOmZ3lDIrn+nBSbPCEN8ktH767CxWtCrc24LAI5xC3uhWKSc+cPACxKm/bCtKsFYhYFpG2yWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYKuN/TJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYKuN/TJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702A31F00893;
	Thu, 10 Sep 2026 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789063007;
	bh=n88X9FTg1q6xLXp2uwI00NmcVcngfPjMolzBATDbazw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TYKuN/TJrK9YAg2qLjNok0wCj/4eKr8iocVUQbr/NbPzkGo+wza19GuhSUIOSf1FQ
	 tNsFIOaVXbd9s8TRLZ1OmSTpBrYMWwXEwtKZYu4ojZFBX7m5dWOcNZgmp+Rj3rqlxZ
	 d1mFK44WwrjGl1L7gBxneAwzzaTcmQQ0W6smw94DVWOinmNFb+E59+p77ahXLB101U
	 O9nhxufgpAulbq8rsiYMETUk7nsGDQS58qnCLmN6R254O9rstVF1pVPL81Ix2raFh7
	 i9l1+evbSv0WW/qKn22u6axirtGuSXWMsGL+tbu4WIsx1Bq1BzahKwg+30NFgKZWHo
	 WCb/be+xOG7UQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1 4/4] ACPI: glue: Skip devices with no type in acpi_device_notify()
Date: Thu, 10 Sep 2026 19:56:22 +0200
Message-ID: <2078562.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <12995802.O9o76ZdvQC@rafael.j.wysocki>
References: <12995802.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Since all of the users of struct acpi_bus_type use the device type
for matching, devices without a type will not be matched by any of
them, so they can be skipped early in acpi_device_notify().

Update the code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 1981ebfb5ce0..c53f3d86254a 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -63,6 +63,9 @@ static struct acpi_device *acpi_companion_lookup(struct device *dev)
 {
 	struct acpi_bus_type *type;
 
+	if (!dev->type)
+		return NULL;
+
 	guard(rwsem_read)(&bus_type_sem);
 
 	list_for_each_entry(type, &bus_type_list, list) {
-- 
2.51.0




