Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505520;
	b=o/+YMMrwb4JkvtACszCh6MbWscQ54E2AgoMlrM7tVFPMt9bO1f/FqUyrRLtUi4R81kqc
	 vjkdpsN5z6jHtHmzTb1A28bWX346PKt+4mRbGWyhLnOM2bBYIzO8JKhFVjtRXwRDc8B9c
	 SwuHGruEB4AAPMePbvPijf09nHzIqxqYNiTarMGg+7HtPrI+Py5JQ0fMYc7AWYNcjjSUa
	 udgZZil3YtJqGTmGuGP6VtbCj6VmjWdzXx16wn7FIEqIZ7nKdFgeqZKAXfYuxh0e6c/Sz
	 8UkWcprZERAvdZwsFrsJJ+R1DVIwXfT6MNAPU7J8GKO7ddzuoKtOaWgpSSQWnCecIYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505520;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c6RmegXGCb/jyW42vsl5a6/uq4CYG4N7rtu0bDUuLYk=;
	b=0iqOhZZimiEgq0ptVe+toPbHGOo0Ew9uvBfMlJoVKelUimYXiVtn+LhyHYskeInocO6o
	 IqOg0lzd/59w/AD7zsZJa/E/3YM2zqJsLWq1GIAPT98SjZk1q/bB+SCE4uMeYMChrxtSr
	 TmbUQH+j54rD3kXSavLFOOFXYaoHdi4Ym5Q5WRaP4bCM0sBasgW3iY318bYK8FMwadQLI
	 fqn1rIZcZWZy/hwI3g3tNsc9uw02yJslxOowGD2Em1STlx/KQeCo2MiuwT7zrh0LkJO68
	 PY4hY1bWpNI3k92AISk5yEW9G8uDIw1wKzdhWcZa4g6am69e9AJhgqs5DuEBn0Pb1ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HCfGw+KP;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9F360A380A;
	Tue, 20 Oct 2026 14:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F9F360A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HCfGw+KP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505520; x=1824041520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vvtp0j7k5W85COgtZwYtqAt2xHyxQfP70HpggW03JuI=;
  b=HCfGw+KPRwXDj2wp23PL1NLtVj2LhN5atAl7iqIu8k8cbmKVRan3SEZ7
   mfYCh1xoY9yhWUjwypNfcwI7DzzwmOyMoLtbjT6gD7JLc2ZuCzWMDXubN
   eNvgP7/rUs/KT1mO8YVudYY4vjad1RoPxQF3qDNkZt6PtmeWN1w+r0Vo1
   u7QbZYmPrX4y6owN5ewS47UuZHJ4FeKyupNybTPNdvHU3MN7hbevMJltP
   gevlZ3ldv4P9niBfef+DOLzgtG3bwH09+pBPK+/sz565w4DGXyv8JfUXz
   UUYUB+fOh6wzmaG+9uhABVn5AQeuj2NdluQO1JEfyaClgGeB/v/MY086A
   A==;
X-CSE-ConnectionGUID: 7lDwv6HBTlOEBY9RaHuznA==
X-CSE-MsgGUID: yMgJOMloTFSfgLF6cCRtjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222305"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222305"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:58 -0700
X-CSE-ConnectionGUID: rJsjKRLDSVSFMG9OieqlRA==
X-CSE-MsgGUID: dKGzu4StRLyovhKJcpLWIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2888026"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:48 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 22/30] ACPICA: Fix PCC OperationRegion command offsets
Date: Tue, 20 Oct 2026 16:10:43 +0200
Message-Id: <20261020141051.2194123-23-pawel.chmielewski@intel.com>
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

From: Sudeep Holla <sudeep.holla@kernel.org>

ACPI 6.3, section 5.5.2.4.7.3, states that the PCC Operation
Region is associated with the region of shared memory that follows the
PCC signature.

The generic and extended PCC shared memory layouts include the 4-byte
signature at offset 0, so their raw shared memory COMMAND fields are at
offsets 4 and 12 respectively. Since AML field offsets for the PCC
OperationRegion are relative to the region after that signature, ACPICA
must look for those COMMAND fields at OperationRegion offsets 0 and 8.

Adjust the generic and master subspace command checks to use those
OperationRegion-relative offsets. Otherwise writes to the COMMAND field
can fail to invoke the PCC address space handler at the offset described
by the PCC OperationRegion definition.

Link: https://github.com/acpica/acpica/commit/57a2afa78dbe
Link: https://github.com/open-acpica/acpica/pull/1205
Fixes: aa6ec56b574d ("ACPICA: ACPI 6.3: add PCC operation region support for AML interpreter")
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/exfield.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 937da115c375..fc186b2d6dd4 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -45,12 +45,13 @@ static const u8 acpi_protocol_lengths[] = {
 
 /*
  * The following macros determine a given offset is a COMD field.
- * According to the specification, generic subspaces (types 0-2) contains a
- * 2-byte COMD field at offset 4 and master subspaces (type 3) contains a 4-byte
- * COMD field starting at offset 12.
+ * According to the specification, the PCC operation_region begins after
+ * the PCC signature. The raw shared memory COMD offsets of 4 for generic
+ * subspaces (types 0-2) and 12 for master subspaces (type 3) therefore
+ * appear at operation_region offsets 0 and 8.
  */
-#define GENERIC_SUBSPACE_COMMAND(a)     (4 == a || a == 5)
-#define MASTER_SUBSPACE_COMMAND(a)      (12 <= a && a <= 15)
+#define GENERIC_SUBSPACE_COMMAND(a) (0 == a || a == 1)
+#define MASTER_SUBSPACE_COMMAND(a) (8 <= a && a <= 11)
 
 /*******************************************************************************
  *
-- 
2.50.1

