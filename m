Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A913D503
	for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 04:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773117341; cv=none; b=Vbl4vg7FRh8IaYWUIwEZ7eclwW/Ro2o+btPcyXc99ohpsH/zKancay6HoGc8NdSzS7KOfhAZVrORxEopuzk+lLqBeRna+/yaS79+1ddSwMdvSjTyv/8wh3nAvnASmb/O3Mv2yXsAUYU3rF743hyu66N2SJ1zDIu7Ka2j3PECkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773117341; c=relaxed/simple;
	bh=NECt5bb220jXhvMdk1n8+7N5KrEkEDqyRHaHPCEYcdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/PiafdKx7pBgKVz6P9twVHQtNi2zU442nQsE1V9Lz95EJVrg9KRj4WxolvgRBGzLC7TvobSQYPU1wm0Rxhfo5jQxDQRr0W/nfCj6wF4Q4/NZRTCdYqnFaVoriFMYfMmowIispv9w4Us+VvNn2lnHxmCvcOZS2wUyIwOvtMKAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfK7x+pf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfK7x+pf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773117340; x=1804653340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NECt5bb220jXhvMdk1n8+7N5KrEkEDqyRHaHPCEYcdo=;
  b=dfK7x+pfyxHt+8KspTewd8olc8SlT51Rb20IeEjwNN5BtBAd2CNkVRZl
   fCaC4vAfoRcnKz61lfwXXBAMA2ZZIX/OLokIVwoe5s33MGyO+ydIyYd+E
   KP9uAgNQB3XyDuSSO+rnjUES20dqr04E4POdmlzUdmlbjKLJgd49j/X/r
   WgVBbGIljKyEXedeB1Z26IKJ6EkcG2Gt74n4jwaQYJuFa6Yg5bryDqlo1
   5r/JKtQE4w+PnyqlFK7lYHJFKGe/8iCMAfUgTbYvHNnCpTHn/GFl9yfJT
   Y/xFSQUfqiCqVWV3/feiu2SwiblREhf6wOCfhnir4r0azM1QKt3IgaW8F
   A==;
X-CSE-ConnectionGUID: iOczzH6HR16TS6NRifpiYA==
X-CSE-MsgGUID: HMy6LazgQ2ec/NczqaEliw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74074081"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="74074081"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 21:35:37 -0700
X-CSE-ConnectionGUID: 6x7CSPmvRnG0ZbZIGywfcg==
X-CSE-MsgGUID: E7ZVlXwfSNqLOO6EKgJVBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="250437405"
Received: from nldesimo-desk.amr.corp.intel.com ([10.53.80.57])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 21:35:36 -0700
From: Nate DeSimone <nathaniel.l.desimone@intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	tony.luck@intel.com
Subject: [PATCH v2 2/2] Documentation: ABI: add FBPT and S3PT entries to sysfs-firmware-acpi
Date: Mon,  9 Mar 2026 21:34:41 -0700
Message-ID: <20260310043449.1295-3-nathaniel.l.desimone@intel.com>
X-Mailer: git-send-email 2.51.2.windows.1
In-Reply-To: <20260310043449.1295-1-nathaniel.l.desimone@intel.com>
References: <20260222063028.2840-1-nathaniel.l.desimone@intel.com>
 <20260310043449.1295-1-nathaniel.l.desimone@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the FBPT and S3PT sysfs attributes under
/sys/firmware/acpi/fpdt/

Signed-off-by: Nate DeSimone <nathaniel.l.desimone@intel.com>
---
 Documentation/ABI/testing/sysfs-firmware-acpi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
index 72e7c9161ce7..fa33dda331f2 100644
--- a/Documentation/ABI/testing/sysfs-firmware-acpi
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi
@@ -41,6 +41,12 @@ Description:
 				platform runtime firmware S3 resume, just prior to
 				handoff to the OS waking vector. In nanoseconds.
 
+		FBPT: The raw binary contents of the Firmware Basic Boot
+			Performance Table (FBPT) subtable.
+
+		S3PT: The raw binary contents of the S3 Performance Table
+			(S3PT) subtable.
+
 What:		/sys/firmware/acpi/bgrt/
 Date:		January 2012
 Contact:	Matthew Garrett <mjg@redhat.com>
-- 
2.34.1

