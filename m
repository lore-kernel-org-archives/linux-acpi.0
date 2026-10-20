Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505522;
	b=F5sLDUfLAN46WjbEMGQKcBV0px+y5b4b+qEppoHZdDVVicb4QfbOiBh/3E++FG/+96eX
	 tIndTrbb+KP5VjS3FMVernaOpslduuMuevlcmHQLCSm70d8Dvw+C/HJ9qwfOBQ0xC7rxU
	 +EQXrUsAqoAy/QyJgzD5qq4q8QmefpfPhh8ULAwuyMZigyjtfTZrtThdMVKX/ulh23Crp
	 3qeFhgCD/7jzsgACmx9OpnDX1lAwVYd6hZtwLoxpaW2UzCvKOtL4DORJN/q7JGSi7M+ri
	 1TDyWrArSUl/V4Go3zKa7n1lMR9RkX9l44U1Xu54U12jBRYu0AamquXhRojvK8lENUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505522;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/RGMtPsTm/8QaP5dJUjKtkf6ssaRNcEBC9Nb0rlpySw=;
	b=whVqjPOBd4peCyZD5d4aSHeVc2PS4KnyxoOcmq2J+zHQLjIZ8CWOzBK9RgW40uglcAcd
	 mKPnXGpV9/+mIRA0k3HiRCFiolZHwCYO6dx3tEskPzmRRoZf+7mZMzTHIzLO7uTqf5/IO
	 fnUmudgpCDfAcVJXQXEPYypxjDsOTD++ZQt8ZYpQZQgh9pEBmD8+So7lyVfKAicYZpQpU
	 ly9i6wChOKikrTBH7TbF6Yuv2+zSRJppSPrKVIm09MiZ/oPinKBDlgtb9NrViWd6kZRq1
	 hwezCqrykiaJz8WaQjsQdMf82kzQBuo3p1IxA0OboFItqFJ3XoGA7C9wq4y6J03o7Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QfeeOsni;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB9D606AA10;
	Tue, 20 Oct 2026 14:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB9D606AA10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QfeeOsni
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505522; x=1824041522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zQD3hbIPnpgaLY5T8/cjBzLo9/tZJaTRDyNNHF0TFMA=;
  b=QfeeOsniZHdBBLuiKyzN37b4HB3pW4N16j/gijVdRdMpGvJJvtWsIwwW
   Gw/ML+BCG/kcdvfcgUnUCbfDYuHQGwKS7HrnYoU+MPXY0yrjjZgI9rE41
   iOFAXZS++E5oQ0G0WoIJLcway9EwlmcglkwbqhwjCgm5B237vtSzf3Guz
   pHIMFs+SVV9Ra1FExEpu9bvHWAb0Yekc7hRpK7ufJlAXfXPcXjNE9eJxB
   GzxxG+tS08BfRGQtTxA9cAcJftzPvDEvy+UqmBEOChAQipUrZTZzR10ts
   9rSfXb/QSnX2fpzbSjzjr6kQjwLIxVXJuyyDtJMyuIigQ+Bu1IcbjEhMQ
   Q==;
X-CSE-ConnectionGUID: ZOX05/T4QUS9vsElPw5Jgg==
X-CSE-MsgGUID: cYhpew1gQ1yR1KmK2Q84oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222320"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222320"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:12:01 -0700
X-CSE-ConnectionGUID: hx9ijRoyQ4+S64Vn60Ucdw==
X-CSE-MsgGUID: LqACVQSYT7CA8kkf1G/Yhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2888076"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:59 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	abhinavmir <atg271@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 28/30] ACPICA: iASL: Fix the truncated count of external control methods
Date: Tue, 20 Oct 2026 16:10:49 +0200
Message-Id: <20261020141051.2194123-29-pawel.chmielewski@intel.com>
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

From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

AcpiGbl_NumExternalMethods counts the external control methods that the
disassembler finds in a table. Its type is BOOLEAN, which is an unsigned
char, so the counter wraps at 256. A table with more than 255 external
control methods gets a wrong count.

The wrong count makes the disassembler print a bogus warning.
AcpiGbl_ResolvedExternalMethods is a UINT32 and keeps the correct value.
The two counts then differ, even when the disassembler resolves every
method. AcpiDmUnresolvedWarning() subtracts the counts to get the number
of unresolved methods. That unsigned subtraction wraps and gives a very
large number. A table with 300 externals, all of them resolved, reports
"There were 44 external control methods found during disassembly, but
only 300 were resolved (4294967040 unresolved)".

A count that is an exact multiple of 256 truncates to zero. In that case
AcpiDmUnresolvedWarning() returns early and prints no warning at all,
even when methods stay unresolved.

Change the type of AcpiGbl_NumExternalMethods to UINT32, which is the
type of AcpiGbl_ResolvedExternalMethods.

Link: https://github.com/acpica/acpica/commit/36a5217a09bd
Link: https://github.com/open-acpica/acpica/pull/1221
Originally-by: abhinavmir <atg271@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/acglobal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 08b8270b10de..5294983a6795 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -294,7 +294,7 @@ ACPI_INIT_GLOBAL(ACPI_PARSE_OBJECT_LIST, *acpi_gbl_temp_list_head, NULL);
 
 ACPI_GLOBAL(u8, acpi_gbl_dm_opt_disasm);
 ACPI_GLOBAL(u8, acpi_gbl_dm_opt_listing);
-ACPI_GLOBAL(u8, acpi_gbl_num_external_methods);
+ACPI_GLOBAL(u32, acpi_gbl_num_external_methods);
 ACPI_GLOBAL(u32, acpi_gbl_resolved_external_methods);
 ACPI_GLOBAL(struct acpi_external_list *, acpi_gbl_external_list);
 ACPI_GLOBAL(struct acpi_external_file *, acpi_gbl_external_file_list);
-- 
2.50.1

