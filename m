Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505519;
	b=jva3Cx4MXSifPCZdvx0haOg7G6ieFuLSlzvdmf4x155LdtPhn/PlkZZKU5oHKqUzaPCS
	 KIUYdWhL8L4CoyDGjtW6HF06u5QONZzBgVllQ0FqTV8QinL52FF1b5ecS2jCy/5pXXbs2
	 6HEXXVqhSAcI1g7UUdCwi4AmnVgdwg7kK+dPJHLbE7X26K9E+bIE/IGAwp3+QbbS8Ttsn
	 NukvoNqHVJsHnDP+vPi9K6/uGwF2xUPqlADiM7r9KFYkIXCuWmqGW04ogtKNhe1GS4t8Z
	 yxFhkZ07fJL3V2ddt9uJISSaKeG7iRhWw2eQA0ObjyC1GklArj7qRp46WqvoTmCslKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505519;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jp7NRr9gJKgMl/Z2WIkpFxemy3lMRMuX8AHQ2WMFZHo=;
	b=ngmN1noeu1rQBXvk7msyhJImDK+k4fjqIcYZJvGppuQyGpwTxP63RTWtA0Zg2RCNydPB
	 eTZ39xI2kIcJd2q+xSGjuyMbXXRiUwlmpZVJ2IGVYPgAwLgD0IhmW/co26YNrIgCCN8iR
	 CsYkHL8iTi310UNqMpMnsgIOH7gOVaehH8QuZIEW4dlOlhPckVT0niUltDj0djIUYpNnT
	 ecZstKR8kM6bxl5rGC2EGlROQNPk7YniqswNXzGHZ8VSmbZnsNW/t6G1ccqBz8fgeSbBa
	 Lv7O7XeCHOao+C6bDN1a3vkVn7g0xdcrF5sN612iFvMAvwlS/CJ3MesS8F0rRvkqT4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BHPYxOUA;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0F60A3823;
	Tue, 20 Oct 2026 14:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB0F60A3823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BHPYxOUA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505520; x=1824041520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e9CRlC6ZSpL5IQo67VIDYovHH0NhvZIbIfr6DUq0+9c=;
  b=BHPYxOUAsE5tgGJrE1QzDYDv6oAKiyMQKT5nqcZlPPt2zdJmzyrgVm70
   trSLAZd6ZTwD+QVTm/NQmu2VG5bnwF77ixHFyw20qyDNObp8mQBogTngQ
   ezKZpDoPqJepALCyHFeGY91Ui+DX1E0CAN0iqMkl/1uvhgkDz+9ECwuuc
   IjbknWkBgXiFfKA79LZ7drU4pxrVtSVl0yHB77pCX7KIFHmSGazptwYCi
   b+vqBpnNdT7J/AAqcWK6bvKwFJJ/b4VpRshIRXuYvYEr7+nXFNHkMpXg1
   q0oZyMcvi0V8ZmJRvqXaQN5y6ge29yZfCwhYfgILn5BOtjLvBNe7DVB6/
   w==;
X-CSE-ConnectionGUID: HdLKQDINTHKm84FkR/tagA==
X-CSE-MsgGUID: QUyMehjNSKaTf9SpZhjixg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222310"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222310"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:58 -0700
X-CSE-ConnectionGUID: jeVoK9wlQNKjdR+TCf0Wxg==
X-CSE-MsgGUID: EehAWreaTOiPnO6zBNuMVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2888036"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:11:52 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 23/30] ACPICA: namespace: Fix possible underflow and NULL pointer dereference
Date: Tue, 20 Oct 2026 16:10:44 +0200
Message-Id: <20261020141051.2194123-24-pawel.chmielewski@intel.com>
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

AcpiPsGetNextNamestring modifies ParserState.Aml. Since it can take on
the AmlEnd value, further instruction that do Aml++ can cause underflows
on pointer arithmetic that's done to calculate AmlLength. Also the
return value can be NULL which is not checked currently.

Verify that return value is not NULL and check if ParserState.Aml can be
incremented safely.

Link: https://github.com/acpica/acpica/commit/ff5efd5d4ee3
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/nsxfname.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index fcd94947fedb..c0466139fd96 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -519,6 +519,14 @@ acpi_status acpi_install_method(u8 *buffer)
 	}
 	path = acpi_ps_get_next_namestring(&parser_state);
 
+	/*
+	 * Path can be NULL, and Aml can be pkg_end which combined with the Aml++
+	 * a few lines below will cause aml_length to underflow.
+	 */
+	if (!path || (parser_state.aml >= parser_state.pkg_end)) {
+		return (AE_AML_PACKAGE_LIMIT);
+	}
+
 	method_flags = *parser_state.aml++;
 	aml_start = parser_state.aml;
 	aml_length = (u32)ACPI_PTR_DIFF(parser_state.pkg_end, aml_start);
-- 
2.50.1

