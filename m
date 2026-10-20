Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505523;
	b=S8OITriMA2xk3dLO7Yz9X7K0JWhTUTvpjCNNYDxHQ/7NN7PLi20Lk2oYnZb6tYiOITS+
	 AgcVu0dHqkqFeT/ijahGr6LF7PJD5PCm/G9znhShtxWe2sdTkzpvLxRbWGJcI0ZhHQqS9
	 ugiCVN6C/Mf7eTHujtZekQ6hdfJnNlnEFuKajmCEjQ6q/4KqDjyQzri1ySOuFlVLFLD6y
	 2F51syxPX30LmF+yN8rSKax9Nw7pU3scEUpfhjNKW4yFYQBhNKJmJQ5wEqAI4rb9vk8/7
	 0OAz3IInS+8nxZ5B/N8LWku/GsfALINtFd0PJ7gOkudcaFt94GJwbdAHCH3UsVUfFrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505523;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zh+CrKCMD7sj/2o1zGTgtKgyJX55Z3YCtyMy1QKVrcw=;
	b=qCF9hf/1npUl5hFW1c7qlBPXlNCqCih2ZtdpfzljjxQhm/RgL/lQwmjMA9s33sGLF2ia
	 Gs/S5hAZ8RLA8xTul9nH0AK46lSBEXy1305IDhix79p/Enulox1ZpIg152qBU2t2v1GIc
	 3FQtkrB9/CnLfH6zNSDaWBVftYgPU3MPgbBm5auI00VMihyhkGJgkbTXXVnM9XD8fJ4fc
	 eYqx//L8AowhUU+SIYf6R2rEQU0jh5QjaWfOGPDnQ5p1UrDeOOxkhEADiOGA1A8ICfGQk
	 O6bI3Gokz9bFRJ5Eu1eU6kJXvSQACqBtr1BJfXKkhCa6WAAdMZCFRKQbDayz7Bde6pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HivJl5AZ;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0DD606AA09;
	Tue, 20 Oct 2026 14:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C0DD606AA09
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HivJl5AZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792505523; x=1824041523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+2pwMYfRQEbaPtH+nuj1lUbTV7cvPt2H1juZnuVoff8=;
  b=HivJl5AZhF/YZzhRXqged1xnAIPELoRfSU4mjnl8LG21KV+P7Q7O0iaJ
   eFp6VvwZKxgwiR7Uf2akHDqKLhK3iKHkMYxnmV9S03l7j4pTRub07zqPI
   iODe0HoqBPxzIKUsqQm+oLrQeuvuIcsMXrXVxAwbBL4tgBx8spgtus0Tn
   HH0l+GQFb9mR3VC2Qe04TkkXVX1jLXyv/bZFVlv1ARrXah6L2ZXbWZHP4
   ZmaSGBKGOzn7KGTcdml/mLEdU8MhKkbwj83z9ksgG8YFlePPXxw6jwlWd
   wQwERak3sQBCTicPXJVNdiSHNK4z1vQCz7Ncya38Rsi8XoC/IgOUyDM9A
   g==;
X-CSE-ConnectionGUID: rY/r/CnnQ96ZUTJRgU5b2g==
X-CSE-MsgGUID: YrvYUQoLTRqhETf4GQm9lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1222323"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1222323"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:12:03 -0700
X-CSE-ConnectionGUID: GMcbuG1IQJ28W062TCBhqA==
X-CSE-MsgGUID: Q9B3Te7vQXeQ4bR8MmzgEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2888081"
Received: from igk-lkp-server01.igk.intel.com ([10.211.93.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 07:12:01 -0700
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 29/30] ACPICA: dispatcher: Allocate the PCC internal buffer only once per region
Date: Tue, 20 Oct 2026 16:10:50 +0200
Message-Id: <20261020141051.2194123-30-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
References: <20261020141051.2194123-1-pawel.chmielewski@intel.com>
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

From: Breno Leitao <leitao@debian.org>

AcpiDsCreateField() allocates InternalPccBuffer for operation regions in
the PCC address space. It runs once per Field() operator, so a second
Field() naming the same region overwrites the pointer and orphans the
buffer the first one allocated. The matching ACPI_FREE() in
AcpiUtDeleteInternalObj() only ever sees the last one.

Every field unit of a PCC region reads and writes through
RegionObj->Field.InternalPccBuffer, so one buffer per region is enough.
Skip the allocation when the region object already has one.

Reproduced with a table declaring two Field() operators on one PCC
region. Before, acpiexec reports the orphaned buffer at exit:

  0x4a09b0 Length 0x00C0   dsfield-0705 [Not a Descriptor]
  ACPI Error: 5 (0x5) Outstanding cache allocations

After, that allocation is gone and field access is unchanged.

On Linux, this is detected by kmemleak, as shown in [1].

Link: https://github.com/acpica/acpica/commit/c71849d476bb
Link: https://lore.kernel.org/all/20260813-acpica-pcc-field-leak-v1-1-3d6c5f0eb557@debian.org/ [1]
Link: https://github.com/open-acpica/acpica/pull/1218
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/acpi/acpica/dsfield.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index d916ff6dd501..28f8293da6a7 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -528,7 +528,8 @@ acpi_ds_create_field(union acpi_parse_object *op,
 	}
 
 	if (info.region_node->object->region.space_id ==
-	    ACPI_ADR_SPACE_PLATFORM_COMM) {
+		    ACPI_ADR_SPACE_PLATFORM_COMM &&
+	    !region_node->object->field.internal_pcc_buffer) {
 		region_node->object->field.internal_pcc_buffer =
 		    ACPI_ALLOCATE_ZEROED(info.region_node->object->region.
 					 length);
-- 
2.50.1

