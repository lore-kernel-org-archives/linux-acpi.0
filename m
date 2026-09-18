Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F250277D;
	Fri, 18 Sep 2026 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745234; cv=none; b=M4y2YeFt4BWk639kv26QbDnAA11kMulrUFtzcBRmPgVtTtdQHR4/9oLWJiXQxjcfqZTfYd/G2EJB6d4cShkM8sK+PKlFV4CAHzNgH+xO5QBiZ3/PRgKlAIkB2duWD7DYmXnshNL1aIasP5xEoKm6dDURIwg4IE1mcWtbyM4yEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745234; c=relaxed/simple;
	bh=VkL8gsqDCA42m48IneROuOYoZgdb0LybAFvlwztkLNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOokp0MGcRWmal068xLPHaCIWAVbpisBls6u2DLRCs67TQpfXwoZ+noKBg/H2X3w11NqocqpopTY5Q6tRaFW0y5Slzq7wiZH9wIrDxdsHBohWbBH908HlRqXb2j4iaCIJX1hCkSg4AHSJzF4VlIKRfTlbTpr6MpchHUJ0HgyLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gPSDnc2f; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gPSDnc2f"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FA1C168F;
	Fri, 18 Sep 2026 08:27:06 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (unknown [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 536413F7B4;
	Fri, 18 Sep 2026 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789745230; bh=VkL8gsqDCA42m48IneROuOYoZgdb0LybAFvlwztkLNY=;
	h=From:To:Cc:Subject:Date:From;
	b=gPSDnc2fWWswEt8GepVXO1FNCeW2Fuwf2lNYu7bHnjt+D9sQU5bbueL/5XXqb8YKw
	 PdpEPksV7sSXNHLguSxNwgeI3pjpz4SXedSgJFOpwyjT7hxEJxGEHcd31wXrwMmrTI
	 8scoLd9Aq/x1GFL+Tj0Lu46qegACQz5W/73GESO0=
From: Robin Murphy <robin.murphy@arm.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: Provide !ACPI stub for acpi_device_uid()
Date: Fri, 18 Sep 2026 16:27:03 +0100
Message-ID: <513319f19ed6b0b6d4c76dc517074531966b98f5.1789745223.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the likes of acpi_dev_uid_to_integer() and acpi_dev_uid_match()
already have stubs for !ACPI, the basic acpi_device_uid() getter does
not. As with acpi_device_hid(), add one for the convenience of portable
drivers who just want the string itself - in fact they are so much alike
that we can simply alias the exact same stub definition.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/acpi/acpi_bus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a45e0d521d8..ed309ea4785d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -963,6 +963,7 @@ static inline const char *acpi_device_hid(struct acpi_device *device)
 {
 	return "";
 }
+#define acpi_device_uid acpi_device_hid
 
 static inline bool
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
-- 
2.54.0.dirty

