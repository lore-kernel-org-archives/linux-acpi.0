Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72B03769FC;
	Sat,  4 Jul 2026 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185865; cv=none; b=SQz/cNsaMN5fvGRF/SWYKmVmZr9JQdfUMq/eauX+O4ThbktyjVccdcn7/nkcDLwLOAFGSO2ycofVcbs0LzJc0GCs8xdXmSVVNACIylUQlVrimYfILhrG3qMU2KR4v2i1sWLy0Wxe7yMAhRiNEe4AJbbFs9np+U8J2/MIarvEgOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185865; c=relaxed/simple;
	bh=LbGUAz7CFaiFiFA3qwNbHTIPBBQz+Bit3qLvS5IIrBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqefEV0FkQPxqaly31/MQI1DFP1M3RN1BSWgVCHPv9bcSXrkDg7/xUG//yAPpIfS5KamZ7n9L41yDNzJvf6hafQgK5wBERxZapoopKp1FU+roVVUxtW5kwBBEZ9g3QInQBifiLtKB1PbS7IQ/AkXjN7yOW6PZz8mL701a0zP+R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gngJ/oRs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gngJ/oRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783185864; x=1814721864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LbGUAz7CFaiFiFA3qwNbHTIPBBQz+Bit3qLvS5IIrBI=;
  b=gngJ/oRsTmhuNk+1dTNahvjMq0XlvGoH5A+t4VSHFCHcqpQzlzsY2Ug1
   wjZGvW9Lpwlv5uQ11HdPG6DDvRW9fQ87qDXNicCCRVyDOOEYjYO21H0ex
   P4Po+ozOiG1H7JAkkDs/Y8v85bSDjIraAgej64Sc/7OGOx5HNzlSsJB8z
   SbVQOQrJzVFwAUgQnIMJ+wDjgHe5aWTndD4ADqpKRJHNkIO/n1kDsKk1i
   0mkzbnQnQDKXXDJ4InQEPGk3IM1AkzKvyVR1Gw5VBqVqgEaXskimLwzQn
   DmnmAoUcDhS+Sly3IXg2desS1gz3QxMouSl+FmOohkeO9mHCC1ah0N5nu
   g==;
X-CSE-ConnectionGUID: gSQ72+KhSGaG8IAE0/bYpA==
X-CSE-MsgGUID: AA7KUBVKTjizLSbD07u0cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="101308164"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="101308164"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 10:24:23 -0700
X-CSE-ConnectionGUID: Iae4OuvhTQ+CxZNt5ICuXA==
X-CSE-MsgGUID: LrJoX8TkSzisD4n/SYdCpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="250677825"
Received: from intel-nuc8i7beh.iind.intel.com ([10.223.163.6])
  by fmviesa008.fm.intel.com with ESMTP; 04 Jul 2026 10:24:20 -0700
From: Arun T <arun.t@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Miguel Vadillo <miguel.vadillo@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mehdi Djait <mehdi.djait@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] media: pci: ipu-bridge: Add NVL CVS ACPI ID
Date: Sat,  4 Jul 2026 22:48:53 +0530
Message-ID: <20260704171855.1462214-3-arun.t@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260704171855.1462214-1-arun.t@intel.com>
References: <20260704171855.1462214-1-arun.t@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add INTC10FA to the IPU bridge ACPI match table so the bridge can
recognize NVL CVS devices.

This enables the camera bridge path to bind on NVL platforms where the
CVS device is exposed through the INTC10FA ACPI ID.

Signed-off-by: Arun T <arun.t@intel.com>
---
 drivers/media/pci/intel/ipu-bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 88581a4c081d..23bd29b7a393 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -171,6 +171,7 @@ static const struct acpi_device_id ivsc_acpi_ids[] = {
 	{ "INTC10DE" }, /* LNL */
 	{ "INTC10E0" }, /* ARL */
 	{ "INTC10E1" }, /* PTL */
+	{ "INTC10FA" }, /* NVL */
 };
 
 static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
-- 
2.43.0

