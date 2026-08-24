Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280B391512;
	Mon, 24 Aug 2026 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606015; cv=none; b=tKpfoG/GVsOreueatyCrrrBgQJRp6Ags18baAtYAYRDFIuC1CPLNuUwt8wHtULNYbH3pkEc5S0tgm65Gp1GHJjPqC+vyO3gcCBZwppQfzWVqAjgvBkH/HAVUOPy3eAZYGsUqu6CK7NghDkRWwlISxlN7iKnti2LWXNhyRnuyBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606015; c=relaxed/simple;
	bh=/2y38aFbHbZPfIQcXrhQMjCZtYrSufSG4y5DF5hX4lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mj19Pi1ooovQDv7QpzswJ4U6DKv8pbT9ZZ1n7lBzEdUt0pCVYCS32RXrxXJP9bYwGBpVC6EesFTk0ekU6Wj5H1f88dIcGzgNn3c2+vBsO2Nj8YM/doEg59UyrwXNQOP9gD8C0bFK8FWWgnThRl8m2QG+Qqax7EdsBs086F0+xng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGeKpT6z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGeKpT6z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787606015; x=1819142015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/2y38aFbHbZPfIQcXrhQMjCZtYrSufSG4y5DF5hX4lU=;
  b=PGeKpT6zEMgJ3QFbXyJ0y8cDW5C1dMbUPeLqpPIPtTKp74XJ+bClutqE
   9lr/5tXqiHSr3/Ckw9GlMWmAUB6TtAgJ5+6N7N3DZmHuSoaxGwQ9rpgoX
   5K4AsdShyqGYUpTB1IE720x/ji0ZYpKLCOaVEVxRmKy7uKk6yYZ42UW9J
   3Bz4Of9cH144odwvjW7D5sV0lMmT5aMBmZFypVBSMUP65ccb1A21JRna2
   ObY0LHTKXRmNq6KWp/MbfvShpNbQfb1Eps0nrHkPhE/EJ+Tn/gJZRI1ST
   2Zl9ScZPlXdiqcmfnpBzwMHkIihKRRd2yJY1hww2BqV9gzJRgXZsBrqk9
   Q==;
X-CSE-ConnectionGUID: bysboGuzSvC/sAz1nhTOxQ==
X-CSE-MsgGUID: wpeB8ayUSYSUqArlRXM8Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88125315"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="88125315"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:13:30 -0700
X-CSE-ConnectionGUID: yqOK1vnWRhKUbnJcruWx9g==
X-CSE-MsgGUID: 7fGOYv6wS9WHzvaRTonMCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="290634205"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.9])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:13:27 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 0F2F8121C16;
	Tue, 25 Aug 2026 00:13:38 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1wybz8-0000000F2MQ-0gYP;
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
Subject: [PATCH v2 0/5] Fix static analyser and compiler warnings in int3472
Date: Tue, 25 Aug 2026 00:13:33 +0300
Message-ID: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
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
third patch adds __free() support for ACPI objects and the final two
further clean up GPIO parsing in the int3472 driver.

Sakari Ailus (5):
  platform/x86: int3472: Address Coccinelle warning on an error print
  platform/x86: int3472: Fix uninitialised variable warning
  ACPI: Support __free() from cleanup.h for ACPI objects
  platform/x86: int3472: Release ACPI objects using __free()
  platform/x86: int3472: Clean up GPIO parsing

 drivers/platform/x86/intel/int3472/discrete.c | 55 +++++++++----------
 drivers/platform/x86/intel/int3472/tps68470.c |  2 +-
 include/linux/acpi.h                          |  2 +
 3 files changed, 30 insertions(+), 29 deletions(-)

-- 
2.47.3


