Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DAE35AC3E;
	Tue, 25 Aug 2026 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787690145; cv=none; b=IKeQul/8Fk656vABcW/pDnLyoeUEDmILhJVAaFc3FB92geLnTa2GVMkGa/xQfClc4JEC2EaPZQhHVy7zo+wOcs8SIkjG9nemsC5u3a1PVe6ytoSeLuKHU2ZnkAYGp8QZnAtono+TqzUN+ad09AaWfT0xnBIReH1DFlyYwjcc5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787690145; c=relaxed/simple;
	bh=n+9qrQZN4kh9MdewAjcnnMvikhpfz9CV7dhIesTCrkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ba0lNSG/TIhA9M+tm+hMexb5osSgGZ/zEZ0NOOUZjjCRqw3V5xkAvZXq/SSC9OZfsG0WX1LgGtYiSVZwry4yrhdxmuWXl9BKykVCPzq8cZmP31+g84GsaiXf+fNCOfHxrVPV4CIC32N2x1+APz5XiEL27E1abkoqNzRzvI0Cyys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsyS+kdV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsyS+kdV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787690144; x=1819226144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n+9qrQZN4kh9MdewAjcnnMvikhpfz9CV7dhIesTCrkw=;
  b=TsyS+kdVysYoDp1IrEb8rOF+kyXiifAKnhS2XK7de/5eHKDXkcDG8P+e
   CK0diR6lKG2jBTDTc9x3wt++Q1GgSTAdVOt/7AoLMueM1vgiSTPI8zuiF
   r9PWUSkH2ZZXw4I9W0QfNjFyBhyNS9r7U4W7x3I/B+nA4nihNnX1hN0PI
   3yG3Hu76mTAjNmxjOIE62D7oxn/3kvoOYRcyxbll5rvNtoAzwNx+/qVgR
   JskBUOSjsno3J7FrT0RWyWS1WCI2tRT2cmWvmeESu1YRUmLs1d4cN0nrX
   PDOtT5DErMe3xKgSaahTpXIMhvD3ubNzsfhrF4UJwjafIvQzi6GB5GVib
   w==;
X-CSE-ConnectionGUID: D3hrepgKR3KxTiUnS5zQtw==
X-CSE-MsgGUID: zZk2K+USQyu8H0WZ1ro8GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88194749"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="88194749"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:35:43 -0700
X-CSE-ConnectionGUID: /DQJl0tBRK+9liSl4Ejnlg==
X-CSE-MsgGUID: EC4CEAFrSwaQUAR1a4sA4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="265579296"
Received: from carterle-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:35:41 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 6178B121C16;
	Tue, 25 Aug 2026 23:35:53 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wyxs9-0000000Fd54-1z3j;
	Tue, 25 Aug 2026 23:35:53 +0300
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
Subject: [PATCH v3 0/3] Fix static analyser and compiler warnings in int3472
Date: Tue, 25 Aug 2026 23:35:50 +0300
Message-ID: <20260825203553.3725132-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi folks,

The two first patches address smatch and compiler warnings in int3472. The
third patch clean up GPIO parsing in the int3472 driver.

since v2:

- Drop the __free(ACPI_FREE) change.

- Move ACPI_FREE() earlier in the function and save the object's integer
  value into a local variable.

- Fix return values -- 0 was returned by v2 in some cases where 1 was the
  right value.

Sakari Ailus (3):
  platform/x86: int3472: Address Coccinelle warning on an error print
  platform/x86: int3472: Fix uninitialised variable warning
  platform/x86: int3472: Clean up GPIO parsing

 drivers/platform/x86/intel/int3472/discrete.c | 51 +++++++++----------
 drivers/platform/x86/intel/int3472/tps68470.c |  2 +-
 2 files changed, 25 insertions(+), 28 deletions(-)


base-commit: 56c29fa3ee666197516a231e75aed789ae9c530d
-- 
2.47.3

