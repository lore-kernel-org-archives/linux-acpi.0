Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4809349B12;
	Tue, 17 Mar 2026 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734544; cv=none; b=Q/Mk+yIGkOwY0rc4KHewZfiqU90W1Cmnh0PZ2DVFYdkkUNaR5r8RucIVHl6AmlQ0+Umdmd3mm8F06Th4c5YbrNcEEkeLcVyjNEHsPWOocAyuNrpUgFvKNsKI+POPKEr3BXWncSCkhNuLJNzA9TiV5BU9gwNo76pYAkt4lDRAcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734544; c=relaxed/simple;
	bh=zCI8aTvJMAF+waMD5qkovAifzzx/ZfL9AwpgWEHyYiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBunThBNgEWB4ePcqVdhs1gB/PTk4cVfl6IYFRgQGFRMP8K88Igo6wLEhcOEiEjLlIVRhAtoVQF9hNZcaClXW701goYflhHAnd1WOG0qOKbrq6cRmBTX+ZB6AhtfNtEEv9So/YfVwh5zX+KGtbDe0sdAbfTXy5vzygHV2seLQEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcDj+b7p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcDj+b7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773734543; x=1805270543;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zCI8aTvJMAF+waMD5qkovAifzzx/ZfL9AwpgWEHyYiE=;
  b=gcDj+b7pcbiq4ko3NvjwnBIHsr0NHSMKyfkRMKQoJw+9kWwOlfli8aaQ
   lB0w5FuPA8M/uW1Y3eXxZH4uJUVVgyFOeB8+5aMYjGrr36AlZehBYsRoC
   yxrxMA5qwyX7Ok7GdUaU5uAnwbZZkLx7QHCbDgCAhRIdZWHVEh03K2vyE
   r/ragghyteu/ytkp3Q5vzlW3yI8V93binBzVc7zAzQdkh80Pga4uo5a7w
   +rDt9ePBe3RK7jCqJgKB3AgRZabik1g53zqi72NWpf7fBnU6wELCZAMKM
   cfy+0cZO4GPl6q42gP9RyLwI8LZzppLgdTW6V3KRpIs8zBHwXkrc5xIax
   A==;
X-CSE-ConnectionGUID: LuOTD2foRJ6ihCglIkvy/g==
X-CSE-MsgGUID: k3RnIauPShKhoDhoSAYsdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="77369212"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="77369212"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 01:02:22 -0700
X-CSE-ConnectionGUID: llc+r6wGTV+mwwOMiZIWqw==
X-CSE-MsgGUID: Z0Ah5iHOSlu4WM5Bd88jwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217920230"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 17 Mar 2026 01:02:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B853B98; Tue, 17 Mar 2026 09:02:19 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] ACPI: processor: idle: Replace strlcat() with better alternative
Date: Tue, 17 Mar 2026 09:01:06 +0100
Message-ID: <20260317080218.1814693-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strlcpy() and strlcat() are confusing APIs and the former one already gone
from the kernel. In preparation to kill strlcat() replace it with the better
alternative.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: moved to scnprintf() to avoid GCC warning (clang was and is okay)

 drivers/acpi/processor_idle.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 45b5d17443cf..479995a4c48a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1010,9 +1010,7 @@ static bool combine_lpi_states(struct acpi_lpi_state *local,
 	result->arch_flags = parent->arch_flags;
 	result->index = parent->index;
 
-	strscpy(result->desc, local->desc, ACPI_CX_DESC_LEN);
-	strlcat(result->desc, "+", ACPI_CX_DESC_LEN);
-	strlcat(result->desc, parent->desc, ACPI_CX_DESC_LEN);
+	scnprintf(result->desc, ACPI_CX_DESC_LEN, "%s+%s", local->desc, parent->desc);
 	return true;
 }
 
-- 
2.50.1

