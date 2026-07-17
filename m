Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9E52EC083;
	Fri, 17 Jul 2026 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308601; cv=none; b=HXH04ArmYHBwgH4EuDdOh75MpwtRV7K/bx6UxX/8+LYy31P56oEdBGIDf2KTcty3SZmAwAEVTQDovorRGdfbveEs1yg7aWd8e6rDnZ5hzhZ00edYXp/iqMOeq9aethEeY2YezuymQxA1sLNgIzVitiXsj1FKWOSkBki7lWVdx48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308601; c=relaxed/simple;
	bh=oXXR3QYZwMbnRbGR1J2sJ3cdJDjnVasFqEFPOkriEHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=reWuS8xGSvytaOe4itKe+2sJewXt5Rl7UkXf+YOBF8Sq+0WA4E66zfpVa/Hc4+w15xc7i4KigafF0/o10vCdM/0ywBqZr1Oy4x2t01T6VtQafyDepCVaZKCG1K767hDppoFfvhlKoJ/ctWeKGIF95Kqgq0HyIYW8UWIGGPKc2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c36TOjKp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c36TOjKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784308600; x=1815844600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oXXR3QYZwMbnRbGR1J2sJ3cdJDjnVasFqEFPOkriEHc=;
  b=c36TOjKp/J4qpjKbyuJm7bGf1dgqux2GiNNgWkknRgn7UCS6OFXXK3dD
   VxIYqf/ryTO3X7sDMr10qFmgPLZeUGELpSMPpDc0SOaU5aNh8npyHE/gr
   z6mtuquH1NCIkefWhoTQygHblkqp29ySbrBYjjz1sLoC2G9ZuuFpLKq/X
   tbkdsJ4Py6L+DZ0xmZ1scly9REnKNBCuO5ouAeupdDv4dLTdUjrXCCKRI
   p4DBlk+kk6b3To4bIv/jN1Ut6487OpBuAB+aDADzzspfQiOn5yZnBp7FG
   bWLhfd/KG5yx/igEqlLwKNt5BFpwMdYJBdWrI4WsUhfUh/M3cDdZqsBPb
   A==;
X-CSE-ConnectionGUID: kD78vo9dS9Gcy0io0CLq0w==
X-CSE-MsgGUID: VwPfnx/0TAS+zqHF2Ns2cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85025718"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="85025718"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:16:40 -0700
X-CSE-ConnectionGUID: +VIPGiuaRKOH0ewr4eKypQ==
X-CSE-MsgGUID: aNHAH+d6SBiIkGUGKDsOUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="260418866"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 17 Jul 2026 10:16:38 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9FB6398; Fri, 17 Jul 2026 19:16:37 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 1/1] ACPI: NHLT: Remove always included kconfig.h
Date: Fri, 17 Jul 2026 19:16:35 +0200
Message-ID: <20260717171635.1783543-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inclusion of <linux/kconfig.h> is unneeded as it's guaranteed by
the build starting from the commit 2a11c8ea20bf ("kconfig: Introduce
IS_ENABLED(), IS_BUILTIN() and IS_MODULE()"). Remove it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/acpi/nhlt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
index 2108aa6d0207..370958d93706 100644
--- a/include/acpi/nhlt.h
+++ b/include/acpi/nhlt.h
@@ -10,7 +10,6 @@
 #define __ACPI_NHLT_H__
 
 #include <linux/acpi.h>
-#include <linux/kconfig.h>
 #include <linux/overflow.h>
 #include <linux/types.h>
 
-- 
2.50.1

