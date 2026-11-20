Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195299;
	b=FcCTZdU0IaL/IczEK5ipETjHx5h6+EdrevtXV7GWrnVmcE4FPubQBCAcsMNVaDcRezfM
	 AYjbjz20n3LOk5oRCZYjMiV9xhLaXgOioayhkZv5z8g8LkOI1S8OA5uCsJ01krLVT5zez
	 Gb6NlZBgDmzf+gHPZT4kxVCUgN3WR/6F/bCzy1/tKhAq1zSrkJqYFLa4gDQde5XhBsvmE
	 1salErAcJNyydiVmmA84oxv+wpbiP4wIaQwpwrQZi16T2PtU9+GNU94/GvRgkcFked5yp
	 +4FvOIN8xk0FGdCFTz/+DRxTtd5fhpqB+X318iw33FnbRBaap/I3GXLZX7kNKW+0vEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195299;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+LDM4HvgTQ8zLPS5TGTJFL1xTOJg0NIQcpVpHembXYc=;
	b=lYGdJXojp6Dh37ahISmwK53GXSG8bDQEE92Ic2N4DJeuhxEW+I1rhVo7IeoMGuo2hJ4D
	 SRyqbGLTwQM+/qk7glsyEtHAa22n/CRijjFv2Wz2tYsBkCM0fGKWdcq1Thn6qgRO1UFD0
	 gUvnOe4QyzodVwvOD0NwgyqHP/Rz6MIDjGKaeZios1My9Qw5eDuUmsQu8FULZeKPQS7kR
	 lEu+L+K0cxOBxEZ5JEjXralf6qh00YWrjM8e2uDh+LQLX5zOeeW6vAm8riUmolfngXMud
	 SgOKqwOz/965HIzLCmWQkUP17ircNSrPQJqWSuzF7GH5MFZ8byUT0o+ySA2HCLdRzcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJHV9uWt;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585EA60A3829;
	Fri, 20 Nov 2026 17:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 585EA60A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJHV9uWt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195299; x=1826731299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dsO4iylP5qjl86UgafHuRFeXwcuNunbBkQmoKM17W98=;
  b=eJHV9uWtX6cdjwKr+RvW/7yQEoTwICgjEoqC6LQ482WAWBKvFV2GdNJE
   gzkVMk695QLFTViWCB7NPxqXkbVkAf4OpBUK/sMbc2oL8DPfuftFWV6fv
   sRCFyNdjs/qzddj4UwVZ+v0D/nlkjVNn941nocpIXerQUI3G+1bmbXA4r
   mk3yC0kI7YIzyuna61cJALXPjuv7Y3C3jFQnL5ackPiONrkim+1As/8Xp
   /bobyIrArlpwYJAj/AF34qcTLFO8YOv4IgC4zmbvfACSxh7zZVkHztmEQ
   wWshIp77MS5sg0Kzj2umjrk3zmDH8uXPD8v9QxNXatpunQ2O2/xJwtGpX
   g==;
X-CSE-ConnectionGUID: oc9B5ep3RS6A3PigMUJdxg==
X-CSE-MsgGUID: rEq6wiiYQg+zEmmSzfQkxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157531"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157531"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:39 -0800
X-CSE-ConnectionGUID: uHEVtNpuSlST8y/88Qlkyg==
X-CSE-MsgGUID: 8GJ93UBUT3ae940o0Ype4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868205"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:37 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/42] ACPICA: events: Add missing event mutex to AcpiEvClearGpeDispatchByOwner()
Date: Fri, 20 Nov 2026 18:18:52 +0100
Message-ID: <8fa96a3a40ac4e7f19679ace75ab3ccde1517bfe.1795194329.git.maciej.wieczor-retman@intel.com>
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

While AcpiEvClearGpeDispatchByOwner() holds the global spinlock there
are other GPE related functions that work on GPE blocks and they acquire
the ACPI_MTX_EVENTS mutex.

Acquire the same mutex around handling GPE blocks to avoid any races
between the different functions.

Link: https://github.com/acpica/acpica/commit/fa543fc1bab6
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/evgpe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 93e205c0709e..f74805507529 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -576,6 +576,11 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 		return_ACPI_STATUS(AE_OK);
 	}
 
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Walk all GPE interrupt blocks */
@@ -629,6 +634,7 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 	}
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
 
-- 
2.56.0

