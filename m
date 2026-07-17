Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC463370E4;
	Fri, 17 Jul 2026 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308198; cv=none; b=A4XGCSv8eREwMm/87qyhDeFEDF/fv165xLU5P19ezhEy2CXdC6QkoveKlyw5dugB4zI0pjnz8mkAOZaU0pysSL6CJYTSD3VXOxtmMAATdMLXP1vwvu+Gy2667YJDCstSIg9t87X0rJjdtsdmkCOzWQIJdFMRXna0F4h/aHMooNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308198; c=relaxed/simple;
	bh=EdAF5djHyA827aYj+g8Hkslg0M7BarVIl6VrilJAIJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQQyVzPQGI6dhPS/vv86ujogJFasVQP25jKfduydQ9bJDLbDzlF1MKG6k/mmheKabX5e/vBBYTePbVb5SCav7h6gTJCW0aLCHo/ScdLtgD3fU22BmQlpQpKaL6IjFGOR6xa+bDfh7VZdAGzTAxP7DCNE8n4cNjj1rD5mTFrIGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfEYckKH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfEYckKH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784308198; x=1815844198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EdAF5djHyA827aYj+g8Hkslg0M7BarVIl6VrilJAIJM=;
  b=VfEYckKH7nimWODZKIBsIfiLqitlx6v3/1FqU89q8aBVKDAWk9uiSGn2
   3nctXYdp4SUKnzdGYI0VMPyqigvTQQYF2ZXSUaYZDGjcA1MxhaJZDNJeD
   i/6f4t3QxR1FuoXuUcLTTCkKEXM/3CVg3PsRoyUt/p6C5+6FtTx7bAItD
   Xqd3O50w0GP3/WLtqqVtqbgW7LwIagiOccCt86IFGgBEHKB8tqWh2K2Lb
   Bqjk7Xl01E86a4Cr6qYP42PvlReHHfT9+JNV8kfViUsSewwI1GTFnd2IN
   MPiEYwh98OjZedG78KJbvTDaKaZUkewE771lenUFGkaLlSZjSJ291i5HH
   A==;
X-CSE-ConnectionGUID: LW0yaDN0SaGpROD1DiGqoQ==
X-CSE-MsgGUID: jGXgMM/BStO9029K2mOKJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="88883534"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="88883534"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:09:56 -0700
X-CSE-ConnectionGUID: 69zbeQWDTK61BS7Lt5wknA==
X-CSE-MsgGUID: +NeZL6MGT5uuQnFTJTXPWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="281286479"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 17 Jul 2026 10:09:54 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9B7929B; Fri, 17 Jul 2026 19:09:52 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/2] ACPI: fan: Update ACPI fan IDs to follow modern style
Date: Fri, 17 Jul 2026 19:08:30 +0200
Message-ID: <20260717170951.1782863-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260717170951.1782863-1-andriy.shevchenko@linux.intel.com>
References: <20260717170951.1782863-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow modern style of defining ACPI IDs by using C99 initialisers.
This is a missing part to bigger rework that's ongoing in the kernel.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/fan.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index e06c055a8bb6..822c5455e43b 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -14,17 +14,17 @@
 #include <linux/limits.h>
 #include <linux/types.h>
 
-#define ACPI_FAN_DEVICE_IDS	\
-	{"INT3404", }, /* Fan */ \
-	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
-	{"INTC1048", }, /* Fan for Alder Lake generation */ \
-	{"INTC1063", }, /* Fan for Meteor Lake generation */ \
-	{"INTC106A", }, /* Fan for Lunar Lake generation */ \
-	{"INTC10A2", }, /* Fan for Raptor Lake generation */ \
-	{"INTC10D6", }, /* Fan for Panther Lake generation */ \
-	{"INTC10FE", }, /* Fan for Wildcat Lake generation */ \
-	{"INTC10F5", }, /* Fan for Nova Lake generation */ \
-	{"PNP0C0B", } /* Generic ACPI fan */
+#define ACPI_FAN_DEVICE_IDS						\
+	{ .id = "INT3404" },	/* Fan */				\
+	{ .id = "INTC1044" },	/* Fan for Tiger Lake generation */	\
+	{ .id = "INTC1048" },	/* Fan for Alder Lake generation */	\
+	{ .id = "INTC1063" },	/* Fan for Meteor Lake generation */	\
+	{ .id = "INTC106A" },	/* Fan for Lunar Lake generation */	\
+	{ .id = "INTC10A2" },	/* Fan for Raptor Lake generation */	\
+	{ .id = "INTC10D6" },	/* Fan for Panther Lake generation */	\
+	{ .id = "INTC10FE" },	/* Fan for Wildcat Lake generation */	\
+	{ .id = "INTC10F5" },	/* Fan for Nova Lake generation */	\
+	{ .id = "PNP0C0B" }	/* Generic ACPI fan */
 
 #define ACPI_FPS_NAME_LEN	20
 
-- 
2.50.1

