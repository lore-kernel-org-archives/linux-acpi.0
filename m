Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505525;
	b=gGQd5R0NjF7vCl5FLvQP5TiBsDTj9I5CUA8OdFrfSzeM/Qr1mBwtE8hm3LgtGLCA4H/d
	 aXei6DswhAACnsMOFNMKgKNOPQD4sBRGTtjK5Izg3QBw9xQA6KDWElinaVRvZVMAtkbld
	 3114NoGoH4LDN3P1YSE90AJuut89Xh2bO5fHoS42/H2hHNZJVRUOv2ux4hcCCdrSZauGC
	 kSsA0kOL/OdorBUmsjkHrjmg+XgXNRZxGS0a7y9Pgk+Q8ZQUJmix2ZLbca8Bbcp7j4s88
	 dMxvAF6mI7YbcY6+1kZXWDPKIIyGm5WxZ3mCsoOi5f8GrssviatXLqrlsN+PGEDrB6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505525;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WHGoCidqFSyi/pUScArPHnmY62JmBnz40/TVqc3BEQU=;
	b=MDa60y+RwCxewArbpmwAFa4SVaY1SlY11Wwjq9cY6oXckuHUMXPSwjdEYosc6RyErDRk
	 +1OlwnBRqcrqKXsreoe/6yLRtUCaZYxOLEIn/ELgcQ6DJdP4Sm0ZlBibHzfwJ8boq3ihF
	 rZyF/GC0MnEcle56CKI9yx3/uj6UOWCi6LqmyzZKewnQNRampDbHDQRpmijgqaUmm9VwY
	 QUSAtMEZPXXyVWeU94SitCgZTcs/NSBDahmBjsix+osQjH5GtomHP8lX8AtHp7WZXULf2
	 U2Y2dmyMqM0fte+JRIZr/0zhu9PbffTbGapvlylBhgl3U+MwAsseSZ9jPuA5o6PAGtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="RAUQj/0g";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F63606AA34;
	Tue, 20 Oct 2026 14:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07F63606AA34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RAUQj/0g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505525; x=1824041525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cw+iEn6H4Xjb0C/nRsSqQor1kcEUPNaTGXaJvFuVa3M=;
  b=RAUQj/0grmmwy/VLqL6o5Dpv5ObHaelMZf8lbPfyn1C2ISzp8VCCw594
   7pYCtwOg/jyXDvscn9jTdHY/4y2Ae+P461qNB/RYM4N43WjxKXgfWe/x8
   vh1vAHNuD6Y4Xj2iq9rwLa3Pu0Zi5JPddscgeb7BD7I8A3zN/4NKS05KV
   85upocY3YWLgmexRCScMIkP81YYtbWUuz5SlZy3IpaqNyeN79BpSCdQj4
   MTr1tAIXzgMImI2eJk6n6ecQghyFEbmVkUMvCIyW1j69ky7j7YiL79BI6
   FlhWEc4A+YhOr5Bl5FTlNsiQB2tOtQFPvzDFAMYpllUfvg0A1ycYh1PLL
   w==;
X-CSE-ConnectionGUID: rFnC6IbgTcyx1pMcdliz+Q==
X-CSE-MsgGUID: WBkbh07RRJCwuW7vjf5nuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222327"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222327"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:12:04 -0700
X-CSE-ConnectionGUID: BuA52f2wTGeZCIMMPzYRQQ==
X-CSE-MsgGUID: WjnonV9YRU2Dyze8oyOa9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2888093"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:12:02 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 30/30] ACPICA: release: Update version to 20260930
Date: Tue, 20 Oct 2026 16:10:51 +0200
Message-Id: <20261020141051.2194123-31-pawel.chmielewski@intel.com>
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

Write most relevant changes that happened since the last release. Move
the release notes to a markdown file for nice formatting compared to the
currently used txt file. Finally update the release number.

Link: https://github.com/acpica/acpica/commit/e85aa3bebaae
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 9557462e0be8..051ea76b7f5d 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20260408
+#define ACPI_CA_VERSION                 0x20260930
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.50.1

