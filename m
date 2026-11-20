Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195300;
	b=F8gSS/g05L0kbQDv65lMUb+Vm2dWlPt99+e7iY6EYEC3R4eGBrfnX5Df2qgbO0JFUwfa
	 r2LrmylMGa2xolRLiXUdJ51Q3qrgJpSOATpKfDMkQYv8MZG1P7jHt1+wIRxa5TEqH65el
	 IEMhMy2sS9FxBIMl8dGs60fjeA40SamoFdjWTtfBHunkeAzJX/MVf/hPpT35KlmjHvoMZ
	 OOpblmZKOcUDptud3d6ElsQGKCrGcKwPevohcTzd77mqq67GRKhhujmuRk+FvDmb14Cs3
	 C126sETl7B9pphFWSR3UaXc5mfq5R8xp3pfV5gwJZZYraqLQ0Hgd9/IaYB0A4nnwLMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195300;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yiVmhWdOxRcuVb6bzjNYZRjMqrIna0OkaPvestc8YIs=;
	b=V1HEe+kwxpLLVat2mF5ahi/MfUkiEdD4dZiA+GXraOMjFY1qA49lwPUQNyL+H63g+MTu
	 3UXN1uXtcdwWOGCObyGq4h3mrkLJeim2QvVXMcC+othrnrZWiKbqTrIXI/3kEdbC/Y/0T
	 RudicQru9fofxH3RCY4Ep6vfNBURnt9tBQ2eXiyRbsa1kjRY7PWVT8gwzCG4yk0h52vS5
	 k1TgX+BKU1HTTaLxgoDxSiG8+X860qCrVbD3ypHCwmI83XrzwVMg7OmqHhkJPXJSWs4nc
	 gKR0ZFfNiTL7BIa9lFEhwU0GO9sa7/JhybRoNxwLA6a5HNp34VgwJIgGg0+bt1jO6lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KcNva7Up;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5886260A3807;
	Fri, 20 Nov 2026 17:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5886260A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KcNva7Up
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195290; x=1826731290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HO8kH8Tc3jDa15cRuBWoCLNmfOSUx7pX24eN/y+mHrE=;
  b=KcNva7Upsgr1eyWpV7tojzE/ZCMOwEcx7qdD73wGcp9zA+lE6Mv/z6cm
   Fk3nZDzEg9MzAaJRV0T/WtHFfdHIyrEqmyQSO4+LW2dbL8ow1I6/E4UqP
   grN2PyIiBgPA28Wmy6Tfz3YLNJ4FlbOvNXN19yaFLYLvibAJBDc1T9EE2
   LjmDwAvtdm7LzzBxmHsMKVQZ4CjKNfNQc/LUmaVsJ1NKZIaHKQoqr7+AF
   MHnJDlJcI4kPNri/h5jOtXMPtAwPN/P12thoS+r5TlgLqhSl9xiv/aQHa
   4ucWrv6/YN8M9r/rwRhXIn9tIh11ME45lShiqP2RV0M7sPnh+SOdvO4tC
   Q==;
X-CSE-ConnectionGUID: UW9ZHX5pSmSVauTItWllIQ==
X-CSE-MsgGUID: h1mkKaf7S7O1SHuPV+sbjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157499"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157499"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:30 -0800
X-CSE-ConnectionGUID: eTJJoo04TDS4GJewHzJ7CA==
X-CSE-MsgGUID: ZyKQVSDGRnC9liVauK6Erw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868175"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:27 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Pawel Chmielewski <pawel.chmielewski@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/42] ACPICA: tables: Fix table buffer leak when Load fails verification
Date: Fri, 20 Nov 2026 18:18:49 +0100
Message-ID: <9a8c8831757087b3a9b9e0296677a0caf10678aa.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Pawel Chmielewski <pawel.chmielewski@linux.intel.com>

Commit "Improve error handling in table loading process to ensure proper
cleanup on failure" removed the ACPI_FREE of the table buffer from the
error path of AcpiExLoadOp, assuming lower layers always release it.
That holds only when the table was installed and AcpiTbLoadTable failed.

If AcpiTbVerifyTempTable fails in AcpiTbInstallStandardTable (e.g.
AE_ALREADY_EXISTS when the table is already loaded), the error path
calls AcpiTbReleaseTempTable, which is a no-op for
ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL. The buffer allocated by the Load
operator leaks on every failed Load.

Make AcpiTbInstallAndLoadTable always consume an INTERNAL_VIRTUAL
table and free it when AcpiTbInstallStandardTable fails. Document
this in the function header and fix the comment in AcpiExLoadOp.
Verified with acpiexec by executing Load twice on the same SSDT buffer.

Link: https://github.com/acpica/acpica/commit/bc6a09d20be6
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@linux.intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/exconfig.c |  8 ++------
 drivers/acpi/acpica/tbdata.c   | 12 +++++++++++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index cb2eed531c67..2354755ce8b3 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -461,12 +461,8 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	acpi_ex_enter_interpreter();
 	if (ACPI_FAILURE(status)) {
 
-		/*
-		 * Table buffer is already freed by acpi_tb_uninstall_table
-		 * in acpi_tb_install_and_load_table if installation succeeded,
-		 * or by acpi_tb_uninstall_table in acpi_tb_install_standard_table
-		 * if verification failed after partial setup.
-		 */
+		/* Table buffer is already freed by acpi_tb_install_and_load_table */
+
 		return_ACPI_STATUS(status);
 	}
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 8185c6f7ce23..c756d34eeb44 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -995,7 +995,9 @@ acpi_tb_load_table(u32 table_index, struct acpi_namespace_node *parent_node)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Install and load an ACPI table
+ * DESCRIPTION: Install and load an ACPI table. An internally allocated
+ *              table (ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL) is always consumed,
+ *              on failure it is freed here.
  *
  ******************************************************************************/
 
@@ -1015,6 +1017,14 @@ acpi_tb_install_and_load_table(acpi_physical_address address,
 	status = acpi_tb_install_standard_table(address, flags, table, TRUE,
 						override, &i);
 	if (ACPI_FAILURE(status)) {
+		/*
+		 * Table was not installed (e.g. it is a duplicate or failed
+		 * verification), so nobody else will free an internal buffer
+		 */
+		if ((flags & ACPI_TABLE_ORIGIN_MASK) ==
+		    ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL) {
+			ACPI_FREE(table);
+		}
 		goto exit;
 	}
 
-- 
2.56.0

