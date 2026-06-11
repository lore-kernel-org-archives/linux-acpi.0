Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5D3B14B1
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187942; cv=none; b=het/U0q2PKGdQ6Jftw07YsEu6hSVAD30HGgfjE7vkSbqaeRZdzFcp0XeI/5wC0vMwhw+SYZNgnNVmq4wW5gB8vv7nVRusT9qs1yC2k9MrkBYja4svVW3MOvzpg5DhOtbGvrZqKXeeq+VVMiNSjZ7Iexz/yY6aoYTYwywBTxpxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187942; c=relaxed/simple;
	bh=/bAa+m5LVejDxQMYd6m2mTVBRjor4xyiNAHclA/+ulY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGEEn/DBt3nKUo674QZFZ4kWMZrsyiljhGfnMBKv+uLcbai+Af45pvOafTNY971BBJjVVzw/AASBeMZgC7FWkJwdA2INaYpH0CXeaJ61KU+VA6s2Dz9PnlxAJJa6+r644KDdXGGc47TYYcdCI0quFS7Ki+Qaw1ZejSfgza7Lswk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K4n7brzD; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K4n7brzD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781187938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Smuugzf+L3BtdH9yG3V9lVgHPUpNn2BUiNfgxrWM5kg=;
	b=K4n7brzDW9qGc1iNtgZiHr+vGu1oyn+N6nyX9LDX0M3Vf/pLQWl/uIXo4X0GxUTO8b+AUQ
	c+vFmQUsgnnlhQ+Sksq88ZmJXEpKU1rniNjnfCvz4pM7zL87u6W3gihFZSVEBHKr5a1Qj6
	UrbR/V2G78xClxHWvZdxulQrIYECCdw=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] ACPI: sysfs: Fix path of module parameters in comments
Date: Thu, 11 Jun 2026 22:25:18 +0800
Message-ID: <20260611142518.77343-1-zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The correct path of module parameters should be
/sys/module/acpi/parameters/xxx. Fix them.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 drivers/acpi/sysfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a625de3c3c8b..908cc5c7e643 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -17,12 +17,12 @@
 #ifdef CONFIG_ACPI_DEBUG
 /*
  * ACPI debug sysfs I/F, including:
- * /sys/modules/acpi/parameters/debug_layer
- * /sys/modules/acpi/parameters/debug_level
- * /sys/modules/acpi/parameters/trace_method_name
- * /sys/modules/acpi/parameters/trace_state
- * /sys/modules/acpi/parameters/trace_debug_layer
- * /sys/modules/acpi/parameters/trace_debug_level
+ * /sys/module/acpi/parameters/debug_layer
+ * /sys/module/acpi/parameters/debug_level
+ * /sys/module/acpi/parameters/trace_method_name
+ * /sys/module/acpi/parameters/trace_state
+ * /sys/module/acpi/parameters/trace_debug_layer
+ * /sys/module/acpi/parameters/trace_debug_level
  */
 
 struct acpi_dlayer {
@@ -269,7 +269,7 @@ module_param_call(trace_state, param_set_trace_state, param_get_trace_state,
 #endif /* CONFIG_ACPI_DEBUG */
 
 
-/* /sys/modules/acpi/parameters/aml_debug_output */
+/* /sys/module/acpi/parameters/aml_debug_output */
 
 module_param_named(aml_debug_output, acpi_gbl_enable_aml_debug_object,
 		   byte, 0644);
-- 
2.53.0

