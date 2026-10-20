Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505491;
	b=5AUBKkR6diEgGZPkze6lxseIs+t7HtkLVVnoT3gu7rM+VLXC+9HTevibm8MAFGVVEbE6
	 N0V9Y59rokv5kuuf6n6hK6+iKY6jsSfacvEC0vdcGjy4aX/Eo7KUKSJjAO0Csdi3cL/a7
	 Uih/athSVxqqg3xsjQYoT+rbn0X+4lYF704E2DYFKy6PE7uZ3im78cThuzmGLHg1OsMXS
	 J3meFpatQYPaU7BIh+BuUiQPMVuqxvoRiaoNVyx7o5au1F3w4eBWieruAUEKHpg01qtTp
	 qXfpml0BCaTMl5N3a+0nEyU4/CDglTrFjI4kb9/9CGN/IBIOmuUVVgrPp9yLJVVkXiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505491;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uRJTzCIE9k/AmBY22KwarCfsFJ5OJ5cxwL5HlUdxmk8=;
	b=5KVoUvFNlMrQ01BiXqNcDdRPITzxV8Qp8aw2GuiL8T1ajR/XBTigRcJyo48F9Sbwd/Np
	 lsW76PxhiYvDtqt8ca2MRWyo18wgoXKlkcCpJTipzFsWi8YZ42jWpWXbY/PMvgsKuZaOE
	 MiftQrCug107jZLCMzWXefavwqOmm70Lh6jH0wFVaWYk3P3HOqmI5NPY44Segkm5FQEt0
	 srswbHRZXftFacYxc5xfN3Y96G1vwBxTn9NIsgxAXu8z5mdblae5tCWmcZ5Y7lwkiaH8m
	 6KlxGR+2J0q2aUto9MyM+vWtkcre0PD0mYKGKBPLVkBlrsQg5VpZhHaUhdDiepbMwgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ce4NNrDx;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531C60A3819;
	Tue, 20 Oct 2026 14:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5531C60A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ce4NNrDx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505492; x=1824041492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OBA90ROKHlSXAzR5W/stdj7l7vRiuStAV3iVFxuadIQ=;
  b=ce4NNrDxzI6PHQZbrdyXv4//8+ACiy4yqZcLADVRZRQPO6g/9vBzK8TD
   TnNAF9O9REbnFzkJTajG9cXa74NV1uQ9kKi3Rcjb9AlHqFVebqyhWpFCP
   NlP5VqeQwSUlJzk833aik8Tadkyin9LbcBBq9QWMoem2EbtzQ8vAQaew5
   1/wEqMfA3m58Ez0uC9n2nH1T9S7Vx9Ekyk5sYHcv57pF9Kn/fcvEfTYiE
   Uq3YvX+6LYdRQYOgYubihyYAl/C0c8+oxrmV9lhrx2oNKgG6tcO8yUPiV
   CbybzT2JKSfIks2WPqHxC6FVTefneJ5HzqfmqOZxJ4uiWTnP5TR+phAy7
   w==;
X-CSE-ConnectionGUID: ibpBCODZRV2tbwWj7/XwyA==
X-CSE-MsgGUID: RqgDjZVUTMeJV1oTjuRUdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222237"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222237"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:32 -0700
X-CSE-ConnectionGUID: S8klNMYUR2STnyAeTLDdFA==
X-CSE-MsgGUID: g7FYxp5pSDqvAjTLdecF0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2887947"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:30 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	ikaros <void0red@gmail.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 11/30] ACPICA: Improve error handling in table loading process
Date: Tue, 20 Oct 2026 16:10:32 +0200
Message-Id: <20261020141051.2194123-12-pawel.chmielewski@intel.com>
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

The AML Load operator can install a table that acpi_tb_load_table()
then fails to load. In that case acpi_tb_install_and_load_table()
returns an error but leaves the table descriptor in
acpi_gbl_root_table_list. acpi_ex_load_op() then frees the table
buffer, so the descriptor still points to freed memory. Later users of
the table list access the freed table. For example,
acpi_tb_terminate() does when it uninstalls all tables.

When loading fails, uninstall the table in
acpi_tb_install_and_load_table(). For internally allocated tables this
also frees the table buffer, so acpi_ex_load_op() must stop freeing it.

Link: https://github.com/acpica/acpica/commit/d243755c4750
Closes: https://github.com/open-acpica/acpica/issues/1173
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/exconfig.c | 9 ++++++---
 drivers/acpi/acpica/tbdata.c   | 6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index da39d578595b..cb2eed531c67 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -461,9 +461,12 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	acpi_ex_enter_interpreter();
 	if (ACPI_FAILURE(status)) {
 
-		/* Delete allocated table buffer */
-
-		ACPI_FREE(table);
+		/*
+		 * Table buffer is already freed by acpi_tb_uninstall_table
+		 * in acpi_tb_install_and_load_table if installation succeeded,
+		 * or by acpi_tb_uninstall_table in acpi_tb_install_standard_table
+		 * if verification failed after partial setup.
+		 */
 		return_ACPI_STATUS(status);
 	}
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 1388d484787f..d5627b12b1d0 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -1019,6 +1019,12 @@ acpi_tb_install_and_load_table(acpi_physical_address address,
 	}
 
 	status = acpi_tb_load_table(i, acpi_gbl_root_node);
+	if (ACPI_FAILURE(status)) {
+		/* Table was installed but not loaded, uninstall to clean up */
+
+		acpi_tb_uninstall_table(&acpi_gbl_root_table_list.tables[i]);
+		goto exit;
+	}
 
 exit:
 	*table_index = i;
-- 
2.50.1

