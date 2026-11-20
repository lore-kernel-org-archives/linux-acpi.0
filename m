Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195304;
	b=LXFKK22n6hK/LIlfU6BlIMgClganCxDyRE6muBXMY3PZJS1IFkc9QwEPopT4Hyz50AJG
	 VT42yPj3uCnKSEsL0N9ZeJpI26F6dMqlm5WuVsJsSMgQT/KphCXQF0DQSn5A37kEiFn96
	 5UJyQDxtP03ta/SzHG1TrnGbq2OmDYdTBFIoE+pINtRAmPduVsxuz0qgSmxOrlnScISMt
	 OGUkHVxlI9B0cvI3KgTBo5F7vs5rSBObL+8v9/nr4H97G3wm90N3xNmRtgdRzgtZV7zIL
	 ebPGAksB35Hd1Bv7vOggPqebFjVtxOgVC4Av9w6X7qw715OWkDtzMP2X5/kVsP8Y8zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195304;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6iXYH4zgRiCKj6TFFGT8b8gjNXrkc/FF/5cTssJWbTk=;
	b=z24DMM3zqiSvRGxGB1aSgBIhaS+8VkyITVgt4MMStbwKXDGtxyNjXg1btwQ7NaPH5/wH
	 GAwxpbmQ6uOZSNtFJbNYblwkyEwpbmGTa/8qGwU+70D+HXHR92UcDkcdqzv3UKe7mgOYZ
	 V/HyYy1sViTDXmqicApatTcOHprYL8nlfh+kmV9ysDNbPQreV0svZQ1fpjzyKk/7El1wm
	 M96AEZ8M22lEm1JthXBv2B1DOUSLAA0lmU4iIQBk20LDBJQtgBziUJGR7QJpGs0tW3Tvd
	 223KOD6kZ3aFnONJddJfIi+bvSlqw7gF2c6LYAV9v4d4RzpYuwVSu1JHd/VzkJ5DzSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="lgfO+/Sq";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A8606A744;
	Fri, 20 Nov 2026 17:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 225A8606A744
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lgfO+/Sq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195302; x=1826731302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YbTf5trDopxe02aOZT+b3VJbn+3UJdoGzNpd2Ze/ER0=;
  b=lgfO+/SqjrMA5bB2+uusSDzd1PUZedVbHFTQTVGGrkPj9qJAkTrAU5wW
   0oWDACnz26r3hnMwWCSkrAQazQBhVUxswU4rtZimObFtSuYmfNLBxUrmL
   FZQeApX8ixVYVjJSBxqEKpIlc1jkAcCYfKHkgHgskJ1ba1Ew3Kk6kjcG7
   Ygm3ikFOYE6xxO06EMDuHGyEfttFMg0GTFVec2ofT+KoGFYIJMl9dnVwA
   ZeVWnxOklSchLr6DVMQYGO3DLa7p4rNi07AFLrr5BjhUWy5NdfiEb+yCW
   cZr3tPOLnepRWVcb04/bC2HDzQmRZ3f1X7yFfbjCy3wR5x3kPkewA5bEB
   w==;
X-CSE-ConnectionGUID: J/0v2U1MQjO+OmcL3VvWww==
X-CSE-MsgGUID: 55c6DZO2R7yEYuVe09CwFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157539"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157539"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:42 -0800
X-CSE-ConnectionGUID: Zn/RYkVbSwmQ5+rr9+/FNw==
X-CSE-MsgGUID: Ws7EdMu/Tv+1IHlAX0hiWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868216"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:39 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/42] ACPICA: events: Remove redundant code
Date: Fri, 20 Nov 2026 18:18:53 +0100
Message-ID: <5071a5286e570bc87844df41525ece3738601784.1795194329.git.maciej.wieczor-retman@intel.com>
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

This snippet happens inside the case part of a switch/case statement. It
only checks whether the switch and case value match which makes no sense
since they will always match. Remove the check.

Link: https://github.com/acpica/acpica/commit/a7f8f92b0422
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/evgpe.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index f74805507529..578651cde6f3 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -489,18 +489,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 
 	case ACPI_GPE_DISPATCH_METHOD:
 
-		/*
-		 * Re-check dispatch type. The table may have been unloaded
-		 * and its GPE dispatch cleared while we were waiting.
-		 */
-		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
-		    ACPI_GPE_DISPATCH_METHOD) {
-			ACPI_DEBUG_PRINT(
-				(ACPI_DB_EVENTS,
-				 "GPE method dispatch cleared during wait\n"));
-			goto error_exit;
-		}
-
 		/* Allocate the evaluation information block */
 
 		info = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
-- 
2.56.0

