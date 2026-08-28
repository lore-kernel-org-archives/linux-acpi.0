Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC43E835E;
	Fri, 28 Aug 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906620; cv=none; b=PzqywBocmijjF08FAqlg575CCHKZrgUM2LmzTo6QUI6M5GBaPyyIlkDpu+fNoxu+CVlD/8uN68E7TTe/0f6E0P7RIgsF6hilUJoPVl8fpYwgQ19btZV/npTl31iOGMWGQoFziZ1CflajLO76zOkCRl93qaQUMP+W8mw3y0E7iFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906620; c=relaxed/simple;
	bh=wyEteO8KWUEC7dh5TrMNq6P8XjEZqUfmLJ/Z1ySwIgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDk51QqgeZ597+GzYvp8YwN4UD3puXPPRu0v4lS/l/kjLdjbwha7/Wwj5qteJDdPcMdIK1XIdUkYtcqalOhzoal49AXtzcyDoH/fGDt92g29taS2ZjQCUxqRD5ZSQNs7UdG/thUcCIu8Ff5xASZiwT7UR/uknJtIx/AfkuR2NIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiRK2nJZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiRK2nJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787906619; x=1819442619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wyEteO8KWUEC7dh5TrMNq6P8XjEZqUfmLJ/Z1ySwIgM=;
  b=BiRK2nJZZCQS1vzh+Rlv5EMSnzfoSLp07gNRPJ7k+sHxdw0Fk3Jijn7/
   s+4fsroBh09AkgLS2rsvVqHnlfwQbcr6RrDLY6tSjMzSP7HLPPtFc4nSd
   +1tKasZidw9He12me28/htDEYt5DBX7dAq/wyuKcv9GVksblaudpv1Li4
   v1hBZclf56QKrykoWzGvooci/XDN0KBtRbY24tcckdY9lp0JMlsW4JVOb
   e6VjpF5Prgj3cGBIIogZhDYrP0fT0RzViEYuLTHj5DIiA70aupM600XXI
   TtFokjPAzOU63GkbdkQAVsUIH1IyrLTIM0JRHjcFsqO9s634caP9HhFBj
   g==;
X-CSE-ConnectionGUID: WcQ0606WTw6Q+D8TMe2yiA==
X-CSE-MsgGUID: wUJgEAFkSSqyitevmE8YmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="75955880"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="75955880"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 01:43:34 -0700
X-CSE-ConnectionGUID: L5vudc38S7uZk87ba0JtJw==
X-CSE-MsgGUID: s+aKW6JLQp+Bf51q28fVjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="261952413"
Received: from rvuia-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.92])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 01:43:33 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id DA3DB121C23;
	Fri, 28 Aug 2026 11:43:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wzsBM-0000000152m-39gx;
	Fri, 28 Aug 2026 11:43:28 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	rafael@kernel.org
Subject: [PATCH 0/3] Make ACPI_PTR() use PTR_IF()
Date: Fri, 28 Aug 2026 11:43:25 +0300
Message-ID: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This small set makes ACPI_PTR() use PTR_IF() and so enables using
ACPI_PTR() on ACPI ID tables without marking the tables with
__maybe_unused.

The ipu-bridge patch needs to be merged first as it contains some
unsanitary use of ACPI_PTR() and that needs to be merged before the ACPI
patch.

I'd take also the ACPI patch via the Media tree if people are happy with
the approach. Otherwise there are two dependencies between the ACPI and
Media trees.

Sakari Ailus (3):
  media: ipu-bridge: Drop redundant ACPI_PTR() usage
  ACPI: Use PTR_IF() for ACPI_PTR()
  media: i2c: Use ACPI_PTR() for ACPI ID tables

 drivers/media/i2c/ccs/ccs-core.c     |  2 +-
 drivers/media/i2c/cvs/core.c         |  4 ++--
 drivers/media/i2c/gc0310.c           |  2 +-
 drivers/media/i2c/mt9m114.c          |  2 +-
 drivers/media/i2c/ov02e10.c          |  2 +-
 drivers/media/i2c/ov2680.c           |  2 +-
 drivers/media/i2c/ov2740.c           |  2 +-
 drivers/media/i2c/ov5693.c           |  2 +-
 drivers/media/i2c/ov7251.c           |  2 +-
 drivers/media/i2c/ov8865.c           |  2 +-
 drivers/media/i2c/ov9734.c           |  2 +-
 drivers/media/pci/intel/ipu-bridge.c | 17 ++++++++---------
 include/linux/acpi.h                 |  5 ++---
 13 files changed, 22 insertions(+), 24 deletions(-)


base-commit: 56c29fa3ee666197516a231e75aed789ae9c530d
-- 
2.47.3

