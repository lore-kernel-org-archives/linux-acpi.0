Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA74E560AB3;
	Wed,  9 Sep 2026 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971965; cv=none; b=hZTh76z+eENkRxAbSVCIVa8n1EvjqJb7ZfcIDws+KxYpjqXlkhy2c6bkVA62AgzTTXo2QATIEUQJ0lhziTGSX7Z+W3TRF6aNQtgR3TzmCnvXB8CgLnVZc2aKnqZ16EhR0u+ZaROpw39BIwpDhUzCUtJ9pkR8+4ECmRnbOOoZwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971965; c=relaxed/simple;
	bh=FOm1fIw0DMQpAGmJi8JiagS47H8KggFhPCfSsm4vK+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAVy1tb57Z9w+wB0ew07o0XKcmlRqrD0L0oDvCfJJcByS3MVjrpURQoeUU6e+8F1lzoh3zBYyONnIpAX1DyGK9Vm4hIrGXKs3SaPVFYYjiYYc9rSdb6DICjydIvqIdJAyn2zlZBjK8cY+ovVjTGboAUfttwGdB2VlHhzAqRaINA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Im87FuBm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Im87FuBm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788971963; x=1820507963;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FOm1fIw0DMQpAGmJi8JiagS47H8KggFhPCfSsm4vK+Y=;
  b=Im87FuBm3frEvf4c10a0VMO75pJA1fqYaUX6KwYDb1lmL9udF7fCXAW3
   iB6CzS6JMBmCkmYUYTubvyVkjS6GVgGwfq6/2HIjK8WBQxj4PVJClGpTD
   d0ey9cGGmuNwrgNuMNUqocHWwJS0qIMWIRcZcGYizIGRcZTwsGBDRQ6A6
   Fm8Dh28zM4evAQbiznVh8LbR0SE2rVQmfuhkTWW5V94zdb+VZDH2Y9gM4
   bDy83HlBthfzG8Qs8WEihhSOCc3V8IEAvAUePalb+HtXjzl0SwhoIYJwP
   yjafEQJxEJdhUuPC1NTq8qfdrcTL6iX5OLxAywWWsA+3SYqXZTK1AUV0e
   Q==;
X-CSE-ConnectionGUID: hNGG9aJUQueLSrQfz4P/iA==
X-CSE-MsgGUID: trH7MebpQTWZ0IOG7i27Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="76964847"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="76964847"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 09:39:22 -0700
X-CSE-ConnectionGUID: FchodqDrRu6u56mwT6YlEQ==
X-CSE-MsgGUID: R9Zcv4YjRTC0iXfF0jXuCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="267688901"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 09 Sep 2026 09:39:20 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8EC0D99; Wed, 09 Sep 2026 18:39:19 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: bus: Reduce runtime memory footprint of struct acpi_device
Date: Wed,  9 Sep 2026 18:39:18 +0200
Message-ID: <20260909163918.368017-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI handler is heavily used by the ACPI code. Making it as
the first member in the struct acpi_device reduces code size.
For instance, the drivers/acpi/scan.o (with `make allyesconfig`)
gives this statistics:

add/remove: 0/0 grow/shrink: 3/8 up/down: 50/-169 (-119)
Function                                     old     new   delta
acpi_device_add                             2294    2319     +25
acpi_add_single_object                      6523    6544     +21
acpi_dev_get_next_consumer_dev               602     606      +4
acpi_tie_acpi_dev                            169     165      -4
acpi_scan_drop_device                        319     315      -4
acpi_dev_clear_dependencies                 1151    1147      -4
acpi_bus_attach                             2898    2894      -4
acpi_dma_get_range                          1420    1415      -5
acpi_init_device_object                     5497    5485     -12
acpi_bus_check_add                          1940    1923     -17
acpi_device_hotplug                         3407    3288    -119
Total: Before=77509, After=77390, chg -0.15%

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/acpi/acpi_bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a10a591c18b2..64ae66ca456e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -435,9 +435,9 @@ struct acpi_device_software_nodes {
 
 /* Device */
 struct acpi_device {
+	acpi_handle handle;		/* no handle for fixed hardware */
 	u32 pld_crc;
 	int device_type;
-	acpi_handle handle;		/* no handle for fixed hardware */
 	struct fwnode_handle fwnode;
 	struct list_head wakeup_list;
 	struct list_head del_list;
-- 
2.50.1

