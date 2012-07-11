From: Wen Congyang <wency@cn.fujitsu.com>
Subject: [PATCH 7/7 v2] release memory resources if hotadd_new_pgdat() failed
Date: Wed, 11 Jul 2012 15:50:47 +0800
Message-ID: <4FFD3057.2050308@cn.fujitsu.com>
References: <4FFD2F1E.10006@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FFD2F1E.10006@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-acpi@vger.kernel.org

We should goto error to release memory resource if hotadd_new_pgdat() failed.

Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 mm/memory_hotplug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0d7e3ec..427bb29 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -618,7 +618,7 @@ int __ref add_memory(int nid, u64 start, u64 size)
 		pgdat = hotadd_new_pgdat(nid, start);
 		ret = -ENOMEM;
 		if (!pgdat)
-			goto out;
+			goto error;
 		new_pgdat = 1;
 	}
 
-- 
1.7.1
