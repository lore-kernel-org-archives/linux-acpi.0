From: Wen Congyang <wency@cn.fujitsu.com>
Subject: [PATCH 8/8] release memory resources if hotadd_new_pgdat() failed
Date: Tue, 26 Jun 2012 17:23:07 +0800
Message-ID: <4FE97F7B.2030808@cn.fujitsu.com>
References: <4FE97DD5.6030205@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:40793 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755305Ab2FZJSm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jun 2012 05:18:42 -0400
In-Reply-To: <4FE97DD5.6030205@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>

We should goto error to release memory resource if hotadd_new_pgdat() failed.

Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 mm/memory_hotplug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a14d35..3796690 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -617,7 +617,7 @@ int __ref add_memory(int nid, u64 start, u64 size)
 		pgdat = hotadd_new_pgdat(nid, start);
 		ret = -ENOMEM;
 		if (!pgdat)
-			goto out;
+			goto error;
 		new_pgdat = 1;
 	}
 
-- 
1.7.1

