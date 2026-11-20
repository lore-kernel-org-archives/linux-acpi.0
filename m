Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195326;
	b=YI2zSkAe3eGUxDAjqYNGr7Mjz5heZPu+ExWKICpkHUZwfuNJfn5r4N6d5BqT4jfcerTn
	 Zif7mS8dH9LSE69FPZy2cQ31AJ+KXUwPK0kyrINwX/x2iZyCtzqe97JE58hcGdRTv/coZ
	 6lci+CDufL+buNBE7ito34tdMEm9RVOX2deZn15+YHBsy9Qos/61W/x1cjmhWTYbCDVrW
	 n75lnSH+eyL4px23+dVekfRAFOWDj0dLI5iyqxQSZT0ldhpGu4QaXcFayFtyXYZX9Qg5n
	 iL72FswQ/pvrzSupmr9kzWI9G6YI+S6y5tCxYdJZDzrb0uPexBzQ3PePfrpJ6fkaIig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195326;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=12ouUaiapDW4WWlIpdSTjSXbjd4LSx3bRcbXj+TR3So=;
	b=oyMNEhIiLl/l+Dd7cn40CrFuBmnovyQCWltnk6Iod5oLwCHnRD7+E1lGmSHnSCavu/W+
	 4df40ojNx+TlcGwI14yUBKS/AC4kIlBAllD5CGQscE+DXWSacwsAfW7pCARxSKeTbn0lR
	 beA43ROYhg22tKYmvTNPwUN4wW48lRde38MZPT8GiZiULl7RyXl3FuiY6bH1H12FfYRvQ
	 md0WVHZu7rf7vd4j5QDyJy1SA+ZFv4A2+G14qECCBtfrEfrR4gCMpNb8HHZLGuSeHVvBo
	 Z959A4XS9+P3qUKQsCImlcOykLUu6hIL/0foBARrEhrJdPvoEYXZCw0xqDKgQXPWxBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="NmOJD0/s";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E439606C281;
	Fri, 20 Nov 2026 17:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E439606C281
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NmOJD0/s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195325; x=1826731325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hf+lgdWMCseyoe99nrXoMhBCzzU39GtnKNwT+QJn86o=;
  b=NmOJD0/sdyQIAPpTS00f1hQzBxJI3Q09lbNMjv/16xOOma1ew4qEVIM2
   0Rmomtwha1KAapT6c8ZY+PXEwoG4IrYpl9t6voRaZZ6kdjwba3igUoipW
   QKIaUcn/o27WM3YR2wMNnYo+9D0xDwSGRKA9QenH2QQGpsV2OT/5MNY2h
   OpkUgzSu5WvlWLF2woP277xIsWjRZqlfQBYmdvutly3FnQXritLHcSWxd
   TBmml43AoaJ25uN88mC8UTJ5ZYcvCDbJoyaEGC9ZOObmgPW9ZLg02XrWe
   P44KbzbPiZchzVfqwY2Y5FCA0tTSqLhfXIXfVNij/MPWxKsYA66HFJ1Wp
   A==;
X-CSE-ConnectionGUID: /oUHccxzSU+gIu1ihwxPsg==
X-CSE-MsgGUID: trIZxb+4SLSYX56VpMBLZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157607"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157607"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:22:05 -0800
X-CSE-ConnectionGUID: HghOiAB7Tqac1N7SNcJMWg==
X-CSE-MsgGUID: poWkDUYMT7abyZwXRKbS1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868295"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:22:02 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 40/42] ACPICA: utilities: Clear NextObject so the outer loop doesn't read it
Date: Fri, 20 Nov 2026 18:19:01 +0100
Message-ID: <1c2723e61e00079e653cb072076c8fa0d0ad2db0.1795194329.git.maciej.wieczor-retman@intel.com>
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

If the inner 'while (PrevObject)' loop exits after NextObject was
already set to the PrevObject->Notify.Next[i], then at the end of the
outer loop, 'if (NextObject)' check will save that discarded object.

Set the unwanted NextObject to NULL before breaking the inner loop so it
doesn't get saved for the next iteration of the outer loop.

Link: https://github.com/acpica/acpica/commit/942f4fcfb1ce
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/utdelete.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 57a0de6a49d6..7645c14aac68 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -519,6 +519,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 				while (prev_object) {
 					if (prev_object->common.type !=
 					    ACPI_TYPE_LOCAL_NOTIFY) {
+						next_object = NULL;
 						break;
 					}
 					next_object =
-- 
2.56.0

