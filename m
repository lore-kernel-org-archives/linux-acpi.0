Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692733909A2;
	Mon, 24 Aug 2026 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606014; cv=none; b=J//5BGI7Yx5V/XtYt0rglGOQfoOMI5sZ18EhhLqX8lIlqjce1paZ0Ve6g5gviAYZHb2A4wLZGNd1PoEVsHLMwWkWrbuXqT2MnnY/ne6xLj2DhuPuEdCsdoIpuXAUhIF40YXkG2Rpwl6q+n1h0VwzTgfqMLdxD6UX3hPHyp7bwJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606014; c=relaxed/simple;
	bh=ogE9JKAdGr2npYKmPNgQJdwRJ80DVqPGMZmO/5+pjfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1Bsig2e6YlurkOg7495plZqp8/5yOZhzCyVmH7Xf5pObkQyfMOnWnoSKUuTuYUPnY2Z2O+b1ZIy021BcpUTX8cI7L2Pj+nx3jTu8CmMOvrA5lxXPMccY0f97Van1bQZ3bc8o6aYFQNdAOY7HcID1vne/Wu7TWpEq4E7CumArXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nce0r4nB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nce0r4nB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787606013; x=1819142013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ogE9JKAdGr2npYKmPNgQJdwRJ80DVqPGMZmO/5+pjfE=;
  b=Nce0r4nBkp2xWiJ3rQ8oPdWq41D716rmqQWsjok7hI7wUhbI7Byw4xLp
   68GUhk6GZOFqJLyf4v+EL9u76KSmC2jam4FXe02iQz+v5cOgGN9gIU0yG
   z3Z9WYeK31SJtk0j9H7dJMJh0A7VfM45EPX1e/HZBlsLZ4ZPDsHV2dPga
   Nr5Q+tlbkG5vJx9gd8FZnl1DMcrCBki1qIg7eSR0yFfb8LqDSPQ9oDEsf
   s5z0vtdQTZsiXU6t5aUg55QIifkHfRIUa/sqpWncPcLGcOn3OMeUdDBNK
   i4FzjajEI/a392vSVR/iq4oQa2xNKGue1KdXyZcjZuaTu07GCQxG1MVQk
   Q==;
X-CSE-ConnectionGUID: vWQ0kt+ySVan6VGyOPN1jw==
X-CSE-MsgGUID: U77oZ888Tm22Nd6uYsXBpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88125307"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="88125307"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:13:30 -0700
X-CSE-ConnectionGUID: ceMY11eFTXm1ElLLCiXyPQ==
X-CSE-MsgGUID: 02irPpfUQq2LoWz3W3tXow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="290634202"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.9])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:13:27 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 178BD121C7B;
	Tue, 25 Aug 2026 00:13:38 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wybz8-0000000F2Mb-0sSk;
	Tue, 25 Aug 2026 00:13:38 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI objects
Date: Tue, 25 Aug 2026 00:13:36 +0300
Message-ID: <20260824211338.3583976-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use DEFINE_FREE() to allow ACPI objects to be released automatically.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/acpi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 10d6c6c11bdf..c89390ac6287 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -62,6 +62,8 @@ static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 #define ACPI_HANDLE_FWNODE(fwnode)	\
 				acpi_device_handle(to_acpi_device_node(fwnode))
 
+DEFINE_FREE(ACPI_FREE, void *, ACPI_FREE(_T))
+
 static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
 {
 	struct fwnode_handle *fwnode;
-- 
2.47.3

