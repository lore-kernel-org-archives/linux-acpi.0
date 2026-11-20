Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195318;
	b=1flcIILpaZHvlqlmTEGtAeF0+ZCy9T3nJ9DJ2KmFaGEweROpOILGhnamnAjiFzcdpcn/
	 DulQYDFU41cJf982f71NiUTuv1A9G4A68M6e94WM5+LPzzJbmU14H40tZsMd9B9xIklUC
	 JLKSM6UpatX8XdQk1VHXZyDyfn52t1+637VFRWW+p80U5iLJbEmO11maHoznUAJdLIbAy
	 +SsL0uXLi/UydNKjhg04qcNC1DqQ+XG7UQLVnjwGOVrc93c9owkFzkdsIcPHFlYUi0q6B
	 zTs9r78OgznXW2NPl52LXRrLK6ducXCDfM1ni+G35fvJ1NQf0h0iTJfnzobzlhM+lpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195318;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ULNCz3K5x39o/iXWWWSLq1RONMQ/QPX3aOJwUIOILM4=;
	b=ktNA7Q7JHRRE/M0OuJ6PBb38ibh9Wht7PrgRSxOuFAgtkHZ/CfXhJPpIX6rSOedJABqk
	 DB3Chz52oYdOVUOwAzJk5bhmYUtl9i3FcRk+Yc4nI2rFYt5bJOM0FfjLIdDpfMYTDvJyb
	 Gsw/Me65tsfZ1m8hmbEziUc7fvNFaTVHW/SeD3YIBgisohMk7/qSlq4yX8P6xLDNG1pC9
	 JScxko+YiqWpaOkoRX0GewxJn3GRJXUyM1ReDr4tLxuVA0/jbaHCo0LsYBwjpzXjszDGx
	 OtJv6abx23Hdvq7efa2ripPIC4Z6PnMcQaQOSseo/C6lWjxxTDR2wnxzwBPrmgZ+zLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C9oePBjN;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF660A6F52;
	Fri, 20 Nov 2026 17:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2CF660A6F52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C9oePBjN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195317; x=1826731317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ocUGYQ4pgxB7p0sDnaBJ4+L2WyFktecEWDhLSinhDSw=;
  b=C9oePBjNvzBVX36dwISMHK7POZM+rPO3kap+T0hTqDiLuPicH1Oi7jZm
   tNMmzsnOFkXCjTd2wdc8qrI3XYcSryMV7FAQ0xL/YcsyAwTBXdHmO2r3z
   Cer9CY+dZ3hsFSJibpBn5q1ZX9S1n/gxjDgmJ4R5OhhUi5hIPTMd/GVBw
   RrX7ZVWRc5hJvswok83HvVBGI4w8+p0u+tzSEElV9LYf78BOd7wZJYMFW
   sl6FW+geWQ2Uwgw7ct+YkJV/AmyKTvh3stKbWgb9Ij9hcHIDMV01C9Ph4
   kgOwOt9DSiXIcwLcowZd49lhvvcyV1Wsalq7ChqA8R1LD9xTgrZ3kRAxy
   Q==;
X-CSE-ConnectionGUID: 0BmJaI4ZSnyg7w5JRdGaoA==
X-CSE-MsgGUID: SmSDKREWQEObE6ncoA1TjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157570"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157570"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:52 -0800
X-CSE-ConnectionGUID: 6Q7UuOOFSM625LnwQEPcpw==
X-CSE-MsgGUID: kpPhtlaaS5a584tkEgenNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868256"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:50 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/42] ACPICA: tables: Fix wrong table unload and notify call order
Date: Fri, 20 Nov 2026 18:18:57 +0100
Message-ID: <9a12259c1955e0d1bbf864ba179366dee0e40eb3.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
References: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newly added cleanup - AcpiEvClearGpeDispatchByOwner() - was ordered in
such a manner that if the clear gpe dispatch call failed it would leave
GPEs still enabled but the host would get notified that the table is
unloaded already.

Simply reorder the code blocks so that notifying the host happens last,
after the GPE dispatch cleanup.

Link: https://github.com/acpica/acpica/commit/b97317a4ef0c
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/tbdata.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index c756d34eeb44..1cf0a46b3539 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -1068,13 +1068,6 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
-	/* Invoke table handler */
-
-	status = acpi_get_table_by_index(table_index, &table);
-	if (ACPI_SUCCESS(status)) {
-		acpi_tb_notify_table(ACPI_TABLE_EVENT_UNLOAD, table);
-	}
-
 #if (!ACPI_REDUCED_HARDWARE)
 	/*
 	 * Clear GPE dispatch for methods owned by the table being unloaded.
@@ -1088,6 +1081,13 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 	}
 #endif /* !ACPI_REDUCED_HARDWARE */
 
+	/* Invoke table handler */
+
+	status = acpi_get_table_by_index(table_index, &table);
+	if (ACPI_SUCCESS(status)) {
+		acpi_tb_notify_table(ACPI_TABLE_EVENT_UNLOAD, table);
+	}
+
 	/* Delete the portion of the namespace owned by this table */
 
 	status = acpi_tb_delete_namespace_by_owner(table_index);
-- 
2.56.0

