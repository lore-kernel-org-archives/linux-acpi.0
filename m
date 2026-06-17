Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2A3806AF;
	Wed, 17 Jun 2026 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687161; cv=none; b=P+KGpaHXefKA2ZZ2v2Jvny6c+mtNd94XVsuUUVB6rG2i1j7kl1na4mUy0y6Iy7X5DdU4mBXo1aoocuidvwtCqDmLmPEbv9T/jawGGN8jVxvL4nysv4IGEgjons67n+QMQnQaeDmnnXlLy2Iv9ZcWy5HSpIxSmhI7zfO2HfKwaZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687161; c=relaxed/simple;
	bh=zuMVcrdhUAXBPtzoKrZHOpptqkWaKT7XuK9kFXYJu38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjvIxF6+7l2ncvVgqzk/MkdJhQ7krCSGd+P0XyL2bB/BKdyHSDDWnWB//9p05+q3n8aAUxCs01ZjxbBQrsbqmMFSDkfWtE18wnFjlQpbH6U+lVxGu2bI9Q0LFj582yXQPY3sDXon48h5QOyLtw9bpqT0DbGm6pz4pMBQ+5DOk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQ3Z2x2H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQ3Z2x2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781687160; x=1813223160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zuMVcrdhUAXBPtzoKrZHOpptqkWaKT7XuK9kFXYJu38=;
  b=dQ3Z2x2HSMl8iu8WI+hiP8GVlRkGZpOdhldoZI6IslZrF3he+jge7TSt
   Y2gqhbfjsprOHQUEX6VrM/dpoyKQlQRa9LjU1cMu9JqITG8Z+ernGTcks
   Y7oO06ycLi/Zq+KGwNT2J76Ro+c/WEhMOGoOJTPCs5yp9LSw9nYA2Peen
   pSTjcH5u+B04XgZXNaayE9EqJUlUSOZNElF3wEsUBPlROa1SN9de6IIuq
   mwqhMpECwPvpygotAMw4T40ODBZ5gsIvsmvFzxx/zTzpx/qhZTN7b3dei
   Ea91TKP0TD2akiu+TEIZ08dO2vhbRXAu4kPAnfyohaYFp46d8/IHtV4nr
   g==;
X-CSE-ConnectionGUID: SUdFgB2fR3Oq/kYiCy3o0Q==
X-CSE-MsgGUID: Wm3s2HBJSHW09/8H4iijUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82483179"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82483179"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:05:59 -0700
X-CSE-ConnectionGUID: OldMHsxPRe62oz2P6ulnEg==
X-CSE-MsgGUID: Wus5CSdUQFSk8U+S4e6YGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="272078039"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 17 Jun 2026 02:05:57 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id ED12495; Wed, 17 Jun 2026 11:05:55 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/1] ACPI: resource: Amend kernel-doc style
Date: Wed, 17 Jun 2026 11:05:55 +0200
Message-ID: <20260617090555.2648709-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions are referred as func() in the kernel-doc. The % (percent)
character makes the rendering for constants as described in the respective
documentation. Amend all these.

Fixes: 8e345c991c8c ("ACPI: Centralized processing of ACPI device resources")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index bc8050d8a6f5..56df4599d360 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -871,7 +871,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 EXPORT_SYMBOL_GPL(acpi_dev_resource_interrupt);
 
 /**
- * acpi_dev_free_resource_list - Free resource from %acpi_dev_get_resources().
+ * acpi_dev_free_resource_list - Free resource from acpi_dev_get_resources().
  * @list: The head of the resource list to free.
  */
 void acpi_dev_free_resource_list(struct list_head *list)
@@ -991,7 +991,7 @@ static int __acpi_dev_get_resources(struct acpi_device *adev,
  *
  * The resultant struct resource objects are put on the list pointed to by
  * @list, that must be empty initially, as members of struct resource_entry
- * objects.  Callers of this routine should use %acpi_dev_free_resource_list() to
+ * objects.  Callers of this routine should use acpi_dev_free_resource_list() to
  * free that list.
  *
  * The number of resources in the output list is returned on success, an error
@@ -1032,7 +1032,7 @@ static int is_memory(struct acpi_resource *ares, void *not_used)
  * The resultant struct resource objects are put on the list pointed to
  * by @list, that must be empty initially, as members of struct
  * resource_entry objects.  Callers of this routine should use
- * %acpi_dev_free_resource_list() to free that list.
+ * acpi_dev_free_resource_list() to free that list.
  *
  * The number of resources in the output list is returned on success,
  * an error code reflecting the error condition is returned otherwise.
-- 
2.50.1

