Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505501;
	b=Mf0rijL6rYl6HGuI9SSV/WVqB12GXRI8mpFhOq56v3hdObZwMH1X1pM1JH4iVPT0/c+2
	 4j/+rkfITZkh5IJd6uJRweY/vjwebFEWlb2CbQ+4VZ1vRNUtgnBSXACt0ob88peGBwEFM
	 NAcBIa1jw3O++EqhLu41agMXZhWM8pg5+OK9XlaAUi5mulHaIUD+K8L48U0Ad+g2dE3Zx
	 2sS/6H5keHinM/HDZvQ53YOkVLCEfw72l2oOoAlAg3EoJrS2BrbN8jGtuIelQL35PDGEB
	 c8Hwdu7elQvgR/poNCajRmPsLmotfzIC5wFmAGjbRfEWSDH45T7YYI5CfDVuZ+RQZkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505501;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=leeD2aI9/9Yt2DSZjo0544j4r2xUUyEwR1jhELORUQ8=;
	b=VdPa3Iy+EBlD4FwCw1RMh2Lw6z5VkptxEMREymWkqt7q4IXeYPSuzGNtNrXNIpOBoPWR
	 oasO3hoadsXchFLhl0wqrgs0Kp8dflhSPFhJEDn0UnZyymr3itZfwWiGvKY/eUvgHiGyK
	 62eTqGKetyaXmmC9g81E2fBgkZ6E+SjNvavEkuR0kntUIKmQxOfRJY3XAuGu0n8x/Mtyn
	 oRNNeBRBlCxb1aRlaan2Up62R4sNjwlMmv1ajZ6eXDIHI0DPQt8RT1nJR9nhRB2Jqa/Bq
	 4FI3y6ljcB/34Lysq0OStEP/Qe+MWSajze/bA5+3qTtVOgr6plnXZtcn2F7/v/8s71A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TWB50Cbe;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709EA60A2611;
	Tue, 20 Oct 2026 14:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 709EA60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TWB50Cbe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505495; x=1824041495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7upXGW7B0OxFLXyJ5Bo5p2gLV0WQ52dE5JetK53GYac=;
  b=TWB50Cbe78Uu6UEKC6eUG27lUgFyv9Z4nywtIFKjAiGx6FKXi+UttVpb
   /KFDuvWgmwoZ06+JULt2d7ApyBXZuFgl3mVshl/YuPHA/QeTEzSdpU1/J
   35eZGDxboMmxgtVvHrTO/Gzdm7AKTtiCsDQWhgDo08RMyxEYJ7cGY9Q0x
   YDo4rDJV92v4mhXC9/twYOyCD9ljZjUPP7tLSdX1FEu50DF++NxHiQ1fO
   IFskieR6ZNT7k4aYxTMcASBk9NWH6sqlGwB3SUBMANRS2HJhuqJuFgOmn
   ImDrKJ5Xylr+IdVnM+hGY7yr6dz4ooTSP9liueGAsQ8iofV2N2hvdTbm2
   Q==;
X-CSE-ConnectionGUID: ACKm05D7Qc6U4PomwrMDPg==
X-CSE-MsgGUID: EShhGT3xT42BPBTASZFrLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222246"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222246"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:35 -0700
X-CSE-ConnectionGUID: rK4p4KvMQ9aT13linLGW/g==
X-CSE-MsgGUID: d6cXOHMURDWejLDaq/hIRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887954"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:33 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	ikaros <void0red@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 13/30] ACPICA: tables: Fix heap-buffer-overflow in AcpiTbFindTable
Date: Tue, 20 Oct 2026 16:10:34 +0200
Message-Id: <20261020141051.2194123-14-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
References: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
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

From: ikaros <void0red@gmail.com>

The OEM ID and OEM Table ID string operands passed to AcpiTbFindTable
can be shorter than ACPI_OEM_ID_SIZE (6) and ACPI_OEM_TABLE_ID_SIZE (8).
The unconditional memcpy reads past the string allocation when the input
is too short. Validate string length before memcpy and copy only what
is available, relying on the prior memset to zero-pad the remainder.

Link: https://github.com/acpica/acpica/commit/dfb5b18ef458
Closes: https://github.com/open-acpica/acpica/issues/1179
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/tbfind.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 60a772c87f42..f36a9b34058f 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -57,8 +57,20 @@ acpi_tb_find_table(char *signature,
 
 	memset(&header, 0, sizeof(struct acpi_table_header));
 	ACPI_COPY_NAMESEG(header.signature, signature);
-	memcpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
-	memcpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	if (strlen(oem_id) >= ACPI_OEM_ID_SIZE) {
+		memcpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
+	} else {
+		memcpy(header.oem_id, oem_id, strlen(oem_id));
+		/* Remainder is already zeroed by memset above */
+	}
+
+	if (strlen(oem_table_id) >= ACPI_OEM_TABLE_ID_SIZE) {
+		memcpy(header.oem_table_id, oem_table_id,
+		       ACPI_OEM_TABLE_ID_SIZE);
+	} else {
+		memcpy(header.oem_table_id, oem_table_id, strlen(oem_table_id));
+		/* Remainder is already zeroed by memset above */
+	}
 
 	/* Search for the table */
 
-- 
2.50.1

