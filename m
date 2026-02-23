Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57FD3793C9;
	Mon, 23 Feb 2026 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879466; cv=none; b=MJ0TjzW5OaLdF3xFBjomEWCnwetEtD3pYWk9xOYelDD91VrOiXFpdsJ4BbU5rCSWQG72cPg+kVNdAkqIxPMz9lvtlfrN8X2lccexyIcDuYOUN/UY9rubX9TLft82xRoS4QIyaLuYsPsq9SFMUIdvjNvH59UoCE7YfjnxkywRP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879466; c=relaxed/simple;
	bh=Tn0lY0FyrVy89tUA5rbZ/41knbzcOO5hQLG1Fdw23yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNZ9+nwc72ZppTWTxPZX8QZdGzS7jhqvgFm32WzrLK0b5ZHcX0aJuD1MGe5ZJx5ZAEoQwndEtvmjDWxltkIf1lSn7hPVhAtUt58TqD5ALzLBJnv4pi5+na1Fid9dCEc5wP0o9ZKHqspULVkCDKgMLlnpHArTc1tfyeU9wD/gcik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPLMV+5O; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPLMV+5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771879463; x=1803415463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tn0lY0FyrVy89tUA5rbZ/41knbzcOO5hQLG1Fdw23yM=;
  b=kPLMV+5OgL5E9gSJVN5yEt/0/DjV7eoaK8wrLoHuiWzgZ2YAZjnjIRM4
   DYYr9ItY3NGpvS2O8C4TlrIgE32qqu/iifHeRZkxpj8cUJDdmwf6/qPGe
   1bTb9mw25eQpFRUChFNw+THISHbhZjh8WwOnEb48Y/UUncrj3SPhci5RK
   GlYLAd3xMnNhM/BchW8veMqx87YRdZjFlRSeFrAr1OHm6vfA+TYYcZuu3
   rRNKY8bG63Ng1p7uxc4S8veO3GuKew3PBR8iDLdsxUCsIrF4lVaVlAhGW
   NdeI4e7GswX6b9iF9lR97p5JAYDH3ehYxloko7pZCUZ6C4dgo5T+SbXnb
   g==;
X-CSE-ConnectionGUID: NBuK9F5nS0K8cICayOZ24A==
X-CSE-MsgGUID: IVvrVTDkTk2J3mnL8KyEjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72795329"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72795329"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 12:44:22 -0800
X-CSE-ConnectionGUID: rTx1+dIvS7CIxKrG0Fi+Fg==
X-CSE-MsgGUID: FTvawWQVS9OD0FraKIvPQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215700221"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 23 Feb 2026 12:44:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2D30195; Mon, 23 Feb 2026 21:44:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 0/3] driver core: Split device.h even more
Date: Mon, 23 Feb 2026 21:30:29 +0100
Message-ID: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In many drivers the whole bunch of what device.h provides is not
being used. Currently we already have device/devres.h which helps
a lot, but splitting more, will do even better. Hence this mini-series.

Note, it hasn't got comprehensive compile-test, so I would be not in
a hurry to apply it (but if you can test or *temporally* place into
Linux Next, it would be nice) and let others to test, including all
crawling CIs and bots.

Andy Shevchenko (3):
  driver core: Split device data types to device/types.h
  driver core: Split device link data types and API to device/devlink.h
  driver core: Split device related fwnode API to device/fwnode.h

 include/linux/device.h         | 498 +--------------------------------
 include/linux/device/devlink.h |  97 +++++++
 include/linux/device/fwnode.h  |  28 ++
 include/linux/device/types.h   | 415 +++++++++++++++++++++++++++
 include/linux/fwnode.h         |   2 +
 5 files changed, 545 insertions(+), 495 deletions(-)
 create mode 100644 include/linux/device/devlink.h
 create mode 100644 include/linux/device/fwnode.h
 create mode 100644 include/linux/device/types.h

-- 
2.50.1

