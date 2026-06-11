Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E3481FDC;
	Thu, 11 Jun 2026 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210148; cv=none; b=US67i5RLpC1iVtmHxLxWVHx81TrTyEAPJz5TOfCrCKt7Qj3jWaMVh4E0AO2+NDUKY6cTG+ah4mSCAhheZYZXT4Xw7KCAJ5i9JElQpHdDkRJ6UImNNOw0h2xBvBRIrL/TZGjvg4emhWn9bmNqKpPuFcvPWXCSSmlMpRk6VIk7NjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210148; c=relaxed/simple;
	bh=EqZwF17Sdan8X/NGW+s0UYDvQFPbLI99grcrCTraU/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mmqmgkRT15Odpt7avLomClMhy78yQhZYsRMbvtjfN5XFtc6YlDARszzzfbhhu/yjtkCiDci5lVa8FrPiYIRoYQik9P1DQfw6WCINRUlD2KulW18A/qb3e6iU7z58yxJtVt+OBLXnDbdMADZnpVQwPrW/UeuniAe1b+TTSJKln2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YY8Z5keB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YY8Z5keB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781210147; x=1812746147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EqZwF17Sdan8X/NGW+s0UYDvQFPbLI99grcrCTraU/I=;
  b=YY8Z5keBSbZPcqN4hOXIfAXJWgG2aFiybJQapwprHDvfji5BtkK5zPpP
   +dV1g2LufkWC7MeXVatW93nAav2q32ReFGvtWEK5IpJFfhSOdVlaPrPTh
   O18rmJoVzM74ha+/3MfgJWJPy3egH0i4FvYub2ir81U8WrQnnI81gci8y
   x34SRsgDjUADoJYKv4cjfQyMpYvBAqQM6PuVzvlVyOO/JamR5wPXUepSP
   3Pwk+3wmD/KKPB6A8IDUXxKLWWtDBTMwIyFwmZ1fgXwUHVCOBKDMIcgxa
   XlvOuSvcih3pOxwsYpYB/EWjjNgLHLZXBYIhYhlCelnpkz6ewF98wnj0d
   A==;
X-CSE-ConnectionGUID: C6BiPlwmTPWsTiRfVqoj6Q==
X-CSE-MsgGUID: 433I8ymuQYCN/30RuhbJpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99456603"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99456603"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 13:35:46 -0700
X-CSE-ConnectionGUID: i3pwIn2BSu+75IGjLOKj5g==
X-CSE-MsgGUID: YoyHNc8XQQ+GXB7essk3ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="270631220"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 11 Jun 2026 13:35:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id C48B195; Thu, 11 Jun 2026 22:35:42 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 0/3] device property: fix child iteration issues with secondary fwnodes
Date: Thu, 11 Jun 2026 22:31:05 +0200
Message-ID: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes two issues in the fwnode child iteration logic when
a secondary fwnode is present.

The first issue is  a refcount imbalance in software_node_get_next_child().
When a software node is used as a secondary fwnode, the iteration code may
incorrectly decrement the refcount of child nodes that do not belong to the
software node hierarchy. This results in refcount underflow and possible
use-after-free.

The second issue is an infinite loop in fwnode_for_each_child_node(), caused
by improper handling of iteration state across primary and secondary fwnodes.
When iterating over children from both primary and secondary fwnodes, the code
may incorrectly resume iteration from the primary fwnode even when the current
child belongs to the secondary, leading to repeated traversal and a loop.

Both issues are triggered when mixing different fwnode types through the
secondary mechanism, and stem from incorrect assumptions about ownership
and traversal context of child nodes.

Changes in v4:
- amended the fix and test case (Andy)
- added patch 2 to align other implementations with RAII approach (Andy)
- tested on Intel Galileo board for which the initial code was developed (Andy)
- Link to v3: https://patch.msgid.link/20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com

Changes in v3:
- remove software node patch
- add a kunit test case suggested by Andy Shevchenko
- Link to v2: https://patch.msgid.link/20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com

Changes in v2:
- use __free() to cleanup parent fwnode
- Link to v1: https://lore.kernel.org/r/20260525-fixes_fwnode_iteration-v1-0-a12903fb2919@nxp.com

Andy Shevchenko (1):
  device property: Refactor to use RAII approach

Xu Yang (2):
  device property: fix infinite loop in fwnode_for_each_child_node()
  device property: add test cases for fwnode_for_each_child_node()

 drivers/base/property.c                 |  41 ++++---
 drivers/base/test/Kconfig               |   1 +
 drivers/base/test/property-entry-test.c | 136 ++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 17 deletions(-)

-- 
2.50.1

